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
set path+=**
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
set tabstop=4
set softtabstop=4
set shiftwidth=4
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

map <F4> :<UP><CR>

" VDebug
let g:vdebug_options= {
	\	"port" : 9100,
	\	"server" : 'localhost',
	\	"timeout" : 20,
	\	"on_close" : 'detach',
	\	"break_on_open" : 1,
	\	"ide_key" : '',
	\	"remote_path" : "",
	\	"local_path" : "",
	\	"debug_window_level" : 0,
	\	"debug_file_level" : 0,
	\	"debug_file" : "",
	\	"watch_window_style" : 'expanded',
	\}

" TagBar
" au! BufEnter * nested :call tagbar#autoopen(0)
let g:tagbar_left = 0
let g:tagbar_compact = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_width = 24

" pathogen
call pathogen#infect()

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
au! FileType css setlocal omnifunc=csscomplete#CompleteCSS
au! FileType html,markdown,smarty setlocal omnifunc=htmlcomplete#CompleteTags
au! FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
au! FileType python setlocal omnifunc=pythoncomplete#Complete
au! FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_overwrite_completefunc = 1
let g:neocomplcache_force_omni_patterns.c =
      \ '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" NeoClang
let g:neocomplcache_clang_use_library = 1
" More user include path.
let g:neocomplcache_clang_user_options = ' -I/usr/include -I/usr/local/include -I/lib/gcc/x86_64-pc-cygwin/4.8.2/include/c++ -I/lib/gcc/x86_64-pc-cygwin/4.8.2/include/c++/x86_64-pc-cygwin'
let g:neocomplcache_clang_debug = 1

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

" A path to a clang executable.
let g:clang_path = "clang++"

" A list of options to add to the clang commandline, for example to add
" include paths, predefined macros, and language options.
let g:clang_opts = [
  \ "-x","c++",
  \ "-D__STDC_LIMIT_MACROS=1","-D__STDC_CONSTANT_MACROS=1",
  \ "-I/lib/gcc/x86_64-pc-cygwin/4.8.2/include/c++",
  \ "-I/lib/gcc/x86_64-pc-cygwin/4.8.2/include/c++/x86_64-pc-cygwin",
  \ "-Iinclude" ]

function! ClangComplete(findstart, base)
   if a:findstart == 1
      " In findstart mode, look for the beginning of the current identifier.
      let l:line = getline('.')
      let l:start = col('.') - 1
      while l:start > 0 && l:line[l:start - 1] =~ '\i'
         let l:start -= 1
      endwhile
      return l:start
   endif

   " Get the current line and column numbers.
   let l:l = line('.')
   let l:c = col('.')

   " Build a clang commandline to do code completion on stdin.
   let l:the_command = shellescape(g:clang_path) .
                     \ " -cc1 -code-completion-at=-:" . l:l . ":" . l:c
   for l:opt in g:clang_opts
      let l:the_command .= " " . shellescape(l:opt)
   endfor

   " Copy the contents of the current buffer into a string for stdin.
   " TODO: The extra space at the end is for working around clang's
   " apparent inability to do code completion at the very end of the
   " input.
   " TODO: Is it better to feed clang the entire file instead of truncating
   " it at the current line?
   let l:process_input = join(getline(1, l:l), "\n") . " "

   " Run it!
   let l:input_lines = split(system(l:the_command, l:process_input), "\n")
   let l:completions_for_neocomplcache = []

   " Parse the output.
   for l:input_line in l:input_lines
      " Vim's substring operator is annoyingly inconsistent with python's.
      if l:input_line[:11] == 'COMPLETION: '
         let l:value = l:input_line[12:]

        " Chop off anything after " : ", if present, and move it to the menu.
        let l:menu = ""
        let l:spacecolonspace = stridx(l:value, " : ")
        if l:spacecolonspace != -1
           let l:menu = l:value[l:spacecolonspace+3:]
           let l:value = l:value[:l:spacecolonspace-1]
        endif

        " Chop off " (Hidden)", if present, and move it to the menu.
        let l:hidden = stridx(l:value, " (Hidden)")
        if l:hidden != -1
           let l:menu .= " (Hidden)"
           let l:value = l:value[:l:hidden-1]
        endif

        " Handle "Pattern". TODO: Make clang less weird.
        if l:value == "Pattern"
           let l:value = l:menu
           let l:pound = stridx(l:value, "#")
           " Truncate the at the first [#, <#, or {#.
           if l:pound != -1
              let l:value = l:value[:l:pound-2]
           endif
        endif

         " Filter out results which don't match the base string.
         if a:base != ""
            if l:value[:strlen(a:base)-1] != a:base
               continue
            end
         endif

        " TODO: Don't dump the raw input into info, though it's nice for now.
        " TODO: The kind string?
        let l:item = {
          \ "word": l:value,
          \ "menu": l:menu,
          \ "info": l:input_line,
          \ "dup": 1 }

        " Report a result.
        if complete_add(l:item) == 0
           return []
        endif
        if complete_check()
           return []
        endif

      elseif l:input_line[:9] == "OVERLOAD: "
         " An overload candidate. Use a crazy hack to get vim to
         " display the results. TODO: Make this better.
         let l:value = l:input_line[10:]
         let l:item = {
           \ "word": " ",
           \ "menu": l:value,
           \ "info": l:input_line,
           \ "dup": 1}

        " Report a result.
        if complete_add(l:item) == 0
           return []
        endif
        if complete_check()
           return []
        endif

      endif
   endfor


   return []
endfunction ClangComplete

" This to enables the somewhat-experimental clang-based
" autocompletion support.
au! FileType c,cpp set omnifunc=ClangComplete
