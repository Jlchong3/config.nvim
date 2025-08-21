vim.pack.add {
    {
        src = 'https://github.com/catppuccin/nvim',
        name = 'catppuccin'
    }
}

require('catppuccin').setup {
    flavour = 'frappe',
    transparent_background = true,
    float = {
        transparent = true
    },
    integrations = {},
    styles = {
        comments = {},
        conditionals = {}
    },
    custom_highlights = function (_)
        return {
            LineNrAbove = { fg = '#b978b7' },
            LineNr = { fg = '#f8abf3' },
            LineNrBelow = { fg = '#b978b7' },
            Whitespace = { link = 'Comment' },
            FloatBorder = { fg = '#EFAAEB' },
            Visual = { bg = '#8f6892' },
            LspInlayHint = { fg = '#ae915f' },
            MiniStatuslineModeNormal = { fg = '#000000', bg = '#EBBCBA' },
            MiniStatuslineFilename = {  fg = '#EBBCBA', bg = 'none' },
            MiniStatuslineInactive = { fg = '#b67e7e', bg = 'none' },
            MiniStatuslineFileinfo = { bg = 'none' },
            MiniStatuslineDevinfo = { bg = 'none' },
            DapBreakpoint = { fg = '#993939', bg = '#2a2b3c'},
            DapLogPoint = { fg = '#61afef', bg = '#2a2b3c' },
            DapStopped = { fg = '#98c379', bg = '#2a2b3c' },
            PmenuSel = { bg = '#2a2b3c' },
            Pmenu = { bg = '#353e5a'},
            TabLineSel = { bg = 'none', fg = '#89b4fa' },
            TabLine = { bg = 'none' },
            TabLineFill = { bg = 'none', fg = '#7f849c'}
        }
    end
}

vim.cmd.colorscheme 'catppuccin'
