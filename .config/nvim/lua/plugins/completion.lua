return {
  "saghen/blink.cmp",
  -- use a release tag to download pre-built binaries
  version = "1.*",
  dependencies = {
    -- optional: provides snippets for the snippet source
    "rafamadriz/friendly-snippets",

    -- Add the compatibility layer
    "saghen/blink.compat",
    -- Actual nvim-cmp source
    "hrsh7th/cmp-calc",
  },
  opts = {
    appearance = {
      nerd_font_variant = "mono"
    },
    completion = {
      keyword = {
        range = "full",
      },
      menu = {
        -- nvim-cmp style menu
        draw = {
          columns = {
            { "label",     "label_description", gap = 1 },
            { "kind_icon", "kind",              "source_name" }
          },
        }
      },
      documentation = {
        auto_show = true,
      },
      ghost_text = {
        enabled = true,
      },
    },
    fuzzy = {
      implementation = "prefer_rust_with_warning",
    },
    keymap = {
      preset = "enter",
      ["<TAB>"] = { "select_next", "fallback" },
      ["<S-TAB>"] = { "select_prev", "fallback" },
      ["<C-u>"] = { "scroll_signature_up", "fallback" },
      ["<C-d>"] = { "scroll_signature_down", "fallback" },
    },
    signature = {
      enabled = true,
      window = {
        show_documentation = true,
      }
    },
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer", "calc" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        calc = {
          name = "calc",                  -- The name used in the source list above
          module = "blink.compat.source", -- Tells blink to use the compat layer
          -- Optional: You can still pass specific nvim-cmp
          -- source options here if the source supports them
          opts = {},
        },
      },
    },
  },
}
