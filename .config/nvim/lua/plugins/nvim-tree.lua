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

vim.g.nvim_tree_side = 'left'
vim.g.nvim_tree_width = 40
vim.g.nvim_tree_ignore = { '.git' }
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_auto_open = 0 -- Opens the tree when typing `vim $DIR` or `vim`
vim.g.nvim_tree_auto_close = 1 -- Closes the tree when it's the last window
vim.g.nvim_tree_auto_ignore_ft = { 'startify', 'dashboard' } -- Don't auto open tree on specific filetypes
vim.g.nvim_tree_quit_on_open = 0 -- Closes the tree when you open a file
vim.g.nvim_tree_follow = 1 -- This option allows the cursor to be updated when entering a buffer
vim.g.nvim_tree_indent_markers = 1 -- Indent markers when folders are open
vim.g.nvim_tree_hide_dotfiles = 1 -- This option hides files and folders starting with a dot `.`
vim.g.nvim_tree_git_hl = 1 -- Will enable file highlight for git attributes (can be used without the icons).
vim.g.nvim_tree_highlight_opened_files = 1 -- Will enable folder and file icon highlight for opened files/directories.
-- TODO: see other options
vim.g.nvim_tree_root_folder_modifier = ':~' -- This is the default. See :help filename-modifiers for more options
vim.g.nvim_tree_tab_open = 0 -- Will open the tree when entering a new tab and the tree was previously open
vim.g.nvim_tree_width_allow_resize  = 1 -- Will resize the tree when opening a file
vim.g.nvim_tree_disable_netrw = 0 -- Disables netrw
vim.g.nvim_tree_hijack_netrw = 0 -- Prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
vim.g.nvim_tree_add_trailing = 1 -- Append a trailing slash to folder names
vim.g.nvim_tree_group_empty = 1 -- Compact folders that only contain a single folder into one node in the file tree
vim.g.nvim_tree_lsp_diagnostics = 1 -- Will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
vim.g.nvim_tree_disable_window_picker = 1 -- Will disable the window picker.
-- Dictionary of buffer option names mapped to a list of option values that
-- indicates to the window picker that the buffer's window should not be
-- selectable.
vim.g.nvim_tree_window_picker_exclude = {
  filetype = { 'packer', 'qf' },
  buftype = { 'terminal' }
}
vim.g.nvim_tree_special_files = { 'README.md', 'Makefile', 'MAKEFILE' } -- List of filenames that gets highlighted with NvimTreeSpecialFile
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
  },
  -- TODO: change to icons used in LSP
  lsp = {
    hint = "",
    info = "",
    warning = "",
    error = "",
  }
}

-- TODO: does not work, fix
-- " a list of groups can be found at `:help nvim_tree_highlight`
vim.cmd('highlight NvimTreeFolderIcon guibg=blue')
