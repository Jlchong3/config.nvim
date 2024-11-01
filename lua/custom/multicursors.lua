return {
    'mg979/vim-visual-multi',
    event = 'VeryLazy',
    config = function ()
        vim.api.nvim_set_hl(0, 'VM_MONO', {link='Cursor'})
        vim.api.nvim_set_hl(0, 'VM_Extend', {link='Visual'})
        vim.api.nvim_set_hl(0, 'VM_Cursor', {link='Cursor'})
        vim.api.nvim_set_hl(0, 'VM_Insert', {link='Cursor'})
        -- Work around vim-visual mapping
        vim.keymap.set('n', '<S-Right>', '<C-w><', { desc = 'Decrease Width'} )
        vim.keymap.set('n', '<S-Left>', '<C-w>>', { desc = 'Increase Width'} )
        vim.keymap.set('n', '<C-S-j>', '<C-Down>', { remap = true } )
    end
}
