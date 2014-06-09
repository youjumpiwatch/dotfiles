syntax enable
filetype plugin indent on

colorscheme darkblue

set number
set nowrap
set nocompatible
set backspace=indent,eol,start
set t_kb=
set nobackup
set noswapfile
set mouse=a
set errorformat=%m\ in\ %f\ on\ line\ %l
set ruler
set updatetime=500
set mousemodel=popup
set pumheight=16
set synmaxcol=256

set langmenu=en_US
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set rtp^=$HOME/.vim

" tabline
if exists("+showtabline")
  function TabLine()
    let s = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
      let buflist = tabpagebuflist(i)
      let winnr = tabpagewinnr(i)
      let s .= '%' . i . 'T'
      let s .= (i == t ? '%1*' : '%2*')
      let s .= ' '
      let s .= i . ')'
      let s .= ' %*'
      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
      let file = bufname(buflist[winnr - 1])
      let file = fnamemodify(file, ':p:t')
      if file == ''
        let file = '[No Name]'
      endif
      let s .= file
      let i = i + 1
    endwhile
    let s .= '%T%#TabLineFill#%='
    let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s
  endfunction
  set stal=2
  set tabline=%!TabLine()
endif

" statusline
set laststatus=2
set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%d/%m/%Y-%H:%M\")}%=\ ASCII:%b\ POS:%o\ COL:%c%V\ ROW:%l\,%L\ %P

" gvim
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Monospace\ 8
  elseif has("gui_win32")
    set guifont=Microsoft\ YaHei\ Mono:h8
  endif
  set guioptions+=b
endif

" fold
set foldmethod=manual
set nofoldenable

" search
set hlsearch
set incsearch

" cursor indicator
"set cursorline
"set cursorcolumn

set showcmd
set showmatch
set showmode

" list chars
set list
set listchars=tab:\|\ ,extends:>

" tabwidth
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab

" auto-complete
set completeopt+=menuone,menu,longest
set completeopt-=preview

" encoding
set ff=unix
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gbk,gb2312
set termencoding=utf-8

" indent
set autoindent
set smartindent

" keymap
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz

nnoremap ; :

nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k

nnoremap <leader>d "_d

map <F4> :<UP><CR>

inoremap jj <Esc>

" find binary
function! FindBin(locations)
  for name in a:locations
    if executable(name)
      return name
    endif
  endfor
  if !exists(name)
    return ''
  endif
endfunction FindBin

" set tags
set tags=./tags;/

" find ctags
let g:ctags_bin = FindBin(['ctags-exuberant', 'exuberant-ctags', 'exctags', '/usr/local/bin/ctags', '/opt/local/bin/ctags', 'ectags', 'ctags.exe', 'ctags'])

" find cscope
let g:cscope_bin = FindBin(['cscope','cscope.exe'])

" whitespace eol & long lines
highlight LongLine ctermbg=lightgreen guibg=lightgreen
highlight CursorColumn cterm=NONE ctermbg=lightred ctermfg=white guibg=lightred guifg=white
" au BufWinEnter * let w:m0=matchadd('LongLine', '\%>80v.\+', -1)

" autocmd
augroup csrc
  au!
  au BufRead,BufNewFile *Makefile* set filetype=make
  au BufLeave,FocusLost * silent! wall
augroup END

" pathogen
call pathogen#infect()

" CtrlP
let g:ctrlp_tabpage_position = 'ac'
let g:ctrlp_use_caching = 1

" NeoComplCache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_ctags_program = expand(g:ctags_bin)
let g:neocomplcache_max_list = 300
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_keyword_length = 3
let g:neocomplcache_caching_limit_file_size = 16*1024*1024
let g:neocomplcache_tags_caching_limit_file_size = 4*1024*1024
let g:neocomplcache_keyword_patterns = {}
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
let g:neocomplcache_omni_patterns = {}
let g:neocomplcache_omni_patterns.smarty = '<[^>]*'
let g:neocomplcache_omni_patterns.xml = '<[^>]*'
let g:neocomplcache_omni_patterns.php = '\h\w*->\|\h\w*::'
let g:neocomplcache_same_filetype_lists = {}
let g:neocomplcache_skip_auto_completion_time = 3
let g:neocomplcache_force_omni_patterns = {}
let g:neocomplcache_force_overwrite_completefunc = 1
let g:neocomplcache_force_omni_patterns.c = '\.\|->\|::'
let g:neocomplcache_force_omni_patterns.cpp = '\.\|->\|::'
au! FileType css setlocal omnifunc=csscomplete#CompleteCSS
au! FileType html,markdown,smarty setlocal omnifunc=htmlcomplete#CompleteTags
au! FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
au! FileType python setlocal omnifunc=pythoncomplete#Complete
au! FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" au! FileType c,cpp set omnifunc=ClangComplete

" NeoSnippet
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : "\<TAB>"
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : "\<S-TAB>"
imap <expr><CR> neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : pumvisible() ? neocomplcache#smart_close_popup() : "\<CR>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><S-TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<S-TAB>"
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" CtrlP
let g:ctrlp_tabpage_position = 'ac'
let g:ctrlp_use_caching = 1

" VDebug
let g:vdebug_options= {
    \    "port" : 9100,
    \    "server" : 'localhost',
    \    "timeout" : 20,
    \    "on_close" : 'detach',
    \    "break_on_open" : 1,
    \    "ide_key" : '',
    \    "remote_path" : "",
    \    "local_path" : "",
    \    "debug_window_level" : 0,
    \    "debug_file_level" : 0,
    \    "debug_file" : "",
    \    "watch_window_style" : 'expanded',
    \}

" TagBar
au! BufEnter * nested :call tagbar#autoopen(0)
let g:tagbar_ctags_bin = expand(g:ctags_bin)
let g:tagbar_left = 0
let g:tagbar_compact = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_width = 24

" LocalVimrc
let g:localvimrc_ask=0

" ClangComplete
let g:clang_use_library=1
let g:clang_user_options= " -xc++ -D__STDC_LIMIT_MACROS=1 -D__STDC_CONSTANT_MACROS=1 -I."
let g:clang_complete_auto=0
if has('win32')
else
  if (executable('gcc'))
    let include_paths = split(system('echo | gcc -xc++ -E -v - 2>&1') , '\n')
    for include_path in include_paths
      let include_path = substitute(include_path, '^\s\+\|\s\+$', '', 'g')
      if match(include_path, '^\/usr\/.*') == 0 && match(include_path, ' ') == -1
        let resolved_path = resolve(include_path)
        let g:clang_user_options .= " -I" . resolved_path
        let &path .= ','.resolved_path
      endif
    endfor
  endif
endif

" Syntastic
let g:syntastic_enable_balloons = 1
let g:syntastic_always_populate_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_cpp_checkers = ['cpplint']

" Local Settings
if filereadable(".vimrc_")
  so .vimrc_
endif
