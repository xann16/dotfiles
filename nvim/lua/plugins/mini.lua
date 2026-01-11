-- MINI: collection of various small independent plugins/modules 

return {
    {
        'echasnovski/mini.nvim',

        config = function()
            
            -- better around/inside textobjects
            require('mini.ai').setup { 
                n_lines = 500 
            }

            -- add/delete/replace surroundings (brackets, quotes, etc.)
            require('mini.surround').setup()

            -- TODO: Consider possible options for mini.surround
            --[[
            opts = {
                -- Add custom surroundings to be used on top of builtin ones. For more
                -- information with examples, see `:h MiniSurround.config`.
                custom_surroundings = nil,

                -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
                highlight_duration = 300,

                -- Module mappings. Use `''` (empty string) to disable one.
                -- INFO:
                -- saiw surround with no whitespace
                -- saw surround with whitespace
                mappings = {
                    add = 'sa',            -- Add surrounding in Normal and Visual modes
                    delete = 'ds',         -- Delete surrounding
                    find = 'sf',           -- Find surrounding (to the right)
                    find_left = 'sF',      -- Find surrounding (to the left)
                    highlight = 'sh',      -- Highlight surrounding
                    replace = 'sr',        -- Replace surrounding
                    update_n_lines = 'sn', -- Update `n_lines`

                    suffix_last = 'l',     -- Suffix to search with "prev" method
                    suffix_next = 'n',     -- Suffix to search with "next" method
                },

                -- Number of lines within which surrounding is searched
                n_lines = 20,

                -- Whether to respect selection type:
                -- - Place surroundings on separate lines in linewise mode.
                -- - Place surroundings on each line in blockwise mode.
                respect_selection_type = false,

                -- How to search for surrounding (first inside current line, then inside
                -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
                -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
                -- see `:h MiniSurround.config`.
                search_method = 'cover',

                -- Whether to disable showing non-error feedback
                silent = false,
            },
            --]]

            -- unobtrusive tree-like floating file explorer working with oil
            local MiniFiles = require('mini.files')
            MiniFiles.setup({
                mappings = {
                    go_in = "<CR>",
                    go_in_plus = "L",
                    go_out = "-",
                    go_out_plus = "H",
                },
            })

            vim.keymap.set("n", "<leader>ee", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle Mini File [EE]xplorer" })
            vim.keymap.set("n", "<leader>ef", function()
                MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
                MiniFiles.reveal_cwd()
            end, { desc = "Toggle Mini File [E]xplorer Into Currently Opened [F]ile" })

            -- tool for detecting and removing trailing whitespaces
            require("mini.trailspace").setup {
                only_in_normal_buffers = true,
            }

            vim.keymap.set("n", "<leader>cw", require("mini.trailspace").trim, { desc = "[C]lear Trailing [W]hitespaces" })
            vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePre" }, {
                pattern = "*",
                callback = function()
                    require("mini.trailspace").unhighlight()
                end,
            })

            -- tool allowing to split and join parameter lists, etc.
            require("mini.splitjoin").setup {
                mappings = { toggle = "" }, -- Disable default mapping
            }

            vim.keymap.set({ "n", "x" }, "sj", require("mini.splitjoin").join, { desc = "[S]plit [J]oin Arguments" })
            vim.keymap.set({ "n", "x" }, "sk", require("mini.splitjoin").split, { desc = "[S]plit [K]ut Arguments" })
        
        end,
    },
}