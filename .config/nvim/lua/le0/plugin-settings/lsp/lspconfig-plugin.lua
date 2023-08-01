-- Lspconfig config

local map = require('le0/plugin-settings/easy-mapping').map

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
map('n', '<leader>e', vim.diagnostic.open_float, opts)
map('n', '[d', vim.diagnostic.goto_prev, opts)
map('n', ']d', vim.diagnostic.goto_next, opts)
map('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    map('n', 'gD', vim.lsp.buf.declaration, bufopts)
    map('n', 'gd', vim.lsp.buf.definition, bufopts)
    map('n', 'gr', vim.lsp.buf.references, bufopts)
    map('n', 'gi', vim.lsp.buf.implementation, bufopts)
    map('n', 'K', vim.lsp.buf.hover, bufopts)
    map('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    map('n', '<leader>wl', function()
	    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    map('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    map('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    map('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    map('n', '<leader>fo', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lspconfig = require('lspconfig')

local lsp_defaults = {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
}

lspconfig.util.default_config = vim.tbl_deep_extend(
    'force',
    lspconfig.util.default_config,
    lsp_defaults
)

lspconfig.lua_ls.setup {
    single_file_support = true,
    settings = {
	Lua = {
	    diagnostics = {
		globals = { 'vim' },
	    }
	}
    }
}

lspconfig.pyright.setup {}

-- lspconfig.clangd.setup {}

lspconfig.gopls.setup {}

lspconfig.hls.setup {
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
}
