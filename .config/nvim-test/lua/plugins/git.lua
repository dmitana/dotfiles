return {
  -- Git integration for buffers
  {
    "lewis6991/gitsigns.nvim",
    -- event = "LazyFile", -- Works only in LazyVim, below is equivallent
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
        end

        -- Navigation
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")

        -- Actions
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        map({ "n", "x" }, "<leader>ghs", gs.stage_hunk, "Stage Hunk")
        map("v", "<leader>ghs", function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end, "Stage Hunk")
        map({ "n", "x" }, "<leader>ghr", gs.reset_hunk, "Reset Hunk")
        map("v", "<leader>ghr", function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end, "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghP", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map("n", "<leader>ghq", gs.setqflist, "Show Hunks in Quickfix List")
        map("n", "<leader>ghQ", function() gs.setqflist("all") end, "Show hunks in Quickfix list for whole repository")

        -- Toggles
        map("n", "<leader>gtb", gs.toggle_current_line_blame, "Toggle Current Line Blame")
        map("n", "<leader>gtd", gs.toggle_deleted, "Toggle Deleted")
        map("n", "<leader>gtw", gs.toggle_word_diff, "Toggle Word Diff")

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
  -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
  {
    "sindrets/diffview.nvim",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>dwo", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>dwc", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
      { "<leader>dwr", "<cmd>DiffviewRefresh<cr>", desc = "Diffview Refresh" },
    },
  },
  -- An interactive and powerful Git interface for Neovim, inspired by Magit
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional
      "nvim-telescope/telescope.nvim", -- optional
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
    },
    opts = {
      integrations = {
        telescope = true,
        diffview = true,
      },
    },
  },
}
