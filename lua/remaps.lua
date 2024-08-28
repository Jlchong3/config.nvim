local remap = vim.keymap.set

-- Inlay Hints toggle
remap('n', '<leader>in', function () vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(_)) end , { desc = '[I]nlay [H]ints' })

-- Remove Q command
remap('n', 'Q', '<Nop>')

-- Start/Restart Lsp
remap('n', '<leader>ls', '<cmd>LspStart<CR>', { desc = '[L]sp [S]tart' })
remap('n', '<leader>lr', '<cmd>LspRestart<CR>', { desc = '[L]sp [R]estart' })

-- Easy Window manipulation
remap('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
remap('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
remap('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
remap('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })
remap('n', '<S-Right>', '<C-w><', { desc = 'Decrease Width'} )
remap('n', '<S-Left>', '<C-w>>', { desc = 'Increase Width'} )
remap('n', '<S-Up>', '<C-w>+', { desc = 'Increse Height'} )
remap('n', '<S-Down>', '<C-w>-', { desc = 'Increase Height'} )

-- Diagnostic keymaps
remap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- quickfixlist keymaps
remap('n', ']q', '<cmd>cnext<CR>zz')
remap('n', '[q', '<cmd>cprev<CR>zz')

-- loclist keymaps
remap('n', ']l', '<cmd>lnext<CR>zz')
remap('n', '[l', '<cmd>lprev<CR>zz')

-- TODO comments
remap('n', ']t', function() require('todo-comments').jump_next() end, { desc = 'Next todo comment' })
remap('n', '[t', function() require('todo-comments').jump_prev() end, { desc = 'Previous todo comment' })

-- Custom (theprimeagen)
remap('v', 'J', [[:m '>+1<CR>gv=gv]])
remap('v', 'K', [[:m '<-2<CR>gv=gv]])
remap('n', 'J', 'mzJ`z')
remap('n', '<C-d>', '<C-d>zz')
remap('n', '<C-u>', '<C-u>zz')
remap('n', 'n', 'nzzzv')
remap('n', 'N', 'Nzzzv')

-- Copy and paste
remap({'n','x'}, '<leader>p', [["0p]], {desc = '[P]aste last Yank'})
remap({'n','x'}, '<leader>P', [["0P]], {desc = '[P]aste last Yank Upper'})
remap({'n','x'}, '<leader>sp', [["+p]], {desc = '[S]ystem [P]aste'})
remap('i', '<A-p>', '<C-r>"', {desc = '[P]aste Insert Mode'})

remap({ 'n', 'v' }, '<leader>y', [["+y]], {desc = '[Y]ank to system'})
remap({ 'n', 'v' }, '<leader>Y', [["+y$]], {desc = '[Y]ank to system Upper'})

-- Stop search highlight
remap({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>')

-- Replace word in file
remap('n', '<leader>rp', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = '[R]e[p]lace'})

-- Delete buffer
remap('n', '<leader>bd', [[:bd! <CR>]], {desc = '[B]uffer [D]elete'})

-- UndoTree toggle
remap('n', '<leader>u', vim.cmd.UndotreeToggle, {desc = '[U]ndoTree'})

-- Mini file explorer
remap('n', '<leader>fe', function ()
    if not require('mini.files').close() then require('mini.files').open(vim.api.nvim_buf_get_name(0)) end
end, { desc = '[F]ile [E]xplorer'})

-- Terminal keymaps
remap('n','<leader>H', function ()
    vim.cmd.split()
    vim.cmd.term()
end, {desc = '[H]orizontal Term'})

remap('n','<leader>V', function ()
    vim.cmd.vsplit()
    vim.cmd.term()
end, {desc = '[V]ertical Term'})

remap('t', '<esc>', [[<C-\><C-n>]])
remap('t', '<C-h>', [[<C-\><C-n><C-w><C-h>]])
remap('t', '<C-l>', [[<C-\><C-n><C-w><C-l>]])
remap('t', '<C-k>', [[<C-\><C-n><C-w><C-k>]])
remap('t', '<C-j>', [[<C-\><C-n><C-w><C-j>]])

-- Jump snippets
remap({'i', 's'}, '<C-j>', function ()
    if require('luasnip').locally_jumpable(1) then
        require('luasnip').jump(1)
    end
end, {silent = true})

remap({'i', 's'}, '<C-k>', function ()
    if require('luasnip').locally_jumpable(-1) then
        require('luasnip').jump(-1)
    end
end, {silent = true})

-- Open AI chat
remap('n', '<leader>ai', [[:CodeCompanionToggle<cr>]], {desc = 'Open [AI] Chat'})
remap('n', '<leader>aa', [[:CodeCompanionActions<cr>]], {desc = 'Open [A]I Actions'})

-- Iron keymaps
remap('n', '<leader>ir', [[:IronRepl<cr>]], {desc = 'Iron Repl'})

-- Crates keymaps
vim.api.nvim_create_autocmd('BufRead', {
    group = vim.api.nvim_create_augroup('CmpSourceCargo', { clear = true }),
    pattern = 'Cargo.toml',
    callback = function()
        require('cmp').setup.buffer({ sources = { { name = 'crates' } } })
        local crates = require('crates')
        remap('n', '<leader>ct', crates.toggle, { silent = true, desc = 'Crates toggle'})
        remap('n', '<leader>cr', crates.reload, { silent = true, desc = 'Crates reload'})

        remap('n', '<leader>cf', crates.show_features_popup, { silent = true, desc = 'Crates show features'})
        remap('n', '<leader>cd', crates.show_dependencies_popup, { silent = true, desc = 'Crates dependencies'})

        remap('n', '<leader>cu', crates.update_crate, { silent = true, desc = 'Update crate'})
        remap('v', '<leader>cu', crates.update_crates, { silent = true, desc = 'Update crates'})
        remap('n', '<leader>cl', crates.update_all_crates, { silent = true, desc = 'Update all crates'})
        remap('n', '<leader>cU', crates.upgrade_crate, { silent = true, desc = 'Upgrade crate'})
        remap('v', '<leader>cU', crates.upgrade_crates, { silent = true, desc = 'Upgrade crates'})
        remap('n', '<leader>cL', crates.upgrade_all_crates, { silent = true, desc = 'Upgrade all crates'})

        remap('n', '<leader>cx', crates.expand_plain_crate_to_inline_table, { silent = true, desc = 'Expand to inline table'})
        remap('n', '<leader>cX', crates.extract_crate_into_table, { silent = true, desc = 'Expand into table'})
    end,
})
