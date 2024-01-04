local map = require('le0/plugin-settings/easy-mapping').map

require("telescope").load_extension("yank_history")

require('yanky').setup {
    ring = {
	history_length = 100,
	storage = "shada",
	sync_with_numbered_registers = true,
	cancel_event = "update",
    },
    picker = {
	select = {
	    action = nil, -- nil to use default put action
	},
	telescope = {
	    use_default_mappings = true, -- if default mappings should be used
	    mappings = nil, -- nil to use default mappings or no mappings (see `use_default_mappings`)
	},
    },
    system_clipboard = {
	sync_with_ring = false,
    },
    highlight = {
	on_put = true,
	on_yank = true,
	timer = 500,
    },
    preserve_cursor_position = {
	enabled = true,
    },
}

map({"n","x"}, "y", "<Plug>(YankyYank)")

map({"n","x"}, "p", "<Plug>(YankyPutIndentAfter)")
map({"n","x"}, "P", "<Plug>(YankyPutIndentBefore)")
map({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
map({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")

map("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
map("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
map("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
map("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

map("n", "<leader>y", ":Telescope yank_history<cr>")
