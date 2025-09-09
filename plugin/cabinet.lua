vim.pack.add {
    {
        src = 'https://github.com/Jlchong3/cabinet.nvim',
        version = 'refactor'
    }
}

local cabinet = require('cabinet').setup {}

vim.keymap.set('n', '<A-e>', cabinet.open)
vim.keymap.set('n', '<leader>da', cabinet.add_drawer)
vim.keymap.set('n', '<leader>a', cabinet.add_file)

vim.keymap.set('n', '<A-j>', function() cabinet.open_file(1) end)
vim.keymap.set('n', '<A-k>', function() cabinet.open_file(2) end)
vim.keymap.set('n', '<A-l>', function() cabinet.open_file(3) end)
vim.keymap.set('n', '<A-;>', function() cabinet.open_file(4) end)

vim.keymap.set('n', '<A-f>', function() cabinet.open_drawer(1) end)
vim.keymap.set('n', '<A-d>', function() cabinet.open_drawer(2) end)
vim.keymap.set('n', '<A-s>', function() cabinet.open_drawer(3) end)
vim.keymap.set('n', '<A-a>', function() cabinet.open_drawer(4) end)
