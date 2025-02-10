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
			local home_repos = vim.fn.expand("~") .. "/repos"
			local home_projects = "C:/Projekte"
			-- Scan for Git repositories
			local repos = {
				plenary_scan.scan_dir(home_repos, { hidden = true, depth = 2, add_dirs = true }),
				plenary_scan.scan_dir(home_projects, { hidden = true, depth = 2, add_dirs = true }),
				vim.fn.stdpath("config"),
			}
			local git_repos = {}

			-- Handle the directories returned by plenary_scan.scan_dir
			for _, repo_list in ipairs(repos) do
				if type(repo_list) == "table" then
					-- If it's a table, we iterate through it
					for _, repo in ipairs(repo_list) do
						if vim.fn.isdirectory(repo .. "/.git") == 1 then
							table.insert(git_repos, repo)
						end
					end
				elseif type(repo_list) == "string" then
					-- If it's a string (vim.fn.stdpath("config")), check it directly
					if vim.fn.isdirectory(repo_list .. "/.git") == 1 then
						table.insert(git_repos, repo_list)
					end
				end
			end

			if #git_repos == 0 then
				print("No Git repositories found in " .. home_repos .. " or " .. home_projects)
				return
			end

			-- Use Telescope to select a repo
			pickers
				.new({}, {
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
				})
				:find()
		end

		-- Function to load a random ASCII header
		local function load_random_header()
			-- Zufallszahlengenerator nur einmal setzen, falls nicht bereits geschehen
			if not _G.random_seeded then
				math.randomseed(os.time())
				_G.random_seeded = true
			end

			-- Verzeichnis mit Header-Dateien festlegen
			local header_folder = vim.fn.stdpath("config") .. "/lua/Config/plugins/header_img/"
			local files = vim.fn.globpath(header_folder, "*.lua", true, true)

			-- Überprüfen, ob Dateien vorhanden sind
			if #files == 0 then
				print("Keine Header-Dateien gefunden!")
				return nil
			end

			-- Zufällige Datei auswählen
			local random_file = files[math.random(#files)]
			local separator = package.config:sub(1, 1)
			local module_name = "Config.plugins.header_img." .. random_file:match("([^" .. separator .. "]+)%.lua$")

			-- Modul neu laden, falls es bereits im Cache ist
			package.loaded[module_name] = nil

			-- Modul laden und Fehler abfangen
			local ok, module = pcall(require, module_name)
			print("Versuche zu laden: " .. module_name)
			local ok, module = pcall(require, module_name)
			if not ok then
				print("Fehlerdetails: " .. module)
				return nil
			end

			-- Header zurückgeben, falls vorhanden
			if module.header then
				return module.header
			else
				print("Keine 'header' Eigenschaft im Modul: " .. module_name)
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
			dashboard.button("f", "  Browse files", ":Telescope find_files <CR>"),
			dashboard.button("r", "󰄉  Recent files", ":Telescope oldfiles <CR>"),
			dashboard.button("s", "  Switch Git Repo", function()
				switch_repo()
			end),
			dashboard.button("g", "󰊢  Open LazyGit", "<cmd>LazyGit<CR>"),
			dashboard.button("u", "󱐥  Update plugins", "<cmd>Lazy update<CR>"),
			dashboard.button("t", "🖮  Practice typing with Typr ", "<cmd>Typr<CR>"),
			dashboard.button("V", "  Vim Practice ", "<cmd>OpenURL https://vim-racer.com/<CR>"),
			dashboard.button("c", "  Settings", ":e $HOME/Appdata/Local/nvim/init.lua<CR>"),
			dashboard.button("Q", "  Quit ", "<cmd>q!<CR>"),
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
