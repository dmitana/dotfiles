local actions = require('telescope.actions')
local telescope = require('telescope')
local lga_actions = require('telescope-live-grep-args.actions')

telescope.setup {
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
    prompt_prefix = '> ',
    selection_caret = '> ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'descending',
    layout_strategy = 'flex',
    layout_config = {
      width = 0.95,
      prompt_position = 'bottom',
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
        preview_cutoff = 50,
      },
      flex = {
        flip_columns = 130,
      }
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {
      '^.git/'
    },
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
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
  },
  pickers = {
    lsp_references = {
      fname_width = 50,
      trim_text = true,
    },
  },
  extensions = {
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      mappings = {
        i = {
          ["<C-g>"] = lga_actions.quote_prompt({ postfix = " --iglob **/" }),
          ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t " }),
        },
      },
    }
  }
}

telescope.load_extension('live_grep_args')

local telescope_fn = function(picker)
    return string.format("<cmd> lua require('telescope.builtin').%s<CR>", picker)
end

-- Keybindings
vim.api.nvim_set_keymap('n', '<leader>ff', telescope_fn('find_files({ hidden = true })'), { noremap = true, silent = false })
-- vim.api.nvim_set_keymap('n', '<leader>fg', telescope_fn('live_grep()'), { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd> lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>fb', telescope_fn('buffers()'), { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>fh', telescope_fn('help_tags()'), { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>gc', telescope_fn('git_commits()'), { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>gb', telescope_fn('git_branches()'), { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>tb', telescope_fn('builtin()'), { noremap = true, silent = false })
