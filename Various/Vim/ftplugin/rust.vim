
" LANGUAGE SERVER
" Show hover
nnoremap <buffer><silent> K :call LanguageClient_textDocument_hover()<CR>
" Go to definition
nnoremap <buffer><silent> gd :call LanguageClient_textDocument_definition()<CR>
" Rename symbol
nnoremap <buffer><silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" Compile and run
nnoremap <buffer> <F5> :wa <BAR> Crun <CR>

" Show errors and warnings
nnoremap <buffer><silent> <F4> :bo copen 4 <BAR> wincmd p <CR> 



