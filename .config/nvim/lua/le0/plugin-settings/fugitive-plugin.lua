-- Vim fugitive config

local map = require('le0/plugin-settings/easy-mapping').map

map('n', '<leader>gc', ':Git commit<cr>')
map('n', '<leader>ga', ':Gwrite<cr>')
map('n', '<leader>gs', ':Git<cr>')
map('n', '<leader>gp', ':Git push<cr>')
