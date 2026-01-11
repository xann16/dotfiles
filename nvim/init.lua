-- configuration inspired by:
--   - Kickstart.nvim, see: https://github.com/nvim-lua/kickstart.nvim
--   - YT videos (and dotfiles) by: Primeagen (and Vimeagen), Seth Phaeno

-- set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- enable Nerd Font support
vim.g.have_nerd_font = true

-- netrw setup (no banner, no split, window size)
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_winsize = 25

-- import core setting files (with options, keymaps, autocommands)
require('core')

-- import lazy.nvim and setup plugins
require('lazy-setup')
