vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set highlight on search
vim.o.hlsearch = true

-- Don't show mode since it is in statusline
vim.opt.showmode = false

-- Make line numbers default
vim.wo.number = true
vim.opt.rnu = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Lines from cursor to end of screen
vim.opt.scrolloff = 8

-- Include in filename
vim.opt.isfname:append('@-@')

--How split works
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·' }

-- Enable break indent
vim.o.breakindent = true

-- Disable wrap
vim.opt.wrap = false

-- Fat Cursor
vim.opt.guicursor = ''

-- Save undo history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. '/.vimfiles/undodir'
vim.opt.undofile = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.conceallevel = 1

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

