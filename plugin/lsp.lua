-- Install lspconfig
vim.pack.add {
    'https://github.com/neovim/nvim-lspconfig',

    'https://github.com/folke/lazydev.nvim',
    'https://github.com/mfussenegger/nvim-jdtls',
    'https://github.com/nvim-flutter/flutter-tools.nvim',
    'https://github.com/GustavEikaas/easy-dotnet.nvim.git'
}

-- UI configuration
vim.diagnostic.config {
    signs = { text = { ERROR = ' ', WARN = ' ', INFO = ' ', HINT = '󰌵'} },
    virtual_text = true,
}

-- LSPs setup
local local_servers = {
    clangd = {},
    ols = {},
    zls = {},
    bashls = {},
    marksman = {},
    asm_lsp = {},
    tinymist = {},
    tailwindcss = {},
    jdtls = {
        settings = {
            java = {
                inlayHints = {
                    parameterNames = {
                        enabled = 'all',
                    }
                },
                extendedClientCapabilities = require('jdtls').extendedClientCapabilities,
                codeGeneration = {
                    toString = {
                        template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
                    },
                    useBlocks = true,
                },
            },
            lombok_support = true
        },
    },
    basedpyright = {
        settings = {
            basedpyright = {
                analysis = {
                    typeCheckingMode = 'standard'
                }
            }
        }
    },
    lua_ls = {
        settings = {
            Lua = {
                hint = { enable = true },
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
            },
        }
    },
    cssls = {},
    jsonls = {},
    eslint = {},
    html = {},
    gopls = {
        settings = {
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
        }
    },
    rust_analyzer = {
        settings = {
            rust_analyzer = {
                autoSearchPaths = true,
            },
            cargo = {
                buildScripts = { enable = true },
                allFeatures = true,
            },
        }
    },
    tsgo = {}
}

require("flutter-tools").setup {}

if vim.fn.executable("dotnet") == 1 then
  require("easy-dotnet").setup {}
end

require('lazydev').setup {
    library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
        -- '~/.local/share/LuaAddons/love2d/library',
        -- '~/.local/share/LuaAddons/luasocket/library',
    }
}

for server, config in pairs(local_servers) do
    vim.lsp.config(server, config)
    vim.lsp.enable(server)
end

-- Lsp keymaps on_attach
vim.api.nvim_create_augroup('LSPGroup', {})
vim.api.nvim_create_autocmd('LspAttach', {
    group = 'LSPGroup',
    callback = function(e)
        local nmap = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = e.buf, desc = desc })
        end

        local extra = require('mini.extra').pickers

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

        vim.lsp.document_color.enable(true, nil, { style = 'virtual' })

        nmap('gd', function() vim.lsp.buf.definition { on_list = on_list } end, '[G]oto [D]efinition')
        nmap('grr', function() extra.lsp { scope = 'references' } end, '[G]oto [R]eferences')
        nmap('gri', function() extra.lsp { scope = 'implementation' } end, '[G]oto [I]mplementation')
        nmap('grt', function() extra.lsp { scope = 'type_definition' } end, '[T]ype Definition')
        nmap('<leader>ds', function() extra.lsp { scope = 'document_symbol' } end, '[D]ocument [S]ymbols')
        nmap('<leader>ws', function() extra.lsp { scope = 'workspace_symbol' } end, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Info')
        nmap('H', vim.lsp.buf.signature_help, 'Signature Documentation')
        nmap('grc', vim.lsp.document_color.color_presentation, 'Change color format')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        vim.bo[e.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
        vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })

        local map_lsp_selection = function(lhs, desc)
            local s = vim.startswith(desc, 'Increase') and 1 or -1
            local rhs = function() vim.lsp.buf.selection_range(s * vim.v.count1) end
            vim.keymap.set('x', lhs, rhs, { desc = desc })
        end

        map_lsp_selection('la', 'Increase selection')
        map_lsp_selection('li', 'Decrease selection')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(e.buf, 'Format', function(_)
            vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
    end
})
