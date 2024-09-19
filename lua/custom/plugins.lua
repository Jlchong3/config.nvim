return {

    -- Detect tabstop and shiftwidth automatically
    { 'tpope/vim-sleuth', event = 'VeryLazy'},

    -- Additional lua configuration, makes nvim stuff amazing!
    { 'folke/lazydev.nvim', ft = 'lua', opts = { } },

    -- Git related plugin
    { 'tpope/vim-fugitive', event = 'VeryLazy' },

    -- For undo navigation
    { 'mbbill/undotree', event = 'VeryLazy'} ,

    -- Automatically add closing tags for HTML and JSX
    { 'windwp/nvim-ts-autotag', event = 'VeryLazy', config = function () require('nvim-ts-autotag').setup() end},

    -- Colorscheme
    { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },

    -- Top dropbar with document symbols {requires nvim nightly (>= 0.10.0-dev)}
    { 'Bekaboo/dropbar.nvim', event = 'VeryLazy', dependencies = { 'nvim-telescope/telescope-fzf-native.nvim' } },

    -- Inline GitBlame
    { 'f-person/git-blame.nvim', lazy = true, cmd = { 'GitBlameEnable' } },

    -- For diffviews
    { 'sindrets/diffview.nvim', lazy = true, cmd = { 'DiffviewOpen ' } },

    -- File Explorer
    { 'stevearc/oil.nvim', event = 'VeryLazy', config = function () require('oil').setup() end },

    -- Showing rgb/hex color ano color picker option
    {
        'uga-rosa/ccc.nvim',
        lazy = true,
        cmd = { 'CccPick', 'CccConvert' , 'CccHighlighterToggle', 'CccHighlighterDisable', 'CccHighlighterEnable'},
        opts = {
            highlighter = { auto_enable = true, lsp = true },
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
    { 'echasnovski/mini.statusline', config = function() require('mini.statusline').setup() end },
    { 'echasnovski/mini.splitjoin', event = 'VeryLazy', config = function () require('mini.splitjoin').setup{ mappings = { toggle = 'gl' } } end },

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
        config = function ()
            vim.g.db_ui_save_location = '~/vimfiles/db_ui'
            vim.g.db_ui_use_nerd_fonts = 1
        end
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
