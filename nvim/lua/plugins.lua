
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'    -- Update package manager automatically
	use 'morhetz/gruvbox'   -- The best color scheme
	use 'nvim-lua/plenary.nvim' -- Utility functions, used by telescope.nvim
	use 'nvim-telescope/telescope.nvim' -- Fuzzy find
	use 'tpope/vim-surround'    -- Surround with braces/quotes
	use 'tpope/vim-repeat'      -- '.'-repeat for more stuff
    use 'godlygeek/tabular'     -- Align text
    use 'cohama/lexima.vim'     -- Auto-close brackets
    use 'wellle/targets.vim'    -- More object motions (inside argument)

    use 'neovim/nvim-lspconfig' -- LSP framework for loading LSP servers
    use 'nvim-lua/lsp_extensions.nvim'  -- Inlay hints and more
    -- use 'hrsh7th/nvim-compe'    -- Completions
    -- use 'ray-x/lsp_signature.nvim'  -- Show type of current argument
    use 'ms-jpq/coq_nvim'
end)


