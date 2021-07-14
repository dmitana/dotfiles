-- Enable 24-bit RGB color in the TUI
vim.cmd 'set termguicolors'

require('plugins')
require('general')

-- Load project local configuration from .nvimrc.lua
require('local-rc')
