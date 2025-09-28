vim.pack.add {
    'https://github.com/mfussenegger/nvim-dap',
    'https://github.com/leoluz/nvim-dap-go',
    'https://github.com/mfussenegger/nvim-dap-python',
}
vim.pack.add ({
  'https://github.com/igorlfs/nvim-dap-view',
}, { load = true })

vim.keymap.set('n', '<F5>', function ()

  vim.keymap.del('n', '<F5>')
  require('debugging')

  require('dap').continue()
end)

vim.keymap.set('n', '<leader>bp', function ()
  require('debugging')

  vim.keymap.del('n', '<leader>bp')

  require('dap').toggle_breakpoint()
end)
