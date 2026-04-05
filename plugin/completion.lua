vim.pack.add {
    'https://github.com/rafamadriz/friendly-snippets'
}

MiniIcons.tweak_lsp_kind()

local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
local process_items = function(items, base)
    return MiniCompletion.default_process_items(items, base, process_items_opts)
end

require('mini.completion').setup({
    lsp_completion = {
        source_func = 'omnifunc',
        process_items = process_items,
    },
})

local latex_patterns = { 'latex/**/*.json', '**/latex.json' }
local lang_patterns = {
    tex = latex_patterns,
    plaintex = latex_patterns,
    markdown_inline = { 'markdown.json' },
}

local snippets = require('mini.snippets')
snippets.setup({
    snippets = {
        snippets.gen_loader.from_lang({ lang_patterns = lang_patterns }),
    },
})
snippets.start_lsp_server()

