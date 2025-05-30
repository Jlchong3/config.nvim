return {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    dependencies = {
        'echasnovski/mini.extra'
    },
    config = function()
        local MiniAi = require('mini.ai')
        local ai = MiniAi.gen_spec;
        local extraAi = require('mini.extra').gen_ai_spec
        MiniAi.setup{
            custom_textobjects = {
                o = MiniAi.gen_spec.treesitter {
                    a = { '@block.outer', '@conditional.outer', '@loop.outer' },
                    i = { '@block.inner','@conditional.inner', '@loop.inner' }
                },

                f = MiniAi.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },

                c = MiniAi.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' },

                t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },

                d = extraAi.number(),

                L = extraAi.line(),

                b = { '%b()', '^.().*().$' },

                B = { '%b{}', '^.().*().$' },

                e = { { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" }, "^().*()$", },

                g = extraAi.buffer();

                i = ai.argument(),

                u = ai.function_call(),

                U = ai.function_call { name_pattern = '[%w_]' },
            },

            n_lines = 500
        }
    end
}
