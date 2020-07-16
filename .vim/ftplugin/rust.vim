

" Enable column limit
set textwidth=100

" Enable wrapping while typing
set fo+=t

" Surround selected text with Option<?>|
" T|    =>   Option<T>|
vnoremap So <ESC>`<iOption<<ESC>`>7la><ESC>
vmap SO So

" Surround T with Result<T, |>
" T|    =>   Result<T, |>
vnoremap SR <ESC>`<iResult<<ESC>`>7la, ><ESC>i

" Surround selected text with Result<?>|
" T|    =>   Result<T>|
vnoremap Sr <ESC>`<iResult<<ESC>`>7la><ESC>

" Delete surrounding wrapper
" Option<T|>    =>    T|
nnoremap dso vi><ESC>`>lx`<hvbd

nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)

