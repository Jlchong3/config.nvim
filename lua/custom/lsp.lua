return {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        { 'williamboman/mason.nvim', opts = { PATH = "append" } },
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        'echasnovski/mini.pick',
        'saghen/blink.cmp'
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

        vim.diagnostic.config {
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
            ols = {},
            zls = {},
            jdtls = {},
            rust_analyzer = {
                rust_analyzer = {
                    autoSearchPaths = true,
                },
                cargo = {
                    buildScripts = { enable = true },
                    allFeatures = true,
                },
            },
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
            marksman = {},
            cssls = { filetypes = { 'css', 'scss' } },
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

        -- blink-cmp supports additional completion capabilities, so broadcast that to servers
        local capabilities = require('blink.cmp').get_lsp_capabilities()
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            'codelldb',
            'delve',
            'java-debug-adapter',
            'java-test',
        })

        require('mason-tool-installer').setup {
            ensure_installed = ensure_installed
        }
        vim.api.nvim_command('MasonToolsInstall')

        ---@diagnostic disable-next-line: missing-fields
        require('mason-lspconfig').setup {
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                    }
                end,
                ['jdtls'] = function() end
            },
        }

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

                nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

                local on_list = function(opts)
                    local previous = vim.fn.getqflist()
                    vim.fn.setqflist({}, ' ', opts)
                    if #opts.items == 1 then
                        vim.cmd.cfirst()
                    else
                        require('mini.extra').pickers.list({ scope = "quickfix" }, { source = { name = opts.title } })
                    end
                    vim.fn.setqflist(previous, ' ')
                end

                nmap('gd', function() vim.lsp.buf.definition { on_list = on_list } end, '[G]oto [D]efinition')
                nmap('gr', function() extra.lsp { scope = 'references' } end, '[G]oto [R]eferences')
                nmap('gI', function() extra.lsp { scope = 'implementation' } end, '[G]oto [I]mplementation')
                nmap('<leader>T', function() extra.lsp { scope = 'type_definition' } end, '[T]ype Definition')
                nmap('<leader>ds', function() extra.lsp { scope = 'document_symbol' } end, '[D]ocument [S]ymbols')
                nmap('<leader>ws', function() extra.lsp { scope = 'workspace_symbol' } end, '[W]orkspace [S]ymbols')

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
    end,
}
