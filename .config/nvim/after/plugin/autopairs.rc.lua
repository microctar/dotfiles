local installed, autopairs = pcall(require, "nvim-autopairs")

if (not installed) then
  print("windwp/nvim-autopairs is not installed")
  return
end

autopairs.setup({
  disable_filetype =  {
    "vim",
    "TelescopePrompt",
  }
})
