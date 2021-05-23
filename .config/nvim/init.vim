" ===== Plugins =====
call plug#begin('~/.config/nvim/bundle')
" General language support
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Nodejs extension host for vim & neovim, load extensions like VSCode and host language servers

" Python
Plug 'Vimjas/vim-python-pep8-indent' " A nicer Python indentation style for vim
" Tag 2.0.0 has bug and it is not working in nvim
Plug 'heavenshell/vim-pydocstring', {'branch': 'master', 'tag': '1.0.0'} " Generate Python docstring to your Python source code
Plug 'tmhedberg/SimpylFold' " No-BS Python code folding for Vim

" C#
Plug 'OmniSharp/omnisharp-vim' " Vim omnicompletion (intellisense) and more for C#

" R
Plug 'jalvesaq/Nvim-R' " Vim plugin to work with R

" Databases
Plug 'tpope/vim-dadbod' " Modern database interface for Vim (PostgreSQL, MySQL, MongoDB, Redis, and many more)
Plug 'kristijanhusak/vim-dadbod-ui' " Simple UI for vim-dadbod

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " Markdown preview plugin for (neo)vim

" General coding support
Plug 'scrooloose/nerdcommenter' " Vim plugin for intensely nerdy commenting powers
Plug 'tpope/vim-surround' " Quoting/parenthesizing made simple
Plug 'honza/vim-snippets' " vim-snipmate default snippets (Previously snipmate-snippets)

" Syntax highlighting
Plug 'sheerun/vim-polyglot' " A solid language pack for Vim (syntax highlighting)
Plug 'ntpeters/vim-better-whitespace' " Better whitespace highlighting for Vim

" Themes and styles
Plug 'morhetz/gruvbox' " Retro groove color scheme for Vim
Plug 'vim-airline/vim-airline'  " Lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline-themes' " A collection of themes for vim-airline
Plug 'ryanoasis/vim-devicons' " Adds file type icons to Vim plugins such as: NERDTree, vim-airline, CtrlP, unite, Denite, lightline, vim-startify and many more

" Git support
Plug 'tpope/vim-fugitive' " A Git wrapper so awesome, it should be illegal
Plug 'airblade/vim-gitgutter' " A Vim plugin which shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks
Plug 'Xuyuanp/nerdtree-git-plugin' " A plugin of NERDTree showing git status

" Navigation
Plug 'scrooloose/nerdtree' " A tree explorer plugin for vim
Plug 'jistr/vim-nerdtree-tabs' " NERDTree and tabs together in Vim, painlessly
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file, buffer, mru, tag, etc finder

" Spelling
Plug 'kamykn/spelunker.vim' " Improved vim spelling plugin (with camel case support)

" General tools
Plug 'tpope/vim-dotenv' " Basic support for .env and Procfile
Plug 'tpope/vim-eunuch' " Helpers for UNIX
Plug 'yssl/QFEnter' " Open a Quickfix item in a window you choose

" Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'nikvdp/neomux'
call plug#end()

" ===== NVIM configuration =====
filetype indent plugin on
set termguicolors
" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Tab navigation
nnoremap <M-l> gt
nnoremap <M-h> gT

" Autoopen of quickfix list (etc. after vimgrep)
augroup autoquickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost    l* lwindow
augroup END

" Map navigation in quickfix list
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>

" Access system clipboard in VIM
set clipboard=unnamed

" Turn off search highlighting
set nohlsearch

" Show tabline even if only one file is open
set showtabline=2

" Show cursor line
set cursorline

" Set relative number on focus and norelative number when lost focus
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set number relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Map yanking to PRIMARY and CLIPBOARD registers
" PRIMARY (*) mnemonic: Star is Select (for copy-on-select)
" CLIPBOARD (+) mnemonic: CTRL PLUS C (for the common keybind)
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" General file configuration
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set encoding=utf-8

" ===== Plugins configuration =====
" --- Spelunker plugin ---
set nospell
let g:enable_spelunker_vim = 0

" --- CtrlP plugin ---
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" --- NERDTree plugin ---
"map <Leader>n <plug>NERDTreeTabsToggle<CR>
map <F5> <plug>NERDTreeTabsToggle<CR>
"nnoremap <F5> :NERDTreeToggle<CR>
" Ignore files and directories in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$', '^__pycache__$[[dir]]']

" --- Gruvbox plugin ---
let g:gruvbox_guisp_fallback="bg"
colorscheme gruvbox

" --- Airline plugin ---
" Set airline theme
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1

" --- QFEnter plugin ---
" Set QFEnter key mappings as in CtrlP
let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']

" --- SimplyFold plugin ---
set foldlevelstart=99
let g:SimpylFold_docstring_preview = 1

" --- Vim Devicons plugin ---
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ' '

" --- Vim-dadbod plugin ---
" Map exec line and selection in DB
" To set db url use `:let g:db = 'url'`
" Or use Vim-Dotenv `:let g:db = DotenvGet('DB_URL')`
xnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExeLine) db#op_exec() . '_'
xmap <leader>db  <Plug>(DBExe)
nmap <leader>db  <Plug>(DBExe)
omap <leader>db  <Plug>(DBExe)
nmap <leader>dbb <Plug>(DBExeLine)

" --- Vim Polyglot plugin ---
let g:python_highlight_all = 1

" --- Coc plugin ---
" Coc global extensions
let g:coc_global_extensions = [
    \ 'coc-pyright',
    \ 'coc-python',
    \ 'coc-pairs',
    \ 'coc-snippets',
    \ 'coc-json',
    \ 'coc-r-lsp',
    \ 'coc-explorer',
    \ 'coc-tsserver',
    \ 'coc-html',
	\ 'coc-yaml',
	\ 'coc-sql',
	\ 'coc-db',
	\ 'coc-omnisharp'
    \ ]

" coc-omnisharp
let $FrameworkPathOverride="~/.config/coc/extensions/coc-omnisharp-data/server/omnisharp"

" To make completion works like VSCode
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

" Coc scroll floating window
nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"

" Coc.nvim settings from README.md
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <C-d> <Plug>(coc-range-select)
"xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" coc-explorer
nmap <space>e :CocCommand explorer<CR>
let g:coc_explorer_global_presets = {
\   '.vim': {
\      'root-uri': '~/.vim',
\   },
\   'floating': {
\      'position': 'floating',
\   },
\   'floatingLeftside': {
\      'position': 'floating',
\      'floating-position': 'left-center',
\      'floating-width': 50,
\   },
\   'floatingRightside': {
\      'position': 'floating',
\      'floating-position': 'left-center',
\      'floating-width': 50,
\   },
\   'simplify': {
\     'file.child.template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }

" Use preset argument to open it
nmap <space>ed :CocCommand explorer --preset .vim<CR>
nmap <space>ef :CocCommand explorer --preset floating<CR>

" List all presets
nmap <space>el :CocList explPresets

" coc-explorer
nmap <space>e :CocCommand explorer<CR>
let g:coc_explorer_global_presets = {
\   '.vim': {
\      'root-uri': '~/.vim',
\   },
\   'floating': {
\      'position': 'floating',
\   },
\   'floatingLeftside': {
\      'position': 'floating',
\      'floating-position': 'left-center',
\      'floating-width': 50,
\   },
\   'floatingRightside': {
\      'position': 'floating',
\      'floating-position': 'left-center',
\      'floating-width': 50,
\   },
\   'simplify': {
\     'file.child.template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }

" Use preset argument to open it
nmap <space>ed :CocCommand explorer --preset .vim<CR>
nmap <space>ef :CocCommand explorer --preset floating<CR>

" List all presets
nmap <space>el :CocList explPresets
