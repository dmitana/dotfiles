local ls = require('luasnip')

ls.snippets = {
	-- When trying to expand a snippet, luasnip first searches the tables for
	-- each filetype specified in 'filetype' followed by 'all'.
	-- If ie. the filetype is 'lua.c'
	--     - luasnip.lua
	--     - luasnip.c
	--     - luasnip.all
	-- are searched in that order.
	all = {}
}

-- Beside defining your own snippets you can also load snippets from 'vscode-like' packages
-- that expose snippets in json files, for example <https://github.com/rafamadriz/friendly-snippets>.
-- Mind that this will extend  `ls.snippets` so you need to do it after your own snippets or you
-- will need to extend the table yourself instead of setting a new one.

-- Lazy loading so you only get in memory snippets of languages you use
require('luasnip/loaders/from_vscode').lazy_load({
  include = {
    'python'
  }
})
