-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    config = function()
        require('gitsigns').setup {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = 'Preview git hunk' })

                -- don't override the built-in and fugitive keymaps
                local gs = package.loaded.gitsigns

                vim.keymap.set({ 'n', 'v' }, ']h', function()
                    if vim.wo.diff then
                        return ']h'
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return '<Ignore>'
                end, { expr = true, buffer = bufnr, desc = 'Goto next hunk' })

                vim.keymap.set({ 'n', 'v' }, '[h', function()
                    if vim.wo.diff then
                        return '[h'
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return '<Ignore>'
                end, { expr = true, buffer = bufnr, desc = 'Goto prev hunk' })
            end,
        }
    end
}
