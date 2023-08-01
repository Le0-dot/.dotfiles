require('le0/settings')
require('le0/plugins')

-- General plugins
require('le0/plugin-settings/general/nord-plugin') -- Colorscheme always first
require('le0/plugin-settings/general/lualine-plugin')
require('le0/plugin-settings/general/floaterm-plugin')
require('le0/plugin-settings/general/telescope-plugin')
require('le0/plugin-settings/general/treesitter-plugin')
require('le0/plugin-settings/general/markdown-plugin')
require('le0/plugin-settings/general/fugitive-plugin')
require('le0/plugin-settings/general/yanky-plugin')

-- Lsp plugins
require('le0/plugin-settings/lsp/lspconfig-plugin')
require('le0/plugin-settings/lsp/lint-plugin')
require('le0/plugin-settings/lsp/cmp-plugin')

-- Cpp plugins
require('le0/plugin-settings/cpp/cmake-plugin')
require('le0/plugin-settings/cpp/gtest-plugin')
require('le0/plugin-settings/cpp/clangd-extentions-plugin')

local map = require('le0/plugin-settings/easy-mapping').map

-- Clipboard integration with wayland
vim.cmd[[
augroup wayland_clipboard
    au!
    au TextYankPost * call setreg("+", getreg(""))
augroup END
]]

map("n", "<C-p>", "\"*p")

-- Put empty line below or above
map("n", "<leader>o", "o<C-[>k")
map("n", "<leader>O", "O<C-[>j")
