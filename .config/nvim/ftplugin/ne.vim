" Sections
function! s:NextSection(backwards, visual)
    if a:visual
        normal! gv
    endif

    let pattern = '<ne type="[^"]*">' 

    if a:backwards
        let dir = '?'
    else
        let dir = '/'
    endif

    let pos = getpos('.')
    let pos[2] -= 10
    call setpos('.', pos)
    execute 'silent normal! ' . dir . pattern . "\r"
    let pos = getpos('.')
    let pos[2] += 10
    call setpos('.', pos)
endfunction

noremap <script> <buffer> <silent> ]]
        \ :call <SID>NextSection(0, 0)<CR>

noremap <script> <buffer> <silent> [[
        \ :call <SID>NextSection(1, 0)<CR>

vnoremap <script> <buffer> <silent> ]]
        \ :<c-u>call <SID>NextSection(0, 1)<CR>

vnoremap <script> <buffer> <silent> [[
        \ :<c-u>call <SID>NextSection(1, 1)<CR>

" Insert annotation opening tag
inoremap <C-A> <ne type=""><LEFT><LEFT>
nnoremap <C-A> i<ne type=""><LEFT><LEFT>

" Insert annotation closing tag
inoremap <C-D> </ne>
nnoremap <C-D> a</ne><C-[>

" Remove annotation (surrounding opening and closing tags)
if exists("$CREAM")
    inoremap <C-W> <RIGHT><C-O>?<ne <CR><C-O>v/>/e+1<CR>d<C-O>/<\/n<CR><C-O>5x
else
    inoremap <C-W> <C-O>?<ne <CR><C-O>v/><CR>d<C-O>/<\/n<CR><C-O>5x
    nnoremap <C-W> ?<ne <CR>v/><CR>d/<\/n<CR>5x
endif

" Find next
inoremap <C-N> <C-O>/<ne type="<CR><C-O>10<RIGHT>
nnoremap <C-N> /<ne type="<CR>10<RIGHT>

" Find previous
inoremap <C-P> <C-O>10<LEFT><C-O>?<ne type="<CR><C-O>10<RIGHT>
nnoremap <C-P> 10<LEFT>?<ne type="<CR>10<RIGHT>

" Insert annotation in visual mode
vnoremap <C-A> c<ne type=""<Esc>maa><C-R>"</ne><C-O>`a

" Insert comment
nnoremap <C-?> V:s/^\(.*\)$/<!-- \1 -->/<CR>
if exists("$CREAM")
    inoremap <C-?> <Esc>V:s/^\(.*\)$/<!-- \1 -->/<CR>i
    vnoremap <C-?> c<!--<CR><C-R>"<CR>--><C-O>^<CR>
else
    vnoremap <C-?> c<!--<CR><C-R>"--><Esc>^<DOWN>
endif

" Set colorscheme
colorscheme ne
