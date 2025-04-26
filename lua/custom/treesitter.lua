-- Highlight, edit, and navigate code

return {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
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
            textobjects = {
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        [']f'] = '@function.outer',
                        [']c'] = '@class.outer',
                    },
                    goto_next_end = {
                        [']F'] = '@function.outer',
                        [']C'] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['[f'] = '@function.outer',
                        ['[c'] = '@class.outer',
                    },
                    goto_previous_end = {
                        ['[F'] = '@function.outer',
                        ['[C'] = '@class.outer',
                    },
                },
            },
        }

        vim.treesitter.language.register('sql', 'mysql')
        vim.treesitter.language.register('sql', 'plsql')

    end, 0)
}
