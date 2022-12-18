-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim' -- A use-package inspired plugin manager for Neovim

  -- LSP
  use 'neovim/nvim-lspconfig' -- Quickstart configurations for the Nvim LSP client

  -- Autocompletion
  -- use 'hrsh7th/nvim-compe' -- Auto completion plugin for nvim that written in Lua
  use {
    'hrsh7th/nvim-cmp', -- A completion plugin for neovim coded in Lua
    requires = {
      'hrsh7th/cmp-nvim-lsp', -- nvim-cmp source for neovim builtin LSP client
      'hrsh7th/cmp-nvim-lua', -- nvim-cmp source for nvim lua
      'hrsh7th/cmp-path', -- nvim-cmp source for path
      'hrsh7th/cmp-buffer', -- nvim-cmp source for buffer words
      'hrsh7th/cmp-calc', -- nvim-cmp source for math calculation
      'onsails/lspkind-nvim', -- vscode-like pictograms for neovim lsp completion items
      'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
      'L3MON4D3/LuaSnip', -- Snippets plugin
      'rafamadriz/friendly-snippets',
    }
  }

  -- Syntax highlighting
  use { -- Nvim Treesitter configurations and abstraction layer
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-refactor' -- Refactor module for nvim-treesitter
  use 'JoosepAlviste/nvim-ts-context-commentstring' -- Neovim treesitter plugin for setting the commentstring based on the cursor location in a file
  use 'ntpeters/vim-better-whitespace' -- Better whitespace highlighting for Vim

  -- Python
  use { -- Generate Python docstring to your Python source code
    'heavenshell/vim-pydocstring',
    run = 'pip install doq'
  }

  -- Javascript / Typescript
  use { -- Generate JSDoc to your JavaScript code.
    'heavenshell/vim-jsdoc',
    run = 'make install'
  }

  -- Markdown
  use { -- Markdown preview plugin for (neo)vim
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end,
    ft = {'markdown'},
    cmd = 'MarkdownPreview'
  }

  -- General coding support
  use { -- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use 'b3nj5m1n/kommentary' -- Neovim commenting plugin, written in lua
  use 'tmsvg/pear-tree' -- A Vim auto-pair plugin
  use 'ray-x/lsp_signature.nvim' -- Lsp signature hint when you type
  use 'kosayoda/nvim-lightbulb' -- VSCode bulb for neovim's built-in LSP
  use 'machakann/vim-sandwich' -- Set of operators and textobjects to search/select/edit sandwiched texts
  use { -- Highlight, list and search todo comments in your projects
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }
  use 'lukas-reineke/indent-blankline.nvim' -- Indent guides for Neovim
  use { -- A neovim lua plugin to help easily manage multiple terminal windows
    'akinsho/nvim-toggleterm.lua',
    tag = 'v2.*'
  }
  use { -- Easy management of a toolwindow.
    'ethanjwright/toolwindow.nvim',
    requires = { 'folke/trouble.nvim', 'akinsho/nvim-toggleterm.lua' },
  }
  use 'andymass/vim-matchup' -- Vim match-up: even better % navigate and highlight matching words

  -- Themes and styling
  use { 'npxbr/gruvbox.nvim', requires = 'rktjmp/lush.nvim' } -- Lua port of the most famous vim colorscheme
  use 'folke/tokyonight.nvim' -- A clean, dark Neovim theme written in Lua
  use { -- OneDark NeoVim theme written in Lua
    'monsonjeremy/onedark.nvim',
    branch = 'treesitter'
  }
  use { -- A blazing fast and easy to configure neovim statusline plugin written in pure lua
    'hoob3rt/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use 'mhartington/formatter.nvim' -- A format runner for neovim, written in lua

  -- Navigation
  use { -- A file explorer tree for neovim written in lua
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use { -- Find, Filter, Preview, Pick. All lua, all the time
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' }
  }
  use { -- Simple statusline component that shows what scope you are working inside
    'SmiteshP/nvim-gps',
    requires = 'nvim-treesitter/nvim-treesitter'
  }

  -- Git support
  use { -- Git signs written in pure lua
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }
  use { -- Magit for neovim
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim'
  }
  use 'sindrets/diffview.nvim'

  -- Spelling
  use 'kamykn/spelunker.vim' -- Improved vim spelling plugin (with camel case support)

  -- Debugging
  use 'mfussenegger/nvim-dap' -- Debug Adapter Protocol client implementation for Neovim
  use 'mfussenegger/nvim-dap-python' -- An extension for nvim-dap, providing default configurations for python and methods to debug individual test methods or classes.
  use 'theHamsta/nvim-dap-virtual-text' -- Virtual text support for nvim-dap
  use 'rcarriga/nvim-dap-ui' -- A UI for nvim-dap
  use 'nvim-telescope/telescope-dap.nvim' -- Integration for nvim-dap with telescope.nvim

  -- Testing
  use { -- An extensible framework for interacting with tests within NeoVim
    'nvim-neotest/neotest',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-python',
      'haydenmeade/neotest-jest',
      'nvim-neotest/neotest-plenary',
      'nvim-neotest/neotest-vim-test'
    }
  }

  -- General tools
  use 'norcalli/nvim-colorizer.lua' -- The fastest Neovim colorizer
  use 'tweekmonster/startuptime.vim' -- Breakdown Vim's --startuptime output
  use 'karb94/neoscroll.nvim' -- Smooth scrolling neovim plugin written in lua
  use 'abecodes/tabout.nvim' -- Tabout plugin for neovim
end)
