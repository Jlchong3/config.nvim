local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local JlchongGroup = augroup('Jlchong', {})

-- HighlightYank
autocmd('TextYankPost', {
    group = JlchongGroup,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Remove trailing spaces in save
autocmd('BufWritePre', {
    group = JlchongGroup,
    pattern = '*',
    command = [[%s/\s\+$//e]]
})


autocmd('BufEnter', {
    group = JlchongGroup,
    pattern = "*",
    callback = function()
        vim.opt.formatoptions:remove("o")
    end
})

-- Lsp keymaps on_attach
autocmd('LspAttach', {
    group = JlchongGroup,
    callback = function(e)
        local nmap = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = e.buf, desc = desc })
        end
        local builtin = require('telescope.builtin')

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
        nmap('gr', builtin.lsp_references, '[G]oto [R]eferences')
        nmap('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
        nmap('<leader>T', builtin.lsp_type_definitions, '[T]ype Definition')
        nmap('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('H', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(e.buf, 'Format', function(_)
            vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
    end
})

-- Terminal buffer settings
augroup('TerminalGroup', {})
autocmd('TermOpen', {
    group = 'TerminalGroup',
    callback = function ()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.scrolloff = 0

        vim.bo.filetype = 'terminal'
    end
})
