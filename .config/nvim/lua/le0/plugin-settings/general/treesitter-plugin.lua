-- Treesitter config

require('nvim-treesitter.configs').setup {
    ensure_installed = { "cpp", "python", "bash", "go", "haskell" },

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    highlight = {
	enable = true,

	-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
	-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
	-- Using this option may slow down your editor, and you may see some duplicate highlights.
	-- Instead of true it can also be a list of languages
	additional_vim_regex_highlighting = false
    },
    indent = { enable = true },
    incremental_selection = {
	enable = true,
	keymaps = {
	    init_selection = "<C-space>",
	    node_incremental = "<C-space>",
	    scope_incremental = false,
	    node_decremental = "<bs>",
	},
    },
    textobjects = {
	swap = {
	    enable = true,
	    swap_next = {
		["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
		["<leader>n:"] = "@property.outer", -- swap object property with next
		["<leader>nm"] = "@function.outer", -- swap function with next
	    },
	    swap_previous = {
		["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
		["<leader>p:"] = "@property.outer", -- swap object property with prev
		["<leader>pm"] = "@function.outer", -- swap function with previous
	    },
	},
	move = {
	    enable = true,
	    set_jumps = true, -- whether to set jumps in the jumplist
	    goto_next_start = {
		["]f"] = { query = "@call.outer", desc = "Next function call start" },
		["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
		["]c"] = { query = "@class.outer", desc = "Next class start" },
		["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
		["]l"] = { query = "@loop.outer", desc = "Next loop start" },

		-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
		-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
		["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
		["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
	    },
	    goto_next_end = {
		["]F"] = { query = "@call.outer", desc = "Next function call end" },
		["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
		["]C"] = { query = "@class.outer", desc = "Next class end" },
		["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
		["]L"] = { query = "@loop.outer", desc = "Next loop end" },
	    },
	    goto_previous_start = {
		["[f"] = { query = "@call.outer", desc = "Prev function call start" },
		["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
		["[c"] = { query = "@class.outer", desc = "Prev class start" },
		["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
		["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
	    },
	    goto_previous_end = {
		["[F"] = { query = "@call.outer", desc = "Prev function call end" },
		["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
		["[C"] = { query = "@class.outer", desc = "Prev class end" },
		["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
		["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
	    },
	},

    },
}

--vim.cmd([[
--set foldmethod=expr
--set foldexpr=nvim_treesitter#foldexpr()
--]])
