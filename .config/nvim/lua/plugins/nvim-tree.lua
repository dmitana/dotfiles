return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<C-n>",     ":NvimTreeToggle<CR>",  desc = "Toggle NvimTree",  silent = true },
    { "<leader>r", ":NvimTreeRefresh<CR>", desc = "Refresh NvimTree", silent = true },
  },
  opts = {
    -- show lsp diagnostics in the signcolumn
    diagnostics = {
      enable = true,
      icons = {
        hint = "󰌶 ", -- Default is 
        info = "󰋽 ", -- Default is 
        warning = "󰀪 ", -- Default is 
        error = "󰅚 ", -- Default is 
      },
    },
    -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
    update_focused_file = {
      -- enables the feature
      enable = true,
      -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
      -- only relevant when `update_focused_file.enable` is true
      update_cwd = false,
      -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
      -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
      ignore_list = {}
    },
    filters = {
      dotfiles = false,
      custom = { "^.git$" }
    },
  },
}
