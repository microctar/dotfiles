require('microctar.base')
require('microctar.highlights')
require('microctar.maps')
require('microctar.plugins')

local has = vim.fn.has
local is_bsd = has("bsd") == 1
local is_mac = has("macunix") == 1
local is_linux = has("linux") == 1
local is_windows = has("windows") == 1

if is_bsd then
  require('microctar.platform.bsd')
elseif is_mac then
  require('microctar.platform.macos')
elseif is_linux then
  require('microctar.platform.linux')
elseif is_windows then
  require('microctar.platform.windows')
end

vim.api.nvim_create_user_command('Busybox', function(args)
  require("microctar.busybox.command").load_command(args.fargs[1], vim.list_slice(args.fargs, 2))
end, {
  range = true,
  nargs = '+',
  complete = function(arg)
    local list = require("microctar.busybox.command").command_list()
    return vim.tbl_filter(function(s)
      return string.match(s, '^' .. arg)
    end, list)
  end,
})
