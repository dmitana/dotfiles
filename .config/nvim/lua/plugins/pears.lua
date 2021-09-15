local R = require'pears.rule'

require'pears'.setup(function(conf)
  conf.preset 'tag_matching'

  -- Python f-string pairs
  conf.pair("'", {
    close = "'",
    filetypes = { 'python' },
    should_expand = R.all_of(
      R.not_(R.child_of_node'string')
    )
  })
  conf.pair('"', {
    close = '"',
    filetypes = { 'python' },
    should_expand = R.all_of(
      R.not_(R.child_of_node'string')
    )
  })
end)
