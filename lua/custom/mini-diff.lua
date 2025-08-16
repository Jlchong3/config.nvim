
return {
    'echasnovski/mini.diff',
    event = 'VeryLazy',
    config = function()
        require('mini.diff').setup {
            view = {
                style = 'sign',
                signs = { add = '+', change = '~', delete = '–' },
            },
        }
        vim.keymap.set('n', 'ghy', function() return MiniDiff.operator('yank') .. 'gh' end, { expr = true, remap = true } )
        vim.keymap.set('n', '<leader>hp', function() MiniDiff.toggle_overlay(0) end, { desc = '[H]unk [P]review' } )
    end
}
