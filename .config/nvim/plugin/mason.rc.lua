local mason_installed, mason = pcall(require, "mason")

if (not mason_installed) then
  print("williamboman/mason.nvim is not installed")
  return
end

local mason_lspconfig_installed, mason_lspconfig = pcall(require, "mason-lspconfig")

if (not mason_lspconfig_installed) then
  print("williamboman/mason-lspconfig.nvim is not installed")
  return
end

mason.setup({})

mason_lspconfig.setup {
  automatic_installation = true
}
