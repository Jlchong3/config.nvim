--additional config of colorscheme
require('catppuccin').setup {
    flavour = 'mocha',
    transparent_background = true,
    integrations = {
        telescope = {
            enabled = true,
            style = 'nvchad'
        },
    },
    styles = {
        comments = {},
        conditionals = {}
    },
    custom_highlights = function (_)
        return {
            LineNrAbove = { fg = '#77D5EA' },
            LineNr = { fg = '#D0F6FF' },
            LineNrBelow = { fg = '#77D5EA' },

            Visual = { bg = '#1684AF' },

            Whitespace = { link = 'Comment' },

            LspInlayHint = { fg = '#638198' }
        }
    end
}

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

