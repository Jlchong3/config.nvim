-- Dap keymaps and DapView config

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

-- Adapters and debuggers config
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}
dap.configurations.c = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
  {
      name = "Launch with args",
      type = "gdb",
      request = "launch",
      program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = "${workspaceFolder}",
      stopAtBeginningOfMainSubprogram = false,
      args = function()
          local input = vim.fn.input('Program arguments: ')
          return vim.split(input, " ", { trimempty = true })
      end,
  },
  {
    name = "Select and attach to process",
    type = "gdb",
    request = "attach",
    program = function()
       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    pid = function()
       local name = vim.fn.input('Executable name (filter): ')
       return require("dap.utils").pick_process({ filter = name })
    end,
    cwd = '${workspaceFolder}'
  },
}
dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c
dap.configurations.zig = dap.configurations.c

require('dap-go').setup()
require('dap-python').setup('uv')
