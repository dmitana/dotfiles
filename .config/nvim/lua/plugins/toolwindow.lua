local toolwindow = function(picker)
    return string.format("<cmd> lua require('toolwindow').%s<CR>", picker)
end

local opts = { noremap = false, silent = true}

-- Close toolwindow
vim.api.nvim_set_keymap('n', '<Leader>bc', toolwindow('close()'), opts)

-- Toggle quickfix list (:copen)
vim.api.nvim_set_keymap('n', '<Leader>bq', toolwindow('open_window("quickfix", nil)'), opts)

-- " use akinsho/nvim-toggleterm.lua
vim.api.nvim_set_keymap('n', '<Leader>bt', toolwindow('open_window("term", nil)'), opts)

-- Toggle folke/trouble.nvim for diagnostics
vim.api.nvim_set_keymap('n', '<Leader>bd', toolwindow('open_window("trouble", nil)'), opts)

-- Toggle folke/todo-comments.nvim for ToDos
vim.api.nvim_set_keymap('n', '<Leader>bn', toolwindow('open_window("todo", nil)'), opts)

-- Configure live test execution per language
--
-- Python
vim.cmd 'autocmd FileType python nnoremap <Leader>bl :lua require("toolwindow").open_window("autobuild", {filetype = "py", cmd = "pytest"})<CR>'
