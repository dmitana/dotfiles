-- Plugin list
require('plugins.plugins')

-- LSP
require('plugins.nvim-lspconfig')

-- Autocompletion
require('plugins.nvim-cmp')
require('plugins.luasnip')

-- Syntax highlighting
require('plugins.nvim-treesitter')

-- Python
require('plugins.vim-pydocstring')

-- Javascript / Typescript
require('plugins.vim-jsdoc')

-- General coding support
require('plugins.trouble')
require('plugins.comment')
require('plugins.pear-tree')
require('plugins.nvim-lightbulb')
require('plugins.todo-comments')
require('plugins.indent-blankline')
require('plugins.nvim-toggleterm')
require('plugins.toolwindow')
require('plugins.formatter')

-- Themes and styling
require('plugins.themes')
require('plugins.lualine')

-- Navigation
require('plugins.nvim-tree')
require('plugins.telescope')
require('plugins.nvim-gps')

-- Git support
require('plugins.gitsigns')
require('plugins.neogit')
require('plugins.diffview')

-- Spelling
require('plugins.spelunker')

-- TODO: Fix Debugging plugins
-- Debugging
-- require('plugins.nvim-dap')
-- require('plugins.nvim-dap-virtual-text')
-- require('plugins.nvim-dap-ui')

-- TODO: Fix Testing plugins
-- Testing
-- require('plugins.vim-ultest')
-- require('plugins.neotest')

-- General tools
require('plugins.nvim-colorizer')
require('plugins.neoscroll')
require('plugins.tabout')
