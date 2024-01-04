-- GTest config

local map = require('le0/plugin-settings/easy-mapping').map

--vim.g['gtest#gtest_command'] = '../../Debug/tests'
vim.g['gtest#gtest_command'] = '/home/le0/Documents/cpp/trie/Debug/tests'
--vim.g['gtest#gtest_command'] = '../Debug/tests'

map('n', '<leader>gt', ':GTestRunUnderCursor<cr>')
