
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

