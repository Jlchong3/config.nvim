return {
    {
        'mfussenegger/nvim-dap',
        keys = { '<F5>' },
        dependencies = {
            {
                'rcarriga/nvim-dap-ui',
                dependencies = {
                    'nvim-neotest/nvim-nio',
                }
            },
            -- If you want go debugger (need delve installed)
            'leoluz/nvim-dap-go',
        },
        config = function()

            local dapui = require('dapui')
            dapui.setup()

            local dap = require('dap')

            --mapping of keys
            vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
            vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
            vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
            vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
            vim.keymap.set('n', '<leader>bp', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
            vim.keymap.set('n', '<leader>vi', function() require('dap.ui.widgets').hover() end, {desc = 'Debug: Variable Information'})
            vim.keymap.set('n', '<leader>do', function() dapui.open() end, {desc = 'Debug: Open'})
            vim.keymap.set('n', '<leader>dc', function() dapui.close() end, {desc = 'Debug: Close'})
            vim.keymap.set('n', '<leader>dr', function() dap.repl.toggle() end, {desc = 'Debug: Repl Toggle'})
            vim.keymap.set('n', '<leader>bc', function()
                dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
            end, { desc = 'Debug: Set Breakpoint' })
            vim.keymap.set('n', '<leader>lp', function()
                dap.set_breakpoint(nil, nil, vim.fn.input('Log point message:'))
            end, {desc = 'Debug: Log Point'})

            -- Make dapui open automatically
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end

        end
    },
    {
        'jay-babu/mason-nvim-dap.nvim',
        event = 'VeryLazy',
        dependencies = {
            'williamboman/mason.nvim',
            'mfussenegger/nvim-dap',
            'WhoIsSethDaniel/mason-tool-installer.nvim'
        },
        opts = {
            handlers = {}
        },
        config = function ()
            require('mason-tool-installer').setup{
                ensure_installed = {
                    'codelldb',
                    'delve'
                }
            }
            vim.api.nvim_command('MasonToolsInstall')

        ---@diagnostic disable-next-line: missing-fields
            require('mason-nvim-dap').setup {
                ensure_installed = { 'codelldb', 'delve' },
                handlers = {}
            }
            -- Setups and custom configs
            local dap = require('dap')

            require('dap-go').setup()

            local configurations_rust = {
                {
                    name = 'Cargo Rust Debug',
                    type = 'codelldb',
                    request = 'launch',
                    program = function()
                        return vim.fn.getcwd() .. '/zig-out/bin/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
                    end,
                    cwd = '${workspaceFolder}',
                    stopAtEntry = false,
                },
            }

            local configurations_zig = {
                {
                    name = 'Zig Project Debug',
                    type = 'codelldb',
                    request = 'launch',
                    program = function()
                        return vim.fn.getcwd() .. '/zig-out/bin/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
                    end,
                    cwd = '${workspaceFolder}',
                    stopAtEntry = false,
                },
            }

            local configurations_c = {
                {
                    name = 'Launch with arguments',
                    type = 'codelldb',
                    request = 'launch',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    args = function()
                        local input = vim.fn.input('Arguments: ')
                        return vim.split(input, ' ')
                    end,
                },
            }
            vim.list_extend(dap.configurations.c, configurations_c)
            vim.list_extend(dap.configurations.zig, configurations_zig)
            vim.list_extend(dap.configurations.rust, configurations_rust)

        end
    }
}
