return {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    dependencies = { 'rafamadriz/friendly-snippets', },
    version = '*',
    build = 'cargo build --release',
    opts = {
        keymap = {
            preset = 'default',
            ['<C-d>'] = { 'scroll_documentation_up', 'fallback' },
        },

        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono'
        },

        completion = {
            menu = {
                draw = {
                    columns = { { "label", "label_description", gap = 1 }, { "kind_icon", gap = 1, "kind" } },
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
            default = { "lsp", "path", "snippets", "buffer", "dadbod" },
            providers = {
                dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
            },
        },
    },
    opts_extend = { "sources.completion.enabled_providers" }
}
