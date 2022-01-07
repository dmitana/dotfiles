-- Settings
vim.g.ultest_use_pty = true
vim.g.ultest_virtual_text = true

-- Keybindings
local opts = { noremap = true, silent = true}
vim.api.nvim_set_keymap('n', '<leader>ta', ':Ultest<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>tn', ':UltestNearest<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ts', ':UltestSummary<CR>', opts)
