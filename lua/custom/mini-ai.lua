return {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    config = function()
        local MiniAi = require('mini.ai')
        MiniAi.setup{
            custom_textobjects = {
                o = MiniAi.gen_spec.treesitter{
                    a = {'@conditional.outer', '@loop.outer'},
                    i = {'@conditional.inner', '@loop.inner'}
                },

                f = MiniAi.gen_spec.treesitter{
                    a = {'@function.outer'},
                    i = {'@function.inner'},
                },

                c = MiniAi.gen_spec.treesitter{
                    a = {'@class.outer'},
                    i = {'@class.inner'},
                },

                b = { { '%b()' }, '^.().*().$' },

                B = { { '%b{}' }, '^.().*().$' },

                a = MiniAi.gen_spec.function_call(),

                i = MiniAi.gen_spec.argument(),
            },

            n_lines = 500
        }
    end
}
