-- Inlay Hints toggle
vim.keymap.set('n', '<leader>in', function () vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(_)) end , { desc = '[I]nlay [H]ints' })

-- Start/Restart Lsp
vim.keymap.set('n', '<leader>ls', '<cmd>LspStart<CR>', { desc = '[L]sp [S]tart' })
vim.keymap.set('n', '<leader>lr', '<cmd>LspRestart<CR>', { desc = '[L]sp [R]estart' })

-- Easy Window manipulation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<Right>', '<C-w><', { desc = 'Decrease Width'} )
vim.keymap.set('n', '<Left>', '<C-w>>', { desc = 'Increase Width'} )
vim.keymap.set('n', '<Up>', '<C-w>+', { desc = 'Increse Height'} )
vim.keymap.set('n', '<Down>', '<C-w>-', { desc = 'Increase Height'} )

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- quickfixlist keymaps
vim.keymap.set('n', ']q', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '[q', '<cmd>cprev<CR>zz')

-- loclist keymaps
vim.keymap.set('n', ']l', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '[l', '<cmd>lprev<CR>zz')

-- TODO comments
vim.keymap.set('n', ']t', function() require('todo-comments').jump_next() end, { desc = 'Next todo comment' })
vim.keymap.set('n', '[t', function() require('todo-comments').jump_prev() end, { desc = 'Previous todo comment' })

-- Custom (theprimeagen)
vim.keymap.set('v', 'J', [[:m '>+1<CR>gv=gv]])
vim.keymap.set('v', 'K', [[:m '<-2<CR>gv=gv]])
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Copy and paste
vim.keymap.set({'n','x'}, '<leader>p', [["0p]], {desc = '[P]aste last Yank'})
vim.keymap.set({'n','x'}, '<leader>P', [["0P]], {desc = '[P]aste last Yank Upper'})
vim.keymap.set({'n','x'}, '<leader>sp', [["+p]], {desc = '[S]ystem [P]aste'})
vim.keymap.set('i', '<A-p>', '<C-r>"', {desc = '[P]aste Insert Mode'})

vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], {desc = '[Y]ank to system'})
vim.keymap.set({ 'n', 'v' }, '<leader>Y', [["+y$]], {desc = '[Y]ank to system Upper'})

-- Stop search highlight
vim.keymap.set({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>')

-- Replace word in file
vim.keymap.set('n', '<leader>rp', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = '[R]e[p]lace'})

-- Delete buffer
vim.keymap.set('n', '<leader>bd', [[:bd! <CR>]], {desc = '[B]uffer [D]elete'})

-- UndoTree toggle
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, {desc = '[U]ndoTree'})

-- Mini file explorer
vim.keymap.set('n', '<leader>fe', function ()
    if not require('mini.files').close() then require('mini.files').open(vim.api.nvim_buf_get_name(0)) end
end, { desc = '[F]ile [E]xplorer'})

-- Terminal keymaps
vim.keymap.set('n','<leader>H', function ()
    vim.cmd.split()
    vim.cmd.term()
    vim.cmd('resize -4')
end, {desc = '[H]orizontal Term'})

vim.keymap.set('n','<leader>V', function ()
    vim.cmd.vsplit()
    vim.cmd.term()
    vim.cmd('vertical resize -14')
end, {desc = '[V]ertical Term'})

vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w><C-h>]])
vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w><C-l>]])
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w><C-k>]])
vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w><C-j>]])

-- jump in snippets
vim.keymap.set({'i', 's'}, '<C-j>', function ()
    if require('luasnip').locally_jumpable(1) then
        require('luasnip').jump(1)
    end
end, {silent = true})

vim.keymap.set({'i', 's'}, '<C-k>', function ()
    if require('luasnip').locally_jumpable(-1) then
        require('luasnip').jump(-1)
    end
end, {silent = true})

-- Crates keymaps
vim.api.nvim_create_autocmd('BufRead', {
    group = vim.api.nvim_create_augroup('CmpSourceCargo', { clear = true }),
    pattern = 'Cargo.toml',
    callback = function()
        require('cmp').setup.buffer({ sources = { { name = 'crates' } } })
        local crates = require('crates')
        vim.keymap.set('n', '<leader>ct', crates.toggle, { silent = true, desc = 'Crates toggle'})
        vim.keymap.set('n', '<leader>cr', crates.reload, { silent = true, desc = 'Crates reload'})

        vim.keymap.set('n', '<leader>cf', crates.show_features_popup, { silent = true, desc = 'Crates show features'})
        vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup, { silent = true, desc = 'Crates dependencies'})

        vim.keymap.set('n', '<leader>cu', crates.update_crate, { silent = true, desc = 'Update crate'})
        vim.keymap.set('v', '<leader>cu', crates.update_crates, { silent = true, desc = 'Update crates'})
        vim.keymap.set('n', '<leader>cl', crates.update_all_crates, { silent = true, desc = 'Update all crates'})
        vim.keymap.set('n', '<leader>cU', crates.upgrade_crate, { silent = true, desc = 'Upgrade crate'})
        vim.keymap.set('v', '<leader>cU', crates.upgrade_crates, { silent = true, desc = 'Upgrade crates'})
        vim.keymap.set('n', '<leader>cL', crates.upgrade_all_crates, { silent = true, desc = 'Upgrade all crates'})

        vim.keymap.set('n', '<leader>cx', crates.expand_plain_crate_to_inline_table, { silent = true, desc = 'Expand to inline table'})
        vim.keymap.set('n', '<leader>cX', crates.extract_crate_into_table, { silent = true, desc = 'Expand into table'})
    end,
})
