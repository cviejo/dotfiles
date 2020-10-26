
" settings
" -------------------------------------------------------------
filetype plugin indent on
set autoread
set background=dark
set clipboard+=unnamedplus
set complete=.,w,b,u,t,i,kspell
set foldmethod=indent
set hidden
set ignorecase
set laststatus=2
set list
set listchars=tab:\|\ ,trail:·
set mouse=a
set noexpandtab
set nofoldenable
set noshowmode
set noswapfile
set number
set path+=**
set shiftwidth=3
set shortmess+=I
set smartcase
set smartindent
set spelllang=en
set splitbelow
set splitright
set t_Co=256
set tabstop=3
set termguicolors
set updatetime=300
set wildignore+=**/node_modules/** 
set wildmenu
if has('nvim')
set inccommand=nosplit
set diffopt+=vertical
endif


" plugins
" -------------------------------------------------------------
call plug#begin('~/.vim/plugged')
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
if !exists('g:vscode')
Plug 'HiPhish/awk-ward.nvim'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'jpalardy/vim-slime'
Plug 'junegunn/fzf.vim' | Plug '/usr/local/opt/fzf'
Plug 'junegunn/goyo.vim'
Plug 'metakirby5/codi.vim'
Plug 'mg979/vim-visual-multi'
Plug 'mhartington/oceanic-next'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'xolox/vim-misc' | Plug 'xolox/vim-notes'
Plug 'neoclide/jsonc.vim'
Plug 'NicholasDunham/chuck.nvim'
else
Plug 'asvetliakov/vim-easymotion', { 'as': 'vim-easymotion-vc' }
endif
call plug#end()
let g:coc_global_extensions = [
	\ 'coc-emmet',
	\ 'coc-eslint',
	\ 'coc-explorer',
	\ 'coc-git',
	\ 'coc-json',
	\ 'coc-prettier',
	\ 'coc-rls',
	\ 'coc-snippets',
	\ 'coc-svelte',
	\ 'coc-tsserver',
	\ 'https://github.com/nathanchapman/vscode-javascript-snippets'
\]


" plugin settings
" -------------------------------------------------------------
let g:notes_word_boundaries = 1
let g:slime_target = "tmux"
let g:slime_dont_ask_default = 1
let g:slime_default_config = {'target_pane': '{next}', 'socket_name': 'default'}
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
nmap cm :CocCommand<cr>
nmap s <Plug>(easymotion-bd-w)
xmap s <Plug>VSurround
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
	\ | autocmd BufLeave <buffer> set laststatus=2 showmode ruler


" coc-snippets tab behaviour
" -------------------------------------------------------------
inoremap <silent><expr> <TAB>
	\ pumvisible() ? coc#_select_confirm() :
	\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'


" general bindings
" -------------------------------------------------------------
tnoremap jk <C-\><C-n>
imap qq <Esc>
imap jj <Esc>
imap jl <Esc>la
imap j[ ${}<Esc>i
imap >> =>
map ; :
noremap ;; ;
nnoremap S J
vnoremap < <gv
vnoremap > >gv


" vimium bindings
" -------------------------------------------------------------
nnoremap K :bn<cr>
nnoremap J :bp<cr>
noremap <c-d> 5j
noremap <c-u> 5k


" g bindings
" -------------------------------------------------------------
nnoremap gl L
nnoremap gm M
nnoremap gh H
nmap <silent> gi <Plug>(coc-type-definition)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)


" q bindings
" -------------------------------------------------------------
vnoremap q; q:
nnoremap q; q:
noremap qb :Buffers<cr>
noremap ql :Lines<cr>
noremap qp :Files<cr>
noremap qr :History<cr>
noremap qh :History:<cr>


" leader bindings
" -------------------------------------------------------------
nmap , `
vmap , `
let mapleader="'"
nmap <leader>; @:
vmap <leader>; @:
nmap <leader>a ggVG
nmap <leader>c gcc
vmap <leader>c gc
nmap <expr> <leader>d 
	\ getbufvar(bufname(), '&buftype') == "" && bufname() != '[Command Line]'
	\ ? ':bdelete<cr>'
	\ : ':close<cr>'
nmap <leader>e :CocCommand explorer<cr>
vmap <leader>f "vy:Rg <c-r>=escape(@v, '[].')<cr><cr>
nmap <leader>g :G<cr>
nmap <leader>f :Rg 
nmap <leader>h :noh<cr>
nmap <leader>i mb"vyiw`b:Rg <c-r>=escape(@v, '[].')<cr><cr>
nmap <leader>j mbvip"by`b:exec '!cd %:p:h && node -e' shellescape(@b, 1)<cr>
xmap <leader>j mb"by`b:exec '!cd %:p:h && node -e' shellescape(@b, 1)<cr>
nmap <leader>l yiwoconsole.log()i"pla, pA;
nmap <leader>n *
vmap <leader>p "_dP
nmap <leader>q @q
xmap <leader>q : norm @q<cr>
xmap <leader>s <Plug>SlimeRegionSend
nmap <leader>s <Plug>SlimeParagraphSend
nmap <leader>w :w<cr>
nmap <leader>z mbvip"by`b:exec '!cd %:p:h && zsh -c ' shellescape(@b, 1)<cr>
xmap <leader>z mb"by`b:exec '!cd %:p:h && zsh -c ' shellescape(@b, 1)<cr>


" inner as default for text objects, omit shift for common keys
" -------------------------------------------------------------
let movements = {
\ '4': '$', 'l': '$',
\ '9': 'i(', '0': 'i)', 'p': 'ap', 'q': 'i"',
\ '<space>': 't<space>', ',': 't,', ';': 't;', ':': 't:', '.': 't.',
\ 'n': 'i{', 'rb': '])', 'rB': ']]'
\ }
for [key, value] in items(movements)
	execute 'nnoremap d'.key.' d'.value
	execute 'nnoremap c'.key.' c'.value
	execute 'nnoremap v'.key.' v'.value
	execute 'nnoremap y'.key.' y'.value
endfor
for char in [ 'w', 'B', '(', ')', '{', '}', '[', ']', '"', "'", '/' ]
	execute 'nnoremap d'.char.' di'.char
	execute 'nnoremap c'.char.' ci'.char
	execute 'nnoremap v'.char.' vi'.char
	execute 'nnoremap y'.char.' yi'.char
endfor
nnoremap vp vip


" extra pseudo objects
" -------------------------------------------------------------
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#' ]
	execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
	execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
	execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
	execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor


" experimental
" -------------------------------------------------------------
function! NearestTextObject(action, items)
	let selection = ''
	let shortest = 0
	exe 'norm mb'
	for x in split(a:items)
		let @b = ''
		silent exe 'norm "byi'.x.'`b'
		let length = strlen(@b)
		if length != 0 && (shortest == 0 || length < shortest)
			let selection = x
			let shortest = length
		endif
	endfor
	if selection != ''
		call feedkeys(a:action.selection)
	endif 
endfunction
for [key, items] in items({ 'b': "( [ {", 'q': "\\\" ' `" })
	for action in ['d', 'c', 'v', 'y']
		exe 'nnoremap '.action.key.' :call NearestTextObject("'.action.'i", "'.items.'")<cr>'
		exe 'nnoremap '.action.'a'.key.' :call NearestTextObject("'.action.'a", "'.items.'")<cr>'
		exe 'nnoremap '.action.'i'.key.' :call NearestTextObject("'.action.'i", "'.items.'")<cr>'
	endfor
endfor


" window
" -------------------------------------------------------------
nnoremap qww <C-w>w
nnoremap qwo <C-w>o
nnoremap qw/ :vsp<cr>
nnoremap qw- :sp<cr>
nnoremap qwz :call ZoomToggle()<cr>


" pane zooming
" -------------------------------------------------------------
function! ZoomToggle() abort
	if exists('t:zoomed') && t:zoomed
		execute t:zoom_winrestcmd
		let t:zoomed = 0
	else
		let t:zoom_winrestcmd = winrestcmd()
		resize
		vertical resize
		let t:zoomed = 1
	endif
endfunction


" theme
" -------------------------------------------------------------
source $HOME/.vim/colors/OceanicNext.vim
colorscheme OceanicNext
let g:airline_theme='base16_ocean'
:hi EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg
:hi LineNr guibg=bg


" misc
" -------------------------------------------------------------
command! LogVar exe 'norm mbyiwoconsole.log()<Esc>i"<Esc>pla, <Esc>pA;<Esc>`b'
command! CloseOtherBufs exe 'norm mb' | silent! exe "%bd|e#|bd#" | exe 'norm `b'
command! TmuxVerticalSplit exe "silent !tmux split-window -h -c ".expand('%:p:h')
command! TmuxHorizontalSplit exe "silent !tmux split-window -c ".expand('%:p:h')
cnoreabbrev sjs set filetype=javascript syntax=javascript
cnoreabbrev sjson set filetype=json syntax=json


" lowercase abbreviations
" -------------------------------------------------------------
for cmd in ['Note', 'Goyo', 'Gr', 'Gread', 'Gw', 'Gwrite', 'Gblame', 'Gedit', 'Gcommit', 'Gdiffsplit']
	exe 'cnoreabbrev '.tolower(cmd).' '.cmd
endfor


" airline
" -------------------------------------------------------------
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_detect_spell=0
let g:airline_right_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_x =''
let g:airline_section_y =''
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline_symbols.branch = '⎇'
let g:airline_mode_map = {
\ '__' : '-', 'n' : 'N', 'i' : 'I', 'R' : 'R', 'c' : 'C', 
\ 'v'  : 'V', 'V' : 'V', 's' : 'S', 'S' : 'S'
\ }


" autocmd
" -------------------------------------------------------------
autocmd FileType netrw setl bufhidden=wipe
autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc
if has('nvim')
autocmd TermOpen * startinsert
endif


" vscode neovim
" -------------------------------------------------------------
if exists('g:vscode')
nnoremap J :call VSCodeCall("workbench.action.previousEditor")<cr>
nnoremap K :call VSCodeCall("workbench.action.nextEditor")<cr>
nnoremap qp :call VSCodeCall("workbench.action.quickOpen")<cr>
nnoremap qw/ :call VSCodeCall("workbench.action.splitEditorRight")<cr>
nnoremap qw- :call VSCodeCall("workbench.action.splitEditorDown")<cr>
nmap <leader>e :call VSCodeCall("workbench.action.toggleSidebarVisibility")<cr>
nmap <leader>d :call VSCodeCall("workbench.action.closeActiveEditor")<cr>
endif
