local actions = require 'telescope.actions'
require('telescope').setup {
    defaults = {
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
                    ['<C-d>'] = actions.delete_buffer + actions.move_to_top
                },
                n = {
                    ['<leader>bd'] = actions.delete_buffer + actions.move_to_top
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

vim.keymap.set('n', '<leader>s/', function()
    builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'live grep in open files',
    }
end, { desc = '[S]earch [/] in open files' })
