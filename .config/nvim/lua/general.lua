-- Show cursor line
vim.wo.cursorline = true

-- Hybrid (number + relative) line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable syntax highlighting
vim.cmd 'syntax on'

-- Enable 24-bit RGB color in the TUI
vim.cmd 'set termguicolors'

-- Enable the colorscheme
vim.cmd 'colorscheme onedark'
