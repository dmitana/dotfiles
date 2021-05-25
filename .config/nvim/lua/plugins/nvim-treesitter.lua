require'nvim-treesitter.configs'.setup {
  -- Ensure that these language parsers are installed
  ensure_installed = {
    "python",
    "json",
    "lua"
  },

  -- Modules
  highlight = {
    enable = true,
    use_languagetree = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  }
}
