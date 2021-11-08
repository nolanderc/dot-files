
-- Shortcut to edit this file
vim.cmd [[command! Vimrc tabe ~/.config/nvim/init.lua]]

require('plugins')

-- Enable mouse support
vim.o.mouse = 'a'

-- Automatically yank to clipboard
vim.o.clipboard = 'unnamedplus'

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

vim.o.hlsearch  = false -- Don't highlight matches after search is completed
vim.o.incsearch = true  -- Highlight while typing the search query

vim.o.breakindent   = true    -- Indent wrapped lines to the same indentation as their parent
vim.o.linebreak     = true   -- Wrap lines on whole words
vim.o.showbreak     = "    "   -- Indent wrapped lines by four spaces

-- Setup fuzzy file finder
require('telescope').setup()

require('lsp-setup')
require('mappings')
require('highlight')
