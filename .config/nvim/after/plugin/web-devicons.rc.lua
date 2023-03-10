local installed, nwdi = pcall(require, "nvim-web-devicons")

if (not installed) then
  print("nvim-tree/nvim-web-devicons is not installed")
  return
end

-- setup
-- Available at:
-- https://github.com/nvim-tree/nvim-web-devicons

nwdi.setup {

-- your personnal icons can go here (to override)
-- you can specify color or cterm_color instead of specifying both of them
-- DevIcon will be appended to `name`

  override = {},
  default = true,
}
