
" LANGUAGE SERVER
" Show hover
nnoremap <buffer><silent> K :LspHover<CR>
" Go to definition
nnoremap <buffer><silent> gd :LspDefinition<CR>
" Rename symbol
nnoremap <buffer><silent> § :LspRename<CR>

" Compile and run
nnoremap <buffer> <F5> :wa <BAR> Crun <CR>

" Show errors and warnings
nnoremap <buffer><silent> <F4> :bo copen 4 <BAR> wincmd p <CR> 


" Enable column limit
set textwidth=100

" Enable wrapping while typing
set fo+=t


" Add function text object
vnoremap if :<C-U>silent! normal! [mvi{<CR>
omap if :normal Vif<CR>

" Surround selected text with Option<>
vnoremap So <ESC>`<iOption<<ESC>`>7la><ESC>
vmap SO So

" Surround selected text with Result<, |>
vnoremap Sr <ESC>`<iResult<<ESC>`>7la, ><ESC>i
vmap SR Sr
