local installed, telescope = pcall(require, "telescope")

if (not installed) then
  print("nvim-telescope/telescope.nvim is not installed")
  return
end

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

vim.keymap.set('n', ';f', function() builtin.find_files({ no_ignore = false, hidden = true }) end)
vim.keymap.set('n', ';r', builtin.live_grep)
vim.keymap.set('n', '\\\\', builtin.buffers)
vim.keymap.set('n', ';t', builtin.help_tags)
vim.keymap.set('n', ';;', builtin.resume)
vim.keymap.set('n', ';e', builtin.diagnostics)
vim.keymap.set("n", "sf", 
  function()
    telescope.extensions.file_browser.file_browser({
      path = "%:p:h",
      cwd = vim.fn.expand('%:p:h'),
      respect_gitignore = false,
      hidden = true,
      grouped = true,
      previewer = false,
      initial_mode = "normal",
      layout_config = { height = 40 }
    })
  end
)

local fb_actions = telescope.extensions.file_browser.actions

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        -- your custom insert mode mappings
        ["i"] = {
          ["<C-w>"] = function() vim.cmd('normal vbd') end,
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd('startinsert')
          end
        },
      },
    },
  },
}

telescope.load_extension("file_browser")
