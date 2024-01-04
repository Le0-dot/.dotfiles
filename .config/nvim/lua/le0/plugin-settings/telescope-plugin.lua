-- Telescope config

local map = require('le0/plugin-settings/easy-mapping').map

require('telescope').setup{
    defaults = {
    -- config_key = value,
	mappings = {
	    i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches pickers
		["<C-h>"] = "which_key"
	    }
	}
    },
    extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
	fzf = {
	    fuzzy = true,                    -- false will only do exact matching
	    override_generic_sorter = true,  -- override the generic sorter
	    override_file_sorter = true,     -- override the file sorter
	    case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
	}
    }
}

require('telescope').load_extension('fzf')

map('n', '<leader>ff', ':Telescope git_files<cr>')
map('n', '<leader>fg', ':Telescope live_grep<cr>')
map('n', '<leader>fb', ':Telescope buffers<cr>')
map('n', '<leader>fh', ':Telescope help_tags<cr>')
