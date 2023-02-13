
vim.cmd [[packadd packer.nvim]]

vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_math = 1
vim.g.lexima_accept_pum_with_enter = 0

vim.g.python_highlight_all = 1
vim.g.python_highlight_space_errors = 0

vim.g.zig_fmt_parse_errors = 0

-- Add `{ ... }` as a valid target for argument mappings
vim.cmd [[
autocmd User targets#mappings#user call targets#mappings#extend({
		\ 'a': {'argument': [{'o': '[{([]', 'c': '[])}]', 's': ','}]},
		\ })
]]

require('packer').startup(function()
	use 'wbthomason/packer.nvim'    -- Update package manager automatically
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use 'stevearc/dressing.nvim' -- nicer UI for selecting/renaming things

	use 'tpope/vim-surround'    -- Surround with braces/quotes
	use 'tpope/vim-repeat'      -- '.'-repeat for more stuff
    use 'tpope/vim-fugitive'

    use 'godlygeek/tabular'     -- Align text
    -- use 'cohama/lexima.vim'     -- Auto-close brackets
    -- use 'wellle/targets.vim'    -- More object motions (inside argument)
    -- use 'vim-scripts/argtextobj.vim' -- argument text object
    use 'PeterRincker/vim-argumentative' -- argument text object

    use 'neovim/nvim-lspconfig' -- LSP framework for loading LSP servers
    use 'nvim-lua/lsp_extensions.nvim'  -- Inlay hints and more

	-- use 'morhetz/gruvbox'   -- The best color scheme
    use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

    -- Save/restore sessions
    use 'tpope/vim-obsession'

    -- Comment out lines
    use 'terrortylor/nvim-comment'

    -- Completions
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- Languages + Syntax --
    use 'plasticboy/vim-markdown'
    use 'cespare/vim-toml'
    use 'lervag/vimtex'
    use 'rust-lang/rust.vim'

    use 'vim-python/python-syntax'

    use 'ziglang/zig.vim'

    use 'fladson/vim-kitty'

    use 'mracos/mermaid.vim'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }
    use 'nvim-treesitter/playground'

    use 'Glench/Vim-Jinja2-Syntax'
end)

require'nvim-treesitter.configs'.setup {
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true,              -- false will disable the whole extension
    },
    playground = {
        enable = true
    },
}

-- Setup fuzzy file finder
require('telescope').setup{
     defaults = {
         mappings = {
             i = {
                 ['<ESC>'] = require'telescope.actions'.close,
             }
         },
         layout_strategy = 'vertical',
     },
}

-- Setup selection UI
require('dressing').setup({
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
})

require('nvim_comment').setup()
