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
        }
      end,
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme('catppuccin')
    end,
  },
}
