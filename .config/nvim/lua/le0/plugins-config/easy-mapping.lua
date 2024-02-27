local easy_map = {}

function easy_map.map(m, k, v, opts)
    opts = opts or { silent = true }
    vim.keymap.set(m, k, v, opts)
end

return easy_map
