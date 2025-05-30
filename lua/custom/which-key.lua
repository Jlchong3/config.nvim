-- Useful plugin to show you pending keybinds.
return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function ()
        ---@diagnostic disable-next-line: missing-fields
        require('which-key').setup{
            preset = 'helix',
        }
        require('which-key').add {
            { '<leader>c', group = '[C]ode' },
            { '<leader>d', group = '[D]ebug [D]ocument' },
            { '<leader>g', group = '[G]it' },
            { '<leader>r', group = '[R]ename [R]eplace' },
            { '<leader>h', group = 'Git [H]unk' },
            { '<leader>s', group = '[S]earch' },
            { '<leader>w', group = '[W]orkspace' },
            { '<leader>b', group = '[B]uffer [B]reakpoint' },
            { '<leader>f', group = '[F]ile' },
            { '<leader>i', group = '[I]nlay' },
            { '<leader>v', group = '[V]ariable' },
        }
    end
}
