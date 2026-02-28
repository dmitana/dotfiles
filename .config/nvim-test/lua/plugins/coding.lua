return {
  -- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
  {
    "folke/trouble.nvim",
    opts = {
      auto_preview = true,
    },
    cmd = "Trouble",
    keys = {
      {
        "<leader>bd",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>bD",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  -- Neovim Lua plugin to automatically manage character pairs. Part of 'mini.nvim' library.
  {
    "nvim-mini/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
  },
  -- Tiny plugin to enhance Neovim's native comments
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
  -- Neovim Lua plugin to extend and create `a`/`i` textobjects. Part of 'mini.nvim' library.
  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),     -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },         -- tags
          d = { "%f[%d]%d+" },                                                        -- digits
          e = {                                                                       -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          -- TODO: Add
          -- g = LazyVim.mini.ai_buffer,                              -- buffer
          u = ai.gen_spec.function_call(),                         -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
          -- TODO: Add
    -- config = function(_, opts)
    --   require("mini.ai").setup(opts)
    --   LazyVim.on_load("which-key.nvim", function()
    --     vim.schedule(function()
    --       LazyVim.mini.ai_whichkey(opts)
    --     end)
    --   end)
    -- end,
  }
}
