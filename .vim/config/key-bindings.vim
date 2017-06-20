
:imap jj <Esc>
let mapleader = " "

nmap <leader>s :w<cr>
nmap <leader>r :source ~/.vimrc<cr>
nmap <leader>a :

nnoremap <C-s> :w<cr>
nnoremap <C-c> :call CloseWindow()<cr>
nnoremap <A-w> :call CloseWindow()<cr>

" vimium
nnoremap K :bn<cr>
nnoremap J :bp<cr>
nnoremap X :call CloseWindow()<cr>

" plugins
nmap <leader>f :Ag ""<left>
nmap <leader>k :NERDTreeToggle<cr>
nmap <leader>h :NERDTreeFind<cr>
nmap <leader>t :Tabularize /=<cr>:Tabularize /:<cr>:Tabularize /from/<cr>
vmap <leader>t :call AlignSelection()<cr>
nnoremap U :GundoToggle<cr>
nnoremap <C-w>z :ZoomToggle<cr>
" map <C-i> <Plug>(easymotion-bd-w)
nmap f <Plug>(easymotion-bd-w)

" tmux
nnoremap <C-w>/ :vsp<cr>
nnoremap <C-w>- :sp<cr>

nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>

" reselect after indent
vnoremap < <gv
vnoremap > >gv

" supercollider
au Filetype supercollider nnoremap <C-e> :call SClang_block()<CR>

" overtone
au Filetype clojure map <C-f> :Eval<CR>
