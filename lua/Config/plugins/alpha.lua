return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        local telescope_builtin = require("telescope.builtin")
        local plenary_scan = require("plenary.scandir")
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        _G.opts = {
            position = "center",
            hl = "Type",
            wrap = "overflow",
        }

        -- Function to switch Git repositories
        local function switch_repo()
            local home = vim.fn.expand("~") .. "/repos" -- Change this path if needed

            -- Scan for Git repositories
            local repos = plenary_scan.scan_dir(home, { hidden = true, depth = 2, add_dirs = true })
            local git_repos = {}

            -- Filter only directories that contain a .git folder
            for _, repo in ipairs(repos) do
                if vim.fn.isdirectory(repo .. "/.git") == 1 then
                    table.insert(git_repos, repo)
                end
            end

            if #git_repos == 0 then
                print("No Git repositories found in " .. home)
                return
            end

            -- Use Telescope to select a repo
            pickers.new({}, {
                prompt_title = "Select a Git Repository",
                finder = finders.new_table({ results = git_repos }),
                sorter = conf.generic_sorter({}),
                attach_mappings = function(prompt_bufnr, _)
                    actions.select_default:replace(function()
                        local selection = action_state.get_selected_entry()
                        actions.close(prompt_bufnr)
                        vim.cmd("cd " .. selection[1])
                        print("Switched to " .. selection[1])
                    end)
                    return true
                end,
            }):find()
        end

        -- Function to load a random ASCII header
        local function load_random_header()
            math.randomseed(os.time())
            local header_folder = vim.fn.stdpath("config") .. "/lua/Config/plugins/header_img/"
            local files = vim.fn.globpath(header_folder, "*.lua", true, true)
            if #files == 0 then
                return nil
            end

            local random_file = files[math.random(#files)]
            local separator = package.config:sub(1, 1)
            local module_name = "custom.plugins.header_img." .. random_file:match("([^" .. separator .. "]+)%.lua$")

            package.loaded[module_name] = nil

            local ok, module = pcall(require, module_name)
            if ok and module.header then
                -- Add padding to the header to set a fixed height
                local fixed_height = 2 -- Set your desired height here
                local header_lines = module.header
                local padding_lines = fixed_height - #header_lines
                if padding_lines > 0 then
                    for _ = 1, padding_lines do
                        table.insert(header_lines, 1, "")
                    end
                end
                return header_lines
            else
                return nil
            end
        end

        -- Function to change the header image
        local function change_header()
            local new_header = load_random_header()
            if new_header then
                dashboard.config.layout[2] = new_header
                vim.cmd("AlphaRedraw") -- Reload dashboard
            else
                print("No images inside header_img folder.")
            end
        end

        -- Load a random header on startup
        local header = load_random_header()
        if header then
            dashboard.config.layout[2] = header
        else
            print("No images inside header_img folder.")
        end

        -- Define Alpha dashboard buttons
        dashboard.section.buttons.val = {
            dashboard.button("<C-d>", "󱓧  Open daily-notes", ":ObsidianToday<CR>"),
            dashboard.button("r", "󰄉  Recent files", ":Telescope oldfiles <CR>"),
            dashboard.button("u", "󱐥  Update plugins", "<cmd>Lazy update<CR>"),
            dashboard.button("c", "  Settings", ":e $HOME/Appdata/Local/nvim/init.lua<CR>"),
            dashboard.button("s", "  Switch Git Repo", function() switch_repo() end),
            dashboard.button("g", "󰊢  Open LazyGit", "<cmd>LazyGit<CR>"),
            dashboard.button("w", "  Change header image", function()
                change_header()
            end),
            dashboard.button("t", "🖮  Practice typing with Typr ", ":Typr<CR>"),
        }

        -- Add footer with plugin stats
        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            desc = "Add Alpha dashboard footer",
            once = true,
            callback = function()
                local stats = require("lazy").stats()
                local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
                dashboard.section.footer.val =
                    { " ", " ", " ", " Loaded " .. stats.count .. " plugins  in " .. ms .. " ms " }
                dashboard.section.header.opts.hl = "DashboardFooter"
                pcall(vim.cmd.AlphaRedraw)
            end,
        })

        dashboard.opts.opts.noautocmd = true
        alpha.setup(dashboard.opts)
    end,
}
