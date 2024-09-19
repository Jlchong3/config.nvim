-- Useful plugin to show you pending keybinds.
return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function ()
        require('which-key').add {
            { '<leader>c', group = '[C]ode' },
            { '<leader>d', group = '[D]ocument' },
            { '<leader>g', group = '[G]it' },
            { '<leader>r', group = '[R]ename, [R]eplace' },
            { '<leader>h', group = 'Git [H]unk' },
            { '<leader>s', group = '[S]earch' },
            { '<leader>w', group = '[W]orkspace' },
            { '<leader>f', group = '[F]ile' },
            { 's', group = '[S]urround'},
        }
    end
}
