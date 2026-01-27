require('mini.ai').setup()

local ai = MiniAi.gen_spec
local extraAi = MiniExtra.gen_ai_spec

MiniAi.setup {
    custom_textobjects = {
        o = ai.treesitter {
            a = {
                '@block.outer',
                '@conditional.outer',
                '@loop.outer'
            },
            i = {
                '@block.inner',
                '@conditional.inner',
                '@loop.inner'
            }
        },

        f = ai.treesitter {
            a = '@function.outer',
            i = '@function.inner'
        },

        c = ai.treesitter {
            a = '@class.outer',
            i = '@class.inner'
        },

        d = extraAi.number(),

        L = extraAi.line(),

        b = { '%b()', '^.().*().$' },

        B = { '%b{}', '^.().*().$' },

        e = { {
            "%u[%l%d]+%f[^%l%d]",
            "%f[%S][%l%d]+%f[^%l%d]",
            "%f[%P][%l%d]+%f[^%l%d]",
            "^[%l%d]+%f[^%l%d]"
        }, "^().*()$", },

        g = extraAi.buffer();

        i = ai.argument(),

        u = ai.function_call(),

        U = ai.function_call { name_pattern = '[%w_]' },
    },

    n_lines = 500,
    silent = true
}
