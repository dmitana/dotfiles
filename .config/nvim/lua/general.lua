-- Show cursor line
vim.wo.cursorline = true

-- Hybrid (number + relative) line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable the colorscheme
vim.cmd('colorscheme tokyonight')

-- Enable 24-bit RGB color in the TUI
vim.g.termguicolors = true
