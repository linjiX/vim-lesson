filetype plugin indent on
syntax on

let mapleader="\<Space>"

set encoding=utf-8

set number
set backspace=indent,eol,start
set hidden

set incsearch
set hlsearch

set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

set nowrap
set scrolloff=1
set nrformats=bin,hex
set formatoptions=tcqj

set autoread
set ruler

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set wildmenu
set wildmode=longest:full,full

set autoindent
set smartindent
set cindent

set updatetime=10

set colorcolumn=100
set cursorline
set cursorcolumn

set noshowmode

if has('macunix')
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif

" Change cursor shape in different modes
let &t_EI .= "\e[1 q"  " EI = NORMAL mode (ELSE)
let &t_SR .= "\e[3 q"  " SR = REPLACE mode
let &t_SI .= "\e[5 q"  " SI = INSERT mode

noremap + :<C-u>bnext<CR>
noremap _ :<C-u>bprevious<CR>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <silent> <C-w><C-m> :call Tabopen()<CR>
noremap <C-p> "0p

function Tabopen() abort
    let l:view = winsaveview()
    tabnew %
    call winrestview(l:view)
endfunction

augroup myAutocmd
    autocmd!
    autocmd BufWritePost ~/.vimrc source %
    autocmd BufWinEnter * if &buftype=="help" | wincmd L
    autocmd FileType vim,help setlocal keywordprg=:help
    autocmd FileType gitcommit setlocal colorcolumn=72
    autocmd FileType * setlocal formatoptions-=cro
augroup END

" vim-plug
let g:plug_window = 'vertical botright new'

call plug#begin('~/.vim/plugged')
" lesson 1
Plug 'tpope/vim-surround'
Plug 'linjiX/vim-star', {'on': '<Plug>(star-'}
Plug 'preservim/tagbar', {'on': ['Tagbar', 'TagbarOpen']}
Plug 'tomasr/molokai'

" lesson 2
Plug 'tpope/vim-repeat'
Plug 'preservim/nerdcommenter'
Plug 'yianwillis/vimcdoc'
Plug 'tpope/vim-unimpaired'

" lesson 3
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'google/vim-searchindex'
Plug 'tpope/vim-endwise'

" lesson 4
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" lesson 5
Plug 'rbong/vim-flog', {'on': ['Flog', 'Flogsplit']}
Plug 'tpope/vim-rhubarb'

call plug#end()

augroup myColorScheme
    autocmd!
    autocmd ColorScheme molokai
                \ highlight Visual ctermbg=238 guibg=#444444 |
                \ highlight link NormalFloat Visual |
                \ highlight! link CursorLine CursorColumn

augroup END
colorscheme molokai

vmap <silent> * <Plug>(star-*):SearchIndex<CR>
vmap <silent> # <Plug>(star-#):SearchIndex<CR>
nmap <silent> * <Plug>(star-*):SearchIndex<CR>
nmap <silent> # <Plug>(star-#):SearchIndex<CR>
nmap <silent> g* <Plug>(star-g*):SearchIndex<CR>
nmap <silent> g# <Plug>(star-g#):SearchIndex<CR>

let g:tagbar_position = 'topleft vertical'
let g:tagbar_width = 30

let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1

" airline/airline
let g:airline_powerline_fonts = 1

let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'

let g:airline#extensions#searchcount#enabled = 0

let g:airline#extensions#whitespace#long_format = 'L[%s]'
let g:airline#extensions#whitespace#trailing_format = 'T[%s]'
let g:airline#extensions#whitespace#conflicts_format = 'C[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'i[%s]'
let g:airline#extensions#whitespace#mixed_indent_file_format = 'I[%s]'
let g:airline#extensions#whitespace#skip_indent_check_ft = {
            \   'markdown': ['trailing'],
            \}

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_tabs = 0

let g:airline#extensions#hunks#non_zero_only = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.dirty = '*'
let g:airline_symbols.readonly = ' '
let g:airline_symbols.linenr = ' '
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.whitespace = ''

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>0 <Plug>AirlineSelectTab0

" tpope/vim-fugitive
nnoremap gb :.GBrowse<CR>
vnoremap gb :GBrowse<CR>

command! -bar -bang Gst vertical botright Git<bang>
command! -nargs=? -complete=customlist,fugitive#CommitComplete Gc
            \ vertical botright Git commit -v <args>
command! -nargs=? -complete=customlist,fugitive#CommitComplete Gca
            \ vertical botright Git commit -v -a <args>

" airblade/vim-gitgutter
let g:gitgutter_preview_win_floating = 1

omap ig <Plug>(GitGutterTextObjectInnerPending)
omap ag <Plug>(GitGutterTextObjectOuterPending)
xmap ig <Plug>(GitGutterTextObjectInnerVisual)
xmap ag <Plug>(GitGutterTextObjectOuterVisual)

nnoremap [rg :GitGutterEnable<CR>
nnoremap ]rg :GitGutterDisable<CR>
nnoremap yrg :GitGutterToggle<CR>

nnoremap [rG :GitGutterBufferEnable<CR>
nnoremap ]rG :GitGutterBufferDisable<CR>
nnoremap yrG :GitGutterBufferToggle<CR>

" rbong/vim-flog
let g:flog_permanent_default_arguments = {
            \   'date': 'short',
            \}
augroup flog
    autocmd FileType floggraph nnoremap <buffer> gb :<C-U>call flog#run_command("GBrowse %(h)")<CR>
augroup END

" GBrowse for phabricator
function s:HomepageForUrl(url) abort
    let l:host_pattern = 'phabricator.*'
    let l:hosts = get(g:, 'phabricator_hosts', [])
    call map(copy(l:hosts), 'substitute(v:val, "/$", "", "")')
    for l:host in l:hosts
        let l:host_pattern .= '\|' . escape(split(l:host, '://')[-1], '.')
    endfor

    let l:base_pattern =
                \ '^\%(https\=://\|git://\|git@\|ssh://code@\|ssh://git@\)\=\zs\('.
                \ l:host_pattern .
                \ '\)\/diffusion[/:][^/]\{-\}\ze[/:].\{-\}\%(\.git\)\=$'

    let l:base = matchstr(a:url, l:base_pattern)
    if !empty(l:base)
        let l:base = substitute(l:base, ':\d\{4}', '', '')
        return 'https://' . tr(l:base, ':', '/')
    endif
    return ''
endfunction

function s:FugitiveUrl(...) abort
    if a:0 == 1 || type(a:1) == v:t_dict
        let l:opts = a:1
        let l:root = s:HomepageForUrl(get(l:opts, 'remote', ''))
    else
        return ''
    endif
    if empty(l:root)
        return ''
    endif
    let l:path = substitute(l:opts.path, '^/', '', '')
    if l:path =~# '^\.git/refs/heads/'
        return l:root . '/history/' . l:path[16:-1]
    elseif l:path =~# '^\.git/refs/tags/'
        return l:root . '/history/;' . l:path[15:-1]
    elseif l:path =~# '^\.git\>'
        return l:root
    endif
    let l:branch = substitute(FugitiveHead(), '/', '%252F7', 'g')
    if empty(l:branch)
        let l:branch = 'master'
    endif
    let l:commit = l:opts.commit
    if l:commit =~# '^\d\=$'
        return ''
    endif
    if get(l:opts, 'type', '') ==# 'tree' || l:opts.path =~# '/$'
        let l:url = substitute(l:root . '/browse/' . l:branch . '/' . l:path, '/$', '', '')
    elseif get(l:opts, 'type', '') ==# 'blob' || l:opts.path =~# '[^/]$'
        let l:url = l:root . '/browse/' . l:branch . '/' . l:path . ';' . l:commit
        if get(l:opts, 'line2') && l:opts.line1 == l:opts.line2
            let l:url .= '$' . l:opts.line1
        elseif get(l:opts, 'line2')
            let l:url .= '$' . l:opts.line1 . '-' . l:opts.line2
        endif
    else
        let l:url = substitute(l:root, '/diffusion/', '/R', '') . ':' . l:commit
    endif
    return l:url
endfunction

if !exists('g:fugitive_browse_handlers')
    let g:fugitive_browse_handlers = []
endif

if index(g:fugitive_browse_handlers, function('s:FugitiveUrl')) == -1
    call insert(g:fugitive_browse_handlers, function('s:FugitiveUrl'))
endif

