vim.pack.add {
    {
        src = 'https://github.com/Saghen/blink.cmp',
        version = vim.version.range("^1")
    },
    'https://github.com/rafamadriz/friendly-snippets'
}

require('blink.cmp').setup {
    keymap = {
        preset = 'default',
    },

    completion = {
        menu = {
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
        documentation = {
            auto_show = true,
            window = {
                border = 'rounded',
            }
        }
    },

    signature = {
        enabled = true,
        window = {
            border = 'rounded',
        }
    },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        per_filetype = {
            lua = { inherit_defaults = true, 'lazydev' }
        },
        providers = {
            lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink', score_offset = 100 },
        },
    },
}

