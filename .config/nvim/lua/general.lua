-- Settings
--
-- Load filetype plugin and indent files
vim.cmd 'filetype plugin indent on'

-- Enable syntax highlighting
vim.cmd 'syntax on'

-- Enable 24-bit RGB color in the TUI
vim.cmd 'set termguicolors'

-- Enable the colorscheme
vim.cmd 'colorscheme onedark'

-- Access system clipboard in VIM
vim.cmd 'set clipboard=unnamed'

-- Turn off search highlighting
vim.cmd 'set nohlsearch'

-- Show tab line even if only one file is open
vim.cmd 'set showtabline=2'

-- Show cursor line
vim.wo.cursorline = true

-- Hybrid (number + relative) line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable to leave a buffer with unsaved changes
vim.cmd 'set hidden'

-- Always show sign columns
vim.cmd 'set signcolumn=yes'

-- If this many milliseconds nothing is typed the swap file will be written to
-- disk. Also used for the CursorHold autocommand event - used for
-- nvim-lightbuld.
vim.opt.updatetime = 1000

-- Keybindings
--
-- Navigation in split windows
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w><C-j>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w><C-k>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w><C-l>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w><C-h>', { noremap = true, silent = true })

-- Tab navigation
vim.api.nvim_set_keymap('n', '<M-l>', 'gt', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-h>', 'gT', { noremap = true, silent = true })

-- Map yanking to PRIMARY and CLIPBOARD registers PRIMARY (*) mnemonic: Star is
-- Select (for copy-on-select) CLIPBOARD (+) mnemonic: CTRL PLUS C (for the
-- common keybind)
vim.api.nvim_set_keymap('', '<Leader>y', '"*y', { noremap = true, silent = false })
vim.api.nvim_set_keymap('', '<Leader>p', '"*p', { noremap = true, silent = false })
vim.api.nvim_set_keymap('', '<Leader>Y', '"+y', { noremap = true, silent = false })
vim.api.nvim_set_keymap('', '<Leader>P', '"+p', { noremap = true, silent = false })
