require('settings')
require('plugins')
require('plugin-settings')

-- Auto compile packer 

vim.cmd([[
    augroup packer_user_config
        autocmd!
	autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])
