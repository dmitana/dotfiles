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

-- FIXME: Fix
-- Toggle folke/trouble.nvim for diagnostics
-- vim.api.nvim_set_keymap('n', '<Leader>bd', toolwindow('open_window("trouble", nil)'), opts)

-- FIXME: Fix
-- Toggle folke/todo-comments.nvim for ToDos
-- vim.api.nvim_set_keymap('n', '<Leader>bn', toolwindow('open_window("todo", nil)'), opts)

-- Configure live test execution per language
--
-- Python
vim.cmd 'autocmd FileType python nnoremap <Leader>bl :lua require("toolwindow").open_window("autobuild", {filetype = "py", cmd = "pytest"})<CR>'


local windows = require("toolwindow")
local Trouble = require("trouble")
local function goto_parent()
    if parent and vim.api.nvim_win_is_valid(parent) then
      vim.api.nvim_set_current_win(parent)
    end
end
local function trouble_open(plugin, args)
    -- validate_trouble()
    if args == nil then
        args = "diagnostics"
    end
    if plugin == nil then
        Trouble.open(args)
        goto_parent()
        return Trouble
    else
        plugin.open(args)
        goto_parent()
    end
end
local function standard_close(plugin)
    if plugin ~= nil and plugin.close ~= nil then
        plugin.close()
    end
end

windows.register("trbl", Trouble, standard_close, trouble_open)
vim.api.nvim_set_keymap('n', '<Leader>bx', toolwindow('open_window("trbl", nil)'), opts)
