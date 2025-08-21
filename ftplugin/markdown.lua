vim.opt_local.wrap = true
vim.opt_local.linebreak = true

vim.keymap.set('n', '<leader>ch', function ()
    local current_line = vim.api.nvim_get_current_line();

    if current_line:match('^%s*$') then
        return
    end

    local non_blank = current_line:match('^%s*'):len() + 1
    local sub_string = current_line:sub(non_blank, non_blank + 4)
    local row, _ = unpack(vim.api.nvim_win_get_cursor(0));
    if sub_string == '- [ ]' then
        vim.api.nvim_buf_set_text(0, row - 1, non_blank + 2, row - 1, non_blank + 3, {'x'});
    elseif sub_string == '- [x]' then
        vim.api.nvim_buf_set_text(0, row - 1, non_blank + 2, row - 1, non_blank + 3, {' '});
    else
        vim.api.nvim_buf_set_text(0, row - 1, non_blank - 1, row - 1, non_blank - 1, {'- [ ] '});
    end
end, { buffer = true, desc = '[CH]eck box' })

vim.keymap.set('v', '<leader>ch', function ()
    vim.api.nvim_feedkeys('\027', 'xt', false)
    local start_line, _ = unpack(vim.api.nvim_buf_get_mark(0, '<'))
    local end_line, _ = unpack(vim.api.nvim_buf_get_mark(0, '>'))
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local non_checkbox_lines = {}
    local unchecked_checkbox_lines = {}

    for i = 1, #lines do
        local non_blank = lines[i]:match('^%s*'):len() + 1
        local sub_string = lines[i]:sub(non_blank, non_blank + 4)
        local non_checkbox = sub_string ~= '- [ ]' and sub_string ~= '- [x]'
        local is_empty = sub_string:match('^%s*$')
        if non_checkbox and not is_empty then
            non_checkbox_lines[i] = non_blank
        elseif sub_string == '- [ ]' then
            unchecked_checkbox_lines[i] = non_blank
        end
    end

    if vim.tbl_count(non_checkbox_lines)~= 0 then
        for ind, non_blank in pairs(non_checkbox_lines) do
            local row = start_line + ind - 1
            vim.api.nvim_buf_set_text(0, row - 1, non_blank - 1, row - 1, non_blank - 1, {'- [ ] '});
        end
    elseif vim.tbl_count(unchecked_checkbox_lines) == 0 then
        for i = 1, #lines do
            lines[i] = lines[i]:gsub('- %[x%]', '- [ ]', 1)
        end
        vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
    else
        for ind, non_blank in pairs(unchecked_checkbox_lines) do
            local row = start_line + ind - 1
            vim.api.nvim_buf_set_text(0, row - 1, non_blank + 2, row - 1, non_blank + 3, {'x'});
        end
    end
end, { buffer = true, desc = '[CH]eck box' })
