require'trouble'.setup {
  auto_preview = false,
  auto_fold = true,
}

-- Keys --
local trouble = require("trouble")

vim.keymap.set("n", "<leader>bd", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>bD", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>bn", "<cmd>Trouble todo<CR>", { desc = "Buffer Diagnostics (Trouble)" })
