return {
	'nvim-treesitter/nvim-treesitter',
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
	},
	build = ':TSUpdate',
	opts = {
		ensure_installed = { "cpp", "python", "haskell", },
		auto_install = true,

		highlight = { enable = true },
		indent = { enable = true },
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["aa"] = { query = "@parameter.outer", desc = "Select [a]round an [a]rgument" },
					["ia"] = { query = "@parameter.inner", desc = "Select [i]nner part of a [a]rgument" },

					["ac"] = { query = "@conditional.outer", desc = "Select [a]round a [c]onditional" },
					["ic"] = { query = "@conditional.inner", desc = "Select [i]nner part of a [c]onditional" },

					["al"] = { query = "@loop.outer", desc = "Select [a]round a [l]oop" },
					["il"] = { query = "@loop.inner", desc = "Select [i]nner part of a [l]oop" },

					["ai"] = { query = "@call.outer", desc = "Select [a]round a function [i]nvocation" },
					["ii"] = { query = "@call.inner", desc = "Select [i]nner part of a function [i]nvocation" },

					["af"] = { query = "@function.outer", desc = "Select [a]round a [f]unction definition" },
					["if"] = { query = "@function.inner", desc = "Select [i]nner part of a [f]unction definition" },
				}
			},
		},
	}
}
