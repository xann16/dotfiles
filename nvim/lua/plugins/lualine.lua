-- LUALINE: statusline

return {
    {
	    "nvim-lualine/lualine.nvim",
	    dependencies = { 
            "nvim-tree/nvim-web-devicons",
            "mfussenegger/nvim-lint"
        },
	    config = function()
		    local lualine = require("lualine")
		    local lazy_status = require("lazy.status")
            local lint = require("lint")

            local lint_progress = function()
                local linters = lint.get_running()
                if #linters == 0 then
                    return ""
                end
                return "󱉶 " .. table.concat(linters, ", ")
            end

            local mode = {
                'mode',
                fmt = function(str)
                    return ' ' .. str
                end,
            }
            local diff = {
                'diff',
                colored = true,
                symbols = { 
                    added = ' ',
                    modified = ' ',
                    removed = ' ' 
                },
            }
            local filename = {
                'filename',
                file_status = true,
            }
            local branch = {
                'branch',
                icon = {
                    '', 
                    color= { fg= '#A6D4DE'}
                },
                '|'
            }

		    lualine.setup({
                icons_enabled = true,
			    options = {
                    theme = 'moonlight',
				    section_separators = { left = "", right = "" },
                    component_separators = { left = "", right = "" },
			    },
			    sections = {
                    lualine_a = { mode },
                    lualine_b = { branch, diff },
                    lualine_c = { "diagnostics", filename },
                    lualine_x = {
					    { "searchcount" },
                        { lint_progress },
                        { "lsp_status" },   
                        {
						    lazy_status.updates,
						    cond = lazy_status.has_updates,
						    color = { fg = "#ff9e64" },
					    },
                        {'fileformat'},
                        {'encoding'}, 
                        {'filetype'},
                    },
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
			    },
		    })
	    end,
    }
}