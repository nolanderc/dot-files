
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
function unmap(mode, keys)
	vim.api.nvim_del_keymap(mode, keys)
end

vim.g.mapleader = " "

-- Copy selected range to clipboard
vmap([[<leader>y]], [["+y]])
nmap([[<leader>y]], [[^vg_"+y]])

nmap([[<leader>p]], [["+p]])

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

-- Scroll the view without the cursor
nmap([[<C-j>]], [[5<C-e>]])
nmap([[<C-k>]], [[5<C-y>]])

-- LSP integration

-- Goto definition
nmap([[gd]], [[<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]])
-- Goto definition, but in a new tab
nmap([[gD]], [[mt:tabe %<CR>`t<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]])
-- Goto definition, but in a split
nmap([[g<c-d>]], [[mt:split<CR>`t<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]])

-- Search workspace symbols
nmap([[<leader>s]], [[<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>]])

-- Search document symbols
nmap([[<leader>S]], [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])

-- List all diagnostics
nmap([[<leader>d]], [[<cmd>lua require('telescope.builtin').diagnostics()<CR>]])
-- List errors
nmap([[<leader>D]], [[<cmd>lua require('telescope.builtin').diagnostics({severity_limit = 'error'})<CR>]])


-- Show hover information on the item under the cursor
nmap([[gh]], [[<cmd>lua vim.lsp.buf.hover()<CR>]])

-- Show the signature of the current function
nmap([[gH]], [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])

nmap([[gR]], [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]])
nmap([[gI]], [[<cmd>lua vim.lsp.buf.incoming_calls()<CR>]])
nmap([[gi]], [[<cmd>lua vim.diagnostic.open_float()<CR>]])
nmap([[gr]], [[<cmd>lua vim.lsp.buf.rename()<CR>]])
nmap([[ga]], [[<cmd>lua vim.lsp.buf.code_action()<CR>]])
nmap([[<leader>f]], [[<cmd>lua vim.lsp.buf.format()<CR>]])

vmap([[ga]], [[<cmd>lua vim.lsp.buf.code_action()<CR>]])
vmap([[<leader>f]], [[<cmd>lua vim.lsp.buf.format()<CR>]])

-- Goto diagnostics
nmap([[gn]], [[<cmd>lua vim.diagnostic.goto_next({ severity = { min = vim.diagnostic.severity.WARN } })<CR>]])
nmap([[gp]], [[<cmd>lua vim.diagnostic.goto_prev({ severity = { min = vim.diagnostic.severity.WARN } })<CR>]])

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

-- Align
vmap([[|]], [[:Tabularize /]], { silent = false })

