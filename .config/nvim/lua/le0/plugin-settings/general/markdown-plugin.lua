-- Markdown preview config

local map = require('le0/plugin-settings/easy-mapping').map

map('n', '<leader>pt', '<Plug>MarkdownPreviewToggle')

vim.g.mkdp_auto_start = 1
