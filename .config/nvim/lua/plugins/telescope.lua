local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_position = 'bottom',
    prompt_prefix = '> ',
    selection_caret = '> ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'descending',
    layout_strategy = 'flex',
    layout_defaults = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
      flex = {
        flip_columns = 130,
      }
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,

    mappings = {
      i = {
        -- Remap previous/next selection
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
      },
    },
  }
}

local telescope = function(picker)
    return string.format("<cmd> lua require('telescope.builtin').%s()<CR>", picker)
end

-- Keybindings
vim.api.nvim_set_keymap('n', '<leader>ff', telescope('find_files'), { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>fg', telescope('live_grep'), { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>fb', telescope('buffers'), { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>fh', telescope('help_tags'), { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>ca', telescope('lsp_code_actions'), { noremap = true, silent = false })