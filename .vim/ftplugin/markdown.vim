
" Set tab width to 4 spaces
set tabstop=4

" When changing indent with < and > change by 4 spaces
set shiftwidth=4
set softtabstop=4

" Use spaces over tabs
set expandtab

" Wrap lines at 80 columns
set textwidth=80

" This gets rid of the nasty _ italic bug in tpope's vim-markdown
" block $$...$$
syn region math start=/\$\$/ end=/\$\$/
" inline math
syn match math '\$[^$].\{-}\$'

" actually highlight the region we defined as "math"
hi link math Statement
