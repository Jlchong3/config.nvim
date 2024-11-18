return {
    'saghen/blink.cmp',
    lazy = false,
    dependencies = {
        'rafamadriz/friendly-snippets',
    },
    build = 'cargo build --release',
    opts = {
        keymap = {
            preset = 'default',
            ['<C-j>'] = { 'snippet_forward', 'fallback' },
            ['<C-k>'] = { 'snippet_backward', 'fallback' },
            ['<C-d>'] = { 'scroll_documentation_up', 'fallback' },
        },

        highlight = {
            use_nvim_cmp_as_default = true,
        },

        nerd_font_variant = 'mono',
        accept = {
            auto_brackets = { enabled = true },
        },

        windows = {
            autocomplete = {
                draw = {
                    columns = { { "label", "label_description", gap = 1 }, { "kind_icon", gap = 1, "kind" } },
                },
            },
            documentation = {
                border = 'rounded',
                auto_show = true,
            }
        },

        sources = {
            completion = {
                enabled_providers = { "lsp", "path", "snippets", "buffer", "dadbod" },
            },
            providers = {
                dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
            },
        },
    },
    opts_extend = { "sources.completion.enabled_providers" }
}
