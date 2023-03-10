local installed, ccc = pcall(require, "ccc")

if (not installed) then
  print("uga-rosa/ccc.nvim is not installed")
  return
end

local mapping = ccc.mapping

ccc.setup({
  highlight_mode = "bg",
  highlighter = {
    auto_enable = true,
  },
})
