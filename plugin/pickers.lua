M = {}

M.lsp_supported_files = function ()
    local filetypes = {}
    for _, client in ipairs(vim.lsp.get_clients()) do
        ---@diagnostic disable-next-line: undefined-field
        for _, ft in ipairs(client.config.filetypes or {}) do
            filetypes[ft] = true
        end
    end

    local extensions = {}
    for _, file in ipairs(vim.fn.systemlist('rg --files')) do
        local extension = file:match("%.([^.]+)$")
        if extension and not extensions[extension] then
            extensions[extension] = true
        end
    end

    local glob_flags = {}
    for extension, _ in pairs(extensions) do
        local filetype = vim.filetype.match { filename = '*.' .. extension }
        if filetype and filetypes[filetype] then
            table.insert(glob_flags, '--glob=*.' .. extension)
        end
    end

    local command = vim.list_extend({ 'rg', '--files' }, glob_flags)
    MiniPick.builtin.cli({ command = command },
        {
            source = {
                show = function(buf_id, items, query) MiniPick.default_show(buf_id, items, query, { show_icons = true }) end,
                name = 'LSP files'
            }
        })
end

return M
