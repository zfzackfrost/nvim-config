return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 5000,
    opts = {
      background = {
        dark = 'frappe',
        light = 'latte',
      },
      integrations = {
        which_key = true,
        mason = true,
        blink_cmp = true,
        overseer = true,
        window_picker = true,
        lsp_trouble = true,
        neotest = true,
      },

      custom_highlights = function(colors)
        return {
          LineNr = { bg = colors.crust },
          CursorLineNr = { bg = colors.crust },
          SignColumn = { bg = colors.crust },
          IndentLine = { fg = colors.surface0 },
          IndentLineCurrent = { fg = colors.surface2 },
          BufferlineBanner = { fg = colors.crust, bg = colors.overlay1 },
        }
      end,
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme('catppuccin')
    end,
  },
}
