local system = require('microctar.utils.system')
local M = {}
local dmi_cmd = {}

M.system_product_manufacturer = ''
M.system_product_name = ''
M.system_family = ''
M.system_sku_number = ''

M.baseboard_manufacturer = ''
M.baseboard_product = ''

M.system_enclosure = ''

dmi_cmd.executor = ''

if system.is_windows then

  dmi_cmd.executor = (vim.fn.executable('pwsh') == 1) and 'pwsh' or 'powershell'

  dmi_cmd.args = {
      system_product_manufacturer = '-NoProfile -Command "Get-WmiObject Win32_ComputerSystemProduct | Select-Object -ExpandProperty Vendor"',
      system_product_name = '-NoProfile -Command "Get-WmiObject Win32_ComputerSystemProduct | Select-Object -ExpandProperty Name"',
      system_family = '-NoProfile -Command "Get-WmiObject Win32_ComputerSystem | Select-Object -ExpandProperty SystemFamily"',
      system_sku_number = '-NoProfile -Command "Get-WmiObject Win32_ComputerSystem | Select-Object -ExpandProperty SystemSKUNumber"',

      baseboard_manufacturer = '-NoProfile -Command "Get-WmiObject Win32_BaseBoard | Select-Object -ExpandProperty Manufacturer"',
      baseboard_product = '-NoProfile -Command "Get-WmiObject Win32_BaseBoard | Select-Object -ExpandProperty Product"',

      system_enclosure = '-NoProfile -Command "Get-WmiObject Win32_SystemEnclosure | Select-Object -ExpandProperty Manufacturer"',
  }
  
end

local function runner(cmd)
  if system.is_windows then
    local handler = io.popen(cmd)
    local info = handler:read('*a')
    handler:close()

    return info:gsub('[\r\n ]', '')
  end
end

-- update dmi information

local co = coroutine.create(function()
    for metier, arg in pairs(dmi_cmd.args) do
      M[metier] = runner(dmi_cmd.executor .. " " .. arg)
    end
end)

coroutine.resume(co)

return M
