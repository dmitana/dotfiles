return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim' -- A use-package inspired plugin manager for Neovim

  -- LSP
  use 'neovim/nvim-lspconfig' -- Quickstart configurations for the Nvim LSP client

  -- Autocompletion
  use 'hrsh7th/nvim-compe' -- Auto completion plugin for nvim that written in Lua

  -- Syntax highlighting
  use { -- Nvim Treesitter configurations and abstraction layer
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- General coding support
  use { -- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use 'b3nj5m1n/kommentary' -- Neovim commenting plugin, written in lua
  use 'steelsojka/pears.nvim' -- Auto pair plugin for neovim
  use 'ray-x/lsp_signature.nvim' -- Lsp signature hint when you type
  use 'kosayoda/nvim-lightbulb' -- VSCode bulb for neovim's built-in LSP

  -- Themes and styling
  use { 'npxbr/gruvbox.nvim', requires = 'rktjmp/lush.nvim' } -- Lua port of the most famous vim colorscheme
  use 'folke/tokyonight.nvim' -- A clean, dark Neovim theme written in Lua
  use 'monsonjeremy/onedark.nvim' -- OneDark NeoVim theme written in Lua
  use { -- A blazing fast and easy to configure neovim statusline plugin written in pure lua
    'hoob3rt/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- Navigation
  use { -- A file explorer tree for neovim written in lua
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use { -- Find, Filter, Preview, Pick. All lua, all the time
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' }
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

end)
