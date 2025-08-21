
local preview_files_and_images = function(buf_id, item)
    if Snacks.image.supports_file(item) then
        Snacks.image.buf.attach(buf_id, { src = item })
    else
        MiniPick.default_preview(buf_id, item)
    end
end

MiniPick.registry.registry = function()
    local selected = MiniPick.start( {
        source = { items = vim.tbl_keys(MiniPick.registry), name = 'Registry' }
    })

    if selected == nil then return end

    return MiniPick.registry[selected]()
end

MiniPick.registry.buffers = function(local_opts)
    local wipeout_cur = function()
        vim.api.nvim_buf_delete(MiniPick.get_picker_matches().current.bufnr, {})
        MiniPick.stop()
        MiniPick.registry.buffers();
    end
    local buffer_mappings = { wipeout = { char = '<C-d>', func = wipeout_cur } }
    MiniPick.builtin.buffers(local_opts, { mappings = buffer_mappings })
end

MiniPick.registry.current_dir_files = function()
    MiniPick.builtin.files(nil, {
        source = {
            cwd = vim.fn.expand('%:p:h'),
            preview = preview_files_and_images
        }
    })
end

MiniPick.registry.files = function()
    MiniPick.builtin.files(nil, {
        source = {
            preview = preview_files_and_images
        }
    })
end

vim.ui.select = MiniPick.ui_select

local builtin = MiniPick.builtin
local extra = MiniExtra.pickers
local registry = MiniPick.registry

vim.keymap.set('n', '<leader>sb', registry.buffers, { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>sf', registry.files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>.', registry.current_dir_files, { desc = '[.] Directory Files' })
vim.keymap.set('n', '<leader>ss', registry.registry, { desc = '[S]earch [S]upported Pickers' })

vim.keymap.set('n', '<leader>sh', builtin.help, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sg', builtin.grep_live, { desc = '[S]earch [G]rep' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })

vim.keymap.set('n', '<leader>sd', extra.diagnostic, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>gst', extra.git_files, { desc = '[G]it [S]earch [T]racked Files' })
vim.keymap.set('n', '<leader>gsm', function() extra.git_files{ scope = 'modified'} end, { desc = '[G]it [S]earch [M]odified Files' })
vim.keymap.set('n', '<leader>gsu', function() extra.git_files{ scope = 'untracked'} end, { desc = '[G]it [S]earch [U]ntracked Files' })
vim.keymap.set('n', '<leader>gsi', function() extra.git_files{ scope = 'ignored'} end, { desc = '[G]it [S]earch [I]gnored Files' })
vim.keymap.set('n', '<leader>gsh', extra.git_hunks, { desc = '[G]it [S]earch [H]unks}' })
vim.keymap.set('n', '<leader>/', function() extra.buf_lines({ scope = 'current' }) end, { desc = '[/] Fuzzy Search Buffer'})
vim.keymap.set('n', '<leader>s/', extra.buf_lines, { desc = '[S]earch [/] Open'})

