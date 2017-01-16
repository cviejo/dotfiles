
:imap jj <Esc>
let mapleader = " "
" let mapleader = ","
" let g:mapleader = ","
" let maplocalleader = ","
" let g:maplocalleader = ","

nmap <leader>s :w<cr>
nmap <leader>r :source ~/.vimrc<cr>
nmap <leader>a :

nnoremap <C-c> :call CloseWindow()<cr>
nnoremap <A-w> :call CloseWindow()<cr>

" vimium
nnoremap K :bn<cr>
nnoremap J :bp<cr>

" plugins
nmap <leader>k :NERDTreeToggle<cr>
nmap <leader>t :Tabularize /=<cr>:Tabularize /:<cr>
nnoremap U :GundoToggle<cr>
nnoremap <C-w>z :ZoomToggle<cr>
map <leader><leader>w <Plug>(easymotion-bd-w)
nmap <leader>f :Ag ""<left>

" tmux
nnoremap <C-w>/ :vsp<cr>
nnoremap <C-w>- :sp<cr>

nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>
