local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local JlchongGroup = augroup('Jlchong', {})

-- HighlightYank
autocmd('TextYankPost', {
    group = JlchongGroup,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Remove trailing spaces in save
autocmd('BufWritePre', {
    group = JlchongGroup,
    pattern = '*',
    command = [[%s/\s\+$//e]]
})


autocmd('BufEnter', {
    group = JlchongGroup,
    pattern = "*",
    callback = function()
        vim.opt.formatoptions:remove("o")
    end
})

-- Terminal buffer settings
augroup('TerminalGroup', {})
autocmd('TermOpen', {
    group = 'TerminalGroup',
    callback = function ()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.scrolloff = 0
    end
})
