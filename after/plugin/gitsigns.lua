require('gitsigns').setup{
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

        vim.keymap.set('n', '<leader>hb',function()
            gs.blame_line{full=true}
        end, { buffer = bufnr, desc = 'Preview git blame' })
    end,
}
