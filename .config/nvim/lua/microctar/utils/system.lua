local has = vim.fn.has

local M = {
  is_bsd = has("bsd") == 1,
  is_mac = has("macunix") == 1,
  is_linux = has("linux") == 1,
  is_windows = has("windows") == 1,
}

return M
