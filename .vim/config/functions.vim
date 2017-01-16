
"-----------------------------------------
function! WordWrap()
	if (&wrap == 1)
		set nowrap
	else
		set wrap
	endif
endfunction
command! WordWrap call WordWrap()
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
function! CloseWindow()
	let name = bufname("%")
	if match(name, "NERD_tree") == 0 || name == "[Plugins]" || name == ""
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
function! Enum()
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


"-----------------------------------------
function! EclipseSetup()
	set guifont=Ubuntu\ Mono\ Regular\ 14
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

