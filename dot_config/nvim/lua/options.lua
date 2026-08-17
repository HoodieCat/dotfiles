vim.loader.enable()
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
local o = vim.o
o.number = true
o.relativenumber = true
o.numberwidth=2
o.wrap = false
o.breakindent = true
o.undofile = true
o.undolevels = 10000
o.mouse = a
o.ignorecase = true
o.smartcase = true
o.signcolumn = 'yes'
o.showmode = false
o.updatetime = 200
o.timeoutlen = 500
o.splitright = true
o.splitbelow = true
o.cursorline = true
o.scrolloff = 10
o.list = true
o.wildignorecase = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.termguicolors = true
vim.opt.iskeyword:append({'-'})
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.clipboard:append {"unnamedplus"}
vim.opt.fillchars = { eob =' '}
vim.opt.shortmess:append{ W= true, I = true }
o.inccommand = 'split'
o.confirm = true
