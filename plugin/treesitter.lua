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
    c = { "*.c", "*.h" },
    cpp = { "*.cpp", "*.hpp", "*.cc", "*.cxx", "*.hh", "*.hxx" },
    go = { "*.go" },
    lua = { "*.lua" },
    python = { "*.py", "*.pyw" },
    rust = { "*.rs" },
    tsx = { "*.tsx" },
    html = { "*.html", "htm" },
    css = { "*.css" },
    glsl = { "*.glsl", "*.vert", "*.frag", "*.geom" },
    json = { "*.json" },
    javascript = { "*.js", "*.mjs", "*.cjs" },
    java = { "*.java" },
    zig = { "*.zig" },
    yuck = { "*.yuck" },
    typescript = { "*.ts" },
    nix = { "*.nix" },
    vimdoc = { "*.txt" },  -- Neovim help docs
    vim = { "*.vim" },
    bash = { "*.sh", "*.bash" },
    sql = { "*.sql" },
    markdown = { "*.md", "*.markdown" },
    markdown_inline = { "*.md", "*.markdown" }, -- same extensions
    yaml = { "*.yaml", "*.yml" },
    odin = { "*.odin" },
}

require('nvim-treesitter').install(vim.tbl_keys(parsers));
require('treesitter-context').setup { enable = true, }
require('nvim-ts-autotag').setup {}


local all_exts = {}
for _, exts in pairs(parsers) do
  for _, ext in ipairs(exts) do
    table.insert(all_exts, ext)
  end
end

vim.api.nvim_create_augroup('TSGroup', {})
vim.api.nvim_create_autocmd('BufEnter', {
    group = 'TSGroup',
    callback = function(e)
        local ft = vim.bo[e.buf].filetype

        if parsers[ft] then
            pcall(vim.treesitter.start, e.buf)
            return
        end

        -- fallback: check filename against patterns
        local name = vim.api.nvim_buf_get_name(e.buf)
        for _, pattern in ipairs(all_exts) do
            if name:match(pattern:gsub("%*", ".*")) then
                pcall(vim.treesitter.start, e.buf)
                return
            end
        end
    end
})
