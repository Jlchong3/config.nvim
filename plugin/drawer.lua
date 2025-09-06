vim.pack.add {
    'https://github.com/Jlchong3/drawer.nvim'
}

local drawer = require('drawer').setup {}

vim.keymap.set('n', '<A-e>', drawer.open)
vim.keymap.set('n', '<leader>da', drawer.add_drawer)
vim.keymap.set('n', '<leader>fa', drawer.add_file)

vim.keymap.set('n', '<A-j>', function() drawer.open_file(1) end)
vim.keymap.set('n', '<A-k>', function() drawer.open_file(2) end)
vim.keymap.set('n', '<A-l>', function() drawer.open_file(3) end)
vim.keymap.set('n', '<A-;>', function() drawer.open_file(4) end)

vim.keymap.set('n', '<A-f>', function() drawer.open_drawer(1) end)
vim.keymap.set('n', '<A-d>', function() drawer.open_drawer(2) end)
vim.keymap.set('n', '<A-s>', function() drawer.open_drawer(3) end)
vim.keymap.set('n', '<A-a>', function() drawer.open_drawer(4) end)
