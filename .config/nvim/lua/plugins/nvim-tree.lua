-- Non setup settings (should be set BEFORE running the setup function)
vim.g.nvim_tree_indent_markers = 1 -- Indent markers when folders are open
vim.g.nvim_tree_git_hl = 1 -- Will enable file highlight for git attributes (can be used without the icons).
vim.g.nvim_tree_highlight_opened_files = 1 -- Will enable folder and file icon highlight for opened files/directories.
vim.g.nvim_tree_root_folder_modifier = ':~' -- This is the default. See :help filename-modifiers for more options
vim.g.nvim_tree_add_trailing = 1 -- Append a trailing slash to folder names
vim.g.nvim_tree_group_empty = 1 -- Compact folders that only contain a single folder into one node in the file tree
-- Dictionary of buffer option names mapped to a list of option values that
-- indicates to the window picker that the buffer's window should not be
-- selectable.
-- List of filenames that gets highlighted with NvimTreeSpecialFile
vim.g.nvim_tree_special_files = {
  ["Cargo.toml"] = true,
  Makefile = true,
  ["README.md"] = true,
  ["readme.md"] = true,
}
-- If 0, do not show the icons for one of 'git', 'folder', and 'files'
-- 1 by default, notice that if 'files' is 1, it will only display
-- if nvim-web-devicons is installed and on your runtimepath
vim.g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1,
}
vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
  git = {
     unstaged = "✗",
     staged = "✓",
     unmerged = "",
     renamed = "➜",
     untracked = "★",
     deleted = "",
     ignored = "◌"
  },
  folder = {
     default = "",
     open = "",
     empty = "",
     empty_open = "",
     symlink = "",
     symlink_open = "",
  }
}

require'nvim-tree'.setup {
  -- disables netrw completely
  disable_netrw = false,
  -- hijack netrw window on startup
  hijack_netrw = true,
  -- open the tree when running this setup function
  open_on_setup = false,
  -- will not open on setup if the filetype is in this list
  ignore_ft_on_setup = { 'startify', 'dashboard' },
  -- closes neovim automatically when the tree is the last **WINDOW** in the view
  auto_close = true,
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab = false,
  -- hijacks new directory buffers when they are opened.
  update_to_buf_dir   = {
    -- enable the feature
    enable = true,
    -- allow to open the tree if it was previously closed
    auto_open = true,
  },
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor = false,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd = false,
   -- show lsp diagnostics in the signcolumn
  diagnostics = {
    enable = true,
    icons = {
      hint = "", -- Default is 
      info = "", -- Default is 
      warning = "", -- Default is 
      error = "", -- Default is 
    }
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
  -- configuration options for the system open command (`s` in the tree by default)
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd = nil,
    -- the command arguments as a list
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = { '.git' }
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    width = 40,
    -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
    height = 30,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
    auto_resize = false,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = {}
    }
  },
  actions = {
    change_dir = {
      enable = true,
      global = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = false,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", },
          buftype  = { "nofile", "terminal", "help", },
        }
      }
    }
  },
  tab_open = false,
}

-- Keybindings
vim.api.nvim_set_keymap(
  'n',
  '<C-n>',
  ':NvimTreeToggle<CR>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>r',
  ':NvimTreeRefresh<CR>',
  { noremap = true, silent = true }
)
