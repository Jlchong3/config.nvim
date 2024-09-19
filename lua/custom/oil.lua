-- File Explorer
return {
    'stevearc/oil.nvim',
    event = 'VeryLazy',
    config = function ()
        require('oil').setup{
            keymaps = {
                ['<C-w>s'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
                ['<C-w>v'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
                ['<C-w>r'] = 'actions.refresh',
                ['<C-l>'] = false,
                ['<C-s>'] = false,
                ['<C-h>'] = false,
            }
        }
    end
}
