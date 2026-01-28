local JlchongGroup = vim.api.nvim_create_augroup('Jlchong', {})

-- HighlightYank
vim.api.nvim_create_autocmd('TextYankPost', {
    group = JlchongGroup,
    callback = function()
        vim.hl.on_yank()
    end
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
    group = JlchongGroup,
    callback = function()
        local pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd([[%s/\s\+$//e]])
        vim.api.nvim_win_set_cursor(0, pos)
    end
})

-- No comment when 'o' pressed
vim.api.nvim_create_autocmd('BufEnter', {
    group = JlchongGroup,
    callback = function()
        vim.opt.formatoptions:remove('o')
    end
})

-- Sync terminal background color
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
    callback = function()
        local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        if not normal.bg then return end

        io.write(string.format("\027]11;#%06x\027\\", normal.bg))
    end
})

vim.api.nvim_create_autocmd({ "UILeave" }, {
    callback = function()
        io.write("\027]111\027\\")
    end
})
