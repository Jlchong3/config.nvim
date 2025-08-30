require('mini.files').setup {}

local show_dotfiles = true

local filter_show = function(fs_entry) return true end

local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, '.')
end

local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles
    local new_filter = show_dotfiles and filter_show or filter_hide
    MiniFiles.refresh({ content = { filter = new_filter } })
end

vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
        local buf_id = args.data.buf_id
        vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
    end,
})

-- Set focused directory as current working directory
local set_cwd = function()
    local path = (MiniFiles.get_fs_entry() or {}).path
    if path == nil then return vim.notify('Cursor is not on valid entry') end
    vim.fn.chdir(vim.fs.dirname(path))
end

-- Yank in register full path of entry under cursor
local yank_path = function()
    local path = (MiniFiles.get_fs_entry() or {}).path
    if path == nil then return vim.notify('Cursor is not on valid entry') end
    vim.fn.setreg(vim.v.register, path)
end

-- Open path with system default handler (useful for non-text files)
local ui_open = function() vim.ui.open(MiniFiles.get_fs_entry().path) end

vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
        local b = args.data.buf_id
        vim.keymap.set('n', 's.', set_cwd,   { buffer = b, desc = 'Set cwd' })
        vim.keymap.set('n', 'gX', ui_open,   { buffer = b, desc = 'OS open' })
        vim.keymap.set('n', 'gy', yank_path, { buffer = b, desc = 'Yank path' })
    end,
})

vim.keymap.set('n', '<leader>fe', function() MiniFiles.open() end, { desc = '[F]ile [E]xplorer' } )

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesActionRename",
  callback = function(event)
    Snacks.rename.on_rename_file(event.data.from, event.data.to)
  end,
})
