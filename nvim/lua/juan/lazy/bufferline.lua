return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers", -- or "tabs"
        numbers = "ordinal",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return icon .. count
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
          },
        },
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = "slant", -- or "thin", "padded_slant"
        enforce_regular_tabs = true,
        always_show_bufferline = true,
      },
    })
  end,
}

