vim.pack.add {
    {
        src = 'https://github.com/nvim-treesitter/nvim-treesitter',
        version = 'main'
    },
    {
        src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
        version = 'main'
    },
    'https://github.com/windwp/nvim-ts-autotag',
    'https://github.com/nvim-treesitter/nvim-treesitter-context',
}

local parsers = {
    'c',
    'cpp',
    'go',
    'lua',
    'python',
    'rust',
    'tsx',
    'html',
    'css',
    'glsl',
    'json',
    'javascript',
    'java',
    'zig',
    'yuck',
    'typescript',
    'nix',
    'vimdoc',
    'vim',
    'bash',
    'sql',
    'markdown',
    'markdown_inline',
    'yaml',
    'odin',
}

require('nvim-treesitter').install(vim.tbl_keys(parsers));
require('treesitter-context').setup { enable = true, }
require('nvim-ts-autotag').setup {}

vim.api.nvim_create_augroup('TSGroup', {})
vim.api.nvim_create_autocmd('BufEnter', {
    group = 'TSGroup',
    callback = function()
        pcall(vim.treesitter.start)
    end
})
