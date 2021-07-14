local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local opts = { noremap = true, silent = false }

  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- Show diagnostics on hover
  vim.cmd 'autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})'

  -- Configure LSP signature plugin
  require'lsp_signature'.on_attach({
    bind = true,
    handler_opts = {
      border = null
    },
    hint_enable = false
  })
end

local nvim_lsp = require('lspconfig')

-- Use a loop to conveniently call 'setup' on multiple servers with default
-- configuration and map buffer local keybindings when the language server
-- attaches
local servers = { 'pyright', 'gopls', 'pylsp' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup { on_attach = on_attach }
end

-- Pyright python LSP configuration
nvim_lsp['pyright'].setup {
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = 'strict'
      }
    }
  }
}

-- Pylsp python LSP configuration
-- Only pyright is used for keybindings (on_attach)
nvim_lsp['pylsp'].setup {
  settings = {
    pylsp = {
      plugins = {
        pydocstyle = { enabled = false },
        jedi_completion = { enabled = false },
        jedi_definition = { enabled = false },
        yapf = { enabled = false },
        rope_completion = { enabled = false },
        pylint = { enabled = false },
        pyflakes = { enabled = false },
        preload = { enabled = false },
        mccabe = { enabled = false },
        jedi_symbols = { enabled = false },
        jedi_references = { enabled = false },
      },
      -- Use flake8 instead of pycodestyle
      configurationSources = 'flake8'
    }
  }
}

nvim_lsp['jsonls'].setup {
  on_attach = on_attach,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
}

-- Set custom diagnostic signs (the same as in `trouble.nvim` plugin)
vim.fn.sign_define(
  'LspDiagnosticsSignError',
  {text = '', numhl = 'LspDiagnosticsDefaultError'}
)
vim.fn.sign_define(
  'LspDiagnosticsSignWarning',
  {text = '', numhl = 'LspDiagnosticsDefaultWarning'}
)
vim.fn.sign_define(
  'LspDiagnosticsSignInformation',
  {text = '', numhl = 'LspDiagnosticsDefaultInformation'}
)
vim.fn.sign_define(
  'LspDiagnosticsSignHint',
  {text = '', numhl = 'LspDiagnosticsDefaultHint'}
)

-- Disable diagnostics virtual text
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
  }
)
