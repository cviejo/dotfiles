
" settings
" -------------------------------------------------------------
filetype plugin indent on
set autoread
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
set noswapfile
set nowrap
set number
set path+=**
set shiftwidth=3
set shortmess+=I
set smartcase
set smartindent
set spelllang=en
set splitbelow
set splitright
set tabstop=3
set wildignore+=**/node_modules/** 
set wildmenu
set background=dark
set t_Co=256
set termguicolors
if has('nvim')
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
Plug 'xolox/vim-misc' | Plug 'xolox/vim-notes'
Plug 'mhartington/oceanic-next'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mg979/vim-visual-multi'
Plug 'sjl/gundo.vim'
Plug 'metakirby5/codi.vim'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'NicholasDunham/chuck.nvim'
else
Plug 'asvetliakov/vim-easymotion', { 'as': 'vim-easymotion-vc' }
endif
call plug#end()
let g:coc_global_extensions = [
	\'coc-eslint',
	\'coc-explorer',
	\'coc-git',
	\'coc-prettier',
	\'coc-snippets',
	\'coc-svelte',
	\'coc-rls',
	\'https://github.com/nathanchapman/vscode-javascript-snippets'
\]

" plugin settings
" -------------------------------------------------------------
let g:codi#raw = 0
let g:codi#width = 50.0
let g:notes_word_boundaries = 1
let g:slime_target = "tmux"
let g:slime_dont_ask_default = 1
let g:slime_default_config = {'target_pane': '{next}', 'socket_name': 'default'}
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
nmap cm :CocCommand<cr>
nmap <silent> gi <Plug>(coc-type-definition)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap s <Plug>(easymotion-overwin-f2)
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler


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
imap jk <Esc>
imap jj <Esc>
imap <c-l> <Esc>la
map ; :
noremap ;; ;
noremap S J
vnoremap < <gv
vnoremap > >gv


" vimium bindings
" -------------------------------------------------------------
nnoremap K :bn<cr>
nnoremap J :bp<cr>
noremap <c-d> 5j
noremap <c-u> 5k


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
nmap <leader>d :bd<cr>
nmap <leader>e :CocCommand explorer<cr>
vmap <leader>f "vy:Rg <c-r>=escape(@v, '[].')<cr><cr>
nmap <leader>f :Rg 
nmap <leader>h :noh<cr>
nmap <leader>i mb"vyiw`b:Rg <c-r>=escape(@v, '[].')<cr><cr>
nmap <leader>j mbvip"by`b:exec '!cd %:p:h && node -e' shellescape(@b, 1)<cr>
xmap <leader>j mb"by`b:exec '!cd %:p:h && node -e' shellescape(@b, 1)<cr>
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
\ '4': '$', '9': 'i(', '0': 'i)', 'p': 'ap', 'q': 'i"',
\ '<space>': 't<space>', ',': 't,', ';': 't;', ':': 't:',
\ 'n': 'i{', 'rb': '])', 'rB': ']]'
\ }
for [key, value] in items(movements)
	execute 'nnoremap d'.key.' d'.value
	execute 'nnoremap c'.key.' c'.value
	execute 'nnoremap v'.key.' v'.value
	execute 'nnoremap y'.key.' y'.value
endfor
for char in [ 'w', 'b', 'B', '(', ')', '{', '}', '[', ']', "'", '"', '/' ]
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


" window
" -------------------------------------------------------------
nnoremap qww <C-w>w
nnoremap qwo <C-w>o
nnoremap qw/ :vsp<cr>
nnoremap qw- :sp<cr>
nnoremap qwz call ZoomToggle()<cr>


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
command! CloseOtherBufs exe 'norm mb' | silent! exe "%bd|e#|bd#" | exe 'norm `b'
command! TmuxVerticalSplit exe "silent !pwd | awk '{ print $0 \"/%\" }' | xargs dirname | xargs tmux split-window -h -c"
command! TmuxHorizontalSplit exe "silent !pwd | awk '{ print $0 \"/%\" }' | xargs dirname | xargs tmux split-window -c"
cnoreabbrev sjs set filetype=javascript syntax=javascript
cnoreabbrev sjson set filetype=json syntax=json


" lowercase abbreviations
" -------------------------------------------------------------
for cmd in ['Sjson', 'Spps', 'Note', 'Goyo', 'Gr', 'Gread', 'Gw', 'Gwrite', 'Gblame', 'Gedit', 'Gcommit', 'Gdiffsplit']
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
if has('nvim')
autocmd TermOpen * startinsert
endif

if exists('g:vscode')
nnoremap K :call VSCodeCall("workbench.action.nextEditor")<cr>
nnoremap J :call VSCodeCall("workbench.action.previousEditor")<cr>
nnoremap qp :call VSCodeCall("workbench.action.quickOpen")<cr>
nnoremap q/ :call VSCodeCall("workbench.action.splitEditorRight")<cr>
nnoremap q- :call VSCodeCall("workbench.action.splitEditorDown")<cr>
nmap <leader>e :call VSCodeCall("workbench.action.toggleSidebarVisibility")<cr>
nmap <leader>d :call VSCodeCall("workbench.action.closeActiveEditor")<cr>
endif
