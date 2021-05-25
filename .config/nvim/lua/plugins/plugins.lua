return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'

  -- Autocompletion
  use 'hrsh7th/nvim-compe'

  -- Syntax highlighting
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Themes and styling
  use { 'npxbr/gruvbox.nvim', requires = 'rktjmp/lush.nvim' }
  use 'folke/tokyonight.nvim'
  use 'joshdick/onedark.vim'

  use { 'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons' }
end)
