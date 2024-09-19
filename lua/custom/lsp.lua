return {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',
    },

    config = function()
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

        local inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
        }

        local servers = {
            clangd = {},
            eslint = {},
            ols = {},
            zls = {},
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
            basedpyright = {
                basedpyright = {
                    analysis = {
                        typeCheckingMode = 'standard'
                    }
                }
            },
            ts_ls = {
                typescript = {
                    inlayHints = inlayHints
                },

                javascript = {
                    inlayHints = inlayHints
                }
            },
            marksman = {},
            cssls = { filetypes = { 'css', 'scss' } },
            tailwindcss = {},
            r_language_server = {
                r = {
                    lsp = {
                        diagnostics = {
                            spacesAroundInfixOperators = false,
                            lineWidth = nil,
                        }
                    }
                }
            },
            html = { filetypes = { 'html', 'twig', 'hbs' } },
            lua_ls = {
                Lua = {
                    hint = { enable = true },
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        }

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

        -- Lsp keymaps on_attach
        vim.api.nvim_create_augroup('LSPGroup', {})
        vim.api.nvim_create_autocmd('LspAttach', {
            group = 'LSPGroup',
            callback = function(e)
                local nmap = function(keys, func, desc)
                    vim.keymap.set('n', keys, func, { buffer = e.buf, desc = desc })
                end
                local builtin = require('telescope.builtin')

                nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

                nmap('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
                nmap('gr', builtin.lsp_references, '[G]oto [R]eferences')
                nmap('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
                nmap('<leader>T', builtin.lsp_type_definitions, '[T]ype Definition')
                nmap('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
                nmap('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

                -- See `:help K` for why this keymap
                nmap('H', vim.lsp.buf.signature_help, 'Signature Documentation')

                -- Lesser used LSP functionality
                nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                -- Create a command `:Format` local to the LSP buffer
                vim.api.nvim_buf_create_user_command(e.buf, 'Format', function(_)
                    vim.lsp.buf.format()
                end, { desc = 'Format current buffer with LSP' })
            end
        })
    end
}
