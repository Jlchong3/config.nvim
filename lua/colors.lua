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

local set_hl = function (name, val)
    vim.api.nvim_set_hl(0, name, val)
end

--Change color in lineNumbers
set_hl('LineNr', { fg='#D0F6FF', bold=true })
set_hl('LineNrBelow', { fg='#77D5EA', bold=true })
set_hl('LineNrAbove', { fg='#77D5EA', bold=true })

--Change color of Visual Highlight
set_hl('Visual', { bg='#1684AF', bold=true })

--Change colors of statusline
set_hl('MiniStatuslineFilename', {fg='#8facf1', bold=true})
set_hl('MiniStatuslineInactive', {fg='#425c88', bold=true})
set_hl('MiniStatuslineFileInfo', {bold=true})
set_hl('MiniStatuslineDevInfo', {bold=true})

--Create a hl for the indentation lines
set_hl('RainbowLightBlue', { fg='#254a6a'})

--Highlight for whitespace
set_hl('Whitespace', {link='Comment'})

--Change vim-Illuminate Highlight
set_hl('IlluminatedWordText', {bg='#434763'})
set_hl('IlluminatedWordRead', {bg='#434763'})
set_hl('IlluminatedWordWrite', {bg='#434763'})

--Highlight for InlayHints
set_hl('LspInlayHint', {fg='#638198'})

