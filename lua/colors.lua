--Set colorscheme
vim.cmd.colorscheme 'catppuccin'

local set_hl = function (name, val)
    vim.api.nvim_set_hl(0, name, val)
end

--Change colors of statusline
set_hl('MiniStatuslineFilename', { fg='#8facf1', bold=true })
set_hl('MiniStatuslineInactive', { fg='#425c88', bold=true })
set_hl('MiniStatuslineFileInfo', { bold = true })
set_hl('MiniStatuslineDevInfo', { bold = true })

