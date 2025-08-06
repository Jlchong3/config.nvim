return {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        { 'mason-org/mason.nvim', opts = { PATH = 'append' } },
        'echasnovski/mini.pick',
        'saghen/blink.cmp'
    },

    config = function()
        require('lspconfig.ui.windows').default_options = { border = 'rounded' }

        require('mason').setup()

        vim.diagnostic.config {
            float = { border = 'rounded' },
            signs = { text = { ERROR = ' ', WARN = ' ', INFO = ' ', HINT = '󰌵'} },
            virtual_text = true,
        }

        local local_servers = {
            clangd = {},
            ols = {},
            zls = {},
            bashls = {},
            marksman = {},
            tailwindcss = {},
            basedpyright = {
                basedpyright = {
                    analysis = {
                        typeCheckingMode = 'standard'
                    }
                }
            },
            lua_ls = {
                Lua = {
                    hint = { enable = true },
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
            cssls = {},
            jsonls = {},
            eslint = {},
            html = {},
            gopls = {
                gopls = {
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true
                    }
                }
            },
            rust_analyzer = {
                rust_analyzer = {
                    autoSearchPaths = true,
                },
                cargo = {
                    buildScripts = { enable = true },
                    allFeatures = true,
                },
            },
        }


        for server, config in pairs(local_servers) do
            vim.lsp.config(server, {
                settings = config,
                filetypes = (config or {}).filetypes,
            })
            vim.lsp.enable(server)
        end

        -- Lsp keymaps on_attach
        vim.api.nvim_create_augroup('LSPGroup', {})
        vim.api.nvim_create_autocmd('LspAttach', {
            group = 'LSPGroup',
            callback = function(e)
                local nmap = function(keys, func, desc)
                    ---@diagnostic disable-next-line: missing-fields
                    vim.keymap.set('n', keys, func, { buffer = e.buf, desc = desc })
                end

                local extra = require('mini.extra').pickers

                nmap('grn', vim.lsp.buf.rename, '[R]e[n]ame')

                local on_list = function(opts)
                    local previous = vim.fn.getqflist()
                    vim.fn.setqflist({}, ' ', opts)
                    if #opts.items == 1 then
                        vim.cmd.cfirst()
                    else
                        extra.list({ scope = "quickfix" }, { source = { name = opts.title } })
                    end
                    vim.fn.setqflist(previous, ' ')
                end

                nmap('gd', function() vim.lsp.buf.definition { on_list = on_list } end, '[G]oto [D]efinition')
                nmap('grr', function() extra.lsp { scope = 'references' } end, '[G]oto [R]eferences')
                nmap('gri', function() extra.lsp { scope = 'implementation' } end, '[G]oto [I]mplementation')
                nmap('grt', function() extra.Isp { scope = 'type_definition' } end, '[T]ype Definition')
                nmap('<leader>ds', function() extra.lsp { scope = 'document_symbol' } end, '[D]ocument [S]ymbols')
                nmap('<leader>ws', function() extra.lsp { scope = 'workspace_symbol' } end, '[W]orkspace [S]ymbols')

                -- See `:help K` for why this keymap
                nmap('K', function() vim.lsp.buf.hover { border = 'rounded' } end, 'Hover Info')
                nmap('H', function() vim.lsp.buf.signature_help { border = 'rounded' } end, 'Signature Documentation')

                -- Lesser used LSP functionality
                nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                -- Create a command `:Format` local to the LSP buffer
                vim.api.nvim_buf_create_user_command(e.buf, 'Format', function(_)
                    vim.lsp.buf.format()
                end, { desc = 'Format current buffer with LSP' })
            end
        })
    end,
}
