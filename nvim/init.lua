#
-- Shortcut to edit this file
vim.cmd [[command! Vimrc tabe ~/.config/nvim/init.lua]]

require('plugins')

-- Enable mouse support
vim.o.mouse = 'a'

-- Set the colorscheme
vim.cmd [[syntax on]]
vim.o.termguicolors = true
vim.o.background = 'dark'
vim.g.gruvbox_italic = 1
vim.cmd [[colorscheme gruvbox]]

-- Save open buffers when losing focus
vim.cmd [[autocmd FocusLost,BufLeave * silent! update]]

-- Indent by 4 spaces
vim.o.expandtab     = true  -- Use spaces over tabs
vim.o.tabstop       = 4     -- Use 4 spaces for each tab
vim.o.shiftwidth    = 4     -- Increase/decrease indentation using 4 spaces at a time

-- Searching
vim.o.hlsearch  = false -- Don't highlight matches after search is completed
vim.o.incsearch = true  -- Highlight while typing the search query

-- Line wrapping
vim.o.breakindent   = true   -- Indent wrapped lines to the same indentation as their parent
vim.o.linebreak     = true   -- Wrap lines on whole words
vim.o.showbreak     = "    " -- Indent wrapped lines by four spaces

-- Keep cursor from going to the very top/bottom of the screen
vim.o.scrolloff = 5

-- Enable persistent undo
vim.o.undofile = true

require('lsp-setup')
require('mappings')
require('highlight')

-- Disable status bar
vim.o.laststatus = 0
vim.o.showmode = false
vim.o.shortmess = vim.o.shortmess .. 'FWc';


-- When attempting to save a file, if the directory does not exist, create it
vim.cmd [[
function g:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call g:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
]]
