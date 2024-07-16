local command = {}

local subcommands = {
  convert_guid_to_cstruct = function()
    local guid = require('microctar.busybox.applets.guid'):new(vim.fn.getreg('"'))
    if guid ~= nil then
      vim.fn.setreg('"', guid:to_cstruct())
    else
      print('invaild guid')
      return
    end
  end,
  get_dmi = function()
    local dmi_info = require('microctar.busybox.applets.dmi')
    local reception = require('microctar.utils.reception'):new({text = dmi_info})
    reception:render()
  end,
}

function command.command_list()
  return vim.tbl_keys(subcommands)
end

function command.load_command(cmd, arg)
  subcommands[cmd](arg)
end

return command
