-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

local luasnip = require 'luasnip'
local cmp = require'cmp'

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'calc' },
    { name = 'luasnip' },
  },
  formatting = {
    format = function(entry, vim_item)
      -- fancy icons and a name of kind
      vim_item.kind = require('lspkind').presets.default[vim_item.kind] .. ' ' .. vim_item.kind

      -- set a name for each source
      vim_item.menu = ({
        nvim_lsp = '[LSP]',
        nvim_lua = '[Lua]',
        path = '[Path]',
        buffer = '[Buffer]',
        calc = '[Calc]',
        luasnip = '[LuaSnip]',
      })[entry.source.name]
      return vim_item
    end,
  },
})

-- Custom highlights
vim.cmd "highlight link CmpItemMenu Pmenu"
