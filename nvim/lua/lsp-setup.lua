
local cmp = require'cmp'
local types = require'cmp.types'

local lspkind_comparator = function(conf)
local lsp_types = require('cmp.types').lsp
return function(entry1, entry2)
  if entry1.source.name ~= 'nvim_lsp' then
    if entry2.source.name == 'nvim_lsp' then
      return false
    else
      return nil
    end
  end
  local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
  local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

  local priority1 = conf.kind_priority[kind1] or 0
  local priority2 = conf.kind_priority[kind2] or 0
  if priority1 == priority2 then
    return nil
  end
  return priority2 < priority1
end
end

local label_comparator = function(entry1, entry2)
    return entry1.completion_item.label < entry2.completion_item.label
end

vim.o.pumheight = 10

vim.o.completeopt='menu,menuone,noselect'

cmp.setup({
    completion = {
        completeopt = 'menu,menuone,noinsert,noselect'
    },
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<TAB>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-u>'] = cmp.mapping.scroll_docs(4),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- For vsnip users.
        { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
        { name = 'path' },
    }),
    sorting = {
        comparators = {
            lspkind_comparator({
                kind_priority = {
                    Field = 11,
                    Property = 11,
                    Constant = 10,
                    Enum = 10,
                    EnumMember = 10,
                    Event = 10,
                    Function = 10,
                    Method = 10,
                    Operator = 10,
                    Reference = 10,
                    Struct = 10,
                    Variable = 9,
                    File = 8,
                    Folder = 8,
                    Class = 5,
                    Color = 5,
                    Module = 5,
                    Keyword = 2,
                    Constructor = 1,
                    Interface = 1,
                    Text = 1,
                    TypeParameter = 1,
                    Unit = 1,
                    Value = 1,
                    Snippet = 0,
                },
            }),
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
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
        { name = 'cmdline', keyword_pattern=[=[[^[:blank:]\!]*]=] }
    })
})

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
-- vim.o.completeopt='menuone,noselect'


local lsp = require('lspconfig')

function on_attach(client, bufnr)
    -- require('renaming').on_attach({})
    -- require('code_action').on_attach({})
end

local config = { 
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    settings = {
        ["rust-analyzer"] = {
            procMacro = {
                enable = true
            },
            checkOnSave = {
                command = "clippy",
            }
        },
        ["html"] = {
            format = {
                wrapAttributes = "force-aligned",
                templating = true,
            },
        },
    },
}

lsp.rust_analyzer.setup(config)
lsp.pyright.setup(config)
lsp.zls.setup(config)
lsp.cssls.setup(config)
lsp.html.setup(config)
lsp.metals.setup(config)

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = false,
    update_in_insert = true,
  }
)
