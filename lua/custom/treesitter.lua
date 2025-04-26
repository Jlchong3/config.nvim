-- Highlight, edit, and navigate code

return {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context'
    },
    build = ':TSUpdate',
    config = vim.defer_fn(function()
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup {
            -- Add languages to be installed here that you want installed for treesitter
            ensure_installed = {
                'c',
                'odin',
                'cpp',
                'go',
                'lua',
                'python',
                'rust',
                'tsx',
                'html',
                'css',
                'javascript',
                'java',
                'zig',
                'typescript',
                'vimdoc',
                'vim',
                'bash',
                'sql',
                'markdown',
                'markdown_inline',
                'yaml'
            },

            highlight = { enable = true },
            indent = { enable = true },
        }

        vim.treesitter.language.register('sql', 'mysql')
        vim.treesitter.language.register('sql', 'plsql')

    end, 0)
}
