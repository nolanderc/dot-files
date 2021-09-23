

" Enable column limit
set textwidth=100

" Enable wrapping while typing
set fo+=t

" Surround selected text with Option<?>|
" T|    =>   Option<T>|
vnoremap So <ESC>`<iOption<<ESC>`>7la><ESC>
vmap SO So

" Delete surrounding wrapper
"   anyhow::Result<T|>    =>    T|
nmap dso ds>hv?\v\w+(::\w+)<CR>d


" Perform a quickfix on the current line
nnoremap <silent> gf <cmd>lua vim.lsp.buf.code_action({ diagonstics = {}, only = {"quickfix"} })<CR>

