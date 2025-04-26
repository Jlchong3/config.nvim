MiniPick.registry.lsp_supported_files = function ()
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

MiniPick.registry.registry = function()
    local selected = MiniPick.start( {
        source = { items = vim.tbl_keys(MiniPick.registry), name = 'Registry' }
    })

    if selected == nil then return end

    return MiniPick.registry[selected]()
end


MiniPick.registry.buffers = function(local_opts)
    local wipeout_cur = function()
        vim.api.nvim_buf_delete(MiniPick.get_picker_matches().current.bufnr, {})
        MiniPick.stop()
        MiniPick.registry.buffers();
    end
    local buffer_mappings = { wipeout = { char = '<C-d>', func = wipeout_cur } }
    MiniPick.builtin.buffers(local_opts, { mappings = buffer_mappings })
end

local preview_files_and_images = function(buf_id, item)
    if Snacks.image.supports_file(item) then
        Snacks.image.buf.attach(buf_id, { src = item })
    else
        MiniPick.default_preview(buf_id, item)
    end
end

MiniPick.registry.current_dir_files = function()
    MiniPick.builtin.files(nil, {
        source = {
            cwd = vim.fn.expand('%:p:h'),
            preview = preview_files_and_images
        }
    })
end

MiniPick.registry.files = function()
    MiniPick.builtin.files(nil, {
        source = {
            preview = preview_files_and_images
        }
    })
end

