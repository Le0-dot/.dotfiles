vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true

vim.opt.showmode = false

vim.opt.clipboard = 'unnamedplus'

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'
vim.opt.relativenumber = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 500

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.showmatch = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 4

vim.opt.linebreak = true
vim.opt.showbreak = '+++'

vim.keymap.set('n', '<C-q>', '<C-w><C-q>', { desc = 'Close focused window' })

vim.keymap.set("n", "<leader>o", "o<C-[>k")
vim.keymap.set("n", "<leader>O", "O<C-[>j")
