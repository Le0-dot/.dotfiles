-- GTest config

local map = require('le0/plugin-settings/easy-mapping').map

vim.g['gtest#gtest_command'] = '../../Debug/tests'

map('n', '<leader>gt', ':GTestRunUnderCursor<cr>')
