vim.g.mapleader = " "

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.errorbells = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.cmdheight = 1

vim.opt.updatetime = 50

vim.opt.shortmess:append("c")

vim.opt.colorcolumn = "80"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.completeopt = "menuone,noinsert,noselect"

vim.opt.mouse = "a"

vim.g.netrw_banner = 0
