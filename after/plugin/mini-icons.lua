require('mini.icons').setup {
    lsp = {
        snippet = { glyph = '', hl = 'MiniIconsGreen'  },
        ['function'] = { glyph = '󰊕', hl = 'MiniIconsAzure'  },
        keyword = { glyph = '󰌋', hl = 'MiniIconsCyan'   },
        constant = { glyph = '󰏿', hl = 'MiniIconsOrange' },
    },
}

MiniIcons.mock_nvim_web_devicons()
