local settings = require("Config.userSettings")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

local function save_colorscheme(colorscheme)
    -- Speichert das Farbschema in einer Datei
    settings.writeSetting("Theme", colorscheme)
end

M.colorscheme_picker_hover = function()
    local themes = vim.fn.getcompletion("", "color")

    pickers
        .new({}, {
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				width = 0.25,
				height = 0.75,
			},
			prompt_title = "",
			layout_prompt_title = " Theme Picker ",
            finder = finders.new_table({
                results = themes,
            }),
            sorter = sorters.get_generic_fuzzy_sorter(),
            attach_mappings = function(prompt_bufnr, map)
                local set_colorscheme = function()
                    local selection = action_state.get_selected_entry()
                    if selection then
                        save_colorscheme(selection[1])
                        vim.cmd("colorscheme " .. selection[1])
                    end
                end

                -- Map <CR> to set the colorscheme
                map("i", "<CR>", function()
				set_colorscheme()
				actions.close(prompt_bufnr)
				end)
				
                map("n", "<CR>", function()
				set_colorscheme()
				actions.close(prompt_bufnr)
				end
				)
				map("n","<Esc>",function()actions.close(prompt_bufnr)end)

                -- Allow default behavior for j and k (navigation)
                map("n", "j", function()
                    actions.move_selection_next(prompt_bufnr)
                    set_colorscheme()  -- Call the function after moving
                end)

                map("n", "k", function()
                    actions.move_selection_previous(prompt_bufnr)
                    set_colorscheme()  
                end)

                return false -- Use default mappings as well
            end,
        })
        :find()
end

vim.api.nvim_create_user_command("ThemePicker", function()
    M.colorscheme_picker_hover()
end, {})

return M
