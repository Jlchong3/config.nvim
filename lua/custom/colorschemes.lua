-- Colorscheme
return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        config = function ()
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

        end
    },
    {
        "ellisonleao/gruvbox.nvim",
        event = 'VeryLazy',
        config = function ()
            require('gruvbox').setup {
                ---@diagnostic disable-next-line: missing-fields
                italic = {
                    comments = false,
                    strings = false
                },
                transparent_mode = true,
            }
        end
    },
}
