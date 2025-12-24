return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 5000,
    ---@module 'catppuccin'
    ---@type CatppuccinOptions
    opts = {
      lsp_styles = {
        underlines = {
          errors = { 'undercurl' },
          warnings = { 'undercurl' },
        },
      },
      background = { -- latte, frappe, macchiato, mocha
        dark = 'macchiato',
        light = 'latte',
      },
      term_colors = true,
      integrations = {
        which_key = true,
        mason = true,
        blink_cmp = true,
        window_picker = true,
        lsp_trouble = true,
        snacks = {
          enabled = true,
        },
      },

      custom_highlights = function(colors)
        return {
          LineNr = { bg = colors.crust },
          CursorLineNr = { bg = colors.crust },
          SignColumn = { bg = colors.crust },
          EdgyWinBar = { fg = colors.surface0, bg = colors.overlay2 },
        }
      end,
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme('catppuccin')
    end,
  },
}
