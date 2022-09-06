
-- Helper functions to easily create bindings
function map(mode, keys, command, opts)
	opts = vim.tbl_extend('keep', opts or {}, { noremap = true, silent = true })
	vim.api.nvim_set_keymap(mode, keys, command, opts)
end
function nmap(keys, command, opts) map('n', keys, command, opts) end
function imap(keys, command, opts) map('i', keys, command, opts) end
function vmap(keys, command, opts) map('v', keys, command, opts) end
function omap(keys, command, opts) map('o', keys, command, opts) end
function xmap(keys, command, opts) map('x', keys, command, opts) end

vim.g.mapleader = " "

-- Copy selected range to clipboard
vmap([[<leader>y]], [["+y]])
nmap([[<leader>y]], [[^vg_"+y]])

-- Repeat the macro recording in `q` abc
nmap([[Q]], [[@q]])
vmap([[Q]], [[:normal @q<CR>]])

-- Fuzzy find files relative to working directory
nmap([[<leader>o]], [[:Telescope find_files<CR>]])
-- Fuzzy find relative to current file
nmap([[<leader>O]], [[:Telescope find_files cwd=%:h<CR>]])
-- Search files for matching text in current directory
nmap([[<leader>F]], [[:Telescope live_grep<CR>]])

-- Edit a new file relative to current file
nmap([[<Leader>t]], [[:tabe <C-R>=expand("%:~:.:h") . "/" <CR>]], { silent = false })
-- Edit a file in a directory named the same as the current file
nmap([[<Leader>n]], [[:tabe <C-R>=expand("%:~:.:r") . "/" <CR>]], { silent = false })

-- Replace visually selected text in file
vmap([[<C-r>]], [["hy:%s/<C-r>h/<C-r>h/g<left><left>]], { silent = false })

-- Move to adjacent windows using `Ctrl+motion`
nmap([[<C-h>]], [[<C-w>h]])
nmap([[<C-j>]], [[<C-w>j]])
nmap([[<C-k>]], [[<C-w>k]])
nmap([[<C-l>]], [[<C-w>l]])

-- Select tabs
nmap([[L]], [[gt]])
nmap([[H]], [[gT]])

-- LSP integration

-- Goto definition
nmap([[gd]], [[<cmd>lua vim.lsp.buf.definition()<CR>]])

-- Goto definition, but in a new tab
nmap([[gD]], [[mt:tabe %<CR>`t<cmd>lua vim.lsp.buf.definition()<CR>]])

nmap([[gh]], [[<cmd>lua vim.lsp.buf.hover()<CR>]])
nmap([[gH]], [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
nmap([[gR]], [[<cmd>lua vim.lsp.buf.references()<CR>]])
nmap([[gI]], [[<cmd>lua vim.lsp.buf.incoming_calls()<CR>]])
nmap([[gi]], [[<cmd>lua vim.diagnostic.open_float()<CR>]])
nmap([[gr]], [[<cmd>lua vim.lsp.buf.rename()<CR>]])
nmap([[ga]], [[<cmd>lua vim.lsp.buf.code_action()<CR>]])
nmap([[<leader>f]], [[<cmd>lua vim.lsp.buf.formatting()<CR>]])

vmap([[ga]], [[<cmd>lua vim.lsp.buf.range_code_action()<CR>]])
vmap([[<leader>f]], [[<cmd>lua vim.lsp.buf.range_formatting()<CR>]])

-- Goto diagnostics
nmap([[gn]], [[<cmd>lua vim.diagnostic.goto_next()<CR>]])
nmap([[gp]], [[<cmd>lua vim.diagnostic.goto_prev()<CR>]])

-- Start inserting on right indentation
vim.cmd [[
function! InsertOnIndentation(default_action)
    if match(getline('.'), "^\\s*$") == 0
        return 'S'
    else
        return a:default_action
    endif
endfunction
noremap <expr> A InsertOnIndentation('A')
noremap <expr> I InsertOnIndentation('I')
]]

-- Select the current line (but ignoring whitespace)
nmap([[-]], [[g_v^]])

-- Argument text object
nmap([[>.]], [[<Plug>Argumentative_MoveRight]], {noremap=false})

xmap([[ia]], [[<Plug>Argumentative_InnerTextObject]], {noremap = false})
xmap([[aa]], [[<Plug>Argumentative_OuterTextObject]], {noremap = false})

omap([[ia]], [[<Plug>Argumentative_OpPendingInnerTextObject]], {noremap = false})
omap([[aa]], [[<Plug>Argumentative_OpPendingOuterTextObject]], {noremap = false})

