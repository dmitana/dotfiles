return {
  -- Highlight, list and search todo comments in your projects
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  -- Create key bindings that stick. WhichKey helps you remember your Neovim keymaps, by showing available keybindings in a popup as you type.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      preset = "helix",
      defaults = {},
      spec = {
        {
          mode = { "n", "x" },
          { "<leader><tab>", group = "tabs" },
          { "<leader>c",     group = "code" },
          { "<leader>d",     group = "debug" },
          { "<leader>dp",    group = "profiler" },
          { "<leader>f",     group = "file/find" },
          { "<leader>g",     group = "git" },
          { "<leader>gh",    group = "hunks" },
          { "<leader>gt",    group = "toggle" },
          { "<leader>q",     group = "quit/session" },
          { "<leader>s",     group = "search" },
          { "<leader>u",     group = "ui" },
          { "<leader>b",     group = "diagnostics/quickfix" },
          { "[",             group = "prev" },
          { "]",             group = "next" },
          { "g",             group = "goto" },
          { "gs",            group = "surround" },
          { "z",             group = "fold" },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
          -- better descriptions
          { "gx", desc = "Open with system app" },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Keymaps (which-key)",
      },
      {
        "<c-w><space>",
        function()
          require("which-key").show({ keys = "<c-w>", loop = true })
        end,
        desc = "Window Hydra Mode (which-key)",
      },
    },
  }
}
