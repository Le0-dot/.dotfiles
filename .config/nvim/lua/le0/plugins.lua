local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)


return require('lazy').setup({
    {
	'catppuccin/nvim',
	lazy = false,
	init = function() vim.cmd.colorscheme("catppuccin") end,
	config = function() require('le0/plugins-config/catppuccin') end,
    },

    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
    'ap/vim-css-color',
    'tpope/vim-obsession',
    {
	"NeogitOrg/neogit",
	dependencies = {
	    "nvim-lua/plenary.nvim",         -- required
	    "sindrets/diffview.nvim",        -- optional - Diff integration
	    "nvim-telescope/telescope.nvim", -- optional
	},
	config = function()
	    require('neogit').setup({})

	    vim.keymap.set("n", "<leader>gs", ":Neogit<cr>",
		{silent = true, noremap = true}
	    )
	    vim.keymap.set("n", "<leader>gc", ":Neogit commit<cr>",
		{silent = true, noremap = true}
	    )
	    vim.keymap.set("n", "<leader>gp", ":Neogit pull<cr>",
		{silent = true, noremap = true}
	    )
	    vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<cr>",
		{silent = true, noremap = true}
	    )
	end,
    },
    {
	'gbprod/yanky.nvim',
	config = function() require('le0/plugins-config/yanky') end,
    },
    {
	'nvim-lualine/lualine.nvim',
	dependencies = {
	    'kyazdani42/nvim-web-devicons',
	},
	config = function() require('le0/plugins-config/lualine') end,
    },
    {
	'nvim-telescope/telescope.nvim',
	event = 'VeryLazy',
	dependencies = {
	    'nvim-lua/plenary.nvim',
	    {
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make'
	    },
	    'nvim-telescope/telescope-ui-select.nvim',
	},
	config = function() require('le0/plugins-config/telescope') end,
    },
    {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	config = function() require('le0/plugins-config/treesitter') end,
    },
    {
	'nvim-treesitter/nvim-treesitter-textobjects',
	dependencies = {
	    'nvim-treesitter/nvim-treesitter',
	},
	config = function() require('le0/plugins-config/treesitter-textobjects') end,
    },
    {
	'iamcco/markdown-preview.nvim',
	build = function() vim.fn['mkdp#util#install']() end,
	config = function()
	    vim.keymap.set('n', '<leader>pt', '<Plug>MarkdownPreviewToggle')
	    vim.g.mkdp_auto_start = 1
	end,
    },

    {
	'neovim/nvim-lspconfig',
	dependencies = {
	  -- Automatically install LSPs and related tools to stdpath for neovim
	  'williamboman/mason.nvim',
	  'williamboman/mason-lspconfig.nvim',
	  'WhoIsSethDaniel/mason-tool-installer.nvim',
	  'j-hui/fidget.nvim',
	},
	config = function() require('le0/plugins-config/lspconfig') end,
    },
    {
	'hrsh7th/nvim-cmp',
	event = 'InsertEnter',
	dependencies = {
	    {
		'L3MON4D3/LuaSnip',
		build = "make install_jsregexp",
	    },
	    'saadparwaiz1/cmp_luasnip',
	    'hrsh7th/cmp-nvim-lsp',
	    'hrsh7th/cmp-buffer',
	    'hrsh7th/cmp-path',
	    'hrsh7th/cmp-cmdline',
	},
	config = function() require('le0/plugins-config/cmp') end,
    },
    {
	'mfussenegger/nvim-lint',
	dependencies = {
	    'williamboman/mason.nvim',
	},
	config = function ()
	    local lint = require('lint')
	    lint.linters_by_ft = lint.linters_by_ft or {}
	    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
	    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
		group = lint_augroup,
		callback = function()
		require('lint').try_lint()
		end,
	    })
	end,
    },
    { -- Autoformat
	'stevearc/conform.nvim',
	lazy = false,
	keys = {
	    {
		'<leader>f',
		function()
		    require('conform').format { async = true, lsp_fallback = true }
		end,
		mode = '',
		desc = '[F]ormat buffer',
	    },
	},
    },

    {
	'mfussenegger/nvim-dap',
	dependencies = {
	    'rcarriga/nvim-dap-ui',
	    'nvim-neotest/nvim-nio',
	    'williamboman/mason.nvim',
	    'jay-babu/mason-nvim-dap.nvim',
	    'mfussenegger/nvim-dap-python',
	},
	config = function () require('le0/plugins-config/dap') end,
    },

    { -- Collection of various small independent plugins/modules
      'echasnovski/mini.nvim',
      config = function()
	-- Examples:
	--  - va)  - [V]isually select [A]round [)]parenthen
	--  - yinq - [Y]ank [I]nside [N]ext [']quote
	--  - ci'  - [C]hange [I]nside [']quote
	require('mini.ai').setup { n_lines = 500 }
	-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
	-- - sd'   - [S]urround [D]elete [']quotes
	-- - sr)'  - [S]urround [R]eplace [)] [']
	require('mini.surround').setup()
      end,
    },

    {
	'cdelledonne/vim-cmake',
	ft = {'c', 'cpp', 'cmake'},
	config = function()
	    vim.cmd ([[
	    let g:cmake_link_compile_commands = 1
	    let g:cmake_root_markers = ['compile_commands.json']
	    ]])

	    vim.keymap.set('n', '<leader>cg', ':CMakeGenerate<cr>')
	    vim.keymap.set('n', '<leader>cb', ':w<cr> :CMakeBuild<cr>')
	    vim.keymap.set('n', '<leader>cl', ':CMakeClean<cr>')
	    vim.keymap.set('n', '<leader>cc', ':CMakeClose<cr>')
	end,
    },
    {
	'alepez/vim-gtest',
	ft = {'c', 'cpp', 'cmake'},
	config = function()
	    vim.g['gtest#gtest_command'] = '../Debug/tests'
	    vim.keymap.set('n', '<leader>gt', ':GTestRunUnderCursor<cr>')
	end,
    },

    {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
	    "nvim-lua/plenary.nvim",
	    'nvim-telescope/telescope.nvim',
	},
	config = function() require('le0/plugins-config/harpoon') end,
    },

    {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	opts = {}
    },
    {
	'tris203/precognition.nvim',
	config = function ()
	    require("precognition").toggle()
	end
    },
}, {})
