require('neotest').setup({
  adapters = {
    require('neotest-python')({
      dap = { justMyCode = false },
      args = { '-vv' },
    }),
    require('neotest-jest')({
      -- jestCommand = "npm test --",
      -- jestConfigFile = "custom.jest.config.ts",
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
    require('neotest-plenary'),
    require('neotest-vim-test')({
      ignore_file_types = { 'python', 'javascript', 'typescript', 'vim', 'lua' },
    }),
  },
  status = {
    enabled = true,
    signs = false,
    virtual_text = true,
  },
  quickfix = {
    enabled = false,
    open = false,
  },
})

local opts = { noremap = true, silent = true}
-- Run the current file
vim.api.nvim_set_keymap('n', '<leader>tf', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', opts)
-- Run the nearest test
vim.api.nvim_set_keymap('n', '<leader>tn', '<cmd>lua require("neotest").run.run()<CR>', opts)
-- Debug the nearest test (requires nvim-dap and adapter support)
vim.api.nvim_set_keymap('n', '<leader>td', '<cmd>lua require("neotest").run.run({strategy = "dap"})<CR>', opts)
-- Stop the nearest test
vim.api.nvim_set_keymap('n', '<leader>tq', '<cmd>lua require("neotest").run.stop()<CR>', opts)
-- Attach to the nearest test,
vim.api.nvim_set_keymap('n', '<leader>ta', '<cmd>lua require("neotest").run.attach()<CR>', opts)
-- Toggle the summary window
vim.api.nvim_set_keymap('n', '<leader>ts', '<cmd>lua require("neotest").summary.toggle()<CR>', opts)
