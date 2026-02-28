return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- Explicitly target the new main branch
    lazy = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main", -- Textobjects also has a rewritten main branch
      },
      "andymass/vim-matchup",
    },
    config = function()
      require "nvim-treesitter".setup {
        -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
        install_dir = vim.fn.stdpath("data") .. "/site"
      }
      local ts = require("nvim-treesitter")

      -- 1. PARSER MANAGEMENT (`ensure_installed` table is gone)
      local parsers_to_install = {
        "python", "json", "lua", "html", "css", "javascript", "typescript",
        "c", "vim", "vimdoc", "query"
      }

      -- Only install missing parsers to prevent startup spam/delays
      local installed = ts.get_installed()
      local missing = vim.tbl_filter(function(parser)
        return not vim.tbl_contains(installed, parser)
      end, parsers_to_install)

      if #missing > 0 then
        ts.install(missing)
      end

      -- 2. ENABLE CORE FEATURES VIA NEOVIM API (`highlight` and `indent` blocks are gone)
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("TreesitterMainConfig", { clear = true }),
        callback = function(event)
          -- Start syntax highlighting safely (fails gracefully if parser isn't installed)
          pcall(vim.treesitter.start, event.buf)

          -- Enable treesitter indentation
          vim.bo[event.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
        end,
      })

      -- 3. FOLDING (Handled natively by Neovim 0.10+)
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
      vim.opt.foldenable = false

      -- 4. TEXTOBJECTS (No longer hooked into TS setup, configured separately)
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
        }
      })

      -- Textobject keymaps configured manually (the modern recommended way for `main`)
      local function map_obj(lhs, obj, desc)
        vim.keymap.set({ "x", "o" }, lhs, function()
          require("nvim-treesitter-textobjects.select").select_textobject(obj, "textobjects")
        end, { desc = desc })
      end

      map_obj("af", "@function.outer", "Select outer part of a function")
      map_obj("if", "@function.inner", "Select inner part of a function")
      map_obj("ac", "@class.outer", "Select outer part of a class")
      map_obj("ic", "@class.inner", "Select inner part of a class")

      -- 5. INCREMENTAL SELECTION REPLACEMENT
      -- The native incremental selection module was removed in `main`.
      -- This is the community-standard snippet to replace it using the <TAB> key.
      _G.selected_nodes = {}
      vim.keymap.set({ "n" }, "<tab>", function()
        _G.selected_nodes = {}
        local node = vim.treesitter.get_node()
        if not node then return end
        table.insert(_G.selected_nodes, node)

        local start_row, start_col, end_row, end_col = node:range()
        vim.fn.setpos("'<", { 0, start_row + 1, start_col + 1, 0 })
        vim.fn.setpos("'>", { 0, end_row + 1, end_col, 0 })
        vim.cmd("normal! gv")
      end, { desc = "Init Treesitter Selection" })

      -- (For expanding selection, you can map another key to traverse the `node:parent()`)
    end,
  },
}
