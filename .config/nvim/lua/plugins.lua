vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile',
})

return require('packer').startup(function(use)
    use {
        'shaunsingh/nord.nvim',
        run = 'cp ~/.config/nvim/my-colors.lua ./lua/nord/named_colors.lua'
    }
    use 'ap/vim-css-color'
    use {
	'nvim-lualine/lualine.nvim',
	requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {
	'nvim-telescope/telescope.nvim', tag = '0.1.0',
	requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
	'nvim-telescope/telescope-fzf-native.nvim', 
	run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' 
    }
    use 'tpope/vim-fugitive'
    use 'voldikss/vim-floaterm'
    use { 
	'neoclide/coc.nvim', branch = 'master', 
	run = 'yarn install --frozen-lockfile'
    }
    use {
	'cdelledonne/vim-cmake',
	ft = {'c', 'cpp', 'cmake'}
    }
    use {
	'jackguo380/vim-lsp-cxx-highlight',
	ft = {'c', 'cpp', 'cmake'}
    }
    use {
	'alepez/vim-gtest',
	ft = {'c', 'cpp', 'cmake'}
    }
    use {
	'nvim-treesitter/nvim-treesitter',
	run = ':TSUpdate'
    }
end)
