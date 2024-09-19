return {

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    -- Additional lua configuration, makes nvim stuff amazing!
    { "folke/lazydev.nvim", ft = "lua", opts = { } },

    -- Useful plugin to show you pending keybinds.
    { 'folke/which-key.nvim', event = 'VeryLazy' },

    -- Git related plugin
    { 'tpope/vim-fugitive', event = 'VeryLazy' },

    -- Adds git related signs to the gutter, as well as utilities for managing changes
    { 'lewis6991/gitsigns.nvim', event = 'VeryLazy' },

    -- For undo navigation
    { 'mbbill/undotree', event = 'VeryLazy'} ,

    -- Automatically add closing tags for HTML and JSX
    { 'windwp/nvim-ts-autotag', event = 'VeryLazy' },

    -- Colorscheme
    { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },

    -- Fast buffer navigation
    { 'ThePrimeagen/harpoon', event = 'VeryLazy', branch = 'harpoon2', dependencies = { 'nvim-lua/plenary.nvim' } },

    -- Top dropbar with document symbols {requires nvim nightly (>= 0.10.0-dev)}
    { 'Bekaboo/dropbar.nvim', event = 'VeryLazy', dependencies = { 'nvim-telescope/telescope-fzf-native.nvim' } },

    -- Inline GitBlame
    { 'f-person/git-blame.nvim', lazy = true, cmd = { 'GitBlameEnable' } },

    -- For diffviews
    { "sindrets/diffview.nvim", lazy = true, cmd = { 'DiffviewOpen ' } },

    -- Surrounding options for text('',"",(),{},[],<>,<p></p>)
    { 'kylechui/nvim-surround', version = '*', event = 'VeryLazy' },

    -- Fuzzy finder for various things
    {
        'nvim-telescope/telescope.nvim',
        event = 'VeryLazy',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function() return vim.fn.executable 'make' == 1 end
            },
            'nvim-telescope/telescope-ui-select.nvim',
        },
    },

    -- Showing rgb/hex color ano color picker option
    {
        'uga-rosa/ccc.nvim',
        lazy = true,
        cmd = { 'CccPick', 'CccConvert' , 'CccHighlighterToggle', 'CccHighlighterDisable', 'CccHighlighterEnable'},
        opts = {
            highlighter = { auto_enable = true, lsp = true },
        }
    },

    -- Debuger adapters
    {
        'mfussenegger/nvim-dap',
        event = 'VeryLazy',
        dependencies = {
            {
                'rcarriga/nvim-dap-ui',
                dependencies = {
                    'nvim-neotest/nvim-nio',
                }
            },
            -- If you want go debugger (need delve installed)
            'leoluz/nvim-dap-go',
        }
    },
    {
        'jay-babu/mason-nvim-dap.nvim',
        event = 'VeryLazy',
        dependencies = {
            'williamboman/mason.nvim',
            'mfussenegger/nvim-dap',
            'WhoIsSethDaniel/mason-tool-installer.nvim'
        },
        opts = {
            handlers = {}
        }
    },


    -- Autocompleting brackets or quotes
    {
        'windwp/nvim-autopairs',
        event = 'VeryLazy',
        config = function()
            require('nvim-autopairs').setup()
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
    },

    -- Collection of various small independent plugins/modules
    {
        'echasnovski/mini.nvim',
        config = function() --Here are the mini plugins which do not require much customization
            require('mini.statusline').setup()
            require('mini.splitjoin').setup { mappings = { toggle = 'gl' } }
        end,
    },

    -- Markdown-preview
    {
        'iamcco/markdown-preview.nvim',
        lazy = true,
        cmd = { 'MarkdownPreview' },
        build = 'cd app && npm install',
        init = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        ft = { 'markdown' },
    },

    -- Databases,
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod', lazy = true},
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
        },
        cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer', },
    },

    -- Rust packages manager
    {
        'saecki/crates.nvim',
        tag = 'stable',
        event = { 'BufRead Cargo.toml' },
        config = function()
            require('crates').setup{ popup = { border = 'single' } }
        end,
    },
}
