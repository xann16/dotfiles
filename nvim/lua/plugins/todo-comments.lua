-- TODO-COMMENTS: highlight todo, notes, etc. in comments

return {
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 
            'nvim-lua/plenary.nvim' 
        }, 
        config = function()
		    local todo_comments = require("todo-comments")

		    todo_comments.setup({
			    -- TODO: Configure custom keywords, highlights and icons
                --[[
                keywords = {
				    FIX = {
					    icon = " ", -- icon used for the sign, and in search results
					    color = "error", -- can be a hex color, or a named color (see below)
					    alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
					    -- signs = false, -- configure signs for some keywords individually
				    },
				    TODO = { icon = " ", color = "info" , alt = {"Personal"} },
				    HACK = { icon = " ", color = "warning", alt = { "DON SKIP" } },
				    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				    NOTE = { icon = " ", color = "hint", alt = { "INFO", "READ", "COLORS", "Custom" } },
				    TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
				    FORGETNOT = { icon = " ", color = "hint" },
			    },
                --]]
                highlight = {
                    multiline = true,
                    multiline_pattern = "^.",
                    multiline_context = 10,
                    before = "",
                    keyword = "wide",
                    after = "fg",
                    pattern = {
                        [[.*<(KEYWORDS)\s*:]], -- default pattern
                        [[<!--\s*(KEYWORDS)\s*:.*-->]], -- HTML comments with colon
                        [[<!--\s*(KEYWORDS)\s*.*-->]], -- HTML comments without colon
                    },
                    comments_only = false, -- highlighting outside of comments
                },
                search = {
                    command = "rg",
                    args = {
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                    },
                    pattern = [[\b(KEYWORDS)\b]],
                },
		    })

		    -- keymaps
		    vim.keymap.set("n", "]t", todo_comments.jump_next, { desc = "Next [T]odo comment" })
            vim.keymap.set("n", "[t", todo_comments.jump_prev, { desc = "Previous [T]odo comment" })

            -- TODO: Consider integration with 'telescope' (or 'snacks')
	    end,
    }
}
