-- Leader keys (must be set before loading lazy.nvim)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.winborder = "rounded"
vim.opt.spell = true
vim.opt.spelllang = "en_us,ru"

-- Editing
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.exrc = true
vim.opt.wildmode = "longest,list,full"

-- Windows / splits
vim.opt.hidden = true
vim.opt.splitright = true

-- Shell
vim.opt.shell = "zsh -l"

-- Sessions
vim.o.sessionoptions =
    "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- netrw
vim.g.netrw_bufsettings = "rnu"
