-- INTERNAL VIM LSP & DIAGNOSTIC CONFIG
-- This controls how errors/warnings look globally
vim.diagnostic.config({
  virtual_text = { prefix = "●" },
  -- virtual_text = false, -- TODO: Old setting
  -- update_in_insert = false,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ", -- Trouble's default Error icon
      [vim.diagnostic.severity.WARN]  = "󰀪 ", -- Trouble's default Warn icon
      [vim.diagnostic.severity.INFO]  = "󰋽 ", -- Trouble's default Info icon
      [vim.diagnostic.severity.HINT]  = "󰌶 ", -- Trouble's default Hint icon
    },
  },
  float = { focus = false, focusable = true },
})

-- GLOBAL LSP ATTACH LOGIC (Advanced on_attach replacement)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local bufnr = ev.buf

    -- Helper for mappings
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc, noremap = true, silent = true })
    end

    -- Telescope integrations from your old file
    local ts = require("telescope.builtin")

    map("gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("gd", ts.lsp_definitions, "Goto Definition (Telescope)")
    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("gi", vim.lsp.buf.implementation, "Goto Implementation")
    map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
    map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
    map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
    map("<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "List Workspace Folders")
    map("<leader>D", vim.lsp.buf.type_definition, "Type Definition")
    map("<leader>rn", vim.lsp.buf.rename, "Rename")
    map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
    map("gr", ts.lsp_references, "Goto References (Telescope)")
    map("gw", ts.lsp_document_symbols, "Document Symbols (Telescope)")
    map("<space>e", function() vim.diagnostic.open_float({ focus = false, focusable = true }) end, "Open Float")
    map("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Previous Diagnostic")
    map("]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next Diagnostic")
    map("<leader>q", vim.diagnostic.setloclist, "Set Loclist")
    map("<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format File")

    -- Enable Inlay Hints if supported
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- TODO: What is this?
    -- Set omnifunc for completion
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end,
})
