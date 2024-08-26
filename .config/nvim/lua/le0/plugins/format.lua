return {
    {
	'stevearc/conform.nvim',
	opts = {},
	keys = {
	    {'<leader>f', function()
		require('conform').format { async = true, lsp_fallback = true }
	    end, desc = '[F]ormat buffer'},
	},
    },
    {
	'zapling/mason-conform.nvim',
	dependencies = {
	    'williamboman/mason.nvim',
	    'stevearc/conform.nvim',
	},
	opts = {},
    }
}
