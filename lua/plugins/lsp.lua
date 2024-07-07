
return {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        {'williamboman/mason.nvim', config = true},
        'williamboman/mason-lspconfig.nvim',

        -- Icons on cmp
        'onsails/lspkind-nvim',

        -- Additional lua configuration, makes nvim stuff amazing!
        'folke/neodev.nvim',
    },

    config = function ()
        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
            vim.lsp.handlers.hover, {
                border = 'rounded'
            }
        )

        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signature_help, {
                border = 'rounded'
            }
        )

        require('lspconfig.ui.windows').default_options = {
            border = 'rounded'
        }

        require('mason').setup()

        require('mason-lspconfig').setup()

        vim.diagnostic.config {
            virtual_text = {
                prefix = ''
            },

            float = {
                border = 'rounded'
            }
        }

        vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
        vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
        vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
        vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })

        local servers = {
            clangd = {},
            eslint = {},
            jdtls = { inlayHints = { parameterNames = { enabled = 'all' } } },
            basedpyright = {
                basedpyright = {
                    analysis = {
                        typeCheckingMode = 'standard'
                    }
                }
            },
            tsserver = {
                typescript = {
                    inlayHints = {
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    }
                },

                javascript = {
                    inlayHints = {
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    }
                }
            },
            marksman = {},
            cssls = { filetypes = { 'css', 'scss' }},
            tailwindcss = {},
            html = { filetypes = { 'html', 'twig', 'hbs' } },
            lua_ls = {
                Lua = {
                    hint = { enable = true },
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        }

        require('neodev').setup()

        -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        -- Ensure the servers above are installed
        local mason_lspconfig = require 'mason-lspconfig'

        mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(servers),
        }

        mason_lspconfig.setup_handlers {
            function(server_name)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                }
            end,
        }

        require('lspconfig').rust_analyzer.setup {
            capabilities = capabilities,
            cmd = {
                'rustup', 'run', 'stable', 'rust-analyzer',
            }
        }

    end
}
