local actions = require 'telescope.actions'
require('telescope').setup {
    defaults = {
        path_display = { 'truncate' },
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
    },
    pickers = {
        buffers = {
            mappings = {
                i = {
                    ['<C-d>'] = actions.delete_buffer
                },
                n = {
                    ['<leader>bd'] = actions.delete_buffer
                }
            }
        }
    },
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_cursor{},
        },
    }
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension,'fzf')
pcall(require('telescope').load_extension,'ui-select')

-- Mappings for telescope
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Recently opened files' })
vim.keymap.set('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 0,
        previewer = false,
    })
end, { desc = '[/] Fuzzy Search in buffer' })

vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect telescope' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })

vim.keymap.set('n', '<leader>.', function()
    builtin.find_files({ cwd = require('telescope.utils').buffer_dir() })
end, { desc = '[.] Directory Files'})

vim.keymap.set('n', '<leader>s/', function()
    builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'live grep in open files',
    }
end, { desc = '[S]earch [/] in open files' })

vim.keymap.set('n', '<leader>sl', function ()
    for _, client in ipairs(vim.lsp.get_clients()) do
        print(vim.inspect(client.config.filetypes))
    end
end, { desc = '[S]earch [L]SP Supported'})

vim.keymap.set('n', '<leader>sl', function ()
    local filetypes = {}
    for _, client in ipairs(vim.lsp.get_clients()) do
        if client.name == 'jdtls' then
            filetypes['java'] = true
        else
            for _, ft in ipairs(client.config.filetypes or {}) do
                filetypes[ft] = true
            end
        end
    end

    local output = vim.fn.systemlist('rg --files')

    local unique_extensions = {}
    local filtered_extensions = {}
    for _, file in ipairs(output) do
        local extension = file:match("%.([^.]+)$")
        if extension and not unique_extensions[extension] then
            unique_extensions[extension] = true
            local filetype = vim.filetype.match({ filename = '*.' .. extension })
            if filetype and filetypes[filetype] then
                table.insert(filtered_extensions, extension)
            end
        end
    end

    local glob_flags = {}
    for _, ext in ipairs(filtered_extensions) do
        table.insert(glob_flags, '--glob=*.' .. ext)
    end

    require('telescope.builtin').find_files{
        prompt_title = 'LSP Supported Files',
        find_command = vim.list_extend({'rg', '--files'}, glob_flags)}

end, { desc = '[S]earch [L]SP Supported'})
