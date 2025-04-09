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
            vim.keymap.set('n', '<leader>dt', function() dapui.toggle() end, {desc = 'Debug: Open'})
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
            -- If you want go debugger (need delve installed)
            'leoluz/nvim-dap-go',
        },
        config = function ()
            ---@diagnostic disable-next-line: missing-fields
            require('mason-nvim-dap').setup {
                handlers = {}
            }
            -- Setups and custom configs
            local dap = require('dap')

            require('dap-go').setup()
        end
    }
}
