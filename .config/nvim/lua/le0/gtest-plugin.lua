-- GTest config

local map = require('le0/easy-mapping').map

vim.g['gtest#gtest_command'] = '../../Debug/tests'

map('n', '<leader>gt', ':GTestRunUnderCursor<cr>')
