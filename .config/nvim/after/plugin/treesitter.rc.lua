local installed, treesitter = pcall(require, "nvim-treesitter.configs")

if (not installed) then
  print("nvim-treesitter/nvim-treesitter is not installed")
  return
end

treesitter.setup {
  highlight = {
    enable = true,
    disable = {},
  },

  indent = {
    enable = true,
    disable = {},
  },

  ensure_installed = {
    "markdown",
    "markdown_inline",

    "json",
    "toml",
    "dockerfile",

    "rust",
    "go",
    "c",
    "cpp",

    "lua",
    "ruby",
    "html",
    "css",
    "tsx",
    "typescript",
    "javascript",
    "fish"
  },

  autotag = {
    enable = true,
    enable_rename = true,
    enable_close = true,
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
