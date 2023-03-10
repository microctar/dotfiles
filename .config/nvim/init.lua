require('microctar.base')
require('microctar.highlights')
require('microctar.maps')
require('microctar.plugins')

local has = vim.fn.has
local is_bsd = has "bsd"
local is_mac = has "macunix"
local is_linux = has "linux"

if is_bsd then
  require('microctar.platform.bsd')
elseif is_mac then
  require('microctar.platform.macos')
elseif is_linux then
  require('microctar.platform.linux')
end
