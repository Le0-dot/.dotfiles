local M = {}

function M.map(m, k, v)
   vim.keymap.set(m, k, v, { silent = true })
end

return M
