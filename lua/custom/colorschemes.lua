-- Colorscheme
return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        opts = {
            flavour = 'mocha',
            transparent_background = true,
            integrations = {
                telescope = {
                    enabled = true,
                },
            },
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
                    PmenuSel = { bg = '#2a2b3c' },
                    Pmenu = { bg = '#353e5a'},
                    TabLineSel = { bg = 'none', fg = '#89b4fa' },
                    TabLine = { bg = 'none' },
                    TabLineFill = { bg = 'none', fg = '#7f849c'}
                }
            end
        }
    },
    {
        'ellisonleao/gruvbox.nvim',
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
                TreesitterContextLineNumber = { fg = '#fe8019' },
                MiniStatuslineFilename = { fg = '#bea784' },
                MiniStatuslineInactive = { fg = '#96865d' },
                LspInlayHint = { fg = '#ae915f' },
                PmenuSel = { bg = '#3c3836', fg = '#faf4da'},
                TabLineSel = { bg = 'none' },
                TabLine = { bg = 'none' },
                TabLineFill = { bg = 'none', fg = '#fe8019'},
                ['@markup.strong'] = { link = 'markdownBold' },
                ['@markup.heading.1'] = { link = 'markdownH1' },
                ['@markup.heading.2'] = { link = 'markdownH2' },
                ['@markup.heading.3'] = { link = 'markdownH3' },
                ['@markup.heading.4'] = { link = 'markdownH4' },
                ['@markup.heading.5'] = { link = 'markdownH5' },
                ['@markup.heading.6'] = { link = 'markdownH6' },
            }
        }
    },
}

