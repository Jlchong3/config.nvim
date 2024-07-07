
return {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',

        -- Adds LSP completion capabilities
        'hrsh7th/cmp-nvim-lsp',

        -- Adds a number of user-friendly snippets
        'rafamadriz/friendly-snippets',
    },

    config = function()
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        require('luasnip.loaders.from_vscode').lazy_load()
        luasnip.config.set_config{
            history = true,
            updateevents = 'TextChanged,TextChangedI'
        }
        -- If some day I do react in here
        -- luasnip.filetype_extend('javascript', { 'javascriptreact' })
        -- luasnip.filetype_extend('javascript', { 'html' })

        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            completion = {
                completeopt = 'menu,menuone,noinsert'
            },

            window = {
                documentation = cmp.config.window.bordered(),
                completion = {
                    winhighlight = 'Normal:NeogitHunkHeaderHighlight',
                    zindex = 10000
                }
            },

            mapping = cmp.mapping.preset.insert {
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-y>'] = cmp.mapping.confirm{
                    -- Decomment if want replace behavior
                    -- behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                },
                ['<C-Space>'] = cmp.mapping.complete{},
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer'},
                { name = 'path'},
            },

            ---@diagnostic disable-next-line: missing-fields
            formatting = {
                format = require('lspkind').cmp_format {
                    mode = 'symbol_text',
                    maxwidth = 50,
                    ---@diagnostic disable-next-line: unused-local
                    before = function(entry, vim_item)
                        local m = vim_item.menu and vim_item.menu or ''
                        if #m > 20 then
                            vim_item.menu = string.sub(m, 1, 20) .. '...'
                        end
                        return vim_item
                    end,
                    -- can also be a function to dynamically calculate max width such as
                    -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                    ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    show_labelDetails = true, -- show labelDetails in menu. Disabled by default
                },
            },
        }

        -- Setup for vim-dadbod
        cmp.setup.filetype({'sql','mysql','plsql'}, {
            sources = {
                { name = 'vim-dadbod-completion' },
                { name = 'buffer' }
            }
        })

    end,
}
