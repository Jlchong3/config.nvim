-- Surrounding options for text('',"",(),{},[],<>,<p></p>)
return {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    opts = {
        keymaps = {
                normal = 'sa',
                normal_cur = 'ss',
                normal_line = 'S',
                normal_cur_line = 'SS',
                visual = 'sa',
                visual_line = 'S',
                delete = 'sd',
                change = 'sc',
                change_line = 'Sc',
        }
    }
}
