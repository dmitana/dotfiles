local R = require'pears.rule'

require'pears'.setup(function(conf)
  conf.preset 'tag_matching'

  -- Python f-string pairs
  conf.pair("f'", {
    close = "'",
    filetypes = { 'python' },
    should_expand = R.not_(R.child_of_node'string')
  })
  conf.pair('f"', {
    close = '"',
    filetypes = { 'python' },
    should_expand = R.not_(R.child_of_node'string')
  })

  -- Completion integration
  conf.on_enter(function(pears_handle)
    if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
      return vim.fn["compe#confirm"]("<CR>")
    else
      pears_handle()
    end
  end)
end)
