return {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    config = function()
        local MiniAi = require('mini.ai')
        MiniAi.setup{
            custom_textobjects = {
                o = MiniAi.gen_spec.treesitter{
                    a = {'@block.outer', '@conditional.outer', '@loop.outer'},
                    i = {'@block.inner','@conditional.inner', '@loop.inner'}
                },

                f = MiniAi.gen_spec.treesitter{
                    a = {'@function.outer'},
                    i = {'@function.inner'},
                },

                c = MiniAi.gen_spec.treesitter{
                    a = {'@class.outer'},
                    i = {'@class.inner'},
                },

                t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },

                d = { "%f[%d]%d+" },

                b = { { '%b()' }, '^.().*().$' },

                B = { { '%b{}' }, '^.().*().$' },

                e = {
                    { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
                    "^().*()$",
                },

                i = MiniAi.gen_spec.argument(),

                u = MiniAi.gen_spec.function_call(),

                U = MiniAi.gen_spec.function_call({ name_pattern = "[%w_]" }),
            },

            n_lines = 500
        }
    end
}
