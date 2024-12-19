---@diagnostic disable: missing-fields
local remap = vim.keymap.set

-- Remove Q command
remap('n', 'Q', '<Nop>')

remap({'n', 'x'}, 's', '<Nop>')
remap({'n', 'x'}, 'S', '<Nop>')

-- surround remaps
remap('n', 'yss', '_ys$', { remap = true })
remap('n', 'yS', 'Vys', { remap = true })

-- Replace
remap('n', 's', require('substitute').operator, { noremap = true })
remap('n', 'ss', require('substitute').line, { noremap = true })
remap('n', 'S', require('substitute').eol, { noremap = true })
remap('x', 's', require('substitute').visual, { noremap = true })

-- '$' nuisance in visual mode
remap('x', '$', '$h')

-- Start/Restart Ls
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
remap('n', '<S-Down>', '<C-w>-', { desc = 'Decrease Height'} )

-- Diagnostic keymaps
remap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- quickfixlist keymaps
remap('n', ']q', '<cmd>cnext<CR>zz')
remap('n', '[q', '<cmd>cprev<CR>zz')

-- loclist keymaps
remap('n', ']l', '<cmd>lnext<CR>zz')
remap('n', '[l', '<cmd>lprev<CR>zz')

-- Custom (theprimeagen)
remap('v', 'J', [[:m '>+1<CR>gv=gv]])
remap('v', 'K', [[:m '<-2<CR>gv=gv]])
remap('n', 'J', 'mzJ`z')
remap('n', '<C-d>', '<C-d>zz')
remap('n', '<C-u>', '<C-u>zz')
remap('n', 'n', 'nzzzv')
remap('n', 'N', 'Nzzzv')

-- Better paste
local function custom_paste(is_upper)
    local register = vim.v.register
    local count = vim.v.count == 0 and '' or vim.v.count
    local expr = 'normal! "' .. register .. count .. (is_upper and 'P' or 'p')

    if vim.fn.getreg(register):sub(-1) == '\n' then
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        vim.cmd(expr)
        vim.api.nvim_win_set_cursor(0, {row + (is_upper and 0 or 1), col})
    else
        vim.cmd(expr)
    end
end

-- Copy and paste
remap('n', 'p', function() custom_paste(false) end)
remap('n', 'P', function() custom_paste(true) end)

remap({'n','x'}, '<leader>p', [["0p]], {desc = '[P]aste last Yank', remap = true})
remap({'n','x'}, '<leader>P', [["0P]], {desc = '[P]aste last Yank', remap = true})
remap({'n','x'}, '<leader>sp', [["+p]], {desc = '[S]ystem [P]aste', remap = true})
remap({'n','x'}, '<leader>sP', [["+P]], {desc = '[S]ystem [P]aste', remap = true})
remap('i', '<A-p>', '<C-r>"', {desc = '[P]aste Insert Mode'})

remap({ 'n', 'x' }, '<leader>y', [["+y]], {desc = '[Y]ank to system'})
remap({ 'n', 'x' }, '<leader>Y', [["+y$]], {desc = '[Y]ank to system Upper'})
remap('n', 'yc', function () vim.fn.setreg('+', vim.fn.getreg('"')) end, { noremap = true, desc = '[Y]ank to [S]ystem register' })

-- Stop search highlight
remap({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>')

-- Replace word in file
remap('n', '<leader>rp', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = '[R]e[p]lace'})

-- Delete buffer
remap('n', '<leader>bd', [[:bd! <CR>]], {desc = '[B]uffer [D]elete'})

-- UndoTree toggle
remap('n', '<leader>u', vim.cmd.UndotreeToggle, {desc = '[U]ndoTree'})

-- Default explorer
remap('n', '<leader>fe', vim.cmd.Ex, { desc = '[F]ile [E]xplorer'})

-- Terminal keymaps
remap('n','<leader>H', function ()
    vim.cmd.split()
    vim.cmd.term()
end, {desc = '[H]orizontal Term'})

remap('n','<leader>V', function ()
    vim.cmd.vsplit()
    vim.cmd.term()
end, {desc = '[V]ertical Term'})

remap('t', '<esc><esc>', [[<C-\><C-n>]])
remap('t', '<C-h>', [[<C-\><C-n><C-w><C-h>]])
remap('t', '<C-l>', [[<C-\><C-n><C-w><C-l>]])
remap('t', '<C-k>', [[<C-\><C-n><C-w><C-k>]])
remap('t', '<C-j>', [[<C-\><C-n><C-w><C-j>]])

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
