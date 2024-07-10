require('mason-tool-installer').setup{
    ensure_installed = {
        'cpptools',
        'delve'
    }
}
vim.api.nvim_command('MasonToolsInstall')

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

-- Setups and custom configs
require('dap-go').setup()

dap.configurations.rust= {
  {
    name = 'Cargo Rust Debug',
    type = 'cppdbg',
    request = 'launch',
    program = function()
---@diagnostic disable-next-line: redundant-parameter
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = false,
  },
}

dap.configurations.c = {
    {
        name = "Launch with arguments",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function()
            local input = vim.fn.input('Arguments: ')
            return vim.split(input, " ")
        end,
    },
}

