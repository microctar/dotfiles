local api = vim.api

local _M = {}
local mt = { __index = _M }

function _M.new(self, config)
  self.height = config and config.height and config.height or 10
  self.width = config and config.width and config.width or 50
  self.text = config.text
  
  local listed = false
  local scratch = true
  self.winbuf = api.nvim_create_buf(listed, scratch)
  
  local current_ui = api.nvim_list_uis()[1]
  self.winopts = {
    relative = 'editor',
    width = self.width,
    height = self.height,
    col = (current_ui.width - self.width) / 2,
    row = (current_ui.height - self.height) / 2,
    anchor = 'NW',
    style = 'minimal',
    border = {"+", "-" ,"+", "|"}
  }
  
  return setmetatable({}, mt)
end

function _M.render(self)

  if type(self.text) == "table" then
    local picsine = {}
    for cnt = 1, self.height do
      table.insert(picsine, string.rep(' ', self.width))
    end
    api.nvim_buf_set_lines(self.winbuf, 0, -1, false, picsine)

    local text_lines = (function() local cnt = 0; for _, _ in pairs(self.text) do cnt = cnt + 1 end return cnt; end)()
    local start_col = 0
    local end_col = 0
    local current_row = math.floor((self.height - text_lines) / 2)
    print(current_row)
    for title, line in pairs(self.text) do
      local line = title and string.format("%s:%s", title, line) or line
      start_col = math.floor((self.width - string.len(line)) / 2)
      end_col = start_col + string.len(line)
      api.nvim_buf_set_text(self.winbuf, current_row, start_col, current_row, end_col, {line})
      current_row = current_row + 1
    end
  end

  local win = api.nvim_open_win(self.winbuf, 1, self.winopts)
end

return _M
