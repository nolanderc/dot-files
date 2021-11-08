
vim.g.coq_settings = { 
    display = {
        pum = {
            -- Don't clear completions results on each keystroke (helps with flickering)
            fast_close = false
        }
    },
    -- Autostart
    auto_start = 'shut-up',
    keymap = {
        recommended = false,
    },
    clients = {
        snippets = {
            warn = {},
        }
    },
}

-- Override default keymap
vim.cmd [[
ino <silent><expr> <TAB>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><TAB>" : "\<C-y>") : "\<TAB>"
]]

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
vim.o.completeopt='menuone,noinsert,noselect'


local lsp = require('lspconfig')
local coq = require('coq')

function on_attach(client, bufnr)
    require('renaming').on_attach({})
    require('code_action').on_attach({})
end

local config = { on_attach = on_attach }
local config = coq.lsp_ensure_capabilities(config)

lsp.rust_analyzer.setup(config)
lsp.pyright.setup(config)

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = false,
    update_in_insert = true,
  }
)
