return {
    'echasnovski/mini.pick',
    event = 'VeryLazy',
    dependencies = {
        'echasnovski/mini.extra'
    },
    config = function()
        require('mini.extra').setup()
        require('mini.pick').setup()
        local builtin = MiniPick.builtin
        local extra = MiniExtra.pickers

        vim.ui.select = MiniPick.ui_select

        vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })
        vim.keymap.set('n', '<leader>sf', builtin.files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>sh', builtin.help, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sg', builtin.grep_live, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sd', extra.diagnostic, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>gf', extra.git_files, { desc = 'Search [G]it [F]iles' })
        vim.keymap.set('n', '<leader>.', function() builtin.files(nil, { source = { cwd = vim.fn.expand '%:p:h' } }) end,
            { desc = '[.] Directory Files' })

        vim.keymap.set('n', '<leader>sl', function()
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
            builtin.cli({ command = command },
                {
                    source = {
                        show = function(buf_id, items, query) MiniPick.default_show(buf_id, items, query, { show_icons = true }) end,
                        name = 'LSP files'
                    }
                })
        end, { desc = '[S]earch [L]SP Supported' })
    end
}
