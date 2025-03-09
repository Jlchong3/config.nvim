return {

    -- Java (Install jdtls,java-test and java-debug lsp through mason)
    { 'mfussenegger/nvim-jdtls', event = 'VeryLazy' },

    -- Detect tabstop and shiftwidth automatically
    { 'tpope/vim-sleuth', event = 'VeryLazy'},

    -- For undo navigation
    { 'mbbill/undotree', event = 'VeryLazy' } ,

    -- Automatically add closing tags for HTML and JSX
    { 'windwp/nvim-ts-autotag', event = 'VeryLazy', opts = { } },

    -- Live-server
    { 'brianhuster/live-preview.nvim', cmd = 'LivePreview', opts = {} },

    -- Autocompleting brackets or quotes
    { 'windwp/nvim-autopairs', event = 'VeryLazy', opts = {} },

    -- Collection of various small independent plugins/modules
    { 'echasnovski/mini.statusline', opts = { } },
    { 'echasnovski/mini.splitjoin', event = 'VeryLazy', opts = { mappings = { toggle = 'gl' } } },

    -- Additional lua configuration, makes nvim stuff amazing!
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                { path = "snacks.nvim", words = { "Snacks" } },
            }
        }
    },

    -- Showing rgb/hex color ano color picker option
    {
        'uga-rosa/ccc.nvim',
        event = 'VeryLazy',
        opts = {
            highlighter = { auto_enable = true, lsp = true },
        }
    },

    -- Better typescript-lsp integration
    {
        'pmizio/typescript-tools.nvim',
        event = 'VeryLazy',
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
    },

    -- Markdown-preview
    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreview' },
        build = 'cd app && npm install',
        init = function() vim.g.mkdp_filetypes = { 'markdown' } end,
        ft = { 'markdown' },
    },

    -- Databases,
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod' },
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
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
    },

    -- Substitute
    {
        'gbprod/substitute.nvim',
        event = 'VeryLazy',
        config = function()
            require('substitute').setup();
            vim.keymap.set('n', 's', require('substitute').operator, { noremap = true })
            vim.keymap.set('n', 'ss', require('substitute').line, { noremap = true })
            vim.keymap.set('n', 'S', require('substitute').eol, { noremap = true })
            vim.keymap.set('x', 's', require('substitute').visual, { noremap = true })
        end
    },

}
