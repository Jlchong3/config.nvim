vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set highlight on search
vim.o.hlsearch = true

-- Don't show mode since it is in statusline
vim.o.showmode = false

-- Make line numbers default
vim.wo.number = true
vim.o.rnu = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Lines from cursor to end of screen
vim.o.scrolloff = 8

-- Include in filename
vim.opt.isfname:append('@-@')

--How split works
vim.o.splitright = true
vim.o.splitbelow = true

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

vim.o.list = true
vim.opt.listchars = { tab = '  ', trail = '·' }

-- Enable break indent
vim.o.breakindent = true

-- Disable wrap
vim.o.wrap = false

-- Fat Cursor
vim.o.guicursor = ''

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

