vim.g.netrw_bufsettings = 'noma nomod nonu nobl nowrap ro rnu'
vim.g.netrw_keepdir = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 20
vim.g.netrw_localcopydircmd = 'cp -r'

vim.api.nvim_set_hl(0, 'netrwMarkFile', { link = 'Search' })

vim.keymap.set('n', 'H', 'u', { buffer = true, remap = true } )
vim.keymap.set('n', 'h', '-', { buffer = true, remap = true } )
vim.keymap.set('n', 'l', '<CR>', { buffer = true, remap = true } )
vim.keymap.set('n', '.', 'gh', { buffer = true, remap = true } )
vim.keymap.set('n', '<TAB>', 'mf', { buffer = true, remap = true } )
vim.keymap.set('n', '<S-TAB>', 'mF', { buffer = true, remap = true } )
vim.keymap.set('n', '<leader><TAB>', 'mu', { buffer = true, remap = true } )
vim.keymap.set('n', 'a', '%:w<CR>:buffer #<CR>', { buffer = true, remap = true })
vim.keymap.set('n', 'fr', 'R', { buffer = true, remap = true })
