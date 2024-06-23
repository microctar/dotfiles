vim.opt.clipboard:append { 'unnamedplus' }
if vim.fn.executable('pwsh') == 1 then
  vim.opt.shell = 'pwsh'
  vim.opt.shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -NoProfile -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSStyle.OutputRendering = [System.Management.Automation.OutputRendering]::PlainText;'
  vim.opt.shellquote=""
  vim.opt.shellxquote=""
elseif vim.fn.executable('powershell') == 1 then
  vim.opt.shell = 'powershell'
  vim.opt.shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -NoProfile -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();'
  vim.opt.shellquote=""
  vim.opt.shellxquote=""
else
  vim.opt.shell = 'cmd'
end
