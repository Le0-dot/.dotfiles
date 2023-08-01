local o = vim.o
local g = vim.g

g.mapleader = ' '

--o.syntax = on

o.backup = false
o.writebackup = flase

o.updatetime = 300

o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = 'yes'

o.scrolloff = 8

o.linebreak = true
o.showbreak = '+++'

o.showmatch = true
o.hlsearch = true
o.smartcase = true
o.ignorecase = true
o.incsearch = true

o.autoindent = true
o.shiftwidth = 4
o.smartindent = true
o.smarttab = true
o.softtabstop = 4

o.splitright = true
o.splitbelow = true

vim.api.nvim_create_user_command("Cppath", function()
    vim.fn.setreg('+', vim.fn.getreg('0'))
end, {})
