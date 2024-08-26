return {
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
	config = function()
		local cmp = require('cmp')
		local luasnip = require('luasnip')

		require('luasnip.loaders.from_vscode').lazy_load()

		vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

		local select_opts = { behavior = cmp.SelectBehavior.Select }

		cmp.setup {
			snippet = {
				expand = function(args) luasnip.lsp_expand(args.body) end
			},
			mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				-- Next item
				['<Tab>'] = cmp.mapping(function(fallback)
					local col = vim.fn.col('.') - 1

					if cmp.visible() then
						cmp.select_next_item(select_opts)
					elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
						fallback()
					else
						cmp.complete()
					end
				end, { 'i', 's' }),
				-- Previous item
				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item(select_opts)
					else
						fallback()
					end
				end, { 'i', 's' }),
				-- Next placeholder in snippet
				['<C-d>'] = cmp.mapping(function(fallback)
					if luasnip.jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end, { 'i', 's' }),
			}),
			sources = {
				{ name = 'nvim_lsp', keyword_length = 1 },
				{ name = 'buffer',   keyword_length = 1 },
				{ name = 'luasnip',  keyword_length = 1 },
				{ name = 'path' },
			},
			window = {
				documentation = cmp.config.window.bordered()
			},
			sorting = {
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.recently_used,
					cmp.config.compare.exact,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
		}
	end,
}
