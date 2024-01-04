require('le0/settings')
require('le0/plugins')

-- General plugins
require('le0/plugin-settings/catppuccin-plugin')
require('le0/plugin-settings/lualine-plugin')
require('le0/plugin-settings/telescope-plugin')
require('le0/plugin-settings/treesitter-plugin')
require('le0/plugin-settings/treesitter-textobjects-plugin')
require('le0/plugin-settings/markdown-plugin')
require('le0/plugin-settings/fugitive-plugin')
require('le0/plugin-settings/yanky-plugin')
require('le0/plugin-settings/comment-plugin')

-- Lsp plugins
require('le0/plugin-settings/lspconfig-plugin')
require('le0/plugin-settings/cmp-plugin')

-- Cpp plugins
require('le0/plugin-settings/cmake-plugin')
require('le0/plugin-settings/lint-plugin')
require('le0/plugin-settings/gtest-plugin')

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
