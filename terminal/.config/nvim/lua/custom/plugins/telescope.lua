local builtin = require('telescope.builtin')

return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make'
		},
		'nvim-telescope/telescope-ui-select.nvim',
	},
	event = 'VeryLazy',
	keys = {
		{ '<leader>sh',       builtin.help_tags,                                 desc = '[S]earch [H]elp' },
		{ '<leader>sk',       builtin.keymaps,                                   desc = '[S]earch [K]eymaps' },
		{ '<leader>sf',       builtin.find_files,                                desc = '[S]earch [F]iles' },
		{ '<leader>ss',       builtin.builtin,                                   desc = '[S]earch [S]elect Telescope' },
		{ '<leader>sw',       builtin.grep_string,                               desc = '[S]earch current [W]ord' },
		{ '<leader>sg',       builtin.live_grep,                                 desc = '[S]earch by [G]rep' },
		{ '<leader>sg',       '"zy:Telescope live_grep default_text=<C-r>z<CR>', desc = '[S]earch by [G]rep', mode = 'v' },
		{ '<leader>sd',       builtin.diagnostics,                               desc = '[S]earch [D]iagnostics' },
		{ '<leader>sr',       builtin.resume,                                    desc = '[S]earch [R]esume' },
		{ '<leader>s.',       builtin.oldfiles,                                  desc = '[S]earch Recent Files ("." for repeat)' },
		{ '<leader><leader>', builtin.buffers,                                   desc = '[ ] Find existing buffers' },

		{
			'<leader>s/',
			function()
				builtin.live_grep {
					grep_open_files = true,
					prompt_title = 'Live Grep in Open Files',
				}
			end,
			desc = '[S]earch [/] in Open Files'
		},

		{
			'<leader>sn',
			function()
				builtin.find_files { cwd = vim.fn.stdpath 'config' }
			end,
			desc = '[S]earch [N]eovim files'
		},
	},
	config = function()
		require('telescope').setup()
		require('telescope').load_extension('fzf')
		require('telescope').load_extension('ui-select')
	end
}
