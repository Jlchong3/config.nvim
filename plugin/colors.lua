vim.cmd.colorscheme 'retrobox'

vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#7c6f64" })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#7c6f64" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#CcBfB4", bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeNormal',  { fg = '#504945', bg = '#83a598', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeInsert',  { fg = '#1e1e1e', bg = '#b8bb26', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeVisual',  { fg = '#1e1e1e', bg = '#d3869b', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeCommand', { fg = '#1e1e1e', bg = '#ffa500', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeReplace', { fg = '#1e1e1e', bg = '#ff0000', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeOther',   { fg = '#1e1e1e', bg = '#fe8019', bold = true })

