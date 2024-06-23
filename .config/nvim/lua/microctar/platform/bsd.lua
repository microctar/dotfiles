vim.opt.clipboard:append { 'unnamedplus' }
vim.opt.shell = 'fish' -- fish is a smart and user-friendly command line shell. official site: https://fishshell.com/
vim.opt.backupdir = os.getenv("HOME") .. "/nvim"
vim.opt.backupskip = { '/tmp/*' }
