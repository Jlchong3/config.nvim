vim.pack.add {
    'https://github.com/folke/snacks.nvim',
}

require('snacks').setup {
    bigfile = {},
    git = {},
    gitbrowser = {},
    toggle = {},
    lazygit = {},
    image = {
        doc = {
            inline = false,
            float = true,
            max_width = 50,
            max_height = 30,
        }
    },
}

-- Keymaps for snacks modules
vim.keymap.set( 'n', '<leader>gb', function()
    Snacks.git.blame_line()
end,
{ desc = '[G]it [B]lame' }
)

vim.keymap.set( 'n', '<leader>go', function()
    Snacks.gitbrowse.open()
end,
{ desc = '[G]it Repository [O]pen' }
)

vim.keymap.set( 'n', '<leader>lg', function()
    Snacks.lazygit.open()
end,
{ desc = '[L]azy[G]it' }
)

-- Toggle options
Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>ts')
Snacks.toggle.option('list', { name = 'List Chars' }):map('<leader>tc')
Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>tl')
Snacks.toggle.diagnostics():map('<leader>td')
Snacks.toggle.inlay_hints():map('<leader>in')
