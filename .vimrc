
" settings
" -------------------------------------------------------------
filetype plugin indent on
set autoread
set clipboard+=unnamedplus
set complete=.,w,b,u,t,i,kspell
set diffopt+=vertical
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

" plugins
" -------------------------------------------------------------
call plug#begin('~/.vim/plugged')
Plug 'HiPhish/awk-ward.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'jpalardy/vim-slime'
Plug 'junegunn/fzf.vim' | Plug '/usr/local/opt/fzf'
Plug 'junegunn/goyo.vim'
Plug 'mhartington/oceanic-next'
Plug 'mkitt/tabline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'sjl/gundo.vim'
call plug#end()

" plugin settings
" -------------------------------------------------------------
let g:notes_word_boundaries = 1
let g:slime_target = "tmux"
let g:slime_dont_ask_default = 1
let g:slime_default_config = {'target_pane': '{next}', 'socket_name': 'default'}
nmap s <Plug>(easymotion-bd-w)
vmap s <Plug>(easymotion-bd-w)
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" general
" -------------------------------------------------------------
imap jk <Esc>
imap jj <Esc>
imap <C-l> <Esc>la
map ; :
noremap ;; ;
noremap S J
nnoremap K :bn<cr>
nnoremap J :bp<cr>
vnoremap < <gv
vnoremap > >gv

" q bindings
" -------------------------------------------------------------
vnoremap q; q:
nnoremap q; q:
noremap qb :Buffers<cr>
noremap ql :Lines<cr>
noremap qp :Files<cr>
noremap qr :History<cr>

" leader bindings
" -------------------------------------------------------------
nmap , `
vmap , `
let mapleader="'"
nmap <leader>; @:
vmap <leader>; @:
nmap <leader>a ggVG
nmap <leader>d :bd<cr>
vmap <leader>f "vy:Rg <c-r>=escape(@v, '[].')<cr><cr>
nmap <leader>f :Rg 
nmap <leader>h :noh<cr>
nmap <leader>i mb"vyiw`b:Rg <c-r>=escape(@v, '[].')<cr><cr>
nmap <leader>j vip"by:exec '!cd %:p:h && node -e' shellescape(@b, 1)<cr>
xmap <leader>j "by:exec '!cd %:p:h && node -e' shellescape(@b, 1)<cr>
nmap <leader>n *
vmap <leader>p "_dP
nmap <leader>q @q
xmap <leader>q : norm @q<cr>
nmap <leader>r :Vex<cr>
xmap <leader>s <Plug>SlimeRegionSend
nmap <leader>s <Plug>SlimeParagraphSend
nmap <leader>t :CocCommand explorer<cr>
nmap <leader>w :w<cr>
nmap <leader>z vip"by:exec '!cd %:p:h && zsh -c ' shellescape(@b, 1)<cr>
xmap <leader>z "by:exec '!cd %:p:h && zsh -c ' shellescape(@b, 1)<cr>

" inner as default for text objects, omit shift for common keys
" -------------------------------------------------------------
for [key, value] in items({ '4': '$', '9': 'i(', '0': 'i)', 'p': 'ap' })
	execute 'nnoremap d'.key.' d'.value
	execute 'nnoremap c'.key.' c'.value
	execute 'nnoremap v'.key.' v'.value
	execute 'nnoremap y'.key.' y'.value
endfor
for char in [ 'b', 'B', '(', ')', '{', '}', '[', ']', "'", '"', '/', ',' ]
	execute 'nnoremap d'.char.' di'.char
	execute 'nnoremap c'.char.' ci'.char
	execute 'nnoremap v'.char.' vi'.char
	execute 'nnoremap y'.char.' yi'.char
endfor

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
nmap <C-l> <C-w>w
nnoremap <C-w>/ :vsp<cr>
nnoremap <C-w>- :sp<cr>
nnoremap <C-w>z :call ZoomToggle()<cr>

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
set background=dark
set termguicolors
source $HOME/.vim/colors/OceanicNext.vim
colorscheme OceanicNext
let g:airline_theme='base16_ocean'
:hi EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg
:hi LineNr guibg=bg

" misc
" -------------------------------------------------------------
command! CloseOtherBufs exe 'norm mb' | silent! exe "%bd|e#|bd#" | exe 'norm `b'
cnoreabbrev sjs set syntax=javascript
cnoreabbrev sjson set syntax=json

" lowercase abbreviations
" -------------------------------------------------------------
for cmd in [ 'Sjson', 'Spps', 'Note', 'Goyo',
	\ 'Gr', 'Gread', 'Gw', 'Gwrite', 'Gblame', 'Gedit', 'Gcommit', 'Gdiffsplit' ]
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
autocmd TermOpen * startinsert
autocmd FileType netrw setl bufhidden=wipe

