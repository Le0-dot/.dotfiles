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

vim.keymap.set({"n","x"}, "y", "<Plug>(YankyYank)")

vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutIndentAfter)")
vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutIndentBefore)")
vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")

vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

vim.keymap.set("n", "<leader>y", ":Telescope yank_history<cr>")
