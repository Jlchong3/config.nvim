local builtins = {
    'gzip',
    'zip',
    'zipPlugin',
    'tar',
    'tarPlugin',
    'getscript',
    'matchit',
    'getscriptPlugin',
    'vimball',
    'vimballPlugin',
    'netrw',
}

for _, plugin in ipairs(builtins) do
    vim.g['loaded_' .. plugin] = 1
end

require('options')
require('remaps')
require('autocmd')
