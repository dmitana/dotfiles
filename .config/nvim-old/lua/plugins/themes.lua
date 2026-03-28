-- Gruvbox theme
vim.o.background = 'dark'

-- Tokyo Night theme
vim.g.tokyonight_style = 'storm'

-- One Dark theme
require('onedark').setup({
  functionStyle = 'italic',
  sidebars = { 'qf', 'vista_kind', 'terminal', 'packer' },
})
vim.g.onedark_terminal_italics = true
