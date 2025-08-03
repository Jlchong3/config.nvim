local jdtls = require('jdtls')
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local bundles = {
    vim.fn.glob(os.getenv('HOME') .. '/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar', true),
}

vim.list_extend(bundles, vim.split(vim.fn.glob(os.getenv('HOME') .. '/.local/share/nvim/mason/share/java-test/*.jar', true), '\n'))

local config = {
    cmd = { 'jdtls' },

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

    init_options = {
        bundles = bundles,
    },

    capabilities = require('blink.cmp').get_lsp_capabilities()
}

config['on_attach'] = function(_, bufnr)
    local nmap = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    local dapview = require('dap-view')

    nmap('<leader>tjc', function () require('jdtls').test_class() dapview.open() dapview.show_view('repl') end, '[T]est [J]ava [C]lass')
    nmap('<leader>tjm', function () require('jdtls').test_nearest_method() dapview.open() dapview.show_view('repl') end, '[T]est [J]ava [M]ethod')

---@diagnostic disable-next-line: missing-fields
    jdtls.setup_dap({ hotcodereplace = 'auto' })
    require('jdtls.dap').setup_dap_main_class_configs()
end

require('jdtls').start_or_attach(config)
