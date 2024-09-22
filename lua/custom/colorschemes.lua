-- Colorscheme
return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        event = 'VeryLazy',
        opts = {
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

                    LspInlayHint = { fg = '#638198' },
                    MiniStatuslineFilename = { fg = '#8facf1', bg = 'none' },
                    MiniStatuslineInactive = { fg = '#425c88', bg = 'none' },
                    PmenuSel = { bg = '#2a2b3c' },
                    Pmenu = { bg = '#353e5a'}
                    TabLineSel = { bg = 'none', fg = '#89b4fa' },
                    TabLine = { bg = 'none' },
                    TabLineFill = { bg = 'none', fg = '#7f849c'}
                }
            end
        }
    },
    {
        'ellisonleao/gruvbox.nvim',
        priority = 1000,
        opts = {
            underline = true,
            undercurl = false,
            italic = {
                strings = false
            },
            transparent_mode = true,
            overrides = {
                Function = { fg = '#458588' },
                LineNrAbove = { fg = '#928374' },
                LineNr = { fg = '#d2c3b4' },
                LineNrBelow = { fg = '#928374' },
                GruvboxRedUnderline = { underline = true },
                GruvboxGreenUnderline = { underline = true },
                GruvboxYellowUnderline = { underline = true },
                GruvboxBlueUnderline = { underline = true },
                GruvboxPurpleUnderline = { underline = true },
                GruvboxAquaUnderline = { underline = true },
                GruvboxOrangeUnderline = { underline = true },
                TreesitterContextBottom =  { underline = true, sp = '#d2c3b4' },
                MiniStatuslineFilename = { fg = '#bea784' },
                MiniStatuslineInactive = { fg = '#96865d' },
                PmenuSel = { bg = '#464240', fg = '#96865d'}
                TabLineSel = { bg = 'none' },
                TabLine = { bg = 'none' },
                TabLineFill = { bg = 'none', fg = '#fe8019'}
            }
        }
    },
}
