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
                keywords = {
				    FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "ERROR" } },
				    TODO = { icon = " ", color = "info" , alt = { "TASK" } },
				    WARN = { icon = " ", color = "warning", alt = { "WARNING" } },
				    PERF = { icon = " ", color = "#aa77cc", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				    NOTE = { icon = " ", color = "hint", alt = { "INFO", "COLORS", "READ", "DOI", "SEE" } },
			    },
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
                    comments_only = true, -- highlighting outside of comments
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
                    pattern = [[\b(KEYWORDS):]],
                },
		    })

		    -- keymaps
		    vim.keymap.set("n", "]t", todo_comments.jump_next, { desc = "Next [T]odo comment" })
            vim.keymap.set("n", "[t", todo_comments.jump_prev, { desc = "Previous [T]odo comment" })

            -- TODO: Consider integration with 'telescope' (or 'snacks')
	    end,
    }
}
