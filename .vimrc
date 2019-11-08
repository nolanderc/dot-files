set encoding=utf-8
" ========================
" Loading Plugins (load-plugins)
" ========================

" HTML/XML
let xml_use_html = 1
let xml_use_xhtml = 1

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
Plug 'drmingdrmer/vim-syntax-markdown'

Plug 'mustache/vim-mustache-handlebars'

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

" === Completion ===
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" === Snippets ===
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

" === Files ===
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" === Editing ===
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'nelstrom/vim-visual-star-search'
Plug 'godlygeek/tabular'
Plug 'cohama/lexima.vim'
Plug 'PeterRincker/vim-argumentative'

" === General ===
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-obsession'

Plug 'amerlyq/vim-focus-autocmd'

" Stop loading plugins
call plug#end()

filetype plugin on

" ========================
" Configure Plugins (conf-plugin)
" ========================

" Disable scratch preview
set completeopt-=preview

" imap <c-space> <Plug>(asyncomplete_force_refresh)

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

set shortmess+=c

" MARKDOWN
let vim_markdown_preview_pandoc=1
let g:table_mode_corner='|'

" JAVA
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" Latex
autocmd FileType tex setlocal omnifunc=vimtex#complete#omnifunc
let g:tex_flavor = 'latex'

let g:tex_conceal='abdmgs'
set conceallevel=1


" RUST
" Set files ending with *.rs to rust source
autocmd BufReadPost *.rs setlocal filetype=rust
autocmd BufNewFile,BufEnter *.pl setlocal filetype=prolog

" LANGUAGE SERVER
" Start the Rust Language Server
autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'whitelist': ['rust'],
        \ })

let g:lsp_diagnostics_enabled = 0


set signcolumn=no


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
highlight TabLine cterm=NONE gui=NONE guifg=#7b6e65 guibg=NONE
highlight TabLineFill ctermbg=NONE guibg=NONE
highlight TabLineSel cterm=italic gui=italic ctermbg=NONE guibg=NONE

" Make Rust Doc-Comments italics
highlight Special cterm=italic gui=italic ctermfg=130 guifg=#af5f00


" Make the hightlight color less distracting
highlight QuickFixLine cterm=italic,bold ctermfg=NONE ctermbg=NONE


" Set relative line numbers
set number relativenumber

" Enable persintent undo history
set undofile
set undodir=~/.vim/undodir


" Disable code folding
set nofoldenable

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
noremap <Leader>o :FZF<CR>

" Edit a file relative to current file
noremap <Leader>t :tabe <C-R>=expand("%:~:.:h") . "/" <CR>
vnoremap <Leader>t y:tabe <C-R>=expand("%:~:.:h") . "/" <CR><C-R>"

" Edit a file in a directory named the same as the current file
noremap <Leader>n :tabe <C-R>=expand("%:~:.:r") . "/" <CR>
vnoremap <Leader>n y:tabe <C-R>=expand("%:~:.:r") . "/" <CR><C-R>"


" Replace visually selected text in file
vnoremap <C-r> "hy:%s/<C-r>h/<C-r>h/g<left><left>


" Format file
let g:rustfmt_options = '--edition 2018'
autocmd FileType rust nmap <Leader>f :RustFmt<CR>

" Remove dbg! macro 
autocmd FileType rust nmap <Leader>d /dbg!(<CR>dt(ds)

" Enclose in dbg! macro
autocmd FileType rust vmap <Leader>d S)idbg!<ESC>

" Perform code action
nmap <silent> <Leader>e <Plug>(coc-codeaction)

" Repeat last macro
noremap Q @@

" Repeat last macro
vnoremap Q :norm @@<CR>

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
autocmd FocusLost,BufLeave * :wa


