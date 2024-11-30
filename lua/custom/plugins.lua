return {

    -- Java (Install jdtls,java-test and java-debug lsp through mason)
    { 'mfussenegger/nvim-jdtls', event = 'VeryLazy' },

    -- Detect tabstop and shiftwidth automatically
    { 'tpope/vim-sleuth', event = 'VeryLazy'},

    -- Additional lua configuration, makes nvim stuff amazing!
    { 'folke/lazydev.nvim', ft = 'lua', opts = { } },

    -- Git related plugin
    { 'tpope/vim-fugitive', event = 'VeryLazy' },

    -- For undo navigation
    { 'mbbill/undotree', event = 'VeryLazy'} ,

    -- Automatically add closing tags for HTML and JSX
    { 'windwp/nvim-ts-autotag', event = 'VeryLazy', opts = { } },

    -- Top dropbar with document symbols {requires nvim nightly (>= 0.10.0-dev)}
    { 'Bekaboo/dropbar.nvim', event = 'VeryLazy', dependencies = { 'nvim-telescope/telescope-fzf-native.nvim' } },

    -- Inline GitBlame
    { 'f-person/git-blame.nvim', lazy = true, cmd = { 'GitBlameEnable' } },

    -- For diffviews
    { 'sindrets/diffview.nvim', lazy = true, cmd = { 'DiffviewOpen' } },

    -- Live-server
    { 'brianhuster/live-preview.nvim', lazy = true, cmd = { 'LivePreview' }, opts = {} },

    -- Substitute
    { "gbprod/substitute.nvim", opts = { } },

    -- Showing rgb/hex color ano color picker option
    {
        'uga-rosa/ccc.nvim',
        event = 'VeryLazy',
        opts = {
            highlighter = { auto_enable = true, lsp = true },
        }
    },

    -- Autocompleting brackets or quotes
    {
        'windwp/nvim-autopairs',
        event = 'VeryLazy',
        opts = {}
    },

    -- Collection of various small independent plugins/modules
    { 'echasnovski/mini.statusline', opts = { } },
    { 'echasnovski/mini.splitjoin', event = 'VeryLazy', opts = { mappings = { toggle = 'gl' } } },

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

    -- Better markdown view
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = 'markdown',
        opts = {},
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    },

    -- Rust packages manager
    {
        'saecki/crates.nvim',
        tag = 'stable',
        event = { 'BufRead Cargo.toml' },
        opts =  { popup = { border = 'single' } }
    },
}
