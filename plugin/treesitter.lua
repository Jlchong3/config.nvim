vim.pack.add ({
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
    'https://github.com/windwp/nvim-ts-autotag',
    'https://github.com/nvim-treesitter/nvim-treesitter-context',
}, { load = true } )

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
    'asm',
    'yuck',
    'typescript',
    'nix',
    'vimdoc',
    'vim',
    'bash',
    'typst',
    'sql',
    'markdown',
    'markdown_inline',
    'yaml',
    'odin',
    'swift'
}

require('nvim-treesitter').install(parsers);
require('treesitter-context').setup {
    enable = true,
    max_lines = 3,
}
require('nvim-ts-autotag').setup {}

vim.api.nvim_create_augroup('TSGroup', {})
vim.api.nvim_create_autocmd('BufEnter', {
    group = 'TSGroup',
    callback = function()
        pcall(vim.treesitter.start)
    end
})
vim.api.nvim_create_autocmd('PackChanged', {
    group = 'TSGroup',
    callback = function(event)
        if event.data.spec.name == 'nvim-treesitter' then
            vim.cmd('TSUpdate')
        end
    end
})
