local keymap = vim.keymap

keymap.set('n', 'x', '"_x')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- New tab
keymap.set('n', 'te', ':tabedit')

-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')

-- Move window
keymap.set('n', '<Space>', '<C-w>w')
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')

opts = {silent = true}
-- Terminal
keymap.set('t', '<Esc>', '<C-\\><C-N>')
keymap.set('n', 'st', ':split<Return><C-W>w:terminal<Return>:resize 10<Return>', opts)
keymap.set('n', 'zt', ':vsplit<Return><C-W>w:terminal<Return>:vertical resize 60<Return>', opts)


-- Terminal navigate
keymap.set('t', '<A-h>', '<C-\\><C-N><C-w>h')
keymap.set('t', '<A-j>', '<C-\\><C-N><C-w>j')
keymap.set('t', '<A-k>', '<C-\\><C-N><C-w>k')
keymap.set('t', '<A-l>', '<C-\\><C-N><C-w>l')

-- DAP
keymap.set('n', '<F5>', "<Cmd>lua require'dap'.continue()<CR>", opts)
keymap.set('n', '<F10>', "<Cmd>lua require'dap'.step_over()<CR>", opts)
keymap.set('n', '<F11>', "<Cmd>lua require'dap'.step_into()<CR>", opts)
keymap.set('n', '<F12>', "<Cmd>lua require'dap'.step_out()<CR>", opts)
keymap.set('n', '<Leader>b', "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap.set('n', '<Leader>B', "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap.set('n', '<Leader>lp', "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
keymap.set('n', '<Leader>dr', "<Cmd>lua require'dap'.repl.open()<CR>", opts)
keymap.set('n', '<Leader>dl', "<Cmd>lua require'dap'.run_last()<CR>", opts)

keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

keymap.set('n', '<Leader>dR', "<Cmd>lua require'dap'.run_to_cursor()<CR>")
keymap.set('n', '<Leader>dd', "<Cmd>lua require'dap'.disconnect()<CR>")
keymap.set('n', '<Leader>dg', "<Cmd>lua require'dap'.session()<CR>")

keymap.set('n', '<Leader>dE', "<Cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<CR>")
keymap.set('n', '<Leader>dU', "<Cmd>lua require'dapui'.toggle()<CR>")
keymap.set('n', '<Leader>de', "<Cmd>lua require'dapui'.eval()<CR>")
