return {
  'luckasRanarison/tailwind-tools.nvim',
  name = 'tailwind-tools',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    server = {
      override = false,
    },
    document_color = {
      enable = true,
    },
    conceal = {
      enabled = false,
    },
  }, -- your configuration
}
