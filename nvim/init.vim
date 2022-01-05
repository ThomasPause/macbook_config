version 7.2

let mapleader = ","

" disable vi compatibility
set nocompatible

" show special characters
set listchars=extends:>,precedes:<,trail:.,tab:>.,eol:$

if version >= 702
	" create new tabs when switching buffers
	set switchbuf=newtab
endif


" line numbers
if v:version >= 700
	set numberwidth=3
endif

" Automatic toggling between line number modes
:set number

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

" milliseconds to wait for macro keystrokes
set timeoutlen=500

" automatic session information (see :h 'viminfo')
set viminfo='100,<50,/50,:50,f1,h,r/tmp,r/media,r/mnt,s1024

" replace current word by output of 'which <word>'
map <C-P> yiW:new<CR>:set bt=nofile<CR>:exe "r!which" shellescape("<C-R>"")<CR>y$:q!<CR>cW<C-R>0<ESC>
vmap <C-P> y:new<CR>:set bt=nofile<CR>:exe "r!which" shellescape("<C-R>"")<CR>y$:q!<CR>gvs<C-R>0<ESC>

" syntax highlighting
syntax on
syntax match SpaceAtEOL "[ \t]+$"
set background=dark
highlight Folded	cterm=none ctermfg=gray		ctermbg=blue
highlight LineNr	cterm=none ctermfg=DarkYellow
highlight Comment	cterm=none ctermfg=DarkCyan
highlight Constant	cterm=none ctermfg=DarkMagenta
highlight StatusLine	cterm=bold ctermfg=darkcyan	ctermbg=darkblue
highlight TabLine	cterm=none ctermfg=DarkCyan
highlight TabLineSel	cterm=none ctermfg=black	ctermbg=LightCyan
highlight TabLineFill	cterm=none ctermfg=white	ctermbg=black
highlight SpaceAtEOL	cterm=none ctermfg=black	ctermbg=cyan
highlight SpecialKey	cterm=none ctermfg=white	ctermbg=red
highlight Normal	guibg=Black guifg=White

highlight diffRemoved	guifg=red


" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048

set wildmenu

" autowrite: Automatically save modifications to files
" when you use critical (rxternal) commands.
set autowrite

set nobackup

" automatic folding
if has('folding')
	set nofoldenable
	set foldmethod=syntax
	set foldminlines=3
endif

" smart indenting
if has('smartindent')
	set smartindent
endif

" hidden buffers ...
set hidden

" always show status line
set laststatus=2
set backspace=indent,eol,start
set autoindent
set nolazyredraw
" set magic
set matchpairs=(:),{:},[:],<:>

" only care for modes on first line
set modelines=1

" report: show a report when N lines were changed.
" report=0 thus means show all changes!
set report=0

set ruler
set shell=zsh
set showcmd
set showmode

" command in history
set history=100

" when scrolling, keep 5 lines below/above cursor visible
set scrolloff=5

" ignore whitespaces in diff
set diffopt+=iwhite

" suffixes to ignore in :edit
set suffixes=.aux,.bak,.dvi,.idx,.log,.swp,.tar

" :vimgrep !!! current search buffer
nmap <silent> <leader>gs :vimgrep /<C-r>// %<CR>:ccl<CR>:cwin<CR><C-W><C-W>:nohls<CR>
" current word
nmap <silent> <leader>gw :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W><C-W>:nohls<CR>
" current WORD
nmap <silent> <leader>gW :vimgrep /<C-r><C-a>/ %<CR>:ccl<CR>:cwin<CR><C-W><C-W>:nohls<CR>

" :make, show quickfix window
nnoremap <silent> <leader>m :make<CR>:cwin<CR><C-W><C-W>

" tab related stuff
if has('windows')
	" command e is an abbreviation for tabe
	" cabbrev e tabe

	" open remaining buffers in new tabs
	nnoremap <silent> <leader>t :tab sball<CR>

	set tabline=%!GetTabLine()
	function! GetTabLine()
		let s = ''
		for i in range(tabpagenr('$'))
			" select the highlighting
			if i + 1 == tabpagenr()
				let s .= '%#TabLineSel#'
			else
				let s .= '%#TabLine#'
			endif

			" set the tab page number (for mouse clicks)
			let s .= '%' . (i + 1) . 'T'

			" the label is made by GetTabLabel()
			let s .= ' %{GetTabLabel(' . (i + 1) . ')} '
		endfor

		" after the last tab fill with TabLineFill and reset tab page nr
		let s .= '%#TabLineFill#%T'

		" right-align the label to close the current tab page
		return s
	endfunction


	function! GetTabLabel(n)
		let buflist = tabpagebuflist(a:n)
		let winnr = tabpagewinnr(a:n)
		return bufname(buflist[winnr - 1])
	endfunction
endif

set wildchar=<TAB>
set nowritebackup

" reasonable values for tabs
set tabstop=8
set shiftwidth=8

" deactivate suspend
map <C-Z> :tabnew +terminal zsh<CR>
autocmd TermOpen * setlocal nonumber|startinsert

cmap <leader>rcm %s/\%x0d//ge<CR>

filetype plugin indent on

" latexsuite
set grepprg=grep\ -nH\ $*
let g:Imap_FreezeImap=1

" vim-spell-de
" setlocal spell spelllang=de
nmap <silent> <leader>s :set invspell<CR>:set spell?<CR>

" disable showmarks by default
let g:showmarks_enable=0

" see augroup Binary below
" noremap <silent> ,x :%!xxd<CR>:set filetype=xxd

" used to save on C-s
noremap <C-S> :w<CR>
inoremap <C-s> <Esc>:w<CR>a

if has("autocmd")
	" address completion in emails
	autocmd FileType mail set omnifunc=muttaliasescomplete#Complete

	augroup Binary
		au!
		au BufReadPre	*.bin let &bin=1
		au BufReadPost	*.bin if &bin | %!xxd
		au BufReadPost	*.bin set filetype=xxd | endif
		au BufWritePre	*     if &bin | %!xxd -r
		au BufWritePre	*     endif
		au BufWritePost	*     if &bin | %!xxd
		au BufWritePost	*     set nomod | endif
	augroup END

	" declare current file as binary
	nnoremap <silent> ,b :do Binary BufReadPre,BufReadPost %.bin

	" cd into dir of file on switching buffers
	" autocmd BufEnter * lcd %:p:h

	" last editing position
	autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\	exe "normal g'\"" |
		\ endif
	autocmd BufReadPost *.py setlocal colorcolumn=+1
endif

" omni completion on C-Y
inoremap <C-Y> <C-X><C-O>

" toggle paste mode
nmap <silent> <leader>p :set invpaste<CR>:set paste?<CR>

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>
nmap <silent> <leader>d  :Texplore<CR>
nmap <silent> <leader>f  :tabedit <cfile><CR>

" toggle line wrapping
nmap <silent> <leader>w :set invwrap<CR>:set wrap?<CR>

" Run the command that was just yanked
nmap <silent> <leader>rc :@"<cr>

" Maps to make handling windows a bit easier
noremap <silent> <leader>h :wincmd h<CR>
noremap <silent> <leader>j :wincmd j<CR>
noremap <silent> <leader>k :wincmd k<CR>
noremap <silent> <leader>l :wincmd l<CR>
noremap <silent> <leader>sb :wincmd p<CR>
noremap <silent> <leader>cc :close<CR>
noremap <silent> <leader>ml <C-W>L
noremap <silent> <leader>mk <C-W>K
noremap <silent> <leader>mh <C-W>H
noremap <silent> <leader>mj <C-W>J

" for new tabs use ,e instead of :e
noremap <silent> <leader>e :tabe

" for new pane in horizontal split use ,s
noremap <silent> <leader>s :split

" for new pane in vertical split use ,v
noremap <silent> <leader>v :vsplit

" highlight last change (visual mode)
command! HLchange norm `[v`]

" incremental search
set incsearch

" printing (see popt-option and pheader-option)
set printoptions=left:1pc,number:y,top:2px,bottom:2pc,syntax:y,wrap:y,portrait:y,paper:A4
set printheader=%=%f%h%m\ Page\ %N

" copied from vim 7.2's example vimrc. Show a diff of current changes
if !exists(":DiffOrig")
	command DiffOrig let g:ft=&ft | vertical rightbelow new | set buftype=nofile | let &ft=g:ft | read # | 0d_ | diffthis | wincmd p | diffthis
endif

" Plugins
" TagBar
nmap <silent> <F8> :TagbarToggle<CR>

" fugitive
nmap <silent> <leader>ga :Git add %<CR>
nmap <silent> <leader>gc :Git commit<CR>
nmap <silent> <leader>gp :Git push<CR>
nmap <silent> <leader>gs :Git status<CR>
nmap <silent> <leader>gu :Git pull<CR>

" gf => new tab
nmap <silent> <leader>gf :tabedit <cfile><cr>

" ALE navigation
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

set guicursor=
autocmd OptionSet guicursor noautocmd set guicursor=

" ALE status line
function! LinterStatus() abort
	let l:counts = ale#statusline#Count(bufnr(''))

	let l:all_errors = l:counts.error + l:counts.style_error
	let l:all_non_errors = l:counts.total - l:all_errors

	return l:counts.total == 0 ? 'OK' : printf('%dW %dE', all_non_errors, all_errors)
endfunction

" %f filename
" %h help flag
" %w preview flag
" %m modified flag
" %r readonly flag
" fugitive items
" ale items
" %= separator
" %l line
" %c column
" %V virtual column
" %P percentage through file
set statusline=%f\ %h%w%m%r\ %{FugitiveStatusline()}\ %=%{LinterStatus()}\ %=%(%l,%c%V\ %=\ %P%)

let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_open_list = 0
let g:ale_fixers = {
\	'*': ['trim_whitespace'],
\	'rust': ['rustfmt']
\}
let g:ale_fix_on_save = 1
let g:ale_rust_rustfmt_options = '--edition=2021'

let g:ale_linters = {
\	'rust': ['analyzer', 'cargo', 'rls', 'rustc'],
\	'salt': ['salt-lint']
\}

let g:ale_linter_aliases = {
\	'sls': 'salt'
\}

let g:ale_virtualenv_dir_names = ['venv/py3']
let g:ale_python_executable='python3'
let g:ale_rust_cargo_use_clippy=1

let g:deoplete#enable_at_startup = 1

let g:python3_host_prog = '~/venv/py3/bin/python'

" file browser
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
let g:netrw_winsize = 15
noremap <F3> :Lexplore<CR>

" local vimrc (.lvimrc)
" store loading decisions if answer was given in upper case
let g:localvimrc_persistent = 1

