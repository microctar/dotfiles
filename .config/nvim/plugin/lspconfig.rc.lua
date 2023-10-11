local installed, nvim_lsp = pcall(require, "lspconfig")

if (not installed) then 
  print('nvim-lspconfig is not installed')
  return 
end

local protocol = require('vim.lsp.protocol')

protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  'ﴯ', -- Class
  '', -- Interface
  '', -- Module
  'ﰠ', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  '', -- Operator
  '', -- TypeParameter
}

-- lspconfig.txt
-- Available at:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/lspconfig.txt

local on_attach = function(client, bufnr)
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
end

-- Autocompletion
-- Available at:
-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#autocompletion-not-built-in-vs-completion-built-in

local cmp_nvim_lsp_installed, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if (not cmp_nvim_lsp_installed) then
  print("hrsh7th/cmp-nvim-lsp is not installed")
  return
end

local capabilities = cmp_nvim_lsp.default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

local servers = {
  'gopls',
  'rust_analyzer',

  'solargraph',
  'pyright',
  'bashls',
  'tsserver'
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local clangd_capabilities = capabilities
clangd_capabilities.offsetEncoding = { "utf-16" }

nvim_lsp['clangd'].setup {
  on_attach = on_attach,
  capabilities = clangd_capabilities,
}

nvim_lsp['powershell_es'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  bundle_path = os.getenv('HOME') .. '/.local/share/nvim/mason/packages/powershell-editor-services'
}

-- Change diagnostic symbols in the sign column (gutter)
-- Available at:
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#customizing-how-diagnostics-are-displayed

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Available at:
-- https://github.com/craftzdog/dotfiles-public/blob/cf96bcffa1120d0116e9dcf34e8540b0f254ad41/.config/nvim/plugin/lspconfig.lua#L140
-- L140-L148

vim.diagnostic.config({
  virtual_text = {
    prefix = '●'
  },
  update_in_insert = true,
  float = {
    source = "always", -- or "if_many"
  },
})
