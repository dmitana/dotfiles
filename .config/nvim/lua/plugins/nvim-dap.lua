-- DAP configuration
require('dap')
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

-- DAP telescope extension
require('telescope').load_extension('dap')

-- DAP Keybindings
local opts = { noremap = true, silent = true}

vim.api.nvim_set_keymap('n', '<leader>dc', '<cmd>lua require"dap".continue()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dv', '<cmd>lua require"dap".step_over()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>di', '<cmd>lua require"dap".step_into()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua require"dap".step_out()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>db', '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)

-- Python configuration
local dap_python = require('dap-python')
dap_python.setup('.venv/bin/python')
dap_python.test_runner = 'pytest'

-- DAP python keybindings
vim.api.nvim_set_keymap('n', '<leader>dtm', '<cmd>lua require"dap-python".test_method()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dtc', '<cmd>lua require"dap-python".test_class()<CR>', opts)
vim.api.nvim_set_keymap('v', '<leader>ds', '<ESC> <cmd>lua require"dap-python".debug_selection()<CR>', opts)
