local installed, autotag = pcall(require, "nvim-ts-autotag")

if (not installed) then
  print("windwp/nvim-ts-autotag is not installed")
end

autotag.setup({})
