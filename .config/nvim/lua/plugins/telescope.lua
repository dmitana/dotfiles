return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    -- Required
    "nvim-lua/plenary.nvim",
    -- Optional but recommended
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = "^1.0.0",
    },
  },
  keys = {
    { "<leader>ff", require("telescope.builtin").find_files,                                        desc = "Telescope find files" },
    { "<leader>fg", function() require("telescope").extensions.live_grep_args.live_grep_args() end, desc = "Telescope live grep" },
    { "<leader>fb", require("telescope.builtin").buffers,                                           desc = "Telescope buffers" },
    { "<leader>fh", require("telescope.builtin").help_tags,                                         desc = "Telescope help tags" },
    { "<leader>gc", require("telescope.builtin").git_commits,                                       desc = "Telescope git commits" },
    { "<leader>gb", require("telescope.builtin").git_branches,                                      desc = "Telescope git branches" },
    { "<leader>gs", require("telescope.builtin").git_status,                                        desc = "Telescope git git status" },
    { "<leader>tb", require("telescope.builtin").builtin,                                           desc = "Telescope builtins" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local lga_actions = require("telescope-live-grep-args.actions")

    telescope.setup({
      defaults = {
        -- This ensures live_grep also respects .gitignore
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        layout_strategy = "flex",
        layout_config = {
          width = 0.95,
          prompt_position = "bottom",
          horizontal = {
            mirror = false,
          },
          vertical = {
            mirror = false,
            preview_cutoff = 50,
          },
          flex = {
            flip_columns = 130,
          }
        },
        mappings = {
          i = {
            -- Remap previous/next selection
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            -- Remap sending to quickfixlist
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            -- Remap which key help
            ["<C-h>"] = actions.which_key,
          },
        },
      },
      pickers = {
        find_files = {
          -- TODO: Update to fd
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        lsp_references = {
          fname_width = 50,
          trim_text = true,
        },
      },
      extensions = {
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          mappings = {
            i = {
              ["<C-g>"] = lga_actions.quote_prompt({ postfix = " --iglob **/" }),
              ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t " }),
            },
          },
        }
      }
    })

    -- Load extensions
    telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")
  end,
}
