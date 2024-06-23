vim.cmd("autocmd!")

vim.wo.number = true -- show line number
vim.opt.termguicolors = true -- enable true color

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.title = true
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.smartindent = true

vim.opt.hlsearch = true
vim.opt.ignorecase = true -- \C is needed to force matching case for the whole pattern
vim.opt.cmdheight = 1
vim.opt.showcmd = true
vim.opt.inccommand = 'split'

vim.opt.backup = true

vim.opt.laststatus = 2 -- the last window always has a status line
vim.opt.scrolloff = 15
vim.opt.wrap = false -- don't wrap lines
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.backspace = { 'indent', 'eol', 'start' }

vim.opt.path:append { '**' } -- look up files recursively

-- undercurl settings
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.opt.formatoptions:append { 'r' } -- default: "tcqj"
