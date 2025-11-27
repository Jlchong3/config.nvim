local dapview = require('dap-view')
local dap = require('dap')
dapview.setup {
    winbar = {
        sections = {
            'watches',
            'scopes',
            'exceptions',
            'breakpoints',
            'threads',
            'repl',
            'console',
        },
    },
    auto_toggle = true
}

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

dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = 'OpenDebugAD7'
}
dap.adapters.codelldb = {
  type = "executable",
  command = "codelldb",
}
dap.configurations.c = {
    {
        name = "Launch",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = false,
    },
    {
        name = "Launch with args",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = false,
        args = function()
            local input = vim.fn.input('Program arguments: ')
            return vim.split(input, " ", { trimempty = true })
        end,
    },
}
dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c
dap.configurations.zig = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },
    {
        name = "Launch with args",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function()
            local input = vim.fn.input('Program arguments: ')
            return vim.split(input, " ", { trimempty = true })
        end,
    }
}

require('dap-go').setup()
require('dap-python').setup('uv')
