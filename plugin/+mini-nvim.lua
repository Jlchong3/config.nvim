vim.pack.add {
    'https://github.com/echasnovski/mini.nvim',
}

require('mini.statusline').setup {}

require('mini.extra').setup {}

require('mini.splitjoin').setup { mappings = { toggle = 'gl' } }

require('mini.operators').setup {
    replace = { prefix = 's' },
    sort = { prefix = nil }
}
vim.keymap.set('n', 'S', 's$', { remap = true })

require('mini.icons').setup {
    lsp = {
        snippet = { glyph = '', hl = 'MiniIconsGreen'  },
        ['function'] = { glyph = '󰊕', hl = 'MiniIconsAzure'  },
        keyword = { glyph = '󰌋', hl = 'MiniIconsCyan'   },
        constant = { glyph = '󰏿', hl = 'MiniIconsOrange' },
    },
}

require('mini.diff').setup {
    view = {
        style = 'sign',
        signs = { add = '+', change = '~', delete = '–' },
    },
}
vim.keymap.set('n', 'ghy', function() return MiniDiff.operator('yank') .. 'gh' end, { expr = true, remap = true } )
vim.keymap.set('n', '<leader>hp', function() MiniDiff.toggle_overlay(0) end, { desc = '[H]unk [P]review' } )

require('mini.surround').setup {
    mappings = {
        add = 'gs',
        delete = 'ds',
        find = '',
        find_left = '',
        highlight = '',
        replace = 'cs',
        update_n_lines = '',

    },
    n_lines = 20,
    search_method = 'cover_or_next',
    respect_selection_type = true,
}
