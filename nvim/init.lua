-- vim:fileencoding=utf-8:foldmethod=marker

-- GENERAL {{{

-- Shortcut to edit this file
vim.cmd [[command! Vimrc tabe ~/.config/nvim/init.lua]]

-- Enable mouse support
vim.o.mouse = 'a'

-- Show line numbers
vim.o.number = true

-- Hide gutter
vim.o.signcolumn = 'no'

-- Save open buffers when losing focus
vim.cmd [[autocmd FocusLost,BufLeave * silent! update]]

-- Indent by 4 spaces
vim.o.expandtab     = true  -- Use spaces over tabs
vim.o.tabstop       = 4     -- Use 4 spaces for each tab
vim.o.shiftwidth    = 4     -- Increase/decrease indentation using 4 spaces at a time

-- Searching
vim.o.hlsearch  = false -- Don't highlight matches after search is completed
vim.o.incsearch = true  -- Highlight while typing the search query

 -- Search case-insensitively if the search term is lowercase
vim.o.ignorecase = true -- Case-insensitive search
vim.o.smartcase = true  -- Override above if search contains uppercase letters

-- Line wrapping
vim.o.breakindent   = true   -- Indent wrapped lines to the same indentation as their parent
vim.o.linebreak     = true   -- Wrap lines on whole words
vim.o.showbreak     = "    " -- Indent wrapped lines by four spaces

-- Keep cursor from going to the very top/bottom of the screen
vim.o.scrolloff = 5

-- Enable persistent undo
vim.o.undofile = true

-- Disable status bar
vim.o.laststatus = 0
vim.o.showmode = false
vim.o.shortmess = vim.o.shortmess .. 'FWc';

-- When attempting to save a file, if the directory does not exist, create it
vim.cmd [[
function! g:MkNonExDir(file, buf)
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

-- }}}

-- MAPPINGS {{{

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
nmap([[<leader>o]], [[<cmd>Telescope find_files<CR>]])
-- Fuzzy find relative to current file
nmap([[<leader>O]], [[<cmd>Telescope find_files cwd=%:h<CR>]])
-- Search files for matching text in current directory
nmap([[<leader>F]], [[<cmd>Telescope live_grep<CR>]])
nmap([[<leader>l]], [[<cmd>lua require('telescope.builtin').find_files{no_ignore=true}<CR>]])
nmap([[<leader>L]], [[<cmd>lua require('telescope.builtin').live_grep{no_ignore=true}<CR>]])

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

nmap([[<C-Space>]], [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
imap([[<C-Space>]], [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
vmap([[<C-Space>]], [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])

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

-- Print syntax node(s) under cursor
nmap([[<leader>z]], [[:echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<CR>]])

-- }}}

-- PLUGINS {{{

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    --- General {{{
    'nvim-lua/plenary.nvim',
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'PeterRincker/vim-argumentative',
    'godlygeek/tabular',
    { 'terrortylor/nvim-comment', name = 'nvim_comment', opts = {} },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require'telescope'.setup{
                defaults = {
                    mappings = {
                        i = {
                            ['<ESC>'] = require'telescope.actions'.close,
                        }
                    },
                    layout_strategy = 'vertical',
                },
            }
        end
    },
    {
        'stevearc/dressing.nvim',
        opts = {
            input = {
                enabled = true,
                insert_only = false,
            },
            select = {
                enabled = true,
                backend = { "telescope", "fzf", "builtin" },
                telescope = {
                    sorting_strategy = 'ascending',
                    layout_strategy = 'cursor',
                    layout_config = {
                        height = 10,
                        width = 50,
                    },
                },
            },
        },
    },
    --- }}}

    -- LSP {{{
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    -- }}}

    -- Languages {{{
    'ziglang/zig.vim',
    'fladson/vim-kitty',
    'tikhomirov/vim-glsl',
    'NoahTheDuke/vim-just',
    'DingDean/wgsl.vim',
    -- }}}
})

-- Completions {{{
local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = nil
            return vim_item
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<TAB>'] = cmp.mapping.confirm({ select = false }),
        -- ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-u>'] = cmp.mapping.scroll_docs(4),
        -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- ['<C-Space>'] = cmp.mapping.complete(),
        -- ['<C-e>'] = cmp.mapping.abort(),
        -- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- For vsnip users.
        { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})
-- }}}

-- LSP Setup {{{
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = false,
        update_in_insert = true,
    }
)

-- }}}

-- LSP Servers {{{
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
lspconfig.zls.setup { capabilities = capabilities }
lspconfig.pylsp.setup { capabilities = capabilities }
lspconfig.glsl_analyzer.setup { capabilities = capabilities }
lspconfig.rust_analyzer.setup { capabilities = capabilities }

vim.lsp.handlers["wgsl-analyzer/requestConfiguration"] = function(err, result, ctx, config)
    return { 
        success = true,
        customImports = { _dummy_ = "dummy"},
        shaderDefs = {},
        trace = {
            extension = false,
            server = false,
        },
        inlayHints = {
            enabled = false,
            typeHints = false,
            parameterHints = false,
            structLayoutHints = false,
            typeVerbosity = "inner",
        },
        diagnostics = {
            typeErrors = true,
            nagaParsingErrors = true,
            nagaValidationErrors = true,
            nagaVersion = "main",
        }
    }
end
lspconfig.wgsl_analyzer.setup { capabilities = capabilities }
-- }}}

-- Other {{{
vim.g.zig_fmt_parse_errors = 0
-- }}}

-- }}}

-- COLORSCHEME {{{

-- Set the colorscheme
vim.cmd [[syntax on]]
vim.o.termguicolors = true
vim.o.background = 'light'
vim.g.gruvbox_italic = 1
vim.cmd [[ colorscheme paperdark ]]
vim.cmd [[ set cursorline ]]

-- Zig {{{
vim.cmd[[hi link zigPreProc Keyword]]
vim.cmd[[hi link zigVarDecl Keyword]]
vim.cmd[[hi link zigMacro Keyword]]
vim.cmd[[hi link zigExecution Keyword]]
-- }}}

-- }}}

-- LANGUAGES {{{
vim.cmd [[autocmd FileType glsl setlocal commentstring=//\ %s]]
-- }}}
