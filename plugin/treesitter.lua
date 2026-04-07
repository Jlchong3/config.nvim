local is_nixos = vim.fn.executable("nixos-rebuild") == 1

if not is_nixos then
    vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter' }
end

vim.pack.add {
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
    'asm',
    'c_sharp',
    'dockerfile',
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
}

if not is_nixos then
    require('nvim-treesitter').install(parsers);
end

require('treesitter-context').setup {
    enable = true,
    max_lines = 3,
}
require('nvim-ts-autotag').setup {}

local TSGroup = vim.api.nvim_create_augroup('TSGroup', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
    group = TSGroup,
    callback = function(args)
        if not vim.treesitter.highlighter.active[args.buf] then
            pcall(vim.treesitter.start, args.buf)
        end
    end
})

if not is_nixos then
    vim.api.nvim_create_autocmd('PackChanged', {
        group = TSGroup,
        callback = function(event)
            if event.data.spec.name == 'nvim-treesitter' then
                vim.cmd('TSUpdate')
            end
        end
    })
end
