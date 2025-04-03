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
  local opts = { noremap = true, silent = true }

  local telescope = function(picker)
      return string.format("<cmd> lua require('telescope.builtin').%s()<CR>", picker)
  end

  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gd', telescope('lsp_definitions'), opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gr', telescope('lsp_references'), opts)
  buf_set_keymap('n', 'gw', telescope('lsp_document_symbols'), opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float({ focus = false, focusable = true })<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- Show diagnostics on hover
  -- vim.cmd 'autocmd CursorHold <buffer> lua vim.diagnostic.open_float({ focus = false, focusable = true })'

  -- Configure LSP signature plugin
  require'lsp_signature'.on_attach({
    bind = true,
    handler_opts = {
      border = null
    },
    hint_enable = false
  })
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

-- Helper no operation function for disabling some textDocument handlers in given clients
local noop = function() return {} end

local nvim_lsp = require('lspconfig')

-- Use a loop to conveniently call 'setup' on multiple servers with default
-- configuration and map buffer local keybindings when the language server
-- attaches
local servers = { 'pyright', 'gopls', 'pylsp', 'html', 'cssls', 'ts_ls', 'eslint' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities
  }
end

-- Pyright python LSP configuration
nvim_lsp['pyright'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
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
  capabilities = capabilities,
  handlers = {
    ['textDocument/hover'] = noop,
    ['textDocument/signatureHelp'] = noop,
    ['textDocument/rename'] = noop,
  },
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
  capabilities = capabilities,
  commands = { }
}

-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
--   vim.lsp.handlers.hover, { focusable = false }
-- )

-- Diagnostics config
vim.diagnostic.config({
    virtual_text = false, -- Disable virtual text
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
})

-- Set custom diagnostic signs (the same as in `trouble.nvim` plugin)
vim.fn.sign_define(
  'DiagnosticSignError',
  {text = '', texthl = 'DiagnosticError', numhl = 'DiagnosticError'}
)
vim.fn.sign_define(
  'DiagnosticSignWarn',
  {text = '', texthl = 'DiagnosticWarn', numhl = 'DiagnosticWarn'}
)
vim.fn.sign_define(
  'LspDiagnosticsSignInformation',
  {text = '', texthl = 'DiagnosticInfo', numhl = 'DiagnosticInfo'}
)
vim.fn.sign_define(
  'LspDiagnosticsSignHint',
  {text = '', texthl = 'DiagnosticHint', numhl = 'DiagnosticHint'}
)
