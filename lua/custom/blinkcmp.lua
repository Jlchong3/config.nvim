return {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    dependencies = { 'rafamadriz/friendly-snippets', },
    build = 'cargo build --release',
    opts = {
        keymap = {
            preset = 'default',
            ['<C-d>'] = { 'scroll_documentation_up', 'fallback' },
        },

        completion = {
            menu = {
                draw = {
                    columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', gap = 1, 'kind' } },
                },
            },

            accept = { auto_brackets = { enabled = true } },
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
            default = { 'lsp', 'path', 'snippets', 'buffer', 'dadbod' },
            per_filetype = {
                sql = { 'dadbod' },
                lua = { inherit_defaults = true, 'lazydev' }
            },
            providers = {
                dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
                lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink', score_offset = 100 },
            },
        },
    },
    opts_extend = { 'sources.default', 'sources.completion.enabled_providers' }
}
