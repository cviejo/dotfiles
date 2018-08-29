
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

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'
Plug 'junegunn/goyo.vim'
Plug 'sjl/gundo.vim'
Plug 'VundleVim/Vundle.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'kien/ctrlp.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'maksimr/vim-jsbeautify'
Plug 'easymotion/vim-easymotion'
Plug 'godlygeek/tabular'
Plug 'marcweber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'keith/swift.vim'
Plug 'rking/ag.vim'
Plug 'mkitt/tabline.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-obsession'
Plug 'jiangmiao/auto-pairs'
Plug 'mhartington/oceanic-next'
Plug 'vim-airline/vim-airline-themes'
Plug 'maksimr/vim-jsbeautify'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'supercollider/scvim'
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-fireplace'
Plug 'pangloss/vim-javascript'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }
Plug 'scrooloose/nerdcommenter'
Plug 'w0rp/ale'
" Plug 'vim-scripts/AutoComplPop'
" Plug 'garbas/vim-snipmate'
" Plug 'ervandew/supertab'
" Plug 'kevinlitchfield/open-tmux-pane.vim'
" Plug 'SirVer/ultisnips'
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" Plug 'neomake/neomake'
" Plug 'terryma/vim-smooth-scroll'
" Plug 'farseer90718/vim-taskwarrior'
" Plug 'vimoutliner/vimoutliner'
" Plug 'goldfeld/vim-seek'
" Plug 'tpope/vim-surround'
" Plug 'jelera/vim-javascript-syntax'
" Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
" Plug 'marijnh/tern_for_vim',   { 'do': function('BuildTern') }
" Plug 'scrooloose/syntastic',   { 'do': function('InstallESLint') }
" Plug 'blueyed/vim-diminactive'
" Plug 'dyng/ctrlsf.vim'
call plug#end()



"-------prettier------
let g:prettier#config#parser = 'babylon'


"-------notes------
let g:notes_word_boundaries = 1


"-------scvim------
let g:sclangTerm = "gnome-terminal -x $SHELL -ic"
let g:sclangPipeApp = "~/.vim/plugged/scvim/bin/start_pipe"
let g:sclangDispatcher = "~/.vim/plugged/scvim/bin/sc_dispatcher"


"-------js-beautify------
command! FormatJS call JsBeautify()


"-------NERDTree------
let NERDTreeWinSize              = 25
let NERDTreeShowHidden           = 1
let NERDTreeShowBookmarks        = 1
let NERDSpaceDelims              = 1
let g:NERDTreeIndicatorMapCustom = {
\ "Modified"  : "✹",
\ "Staged"    : "✚",
\ "Untracked" : "✭",
\ "Renamed"   : "➜",
\ "Unmerged"  : "═",
\ "Deleted"   : "✖",
\ "Dirty"     : "x",
\ "Clean"     : "✔︎",
\ 'Ignored'   : '☒',
\ "Unknown"   : "?"
\ }


"-------ctrlp------
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|.gradle'
let g:ctrlp_show_hidden   = 1


"-------ag------
let g:ag_prg               = 'ag -S --nocolor --nogroup --column --ignore "\.gradle" --ignore node_modules --ignore "*.sublime-workspace" --ignore "*min.js"'
let g:ag_working_path_mode = "r"
let g:ag_highlight         = 1


"-------ale------
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
let g:ale_javascript_eslint_use_global = 1
let g:ale_fix_on_save = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'

highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

autocmd BufWrite *.js ALEFix


"-------deoplete-ultisnips------
" let g:UltiSnipsExpandTrigger       = "<nothing>"
" let g:UltiSnipsJumpForwardTrigger  = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" let g:ulti_expand_or_jump_res = 0
" let g:deoplete#enable_at_startup   = 1
" function! ExpandSnippetOrCarriageReturn()
	" let snippet = UltiSnips#ExpandSnippetOrJump()
	" if g:ulti_expand_or_jump_res > 0
		" return snippet
	" else
		" return "\<CR>"
	" endif
" endfunction
" inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"


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
"
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


let g:goyo_height = '95%'
let g:goyo_width = '120'
function! s:goyo_enter()
	silent !tmux set status off
	silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
	set noshowmode
	set noshowcmd
	set scrolloff=999
	execute "NERDTreeClose"
endfunction

function! s:goyo_leave()
	silent !tmux set status on
	silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
	set showmode
	set showcmd
	set scrolloff=5
	hi NonText guifg=bg "~ at the end of the file
	hi LineNr  guibg=bg
	execute "NERDTreeClose"
endfunction

" call deoplete#custom#set('ultisnips', 'matchers', ['matcher_fuzzy'])
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


"-----------------------------------------
for cmd in ['Goyo', 'Gcd', 'Glcd', 'Gstatus', 'Gcommit', 'Gmerge', 'Gpull',
\ 'Grebase', 'Gpush', 'Gfetch', 'Grename', 'Gdelete', 'Gremove', 'Gblame', 'Gbrowse',
\ 'Ggrep', 'Glgrep', 'Glog', 'Gllog', 'Gedit', 'Gsplit', 'Gvsplit', 'Gtabedit', 'Gpedit',
\ 'Gread', 'Gw', 'Gwrite', 'Gw', 'Gwq', 'Gdiff', 'Gsdiff', 'Gvdiff', 'Gmove']
	exe 'cnoreabbrev '.tolower(cmd).' '.cmd
endfor

" if has("nvim")
    " au BufEnter,TermOpen term://* AcpDisable
    " au BufLeave term://* AcpEnable
" endif

"-------neosnippets-------
imap <C-o> <Plug>(neosnippet_expand_or_jump)
smap <C-o> <Plug>(neosnippet_expand_or_jump)
xmap <C-o> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
\ pumvisible() ? "\<C-n>" :
\ neosnippet#expandable_or_jumpable() ?
\    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" use tab to forward cycle
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

let g:neosnippet#snippets_directory='~/.vim/snippets'

