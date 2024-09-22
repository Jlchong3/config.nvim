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
                    winhighlight = 'Normal:Pmenu,Search:PmenuSel',
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
                format = function(_, vim_item)
                    local icon, hl = MiniIcons.get('lsp', vim_item.kind)
                    local m = vim_item.menu and vim_item.menu or ''
                    if #m > 20 then
                        vim_item.menu = string.sub(m, 1, 20) .. '...'
                    end
                    vim_item.kind = icon .. " " .. vim_item.kind
                    vim_item.kind_hl_group = hl
                    return vim_item
                end,
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
