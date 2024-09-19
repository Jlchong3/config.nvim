require'options'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

--this is the setup coming with kickstart
require('lazy').setup({ import = 'custom' }, {
    change_detection = { notify = false },
    performance = {
        rtp = {
            disabled_plugins = {
                'gzip', 'tarPlugin', 'tutor', 'zipPlugin', 'tohtml',
            }
        }
    }
})

require'remaps'
require'colors'
require'autocmd'
