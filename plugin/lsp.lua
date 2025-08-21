-- Install lspconfig
vim.pack.add {
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/folke/lazydev.nvim'
}

-- UI configuration
require('lspconfig.ui.windows').default_options = { border = 'rounded' }
vim.diagnostic.config {
    float = { border = 'rounded' },
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

require('lazydev').setup {
    library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
    }
}

for server, config in pairs(local_servers) do
    vim.lsp.config(server, {
        settings = config,
    })
    vim.lsp.enable(server)
end
