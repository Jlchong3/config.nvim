vim.pack.add {
    -- For undo navigation
    'https://github.com/mbbill/undotree.git',

    -- Live-server for neovim
    'https://github.com/brianhuster/live-preview.nvim',

    -- Detect tabstop and shiftwidth automatically
    'https://github.com/NMAC427/guess-indent.nvim',

    -- Better markdown view
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'UndoTree' })

require('guess-indent').setup {}
