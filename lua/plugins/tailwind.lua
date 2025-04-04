return {
  'luckasRanarison/tailwind-tools.nvim',
  name = 'tailwind-tools',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  ft = {
    'css',
    'scss',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'svelte',
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
  },
}
