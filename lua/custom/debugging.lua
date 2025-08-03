return {
    {
        'mfussenegger/nvim-dap',
        keys = { '<F5>' },
        dependencies = {
            { "igorlfs/nvim-dap-view", opts = {} }
        },
        config = function()

            local dapview = require('dap-view')

            local dap = require('dap')
            vim.fn.sign_define('DapBreakpoint', { text='●', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
            vim.fn.sign_define('DapBreakpointCondition', { text='⨂', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
            vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
            vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
            vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })

            --mapping of keys
            vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
            vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
            vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
            vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
            vim.keymap.set('n', '<leader>bp', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
            vim.keymap.set('n', '<leader>vi', function() require('dap.ui.widgets').hover() end, {desc = 'Debug: Variable Information'})
            vim.keymap.set('n', '<leader>dt', function() dapview.toggle() end, {desc = 'Debug: Toggle Panel'})
            vim.keymap.set('n', '<leader>dr', function() dap.repl.toggle() end, {desc = 'Debug: Repl Toggle'})
            vim.keymap.set('n', '<leader>bc', function()
                dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
            end, { desc = 'Debug: Set Breakpoint' })
            vim.keymap.set('n', '<leader>lp', function()
                dap.set_breakpoint(nil, nil, vim.fn.input('Log point message:'))
            end, {desc = 'Debug: Log Point'})

            -- Make dapui open automatically
            dap.listeners.before.attach.dapui_config = function()
                dapview.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapview.open()
            end

        end
    },
    {
        'jay-babu/mason-nvim-dap.nvim',
        event = 'VeryLazy',
        dependencies = {
            'mason-org/mason.nvim',
            'mfussenegger/nvim-dap',
            -- If you want go debugger (need delve installed)
            'leoluz/nvim-dap-go',
            'mfussenegger/nvim-dap-python'
        },
        config = function ()
            ---@diagnostic disable-next-line: missing-fields
            require('mason-nvim-dap').setup {
                ensure_installed = { 'delve', 'codelldb', 'javadbg', 'javatest' },
                handlers = {}
            }
            -- Setups and custom configs
            local dap = require('dap')
            require('dap-go').setup()
            require('dap-python').setup("uv")
        end
    }
}
