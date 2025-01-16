return {
    'echasnovski/mini.pick',
    event = 'VeryLazy',
    dependencies = {
        'echasnovski/mini.extra'
    },
    config = function()
        require('mini.extra').setup()
        require('mini.pick').setup()
        local custom_pickers = require('extra.pickers')

        local builtin = MiniPick.builtin
        local extra = MiniExtra.pickers
        local remap = vim.keymap.set

        vim.ui.select = MiniPick.ui_select

        remap('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })
        remap('n', '<leader>sf', builtin.files, { desc = '[S]earch [F]iles' })
        remap('n', '<leader>sh', builtin.help, { desc = '[S]earch [H]elp' })
        remap('n', '<leader>sg', builtin.grep_live, { desc = '[S]earch current [W]ord' })
        remap('n', '<leader>sd', extra.diagnostic, { desc = '[S]earch [D]iagnostics' })
        remap('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        remap('n', '<leader>gf', extra.git_files, { desc = 'Search [G]it [F]iles' })
        remap('n', '<leader>.', function() builtin.files(nil, { source = { cwd = vim.fn.expand '%:p:h' } }) end,
            { desc = '[.] Directory Files' })
        remap('n', '<leader>/', function() extra.buf_lines({ scope = 'current' }) end, { desc = '[/] Fuzzy Search Buffer'})
        remap('n', '<leader>s/', extra.buf_lines, { desc = '[S]earch [/] Open'})
        remap('n', '<leader>sl', custom_pickers.lsp_supported_files, { desc = '[S]earch [L]SP Supported' })
    end
}
