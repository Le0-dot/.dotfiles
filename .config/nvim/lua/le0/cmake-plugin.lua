-- CMake config 

local map = require('le0/easy-mapping').map

vim.cmd ([[ 
let g:cmake_link_compile_commands = 1
let g:cmake_root_markers = ['compile_commands.json']
]])

map('n', '<leader>cg', ':CMakeGenerate<cr>')
map('n', '<leader>cb', ':w<cr> :CMakeBuild<cr>')
map('n', '<leader>cl', ':CMakeClean<cr>')
map('n', '<leader>cc', ':CMakeClose<cr>')
