
"-----------------------------------------
function! WordWrap()
	if (&wrap == 1)
		set nowrap
	else
		set wrap
	endif
endfunction
command! WW call WordWrap()


"-----------------------------------------
function! FormatJSON(...)
	let code="\"
				 \ var i = process.stdin;
				 \ var d = '';
				 \ i.resume();
				 \ i.setEncoding('utf8');
				 \ i.on('data', function(data) { d += data; });
				 \ i.on('end', function() {
				 \     console.log(JSON.stringify(JSON.parse(d), null, '\t'));
				 \ });\""
	execute "%! node -e " . code
endfunction


"-----------------------------------------
let s:hidden_all = 0
function! FullScreenToggle()
	set number!
	execute "AirlineToggle"
	if s:hidden_all  == 0
		let s:hidden_all = 1
		set listchars=tab:\ \ ,trail:·
		set noshowmode
		set noruler
		set laststatus=0
		set noshowcmd
	else
		let s:hidden_all = 0
		set listchars=tab:\|\ ,trail:·
		set showmode
		set ruler
		set laststatus=2
		set showcmd
	endif
endfunction
command! FS call FullScreenToggle()


"-----------------------------------------
function! Pretty(...)
	execute "%! node /developer/node/pretty.js"
endfunction


"-----------------------------------------
function! Easy()
	let name = bufname("%")
	echo name
	" name == ""
	if match(name, "NERD_tree") == 0
		echo "eee"
		exe "<Plug>(easymotion-bd-w)"
	else 
		echo "nopew"
	endif
endfunction

"-----------------------------------------
function! CloseWindow()
	let name = bufname("%")
	" name == ""
	if match(name, "NERD_tree") == 0 || name == "ALEPreviewWindow" || name == "[Plugins]" || name == ".git/index" || match(name, "fugitive:") == 0
		exe "q"
	else
		exe "Bclose"
	endif
endfunction


"-----------------------------------------
function! Name()
	echo bufname("%")
endfunction
command! Name call Name()


"-----------------------------------------
function! EnumPanes()
	for i in range(1, tabpagewinnr(tabpagenr(), '$'))
		let dim = 1
		if i == winnr()
			let dim = 0
		endif
		echo bufname(winbufnr(i))
		" let l:range = ""
		" let l:width = 256
		" let l:range = join(range(1, l:width), ',')
		" call setwinvar(i, '&colorcolumn', l:range)
		setlocal colorcolumn<
	endfor
endfunction
command! EnumPanes call EnumPanes()


"-----------------------------------------
function! EclipseSetup()
	set guifont=Ubuntu\ Mono\ Regular\ 13
	set guioptions -=T
endfunction
command! EclipseSetup call EclipseSetup()


"-----------------------------------------
function! s:ZoomToggle() abort
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
command! ZoomToggle call s:ZoomToggle()
command! Zoom call s:ZoomToggle()


"-----------------------------------------
function! Retab(...)
	let &tabstop=a:0 > 0 ? a:1 : 2
	set noexpandtab
	%retab!
	set tabstop=3
endfunction
command! -nargs=* Retab call Retab(<f-args>)
command! -nargs=* RT call Retab(<f-args>)


"-----------------------------------------
function! Spaces(...)
	" let &tabstop=a:0 > 0 ? a:1 : 2
	let &shiftwidth = a:0 > 0 ? a:1 : 2
	" set shiftwidth=3
	set expandtab
endfunction
command! -nargs=* Spaces call Spaces(<f-args>)
command! -nargs=* SP call Spaces(<f-args>)


"-----------------------------------------
function! AlignSelection()
	execute "Tabularize /".GetSelection()
endfunction


"-----------------------------------------
function! GetSelection()
	try
		let a_save = @a
		normal! gv"ay
		return @a
	finally
		let @a = a_save
	endtry
endfunction


"-----------------------------------------
function! ChangeWorkingDirectory()
	silent! lcd %:p:h
endfunction
command! CWD call ChangeWorkingDirectory()


"-----------------------------------------
function! PrintCommand(cmd)
  redir => message
  silent execute a:cmd
  redir END
  if !empty(message)
    enew
    silent put=message
  endif
endfunction
command! -nargs=+ -complete=command PrintCommand call PrintCommand(<q-args>)

command! -nargs=+ PrintCommand2 call feedkeys(":redir @a\r:silent ".<q-args>."\r:redir END\r:enew\n\"ap")

"-----------------------------------------
function! OpenTerminal(split)
	let $vimDir = getcwd()
	cd %:p:h
	execute a:split."terminal"
	cd $vimDir
endfunction
command! TT call OpenTerminal("")
command! VT call OpenTerminal("vs | ")
command! HT call OpenTerminal("sp | ")


command! Sjs call feedkeys(":set\ syntax=javascript\n")
command! Sjson call feedkeys(":set\ syntax=json\n")
command! PreferDestructring call feedkeys("0t;lF.dt;F=bi{}xi ea p0")
command! Noplusplus call feedkeys("0/++vlc += 10")
" command! Eqeqeq call feedkeys("0/\( == \| != \)ea=0")
" command! Eqeqeq call feedkeys("0/(!=\ \|==)ea=0")
command! Eqeqeq call feedkeys("\:%s/ == / === /g | %s/ != / !== /g")
command! Gr exe 'Gread'
command! Reload call feedkeys(":edit!\n")

"-----------------------------------------
for cmd in [ 'Reload', 'Sjson', 'Sjs', 'Note', 'Gr', 'WW', 'FS', 'CWD', 'TT', 'VT', 'HT' ]
	exe 'cnoreabbrev '.tolower(cmd).' '.cmd
endfor
