
set background=dark
set laststatus=2
set number

if has("termguicolors")
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
	set termguicolors
	colorscheme OceanicNext
	let g:airline_theme='base16_ocean'
else
	set t_Co=256
	let g:airline_theme='lucius'
	colorscheme spacegray
	let g:solarized_termcolors=256
endif

:hi NonText guifg=bg "~ at the end of the file
:hi LineNr  guibg=bg
" set foldcolumn=2
" set numberwidth=3
