local installed, null_ls = pcall(require, "null-ls")

if (not installed) then
  print("jose-elias-alvarez/null-ls.nvim is not installed")
  return
end

-- Avoiding LSP formatting conflicts. 
-- Available at: 
-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end

-- Built-in sources
-- Available at:
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

local sources = {
  -- formatting settings
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.rustfmt.with({
          extra_args = function(params)
              local Path = require("plenary.path")
              local cargo_toml = Path:new(params.root .. "/" .. "Cargo.toml")

              if cargo_toml:exists() and cargo_toml:is_file() then
                  for _, line in ipairs(cargo_toml:readlines()) do
                      local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
                      if edition then
                          return { "--edition=" .. edition }
                      end
                  end
              end
              -- default edition when we don't find `Cargo.toml` or the `edition` in it.
              return { "--edition=2021" }
          end,
      }),


  -- diagnostics settings
    null_ls.builtins.diagnostics.fish,

    null_ls.builtins.diagnostics.clang_check,
    null_ls.builtins.diagnostics.golangci_lint,

    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.eslint_d.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
}

null_ls.setup {
  sources = sources,
  on_attach = on_attach
}
