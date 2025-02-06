return {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    keys = {
        { '<leader>fe', '<cmd>Yazi<cr>', desc = '[F]ile [E]xplorer', },
        { '<leader>fc', '<cmd>Yazi cwd<cr>', desc = '[F]ile Explorer [C]wd', },
        { '<leader>fr', '<cmd>Yazi toggle<cr>', desc = '[F]ile Explorer [R]esume', },
    },
    opts = {
        open_for_directories = false,
        keymaps = {
            open_file_in_vertical_split = false,
        },
    },
}
