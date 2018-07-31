
set noswapfile
set ignorecase
set clipboard=unnamedplus
set foldmethod=indent
set nofoldenable
set splitbelow
set splitright
set diffopt+=vertical
set nowrap
set shortmess+=I
set mouse=a
set hidden
set autoread
" set autowriteall
" set scrolloff=10

au BufNewFile,BufRead *.ejs set filetype=html

source $HOME/.vim/colors/OceanicNext.vim

source $HOME/.vim/config/indent.vim
source $HOME/.vim/config/key-bindings.vim
source $HOME/.vim/config/functions.vim
source $HOME/.vim/config/plugins.vim
source $HOME/.vim/config/theme.vim
source $HOME/.vim/config/macros.vim

" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd w


augroup neomake_hooks
  au!
  autocmd User NeomakeJobFinished :checktime
augroup END

let g:ale_fixers = {
\   'javascript': ['eslint'],
\}

let g:ale_fix_on_save = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

let g:prettier#config#parser = 'babylon'
" let g:neomake_javascript_enabled_makers = ['eslint']
" let g:neomake_javascript_eslint_args = ['-f', 'compact', '--fix']
" let g:neomake_javascript_eslint_args = ['--fix']
" call neomake#configure#automake('w')

" autocmd BufEnter * silent! lcd %:p:h
" autocmd! BufWritePost *.js Neomake eslint
" autocmd! BufWritePost * Neomake
" autocmd! BufWritePost * Neomake eslint
" autocmd BufRead,BufWritePost,BufEnter *.js,*.jsx silent! Neomake eslint
" autocmd BufWritePost *.js,*.jsx silent! Neomake eslint
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue Prettier
