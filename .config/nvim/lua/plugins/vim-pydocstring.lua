vim.g.pydocstring_formatter = 'sphinx'
vim.g.pydocstring_doq_path = 'doq'
vim.g.pydocstring_enable_mapping = false

vim.api.nvim_set_keymap('n', '<leader>pd', ':Pydocstring<CR>', { noremap = true, silent = false })
