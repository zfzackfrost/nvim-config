return {
  'luckasRanarison/tailwind-tools.nvim',
  name = 'tailwind-tools',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  ft = {
    'css',
    'scss',
    'html',
    'vue',
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
