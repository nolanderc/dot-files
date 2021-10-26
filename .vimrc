set encoding=utf-8
" ========================
" Loading Plugins (load-plugins)
" ========================

" HTML/XML
let xml_use_html = 1
let xml_use_xhtml = 1

" Only select the contents of the argument, ignoring whitespace
let g:targets_aiAI = 'aIAi'

let g:python3_host_prog="/usr/local/bin/python3"

" Highlight everything
let g:python_highlight_all = 1
let g:python_highlight_space_errors = 0

" Always insert new line on enter
let g:lexima_accept_pum_with_enter = 0

" Load the plugin manager
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Begin loading plugins
call plug#begin('~/.vim/plugged')

" === Themes ===
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'


" === Languages ===

Plug 'fladson/vim-kitty'

Plug 'lepture/vim-jinja'

Plug 'alvan/vim-closetag'

Plug 'BeneCollyridam/futhark-vim'

Plug 'tbastos/vim-lua'

Plug 'vim-python/python-syntax'

Plug 'petRUShka/vim-opencl'

Plug 'bfrg/vim-cpp-modern'

Plug 'jparise/vim-graphql'

Plug 'drmingdrmer/vim-syntax-markdown'

Plug 'mustache/vim-mustache-handlebars'

Plug 'neovimhaskell/haskell-vim'

Plug 'lervag/vimtex'

Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'

Plug 'ron-rs/ron.vim'
Plug 'mrk21/yaml-vim'

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'posva/vim-vue'

Plug 'pest-parser/pest.vim'

Plug 'JuliaEditorSupport/julia-vim'
Plug 'daeyun/vim-matlab'

Plug 'vim-scripts/DoxygenToolkit.vim'

Plug 'tikhomirov/vim-glsl'

" === Completion ===
Plug 'neovim/nvim-lspconfig'

" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'

" Autocompletion framework for LSP
Plug 'hrsh7th/nvim-compe'

" Show signatures
Plug 'ray-x/lsp_signature.nvim'

" === Snippets ===
" Plug 'sirver/ultisnips'
" Plug 'honza/vim-snippets'

" === Files ===
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'derekwyatt/vim-fswitch'

" === Editing ===
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'nelstrom/vim-visual-star-search'
Plug 'godlygeek/tabular'

" Auto close brackets
Plug 'cohama/lexima.vim'

" Delete inside argument
Plug 'wellle/targets.vim'

" === General ===
Plug 'tpope/vim-obsession'

" === Utility ===
Plug 'tpope/vim-fugitive'

" Stop loading plugins
call plug#end()

filetype plugin on

" ========================
" Configure Plugins (conf-plugin)
" ========================

" Set the current theme
syntax on
set termguicolors
set bg=dark
let g:gruvbox_italic=1
colorscheme gruvbox

" Set the color of the gutter
highlight SignColumn        ctermbg=NONE guibg=NONE
highlight GruvboxRedSign    ctermbg=NONE guibg=NONE
highlight GruvboxYellowSign ctermbg=NONE guibg=NONE
highlight GruvboxGreenSign  ctermbg=NONE guibg=NONE
highlight GruvboxBlueSign   ctermbg=NONE guibg=NONE
highlight GruvboxPurpleSign ctermbg=NONE guibg=NONE
highlight GruvboxAquaSign   ctermbg=NONE guibg=NONE

highlight CursorLineNr guifg=#7b6e65 guibg=NONE

" Set the color of tabs
highlight TabLine       gui=NONE  guifg=gray    guibg=bg cterm=NONE  ctermfg=gray    ctermbg=bg
highlight TabLineFill   gui=NONE  guifg=gray    guibg=bg cterm=NONE  ctermfg=gray    ctermbg=bg
highlight TabLineSel    gui=NONE  guifg=orange  guibg=10 cterm=NONE  ctermfg=darkyellow  ctermbg=10

" Make Rust Doc-Comments italics
highlight Special cterm=italic gui=italic ctermfg=130 guifg=#af5f00

" Make the hightlight color less distracting
highlight QuickFixLine cterm=italic,bold ctermfg=NONE ctermbg=NONE

" Set background color of floating windows
highlight NormalFloat ctermbg=bg guibg=#202020
highlight FloatBorder ctermbg=NONE guibg=#202020

" Change highlighting of operators
highlight Operator guifg=orange


let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

set shortmess+=c

" MARKDOWN
let vim_markdown_preview_pandoc=1
let g:table_mode_corner='|'
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'c', 'rust', 'prolog']

" JAVA
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" Latex
autocmd FileType tex setlocal omnifunc=vimtex#complete#omnifunc
let g:tex_flavor = 'latex'

let g:tex_conceal='abdmgs'
set conceallevel=1


autocmd BufReadPost *.rs setlocal filetype=rust
autocmd BufNewFile,BufEnter *.pl setlocal filetype=prolog
autocmd BufReadPost *.metal setlocal filetype=metal

" LANGUAGE SERVER

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Disable scratch preview
" set completeopt-=preview

" ==============================
" Initialize LSP
" ==============================
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

local on_attach = function()
    -- require'signatures'.on_attach({
    --     follow_cursor = true,
    -- })
    require'renaming'.on_attach({})
    require'code_action'.on_attach({})
    require'lsp_signature'.on_attach({
        hint_prefix = "",
        timer_interval = 10,
        doc_lines = 0,
        transpancy = nil,
        floating_window = false,
    })
end


-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({ on_attach = on_attach })
nvim_lsp.pyright.setup({ on_attach = on_attach })

require'compe'.setup({
    enabled = true,
    source = {
        path = true,
        buffer = true,
        nvim_lsp = true,
    },
})

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = false,
    update_in_insert = true,
  }
)

EOF

" Code navigation shortcuts
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gH <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gI    <cmd>lua vim.lsp.buf.incoming_calls()<CR>

nnoremap <silent> gi    <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gr    <cmd>lua require'renaming'.rename()<CR>

nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
vnoremap <silent> ga    <cmd>lua vim.lsp.buf.range_code_action()<CR>

" nnoremap <silent> ga    <cmd>lua require'code_action'.code_action()<CR>

nnoremap <silent> <leader>f <cmd>lua vim.lsp.buf.formatting()<CR>
vnoremap <silent> <leader>f <cmd>lua vim.lsp.buf.range_formatting()<CR>

inoremap <silent><expr> <Tab> compe#confirm('<Tab>')


" Go to next/previous error
nnoremap <silent> gp <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> gn <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=no


" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }



" C++
au! BufEnter *.cpp let b:fswitchdst = 'hpp,h' | let b:fswitchlocs = '../include'

let g:load_doxygen_syntax=1

noremap <Leader>h :w<CR>:FSHere<CR>

" Zed
autocmd BufEnter *.zed set syntax=rust

" ========================
" General Configuration (conf-general)
" ========================


set autoread
au FocusGained,BufEnter * :checktime


" make backspace work like most other programs
set backspace=2

" Make <ESC> work immediately when exiting insert mode
set timeout
set timeoutlen=1000 ttimeoutlen=0


" Set tab width to 4 spaces
set tabstop=4

" When changing indent with < and > change by 4 spaces
set shiftwidth=4
set softtabstop=4

" Use spaces over tabs
set expandtab


" Soft wrap of lines
set breakindent   " Indent wrapped lines to the same indentation as their parent
set linebreak     " Wrap lines on whole words
set showbreak=\ \ " Indent wrapped lines by two spaces


" Disable search highlight
set nohlsearch
set incsearch


" Set relative line numbers
set nonumber norelativenumber

" Enable persintent undo history
set undofile
set undodir=~/.vim/undodir


" Disable code folding
autocmd BufEnter * set nofoldenable

" Highligh code over 100 column limit
highlight OverLength ctermbg=red ctermfg=NONE guibg=#592929
match OverLength /\%101v.\+/


" Automatically create the file's parent directory if necessary
function! s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction
augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END


" Only complete the common part in wildmenu
set wildmode=longest:full,full

" ========================
" Key Mappings (conf-key-map)
" ========================

" Enable mouse support
set mouse=a

map <ScrollWheelUp> <C-y>
map <ScrollWheelDown> <C-e>

" Disable the arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

noremap <C-Up> <NOP>
noremap <C-Down> <NOP>
noremap <C-Left> <NOP>
noremap <C-Right> <NOP>

inoremap <C-Up> <NOP>
inoremap <C-Down> <NOP>
inoremap <C-Left> <NOP>
inoremap <C-Right> <NOP>

" Max distance between top and bottom of screen and cursor
set scrolloff=3

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"


" Navigate panes using ctrl + movement
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k

" Disable the Ctrl+C command to get to normal mode
inoremap <C-C> <NOP>

" Disable Ex mode
noremap Q <NOP>


" Navigate quick fixes
noremap [q :Cprev<CR>
noremap ]q :Cnext<CR>

" Search for files in current directory
if (!exists('g:vscode'))
noremap <Leader>o :Files<CR>
noremap <Leader>F :Rg<CR>
noremap <Leader>O :Files %:h<CR>
endif

" Edit a file relative to current file
noremap <Leader>t :tabe <C-R>=expand("%:~:.:h") . "/" <CR>
vnoremap <Leader>t y:tabe <C-R>=expand("%:~:.:h") . "/" <CR><C-R>"

" Edit a file in a directory named the same as the current file
noremap <Leader>n :tabe <C-R>=expand("%:~:.:r") . "/" <CR>
vnoremap <Leader>n y:tabe <C-R>=expand("%:~:.:r") . "/" <CR><C-R>"


" Replace visually selected text in file
vnoremap <C-r> "hy:%s/<C-r>h/<C-r>h/g<left><left>


" Remove dbg! macro 
autocmd FileType rust nmap <Leader>d /dbg!(<CR>dt(ds)

" Enclose in dbg! macro
autocmd FileType rust vmap <Leader>d S)idbg!<ESC>

noremap Q @q

" Repeat last macro
vnoremap Q :norm @q<CR>

" Execute current line as command
noremap <silent> ,e vipy`>o<ESC>pvip:s/\\\n//g<CR>vipd:.!<C-R>"<CR>

noremap ,E :exec '!'.getline('.')<CR>

" Repeat previous command in normal mode on each line in visual mode
vnoremap <leader>. :norm .<CR>

" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre   *.wav let &bin=1
  au BufReadPost  *.wav if &bin | %!xxd
  au BufReadPost  *.wav set ft=xxd | endif
  au BufWritePre  *.wav if &bin | %!xxd -r
  au BufWritePre  *.wav endif
  au BufWritePost *.wav if &bin | %!xxd
  au BufWritePost *.wav set nomod | endif
augroup END


" ========================
" Editing
" ========================

" Start inserting on right indentation
function! InsertOnIndentation(default_action)
    if match(getline('.'), "^\\s*$") == 0
        return 'S'
    else
        return a:default_action
    endif
endfunction
noremap <expr> A InsertOnIndentation('A')
noremap <expr> I InsertOnIndentation('I')

" Select the current line (but ignoring whitespace)
nnoremap - ^vg_

" Yank to clipboard
vmap <leader>y "+y
nmap <leader>y "+yy

" Add curly brackets to argument motion
autocmd User targets#mappings#user call targets#mappings#extend({
    \ 'a': {'argument': [{'o': '[({[]', 'c': '[])}]', 's': ','}]},
    \ })

" ========================
" Custom commands (conf-commands)
" ========================

" Save as sudo
command! W w !sudo tee "%" > /dev/null

" Make cnext and cprevious wrap around
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry

" Open vimrc in new tab
command! Vimrc tabe ~/.vimrc

" ========================
" Events (conf-events)
" ========================

" Save buffers on focus lost
autocmd FocusLost,BufLeave * silent! update

if (exists('g:vscode'))
    nnoremap gd :call VSCodeCall('editor.action.revealDefinition')<CR>
    nnoremap <leader>r :call VSCodeCall('editor.action.rename')<CR>
    nnoremap <leader>f :call VSCodeCall('editor.action.formatDocument')<CR>
endif


