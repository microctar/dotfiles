local _M = {}

_M.Data1 = 0x00000000
_M.Data2 = 0x0000
_M.Data3 = 0x0000
_M.Data4 = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}

local mt = { __index = _M }

function _M.new(self, guid_str)
  if type(guid_str) ~= 'string' then
    return nil, "accept only string"
  end

  if string.len(guid_str) ~= 36 then
    return nil, "invalid guid"
  end

  local data1, data2, data3, data4p1, data4p2 = string.match(guid_str, "^([0-9A-Fa-f]+)-([0-9A-Fa-f]+)-([0-9A-Fa-f]+)-([0-9A-Fa-f]+)-([0-9A-Fa-f]+)$")

  if string.len(data1) ~= 8 or
      string.len(data2) ~= 4 or
      string.len(data3) ~= 4 or
      string.len(data4p1) ~= 4 or
      string.len(data4p2) ~= 12 then
    return nil, "invalid format"
  end

  self.Data1 = tonumber(data1, 16)
  self.Data2 = tonumber(data2, 16)
  self.Data3 = tonumber(data3, 16)
  local data4 = tonumber(data4p1, 16)

  self.Data4[1] = data4 / 0x100
  self.Data4[2] = data4 % 0x100

  data4 = tonumber(data4p2, 16)

  for offset = 8, 3, -1 do
    self.Data4[offset] = data4 % 0x100
    data4 = data4 / 0x100
  end

  return setmetatable({}, mt)
end

function _M.to_cstruct(self)
  return string.format(
    "{0x%08x, 0x%04x, 0x%04x, {0x%02x, 0x%02x, 0x%02x, 0x%02x, 0x%02x, 0x%02x, 0x%02x, 0x%02x}}", 
          self.Data1,
          self.Data2,
          self.Data3,
          self.Data4[1], self.Data4[2],
          self.Data4[3], self.Data4[4], self.Data4[5], self.Data4[6], self.Data4[7], self.Data4[8])
end

return _M
