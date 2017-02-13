
function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.sh
  endif
endfunction

function! BuildTern(info)
  if a:info.status == 'installed' || a:info.force
    !npm install
  endif
endfunction

function! InstallESLint(info)
  if a:info.status == 'installed' || a:info.force
    !npm install -g eslint
  endif
endfunction

"-------plugins------
call plug#begin('~/.vim/plugged')
Plug 'sjl/gundo.vim'
Plug 'VundleVim/Vundle.vim'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'maksimr/vim-jsbeautify'
Plug 'easymotion/vim-easymotion'
Plug 'godlygeek/tabular'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'rking/ag.vim'
Plug 'mkitt/tabline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'rbgrouleff/bclose.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'mhartington/oceanic-next'
Plug 'vim-airline/vim-airline-themes'
Plug 'ervandew/supertab'
Plug 'maksimr/vim-jsbeautify'
Plug 'vim-scripts/AutoComplPop'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Plug 'terryma/vim-smooth-scroll'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
" Plug 'vimoutliner/vimoutliner'
" Plug 'goldfeld/vim-seek'
" Plug 'pangloss/vim-javascript'
" Plug 'jelera/vim-javascript-syntax'
" Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
" Plug 'marijnh/tern_for_vim',   { 'do': function('BuildTern') }
" Plug 'scrooloose/syntastic',   { 'do': function('InstallESLint') }
" Plug 'blueyed/vim-diminactive'
"Plug 'dyng/ctrlsf.vim'
call plug#end()

"-------js-beautify------
command! FormatJS call JsBeautify()

let NERDTreeWinSize                = 25
let NERDTreeShowHidden             = 1
let NERDTreeShowBookmarks          = 1
let NERDSpaceDelims                = 1
let g:ctrlp_custom_ignore          = 'node_modules\|DS_Store\|git\|.gradle'
let g:ctrlp_show_hidden            = 1
let g:ag_prg                       = 'ag -S --nocolor --nogroup --column --ignore "\.gradle" --ignore node_modules --ignore "*.sublime-workspace" --ignore "*min.js"'
let g:ag_working_path_mode         = "r"
let g:ag_highlight                 = 1
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" If you want : UltiSnipsEdit to split your window.
" let g       : UltiSnipsEditSplit="vertical"


" tidy up here
"-------airlline-------
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_detect_spell=0
let g:airline_right_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.linenr = 'Ξ'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = '□□'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#mixed_indent_format = 'MI[%s]'
let g:airline#extensions#whitespace#trailing_format = 'T[%s]'
let g:airline#extensions#whitespace#trailing_regexp = '\s\s$'
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing']
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#format = 2
let g:airline#extensions#hunks#enabled = 1
let g:airline_symbols.branch = '⎇'
" let g:airline_left_sep = '▶'

" show Obsession Status:
" Prepend $ sign if Obsession is active
let g:airline_section_z = airline#section#create(['%{ObsessionStatus(''$'', '''')}', 'windowswap', '%3p%% ', 'linenr', ':%3v '])
" Tells airline not to display file format
let g:airline_section_x =''
" Tells airline not to display fileencoding or fileformat
let g:airline_section_y =''
" If need to know these then simply do:
" set ff for fileformat
" set fenc for fileencoding
" set ft for filetype
" mode short forms
let g:airline_mode_map = {
\ '__' : '-',
\ 'n' : 'N',
\ 'i' : 'I',
\ 'R' : 'R',
\ 'c' : 'C',
\ 'v' : 'V',
\ 'V' : 'V',
\ 's' : 'S',
\ 'S' : 'S',
\ }
