return {
    'echasnovski/mini.pick',
    event = 'VeryLazy',
    dependencies = {
        'echasnovski/mini.extra'
    },
    config = function()
        require('mini.pick').setup()
        require('mini.extra').setup()

        local builtin = MiniPick.builtin
        local extra = MiniExtra.pickers
        local custom_pickers = require('extra.pickers')

        local remap = vim.keymap.set

        vim.ui.select = MiniPick.ui_select

        remap('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })
        remap('n', '<leader>sf', builtin.files, { desc = '[S]earch [F]iles' })
        remap('n', '<leader>.', function() builtin.files(nil, { source = {
            cwd = vim.fn.expand '%:p:h'
        } }) end, { desc = '[.] Directory Files' })
        remap('n', '<leader>sh', builtin.help, { desc = '[S]earch [H]elp' })
        remap('n', '<leader>sg', builtin.grep_live, { desc = '[S]earch [G]rep' })
        remap('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })

        remap('n', '<leader>sd', extra.diagnostic, { desc = '[S]earch [D]iagnostics' })
        remap('n', '<leader>gst', extra.git_files, { desc = '[G]it [S]earch [T]racked Files' })
        remap('n', '<leader>gsm', function() extra.git_files{ scope = 'modified'} end, { desc = '[G]it [S]earch [M]odified Files' })
        remap('n', '<leader>gsu', function() extra.git_files{ scope = 'untracked'} end, { desc = '[G]it [S]earch [U]ntracked Files' })
        remap('n', '<leader>gsi', function() extra.git_files{ scope = 'ignored'} end, { desc = '[G]it [S]earch [I]gnored Files' })
        remap('n', '<leader>gsd', function() extra.git_files{ scope = 'deleted'} end, { desc = '[G]it [S]earch [D]eleted Files' })
        remap('n', '<leader>/', function() extra.buf_lines({ scope = 'current' }) end, { desc = '[/] Fuzzy Search Buffer'})
        remap('n', '<leader>s/', extra.buf_lines, { desc = '[S]earch [/] Open'})

        remap('n', '<leader>sl', custom_pickers.lsp_supported_files, { desc = '[S]earch [L]SP Supported' })
    end
}
