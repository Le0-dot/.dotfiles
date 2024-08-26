return {
    "NeogitOrg/neogit",
    dependencies = {
	"nvim-lua/plenary.nvim",         -- required
	"sindrets/diffview.nvim",        -- optional - Diff integration
	"nvim-telescope/telescope.nvim", -- optional
    },
    opts = {},
    keys = {
	{'<leader>gs', ':Neogit<cr>', desc = 'Open [g]it [s]tatus', noremap = true},
	{'<leader>gc', ':Neogit commit<cr>', desc = '[g]it [c]ommit', noremap = true},
	{'<leader>gp', ':Neogit pull<cr>', desc = '[g]it [p]pull', noremap = true},
	{'<leader>gb', ':Telescope git_branches<cr>', desc = '[g]it [b]ranches', noremap = true},
    }
}
