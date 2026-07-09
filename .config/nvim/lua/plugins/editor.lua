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
          { "<leader>gh",    group = "git hunks" },
          { "<leader>gt",    group = "git toggle" },
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
  },
  -- markdown preview plugin for (neo)vim (preview markdown in browser)
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
  },
  -- Hackable in-editor previewer for Markdown, LaTeX, Typst, YAML, HTML
  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- README: do NOT lazy-load; the plugin self-defers
    dependencies = {
      "saghen/blink.cmp",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      preview = {
        icon_provider = "devicons",
      },
    },
    keys = {
      { "<leader>um", "<cmd>Markview Toggle<cr>",      desc = "Markview: toggle preview" },
      { "<leader>uM", "<cmd>Markview splitToggle<cr>", desc = "Markview: toggle splitview" },
    },
  },
  -- Render mermaid code blocks inline as ASCII/Unicode diagrams (via virtual text)
  {
    "kais-radwan/ascii-mermaid",
    ft = "markdown",
    opts = {
      display_mode = "inline", -- draw diagram below the fenced block; leave markview to style the block itself
    },
    -- This code renders ascii-mermaid also in Markview Split View
    -- config = function(_, opts)
    --   require("ascii-mermaid").setup(opts)
    --
    --   -- markview's splitview is an unnamed scratch buffer with `ft=markdown`.
    --   -- ascii-mermaid's built-in autocmds filter by `pattern = "*.md"` (filename),
    --   -- so nothing fires on the split. Drive the renderer against it explicitly.
    --   local display = require("ascii-mermaid.display")
    --   local mermaid = require("ascii-mermaid")
    --
    --   vim.api.nvim_create_autocmd("User", {
    --     pattern = "MarkviewSplitviewOpen",
    --     callback = function(ev)
    --       local buf = ev.data and ev.data.preview_buffer
    --       if not buf or not vim.api.nvim_buf_is_valid(buf) then return end
    --       if vim.b[buf].ascii_mermaid_split_attached then return end
    --       vim.b[buf].ascii_mermaid_split_attached = true
    --
    --       local timer
    --       local function schedule_render()
    --         if timer then timer:stop() end
    --         timer = vim.defer_fn(function()
    --           if not vim.api.nvim_buf_is_valid(buf) then return end
    --           -- Force a fresh render: markview's repeated `nvim_buf_set_lines`
    --           -- on the split buffer can invalidate our extmarks, but ascii-mermaid's
    --           -- content-hash cache would then skip re-rendering. Clear first.
    --           display.clear(buf)
    --           display.show(buf, mermaid.config)
    --         end, 200)
    --       end
    --
    --       vim.api.nvim_buf_attach(buf, false, {
    --         -- on_lines fires in nvim's "fast context"; hop to the main loop
    --         -- before touching buffer APIs.
    --         on_lines = vim.schedule_wrap(function()
    --           if not vim.api.nvim_buf_is_valid(buf) then return true end
    --           schedule_render()
    --         end),
    --         on_detach = function()
    --           if timer then timer:stop() end
    --         end,
    --       })
    --
    --       schedule_render()
    --     end,
    --   })
    -- end,
  },
}
