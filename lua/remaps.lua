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
vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w><C-h>]])
vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w><C-l>]])
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w><C-k>]])
vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w><C-j>]])
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]])

-- Make
vim.keymap.set('n', '<leader>m', ':make ', { desc = '[M]ake' })

local MarkupGroup = require('augroups').MarkupGroup
vim.api.nvim_create_autocmd('BufEnter', {
    group = MarkupGroup,
    pattern = { '*.org', '*.md' },
    callback = function()
        vim.keymap.set('n', '<leader>ch', function ()
            local current_line = vim.api.nvim_get_current_line();

            if current_line:match('^%s*$') then
                return
            end

            local non_blank = current_line:match('^%s*'):len() + 1
            local sub_string = current_line:sub(non_blank, non_blank + 4)
            local row, _ = unpack(vim.api.nvim_win_get_cursor(0));
            if sub_string == '- [ ]' then
                vim.api.nvim_buf_set_text(0, row - 1, non_blank + 2, row - 1, non_blank + 3, {'x'});
            elseif sub_string == '- [x]' then
                vim.api.nvim_buf_set_text(0, row - 1, non_blank + 2, row - 1, non_blank + 3, {' '});
            else
                vim.api.nvim_buf_set_text(0, row - 1, non_blank - 1, row - 1, non_blank - 1, {'- [ ] '});
            end
        end, { buffer = true, desc = '[CH]eck box' })

        vim.keymap.set('v', '<leader>ch', function ()
            vim.api.nvim_feedkeys('\027', 'xt', false)
            local start_line, _ = unpack(vim.api.nvim_buf_get_mark(0, '<'))
            local end_line, _ = unpack(vim.api.nvim_buf_get_mark(0, '>'))
            local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
            local non_checkbox_lines = {}
            local unchecked_checkbox_lines = {}

            for i = 1, #lines do
                local non_blank = lines[i]:match('^%s*'):len() + 1
                local sub_string = lines[i]:sub(non_blank, non_blank + 4)
                local non_checkbox = sub_string ~= '- [ ]' and sub_string ~= '- [x]'
                local is_empty = sub_string:match('^%s*$')
                if non_checkbox and not is_empty then
                    non_checkbox_lines[i] = non_blank
                elseif sub_string == '- [ ]' then
                    unchecked_checkbox_lines[i] = non_blank
                end
            end

            if vim.tbl_count(non_checkbox_lines)~= 0 then
                for ind, non_blank in pairs(non_checkbox_lines) do
                    local row = start_line + ind - 1
                    vim.api.nvim_buf_set_text(0, row - 1, non_blank - 1, row - 1, non_blank - 1, {'- [ ] '});
                end
            elseif vim.tbl_count(unchecked_checkbox_lines) == 0 then
                for i = 1, #lines do
                    lines[i] = lines[i]:gsub('- %[x%]', '- [ ]', 1)
                end
                vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
            else
                for ind, non_blank in pairs(unchecked_checkbox_lines) do
                    local row = start_line + ind - 1
                    vim.api.nvim_buf_set_text(0, row - 1, non_blank + 2, row - 1, non_blank + 3, {'x'});
                end
            end
        end, { buffer = true, desc = '[CH]eck box' })
    end
})

-- Runner for class
local TempGroup = vim.api.nvim_create_augroup('Temp', { clear = true })
-- Make this into a small program or plugin
vim.api.nvim_create_autocmd('BufEnter', {
    group = TempGroup,
    pattern = { "*.py" },
    callback = function(e)
        vim.keymap.set(
            'n',
            '<C-p>',
            function ()
                local win_height = vim.api.nvim_win_get_height(0)
                local runner_height = math.floor(win_height / 3)
                local buf = vim.api.nvim_create_buf(false, true)
                local win = vim.api.nvim_open_win(buf, true, {
                    split = "below",
                    win = 0,
                    height = runner_height
                })
                local task = "python " .. e.file
                vim.fn.jobstart(task, {
                    term = true,
                    on_exit = function ()
                        if vim.api.nvim_get_current_buf() == buf then
                            vim.cmd('stopinsert')
                        end
                    end
                })
                vim.api.nvim_feedkeys('i', 'n', false)

                vim.keymap.set('n', 'Q', function()
                    if vim.api.nvim_win_is_valid(win) then
                        vim.api.nvim_win_close(win, true)
                    end
                end)

                vim.keymap.set('n', 'q', function()
                    if vim.api.nvim_win_is_valid(win) then
                        vim.api.nvim_win_close(win, true)
                    end
                end, { buf = buf })
            end,
            { buffer = e.buf }
        )
    end
})


