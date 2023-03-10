local installed, bufferline = pcall(require, "bufferline")

if (not installed) then
  print("akinsho/bufferline.nvim is not installed")
  return
end

bufferline.setup({
  options = {
    mode = "tabs",
    separator_style = "slant",
    numbers = "buffer_id",

    modified_icon = '●',
    left_trunc_marker = '',
    right_trunc_marker = '',
    color_icons = true,

    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or ""
        return " " .. icon .. count
    end,
  },

-- color scheme
-- Available at:
-- https://www.reddit.com/r/evangelion/comments/8w6qr8/evangelion_based_color_palettes

  highlights = {
    fill = {
      bg = '#151221',
    },

    separator = {
      fg = '#584974',
    },

    separator_selected = {
      fg = '#19000d',
    },

  },
})

vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
