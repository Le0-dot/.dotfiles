-- Map leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- Line number
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'


-- System clipboard interactions
-- vim.opt.clipboard = 'unnamedplus' -- sync with system clipboard
vim.keymap.set({ 'n', 'x' }, 'gy', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('n', 'gp', '"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set('n', 'gP', '"+P', { desc = 'Paste from system clipboard' })
vim.keymap.set('v', 'gp', '"+P', { desc = 'Paste from system clipboard in visual mode without copying' })


-- Search
vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true


-- Indenting TODO
vim.opt.expandtab = true -- Tabs with spaces
vim.opt.tabstop = 4      -- Width of tab character
vim.opt.shiftwidth = 0   -- Width of tabs for > and < (0 to use tabstop value)
vim.opt.softtabstop = -1 -- Number of spaces to insert for <TAB> and delete for <BS> (negative to use shiftwidth value)
vim.opt.smarttab = true

vim.opt.smartindent = true
vim.opt.autoindent = true


-- Line breaks
vim.opt.linebreak = true
vim.opt.showbreak = '+++'
vim.opt.breakindent = true


-- Timing
vim.opt.updatetime = 250 -- Timeout for plugin start
vim.opt.timeoutlen = 500 -- Mapping timeout


-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true


-- Cursor
vim.opt.cursorline = true -- Highlight current line
vim.opt.scrolloff = 10


-- Filesystem
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.writebackup = false


-- Misc
vim.opt.showmode = false -- Show Insert, Visial or Replace mode
vim.opt.showmatch = true
vim.opt.formatoptions:remove('o')
vim.opt.inccommand = 'split' -- Show preview in a split


vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        pcall(function() vim.cmd [[%s/\s\+$//e]] end)   -- Delete trailing whitespaces
        pcall(function() vim.cmd [[%s/\n\+\%$//e]] end) -- Delete trailing empty lines
        vim.fn.setpos(".", save_cursor)
    end,
})

vim.api.nvim_create_user_command('TrackSession', function ()
    local session_file = 'Session.vim'
    if vim.fn.filereadable(vim.fn.expand(session_file)) == 0 then
        vim.cmd('Obsession')
    else
        vim.cmd('source ' .. session_file)
    end
end, {})


vim.keymap.set('n', '<C-q>', '<C-w><C-q>', { desc = 'Close focused window' })

vim.keymap.set('n', '<leader>o', 'o<C-[>0"_Dk', { desc = 'Insert empty line below' })
vim.keymap.set('n', '<leader>O', 'O<C-[>0"_Dj', { desc = 'Insert empty line above' })

vim.keymap.set('n', '<leader>do', 'j"_ddk', { desc = 'Delete line below' })
vim.keymap.set('n', '<leader>dO', 'k"_dd', { desc = 'Delete line above' })

vim.keymap.set('n', '<C-D>', '<C-D>zz', { desc = 'Scroll down and center' })
vim.keymap.set('n', '<C-U>', '<C-U>zz', { desc = 'Scroll up and center' })

vim.keymap.set({ 'n', 'x' }, '<leader>d', '"_d', { desc = 'Delete without overriding current registers' })
vim.keymap.set('n', '<leader>D', '"_D', { desc = 'Delete without overriding current registers' })
vim.keymap.set('x', '<leader>p', '"_dP"', { desc = 'Paste without copying' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Stop highlighting the search results' })

vim.keymap.set('n', 'gcA', function()
    local comment_start = string.format(vim.bo.commentstring, '')
    local new_line = vim.fn.getline('.') .. ' ' .. comment_start
    vim.fn.setline('.', new_line) ---@diagnostic disable-line: param-type-mismatch
    vim.cmd [[ startinsert! ]]
end, { desc = 'Append comment to the line' })

function Dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. Dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end