--Set colorscheme
vim.cmd.colorscheme 'catppuccin'

local set_hl = function (name, val)
    vim.api.nvim_set_hl(0, name, val)
end

--Change colors of statusline gruvbox
set_hl('MiniStatuslineFileInfo', { bold = true })
set_hl('MiniStatuslineDevInfo', { bold = true })
set_hl('TreesitterContextBottom', { underline = false })
