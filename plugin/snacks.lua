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
