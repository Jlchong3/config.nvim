-- Remove Q command
vim.keymap.set('n', 'Q', '<Nop>')

vim.keymap.set({'n', 'x'}, 's', '<Nop>')
vim.keymap.set({'n', 'x'}, 'S', '<Nop>')

-- Remove nuisance on visual mode
vim.keymap.set('x', '$', '$h')

-- Easy Window manipulation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<S-Right>', '<C-w><', { desc = 'Decrease Width' } )
vim.keymap.set('n', '<S-Left>', '<C-w>>', { desc = 'Increase Width' } )
vim.keymap.set('n', '<S-Up>', '<C-w>+', { desc = 'Increse Height' } )
vim.keymap.set('n', '<S-Down>', '<C-w>-', { desc = 'Decrease Height' } )

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>co', function() vim.cmd('copen') end, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>D', function()
    if vim.diagnostic.config().virtual_lines then
        vim.diagnostic.config({ virtual_lines = false })
        vim.diagnostic.config({ virtual_text = true })
    else
        vim.diagnostic.config({ virtual_lines = { current_line = true } })
        vim.diagnostic.config({ virtual_text = { current_line = false } })
        vim.api.nvim_create_autocmd('CursorMoved', {
            once = true,
            pattern = '*',
            callback = function ()
                vim.diagnostic.config({ virtual_lines = false })
                vim.diagnostic.config({ virtual_text = true })
            end
        });
    end
end)

-- quickfixlist keymaps
vim.keymap.set('n', ']q', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '[q', '<cmd>cprev<CR>zz')

-- loclist keymaps
vim.keymap.set('n', ']l', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '[l', '<cmd>lprev<CR>zz')

-- Capital J without moving cursor
vim.keymap.set('n', 'J', 'mzJ`z')

-- Scrolling/Searching without losing cursor
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

-- Copy and paste
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

vim.keymap.set('n', 'p', function() custom_paste(false) end)
vim.keymap.set('n', 'P', function() custom_paste(true) end)

vim.keymap.set({'n','x'}, '<leader>p', [["0p]], { desc = '[P]aste last Yank', remap = true })
vim.keymap.set({'n','x'}, '<leader>P', [["0P]], { desc = '[P]aste last Yank', remap = true })
vim.keymap.set({'n','x'}, '<leader>sp', [["+p]], { desc = '[S]ystem [P]aste', remap = true })
vim.keymap.set({'n','x'}, '<leader>sP', [["+P]], { desc = '[S]ystem [P]aste', remap = true })
vim.keymap.set('i', '<A-p>', '<C-r>"', { desc = '[P]aste Insert Mode' })

vim.keymap.set({ 'n', 'x' }, '<leader>y', [["+y]], { desc = '[Y]ank to system' })
vim.keymap.set({ 'n', 'x' }, '<leader>Y', [["+y$]], { desc = '[Y]ank to system Upper' })
vim.keymap.set('n', 'yc', function() vim.fn.setreg('+', vim.fn.getreg('"')) end, { remap = false, desc = '[Y]ank to [S]ystem register' })

-- Stop search highlight
vim.keymap.set({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>')

-- Replace word in file
vim.keymap.set('n', '<leader>rp', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[R]e[p]lace' })

-- Delete buffer
vim.keymap.set('n', '<leader>bd', '<cmd>bd! <CR>', { desc = '[B]uffer [D]elete' })

-- Escape terminal easily
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w><C-h>]])
vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w><C-l>]])
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w><C-k>]])
vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w><C-j>]])

-- Make
vim.keymap.set('n', '<leader>m', '<cmd>make<CR>', { desc = '[M]ake' })

vim.api.nvim_create_augroup("markup_language", {})
vim.api.nvim_create_autocmd('BufEnter', {
    group = "markup_language",
    pattern = { '*.typ', '*.md', '*.html', '*.js', '*.tsx', '*.css', '*.scss' },
    callback = function()
        vim.keymap.set('n', '<leader>ip', function()
            require('snacks').image.hover()
        end, { buffer = true, desc = '[I]mage [P]review' })
    end
})

