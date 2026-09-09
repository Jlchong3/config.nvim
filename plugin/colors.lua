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
    highlight_groups = {
        Visual = { bg = '#707295', inherit = false },
        MatchParen = { bg = '#707295', underline = true, inherit = false },
    }
}

vim.cmd.colorscheme 'rose-pine'

vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#8e8aa6' })
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#8e8aa6' })
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#bebad6', bold = true })

if vim.g.colors_name == 'default' then
    local special = vim.api.nvim_get_hl(0, { name = 'Special' })
    special.bold = true
    vim.api.nvim_set_hl(0, '@lsp.type.type.zig', special)
end
