local prettier = function()
  return {
    exe = 'prettier',
    args = {'--stdin-filepath', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
    stdin = true
  }
end

local black = function()
  return {
    exe = 'black',
    args = { '-' },
    stdin = true,
  }
end

require('formatter').setup({
  filetype = {
    javascript = { prettier },
    typescript = { prettier },
    typescriptreact = { prettier },
    python = { black },
  }
})
