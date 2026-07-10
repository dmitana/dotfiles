-- NOTE (2026-07): nvim-treesitter's repo was ARCHIVED on 2026-04-03 (read-only,
-- frozen) after the 0.12 rewrite. We intentionally stay pinned to the final
-- `main` commit (see lazy-lock.json) — it is frozen but fully functional on
-- Nvim 0.12. Consequences:
--   * `:Lazy update` / `:TSUpdate` will no longer pull new parser revisions.
--   * Neovim provides the treesitter *engine* natively, but bundles only 7
--     parsers (c, lua, markdown, markdown_inline, query, vim, vimdoc). Our other
--     languages' parsers AND queries are installed under stdpath("data")/site
--     (auto-loaded by Nvim), which is why highlighting keeps working.
--   * `nvim-treesitter-textobjects` (below) is a SEPARATE repo and is NOT
--     archived — it still receives updates.
-- If ongoing parser updates become necessary, migrate parser management to a
-- maintained successor (e.g. tree-sitter-manager.nvim) and keep native highlighting.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- Explicitly target the new main branch (archived/frozen — see note above)
    lazy = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main", -- Textobjects also has a rewritten main branch (still maintained)
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
        "c", "vim", "vimdoc", "query",
        "markdown", "markdown_inline", "latex", "typst", "yaml", "comment",
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

      -- 5. INCREMENTAL SELECTION — provided natively by Nvim 0.12, no config needed:
      --    an / in : grow / shrink selection to the node outwards / inwards
      --    ]n / [n : select next / previous sibling node
      --    ]N / [N : expand to sibling node
    end,
  },
}
