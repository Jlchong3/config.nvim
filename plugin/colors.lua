vim.pack.add({
    {
        src = "https://github.com/rose-pine/neovim",
        name = "rose-pine",
    }
})
require("rose-pine").setup {
    dark_variant = "moon",
    styles = {
        italic = false,
    },
}
vim.cmd.colorscheme 'rose-pine'

vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#8e8aa6' })
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#8e8aa6' })
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#bebad6', bold = true })
vim.api.nvim_set_hl(0, 'Visual', { bg = '#707295' })
vim.api.nvim_set_hl(0, 'MatchParen', { bg = '#707295', underline = true })
