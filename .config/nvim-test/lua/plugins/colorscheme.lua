return {
  -- the colorscheme should be available when starting Neovim
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      style = "storm",
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  -- {
  --   'monsonjeremy/onedark.nvim',
  --   branch = 'treesitter',
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   opts = {
  --     functionstyle = 'italic',
  --     sidebars = { 'qf', 'vista_kind', 'terminal', 'packer' },
  --   },
  --   config = function(_, opts)
  --     require("onedark").setup(opts)
  --     vim.g.onedark_terminal_italics = true
  --     -- load the colorscheme here
  --     vim.cmd([[colorscheme onedark]])
  --   end,
  -- },
}
