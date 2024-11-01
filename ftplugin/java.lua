local jdtls = require('jdtls')
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local bundles = {
    vim.fn.glob(os.getenv('HOME') .. '/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar', true),
}

vim.list_extend(bundles, vim.split(vim.fn.glob(os.getenv('HOME') .. '/.local/share/nvim/mason/share/java-test/*.jar', true), '\n'))

local config = {
    cmd = {

        'java',

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:' .. os.getenv('HOME') .. '/.local/share/nvim/mason/share/jdtls/lombok.jar',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',

        '-jar',
        vim.fn.expand(
            os.getenv('HOME') .. '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'
        ),

        '-configuration',
        vim.fn.expand(os.getenv('HOME') .. '/.local/share/nvim/mason/packages/jdtls/config'),

        '-data',
        vim.fn.expand('~/.cache/jdtls/workspace') .. project_name,
    },

    root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),

    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            inlayHints = {
                parameterNames = {
                    enabled = 'all',
                }
            },
            completion = {
                favoriteStaticMembers = {
                    'org.hamcrest.MatcherAssert.assertThat',
                    'org.hamcrest.Matchers.*',
                    'org.hamcrest.CoreMatchers.*',
                    'org.junit.jupiter.api.Assertions.*',
                    'java.util.Objects.requireNonNull',
                    'java.util.Objects.requireNonNullElse',
                    'org.mockito.Mockito.*'
                },
                filteredTypes = {
                    'com.sun.*',
                    'io.micrometer.shaded.*',
                    'java.awt.*',
                    'jdk.*', 'sun.*',
                },
                importOrder = {
                    'java',
                    'javax',
                    'com',
                    'org'
                },
            },

            extendedClientCapabilities = jdtls.extendedClientCapabilities,

            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
                },
                useBlocks = true,
            },
        },
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = bundles,
    },

    capabilities = require('cmp_nvim_lsp').default_capabilities()
}

config['on_attach'] = function(_, bufnr)
    local nmap = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>tc', function () require('jdtls').test_class() require('dapui').open() end, '[T]est [C]lass')
    nmap('<leader>tm', function () require('jdtls').test_nearest_method() require('dapui').open() end, '[T]est [M]ethod')

---@diagnostic disable-next-line: missing-fields
    jdtls.setup_dap({ hotcodereplace = 'auto' })
    require('jdtls.dap').setup_dap_main_class_configs()
end

require('jdtls').start_or_attach(config)
