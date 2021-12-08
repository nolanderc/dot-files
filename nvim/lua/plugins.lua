
vim.cmd [[packadd packer.nvim]]

vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_math = 1
vim.g.lexima_accept_pum_with_enter = 0

vim.g.python_highlight_all = 1
vim.g.python_highlight_space_errors = 0

-- Add `{ ... }` as a valid target for argument mappings
vim.cmd [[
autocmd User targets#mappings#user call targets#mappings#extend({
		\ 'a': {'argument': [{'o': '[{([]', 'c': '[])}]', 's': ','}]},
		\ })
]]

require('packer').startup(function()
	use 'wbthomason/packer.nvim'    -- Update package manager automatically
	-- use 'morhetz/gruvbox'   -- The best color scheme
	use 'nvim-lua/plenary.nvim' -- Utility functions, used by telescope.nvim
	use 'nvim-telescope/telescope.nvim' -- Fuzzy find
	use 'tpope/vim-surround'    -- Surround with braces/quotes
	use 'tpope/vim-repeat'      -- '.'-repeat for more stuff
    use 'godlygeek/tabular'     -- Align text
    -- use 'cohama/lexima.vim'     -- Auto-close brackets
    use 'wellle/targets.vim'    -- More object motions (inside argument)

    use 'neovim/nvim-lspconfig' -- LSP framework for loading LSP servers
    use 'nvim-lua/lsp_extensions.nvim'  -- Inlay hints and more

    use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

    -- Completions
    use 'ms-jpq/coq_nvim'

    -- Languages + Syntax --
    use 'plasticboy/vim-markdown'
    use 'cespare/vim-toml'
    use 'lervag/vimtex'

    use 'vim-python/python-syntax'

    use 'ziglang/zig.vim'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }
end)

require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true,              -- false will disable the whole extension
    },
}

