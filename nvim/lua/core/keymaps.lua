local opts = { noremap = true, silent = true }

-- clear highlights on search when pressing <Esc> or <C-c> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights', silent = true })
vim.keymap.set('n', '<C-c>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights', silent = true })

-- use double j (or <C-c>) to exit insert mode
vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Exit insert mode' })
vim.keymap.set('i', '<C-c>', '<Esc>', { desc = 'Exit insert mode' })

-- open quickfix list and location list
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- better navigation (quickfix lists and location lists, respectively)
vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz', { desc = 'Go to [J]-next item in the quickfix list' })
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz', { desc = 'Go to [K]-previous item in the quickfix list' })
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz', { desc = 'Go to [J]-next item in the location list' })
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz', { desc = 'Go to [K]-previous item in the location list' })

-- move selected lines up or down in the visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })

-- move up or down through the buffer with cursor centered
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move down a half page with cursor centered' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move up a half page with cursor centered' })

-- add centering (and visual mode) to moving through search results
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)' })

-- add visual mode to indentation shifts to chain them easily
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- delete without moving contents to clipboard
vim.keymap.set('n', '<leader>d', '"_d', { desc = 'Delete without yanking' })
vim.keymap.set('n', 'x', '"_x', opts)

-- disable mapping for internal nvim terminal
vim.keymap.set('n', 'Q', '<nop>')

-- close split window
vim.keymap.set('n', '<C-w>q', '<cmd>close<CR>', { desc = 'Close split window' })

-- replace word under cursor (as command template to use)
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word cursor is on globally" })







-- copy current filepath (relative to the home directory) to the clipboard 
vim.keymap.set("n", "<leader>fp", function()
  local filePath = vim.fn.expand("%:~")
  vim.fn.setreg("+", filePath)
  print("File path copied to clipboard: " .. filePath)
end, { desc = "Copy file path to clipboard" })