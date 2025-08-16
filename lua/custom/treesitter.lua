-- Highlight, edit, and navigate code

return {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    dependencies = {
        {
            'nvim-treesitter/nvim-treesitter-context',
            opts = {
                max_lines = 3,
            }
        },
        {
            'nvim-treesitter/nvim-treesitter-textobjects',
            branch = 'main'
        }
    },
    branch = 'main',
    build = ':TSUpdate',
    config = function()
        local parsers = {
            c = true,
            odin = true,
            cpp = true,
            go = true,
            lua = true,
            python = true,
            rust = true,
            tsx = true,
            html = true,
            css = true,
            glsl = true,
            json = true,
            javascript = true,
            java = true,
            zig = true,
            yuck = true,
            typescript = true,
            nix = true,
            vimdoc = true,
            vim = true,
            bash = true,
            sql = true,
            markdown = true,
            markdown_inline = true,
            yaml = true,
        }
        require('nvim-treesitter').install(vim.tbl_keys(parsers));

        require('treesitter-context').setup {
            enable = true,
        }

        vim.api.nvim_create_augroup('TSGroup', {})
        vim.api.nvim_create_autocmd('FileType', {
            group = 'TSGroup',
            callback = function(e)
                if parsers[vim.bo[e.buf].filetype] then
                    vim.treesitter.start(e.buf)
                end
            end
        })
        vim.api.nvim_create_autocmd('LspAttach', {
            group = 'TSGroup',
            callback = function(e)
                vim.treesitter.start(e.buf)
            end
        })
    end
}
