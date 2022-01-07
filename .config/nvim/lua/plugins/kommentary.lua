require('kommentary.config').configure_language('default', {
    prefer_single_line_comments = true,
    hook_function = function()
      require('ts_context_commentstring.internal').update_commentstring()
    end,
})
