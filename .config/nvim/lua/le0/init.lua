require('le0/settings')
require('le0/plugins')

-- General plugins
require('le0/plugin-settings/general/nord-plugin') -- Colorscheme always first
require('le0/plugin-settings/general/lualine-plugin')
require('le0/plugin-settings/general/floaterm-plugin')
require('le0/plugin-settings/general/telescope-plugin')
require('le0/plugin-settings/general/treesitter-plugin')
require('le0/plugin-settings/general/markdown-plugin')

-- Lsp plugins
require('le0/plugin-settings/lsp/lspconfig-plugin')
require('le0/plugin-settings/lsp/lint-plugin')
require('le0/plugin-settings/lsp/cmp-plugin')

-- Cpp plugins
require('le0/plugin-settings/cpp/cmake-plugin')
require('le0/plugin-settings/cpp/gtest-plugin')
--require('le0/plugin-settings/cpp/clangd-extentions-plugin')
