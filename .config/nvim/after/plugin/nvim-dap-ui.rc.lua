local installed, dapui = pcall(require, "dapui")

if (not installed) then
  print("rcarriga/nvim-dap-ui is not installed")
  return
end

dapui.setup()
