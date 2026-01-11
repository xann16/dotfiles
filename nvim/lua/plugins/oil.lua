-- source: https://github.com/Sin-cy/dotfiles/blob/main/nvim/.config/nvim/lua/sethy/plugins/oil.lua

return {
	"stevearc/oil.nvim",
	dependencies = {
        { "nvim-mini/mini.icons", opts = {} }
    },
	config = function()
		require("oil").setup({
            default_file_explorer = true,
			columns = { 
                "icon",
                "permissions",
                "size",
                "mtime",
            },
			keymaps = {
				["<C-h>"] = false,
                ["<C-c>"] = false,
				["<M-h>"] = "actions.select_split",
                ["q"] = "actions.close",
			},
            win_options = {
                number = true,
                relativenumber = true,
                signcolumn = "no",
                wrap = false,
            },
            delete_to_trash = true,
			view_options = {
				show_hidden = true,
			},
            skip_confirm_for_simple_edits = true,
            lazy = false,
		})

		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		vim.keymap.set("n", "<leader>-", require("oil").toggle_float, { desc = "Open parent directory in floating window" })

	end,
}