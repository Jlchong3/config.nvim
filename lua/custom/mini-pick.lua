return {
    'echasnovski/mini.pick',
    event = 'VeryLazy',
    dependencies = {
        'echasnovski/mini.extra'
    },
    config = function()
        require('mini.pick').setup()
        require('mini.extra').setup()

        local remap = vim.keymap.set

        vim.ui.select = MiniPick.ui_select

        MiniPick.registry.buffers = function(local_opts)
            local wipeout_cur = function()
                vim.api.nvim_buf_delete(MiniPick.get_picker_matches().current.bufnr, {})
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

        local builtin = MiniPick.builtin
        local extra = MiniExtra.pickers
        local custom_pickers = require('extra.pickers')

        remap('n', '<leader>sb', MiniPick.registry.buffers, { desc = '[S]earch [B]uffers' })
        remap('n', '<leader>sf', function() builtin.files(nil,
            {
                source = {
                    preview = preview_files_and_images
                }
            }) end, { desc = '[S]earch [F]iles' })
        remap('n', '<leader>.', function() builtin.files(nil,
            {
                source = {
                    cwd = vim.fn.expand '%:p:h',
                    preview = preview_files_and_images
                }
            }) end, { desc = '[.] Directory Files' })
        remap('n', '<leader>sh', builtin.help, { desc = '[S]earch [H]elp' })
        remap('n', '<leader>sg', builtin.grep_live, { desc = '[S]earch [G]rep' })
        remap('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })

        remap('n', '<leader>sd', extra.diagnostic, { desc = '[S]earch [D]iagnostics' })
        remap('n', '<leader>gst', extra.git_files, { desc = '[G]it [S]earch [T]racked Files' })
        remap('n', '<leader>gsm', function() extra.git_files{ scope = 'modified'} end, { desc = '[G]it [S]earch [M]odified Files' })
        remap('n', '<leader>gsu', function() extra.git_files{ scope = 'untracked'} end, { desc = '[G]it [S]earch [U]ntracked Files' })
        remap('n', '<leader>gsi', function() extra.git_files{ scope = 'ignored'} end, { desc = '[G]it [S]earch [I]gnored Files' })
        remap('n', '<leader>/', function() extra.buf_lines({ scope = 'current' }) end, { desc = '[/] Fuzzy Search Buffer'})
        remap('n', '<leader>s/', extra.buf_lines, { desc = '[S]earch [/] Open'})

        remap('n', '<leader>sl', custom_pickers.lsp_supported_files, { desc = '[S]earch [L]SP Supported' })
        remap('n', '<leader>ss', custom_pickers.registry, { desc = '[S]earch [S]upported Pickers' })
    end
}
