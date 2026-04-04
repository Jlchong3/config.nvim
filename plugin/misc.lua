vim.pack.add {
    -- Detect tabstop and shiftwidth automatically
    'https://github.com/NMAC427/guess-indent.nvim',

    -- Better markdown view
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}

vim.cmd.packadd('nvim.undotree')
vim.cmd.packadd('nvim.difftool')

vim.keymap.set('n', '<leader>u', vim.cmd.Undotree, { desc = 'UndoTree' })

require('guess-indent').setup {}
