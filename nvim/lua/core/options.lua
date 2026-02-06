-- gutter setup
vim.o.number = true                         -- use line numbers
vim.o.relativenumber = true                 -- use relative line numbers
vim.o.signcolumn = 'yes'                    -- always keep signcolumn on

-- current line and position tracking and highlights
vim.o.guicursor = ''                        -- set the GUI cursor shape to full block
vim.o.cursorline = true                     -- highlight the current line
vim.o.scrolloff = 8                         -- set minimal number of screen lines to keep above and below the cursor
vim.o.sidescrolloff = 8                     -- set minimal number of screen columns to keep to the left and right of the cursor

-- indents, tabs
vim.o.tabstop = 4                           -- set tab width to 4 spaces
vim.o.softtabstop = 4                       -- set soft tab width to 4 spaces
vim.o.shiftwidth = 4                        -- set indentation width to 4 spaces
vim.o.expandtab = true                      -- replace Tabs with Spaces
vim.o.autoindent = true                     -- enable automatic indentation
vim.o.smartindent = true                    -- enable smart indentation

-- line width and word wrap
vim.o.wrap = false                          -- disable line wrapping
vim.o.colorcolumn = '80'                    -- highlight the 80th column

-- metafiles
vim.o.undofile = true                       -- save undo history for a file
vim.o.swapfile = false                      -- disable swapfile
vim.o.backup = false                        -- disable backup file

-- backspace settings
vim.o.backspace = 'indent,eol,start'        -- allow backspacing over everything in insert mode

-- search and completion
vim.o.ignorecase = true                     -- ignore case when searching (unless \C is used)
vim.o.smartcase = true                      -- if capital letters are in search field, use case-sensitive search
vim.o.hlsearch = true                       -- highlight all matches on previous search
vim.o.incsearch = true                      -- enable incremental search
vim.o.inccommand = 'split'                  -- enable live preview of substitutions, as they are being typed

-- wait and response times
vim.o.updatetime = 50                       -- decrease update time
-- vim.o.timeoutlen = 300                   -- decrease time to wait for a mapped sequence to complete

-- window splits
vim.o.splitright = true                     -- configure new splits to open to the right
vim.o.splitbelow = true                     -- configure new splits to open below

-- extra cleanup and convenience options
vim.o.mouse = 'a'                           -- enable mouse support ('a' - in all modes)
vim.o.confirm = true                        -- confirm dialog, for operations that would otherwise fail due to unsaved changes
vim.o.showmode = false                      -- do not show mode (it is included in status bar)
vim.opt.shortmess:append('S')               -- suppress displaying search count (it is included in status bar)
vim.o.termguicolors = true                  -- enable 24-bit RGB color support

-- clipboard mode - sync system and Neovim clipboard
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
