vim.pack.add {
    -- For undo navigation
    'https://github.com/mbbill/undotree.git',

    -- Live-server for neovim
    'https://github.com/brianhuster/live-preview.nvim',

    -- Detect tabstop and shiftwidth automatically
    'https://github.com/NMAC427/guess-indent.nvim',

    -- Better markdown view
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',

    'https://github.com/Jlchong3/drawer.nvim'
}

require('drawer').setup {}
require('guess-indent').setup {}
