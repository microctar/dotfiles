local installed, gitsigns = pcall(require, "gitsigns")

if (not installed) then
  print("lewis6991/gitsigns.nvim is not installed")
  return
end

gitsigns.setup {
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 200,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
}
