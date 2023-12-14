vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile',
})

return require('packer').startup(function(use)
    -- General plugins
    use { "catppuccin/nvim", as = "catppuccin" }
    use {
	'nvim-lualine/lualine.nvim',
	requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'voldikss/vim-floaterm'
    use {
	'nvim-telescope/telescope.nvim', tag = '0.1.0',
	requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
	'nvim-telescope/telescope-fzf-native.nvim',
	run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    }
    use {
	'nvim-treesitter/nvim-treesitter',
	run = ':TSUpdate'
    }
    use {
	"nvim-treesitter/nvim-treesitter-textobjects",
	after = "nvim-treesitter",
	requires = "nvim-treesitter/nvim-treesitter",
    }
    use 'ap/vim-css-color'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-obsession'
    use 'ThePrimeagen/vim-be-good'
    use({
	"iamcco/markdown-preview.nvim",
	run = function() vim.fn["mkdp#util#install"]() end,
    })
    use("gbprod/yanky.nvim")


    -- Lsp plugins
    use 'neovim/nvim-lspconfig'
    use 'L3MON4D3/LuaSnip'
    use 'mfussenegger/nvim-lint'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'

    -- Cpp plugins
    use {
	'cdelledonne/vim-cmake',
	ft = {'c', 'cpp', 'cmake'}
    }
    use {
	'alepez/vim-gtest',
	ft = {'c', 'cpp', 'cmake'}
    }
end)
