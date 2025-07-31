return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = {},
        git = {},
        gitbrowse = {},
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
    },
    keys = {
        { '<leader>gb', function() Snacks.git.blame_line() end, desc = '[G]it [B]lame' },
        { '<leader>go', function() Snacks.gitbrowse.open() end, desc = '[G]it Repository [O]pen' },
        { '<leader>lg', function() Snacks.lazygit.open() end, desc = '[L]azy [G]it' },
    },
    init = function ()
        vim.api.nvim_create_autocmd('User', {
            pattern = 'VeryLazy',
            callback = function()
                -- Create some toggle mappings
                Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>ts')
                Snacks.toggle.option('list', { name = 'List Chars' }):map('<leader>tc')
                Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>tl')
                Snacks.toggle.diagnostics():map('<leader>td')
                Snacks.toggle.inlay_hints():map('<leader>in')
            end,
        })

    end
}
