vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.netrw_bufsettings = 'nu rn'

-- Set highlight on search
vim.o.hlsearch = true

-- Don't show mode since it is in statusline
vim.o.showmode = false

-- Make line numbers default
vim.wo.number = true
vim.o.rnu = true

-- Enable mouse mode
vim.o.mouse = ''

-- Lines from cursor to end of screen
vim.o.scrolloff = 6

-- Include in filename
vim.opt.isfname:append('@-@')

--How split works
vim.o.splitright = true
vim.o.splitbelow = true

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

vim.o.list = true
vim.opt.listchars = {
    -- eol = "↴",
    tab = "» ",
    trail = '·'
}

-- Enable break indent
vim.o.breakindent = true

-- Disable wrap
vim.o.wrap = false

-- Fat Cursor
vim.o.guicursor = 'i-c-ci-cr-r:blinkon1'

-- Save undo history
vim.o.swapfile = false
vim.o.backup = false
vim.opt.undodir = os.getenv("HOME") .. '/.vimfiles/undodir'
vim.o.undofile = true

-- Shift and Tab config
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.conceallevel = 1

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true

function MyTabline()
    local s = ''
    local tab_count = vim.fn.tabpagenr('$')

    for i = 1, tab_count do
        if i == vim.fn.tabpagenr() then
            s = s .. '%#TabLineSel#'
        else
            s = s .. '%#TabLine#'
        end

        s = s .. '%' .. i .. 'T' .. i .. ' ' .. vim.fn.fnamemodify(vim.fn.bufname(vim.fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)]), ':t')

        if i ~= tab_count then
            s = s .. '%#TabLineFill# | '
        end
    end

    return s
end

vim.o.tabline = '%!v:lua.MyTabline()'
