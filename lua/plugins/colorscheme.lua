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
        noice = true,
        grug_far = true,
        snacks = {
          enabled = true,
        },
      },
      custom_highlights = function(colors)
        local color_utils = require('catppuccin.utils.colors')
        return {
          LineNr = { bg = colors.crust },
          CursorLineNr = { bg = colors.crust },
          SignColumn = { bg = colors.crust },
          EdgyWinBar = { fg = colors.overlay2, bg = color_utils.darken(colors.surface0, 0.5, colors.mantle) },
          MiniIconsDarkGrey = { fg = colors.overlay0 },
          MiniCursorword = { bg = color_utils.darken(colors.surface1, 0.5, colors.base), underline = true },
          NeoTreeDotFile = { fg = colors.overlay0 },
          ['@comment.hint'] = { fg = colors.blue, bg = colors.none },
          ['@comment.note'] = { fg = colors.blue, bg = colors.none },
          ['@comment.todo'] = { fg = colors.flamingo, bg = colors.none },
          ['@comment.warning'] = { fg = colors.yellow, bg = colors.none },
          ['@comment.error'] = { fg = colors.red, bg = colors.none },
        }
      end,
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme('catppuccin-nvim')
    end,
  },
}
