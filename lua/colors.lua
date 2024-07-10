--additional config of colorscheme
require('catppuccin').setup({
    flavour = 'mocha',
    transparent_background = true,
    integrations = {
        telescope = {
            enabled = true,
            style = 'nvchad'
        },
    },
    no_italic = true;
})

--Set colorscheme
vim.cmd.colorscheme 'catppuccin'

--Change color in lineNumbers
vim.api.nvim_set_hl(0, 'LineNr', { fg='#D0F6FF', bold=true })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#77D5EA', bold=true })
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#77D5EA', bold=true })

--Change color of Visual Highlight
vim.api.nvim_set_hl(0, 'Visual', { bg='#1684AF', bold=true })

--Change colors of statusline
vim.api.nvim_set_hl(0, 'MiniStatuslineFilename', {fg='#8facf1', bold=true})
vim.api.nvim_set_hl(0, 'MiniStatuslineInactive', {fg='#425c88', bold=true})
vim.api.nvim_set_hl(0, 'MiniStatuslineFileInfo', {bold=true})
vim.api.nvim_set_hl(0, 'MiniStatuslineDevInfo', {bold=true})

--Change color of MultiCursor
vim.api.nvim_set_hl(0, 'VM_MONO', {link='Cursor'})
vim.api.nvim_set_hl(0, 'VM_Extend', {link='Visual'})
vim.api.nvim_set_hl(0, 'VM_Cursor', {link='Cursor'})
vim.api.nvim_set_hl(0, 'VM_Insert', {link='Cursor'})

--Create a hl for the indentation lines
vim.api.nvim_set_hl(0, 'RainbowLightBlue', { fg='#254a6a'})

--Highlight for whitespace
vim.api.nvim_set_hl(0, 'Whitespace', {link='Comment'})

--Change vim-Illuminate Highlight
vim.api.nvim_set_hl(0, 'IlluminatedWordText', {bg='#434763'})
vim.api.nvim_set_hl(0, 'IlluminatedWordRead', {bg='#434763'})
vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', {bg='#434763'})

--Highlight for InlayHints
vim.api.nvim_set_hl(0, 'LspInlayHint', {fg='#638198'})

