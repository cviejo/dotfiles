
:imap jj <Esc>
let mapleader = " "

nmap <leader>r :source ~/.vimrc<cr>
nmap ; :
vmap ; :
nmap ' `
vmap ' `
nmap s :!
nmap S :r !
nmap Q @q
nmap rr @:
nmap <C-l> <C-w>w

nnoremap <leader>s :w<cr>
nnoremap <C-s> :w<cr>
nnoremap <C-c> :call CloseWindow()<cr>
nnoremap <A-w> :call CloseWindow()<cr>

" vimium
nnoremap K :bn<cr>
nnoremap J :bp<cr>

" plugins
nmap <leader>f :Ag ""<left>
nmap <leader>g :Goyo<cr>
nmap <leader>k :NERDTreeToggle<cr>
nmap <leader>h :NERDTreeFind<cr>
nmap <leader>t :Tabularize /=<cr>:Tabularize /:<cr>:Tabularize /from/<cr>
vmap <leader>t :call AlignSelection()<cr>
nnoremap U :GundoToggle<cr>
nnoremap <C-w>z :ZoomToggle<cr>
" nmap <C-f> <Plug>(easymotion-bd-w)
nmap f <Plug>(easymotion-bd-w)

" tmux
nnoremap <C-w>/ :vsp<cr>
nnoremap <C-w>- :sp<cr>

" terminal
:tnoremap <Esc> <C-\><C-n>
:tnoremap jj <C-\><C-n>

" neomake / eslint
map <C-e> :lnext<cr>

" reselect after indent
vnoremap < <gv
vnoremap > >gv

" NERDCommenter
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle

" supercollider
au Filetype supercollider nnoremap <C-e> :call SClang_block()<CR>

" overtone
au Filetype clojure map <C-f> :Eval<CR>
