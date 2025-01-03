---@diagnostic disable: missing-fields
-- Fuzzy finder for various things
return {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function() return vim.fn.executable 'make' == 1 end
        },
        'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function ()
        local actions = require 'telescope.actions'
        require('telescope').setup {
            defaults = {
                path_display = { truncate = 1 },
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                        ['<C-s>'] = require('telescope.actions').select_horizontal,
                        ['<C-x>'] = false
                    },
                    n = {
                        ['<C-s>'] = require('telescope.actions').select_horizontal,
                    }
                },
                layout_config = { prompt_position = 'top' },
                sorting_strategy = 'ascending'
            },
            pickers = {
                buffers = {
                    mappings = {
                        i = {
                            ['<C-d>'] = actions.delete_buffer
                        },
                        n = {
                            ['bd'] = actions.delete_buffer
                        }
                    }
                }
            },
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_cursor{},
                },
                fzf = {}
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
            local filetypes = {}
            for _, client in ipairs(vim.lsp.get_clients()) do
                ---@diagnostic disable-next-line: undefined-field
                for _, ft in ipairs(client.config.filetypes or {}) do
                    filetypes[ft] = true
                end
            end

            local extensions = {}
            for _, file in ipairs(vim.fn.systemlist('rg --files')) do
                local extension = file:match("%.([^.]+)$")
                if extension and not extensions[extension] then
                    extensions[extension] = true
                end
            end

            local glob_flags = {}
            for extension, _ in pairs(extensions) do
                local filetype = vim.filetype.match{ filename = '*.' .. extension}
                if filetype and filetypes[filetype] then
                    table.insert(glob_flags, '--glob=*.' .. extension)
                end
            end

            require('telescope.builtin').find_files{
                prompt_title = 'LSP Supported Files',
                find_command = vim.list_extend({'rg', '--files'}, glob_flags)}

        end, { desc = '[S]earch [L]SP Supported'})
    end
}
