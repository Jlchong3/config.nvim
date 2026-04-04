vim.pack.add {
    {
        src = 'https://github.com/Saghen/blink.cmp',
        version = vim.version.range("^1")
    },
    'https://github.com/rafamadriz/friendly-snippets'
}

require('blink.cmp').setup {
    keymap = { preset = 'default' },

    completion = {
        menu = {
            border = 'none',
            draw = {
                columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', gap = 1, 'kind' } },
                components = {
                    kind_icon = {
                        text = function(ctx)
                            local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                            return kind_icon
                        end,
                    },
                }
            }
        },

        accept = { auto_brackets = { enabled = false } },
        documentation = { auto_show = true, }
    },

    signature = { enabled = true, },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
}

