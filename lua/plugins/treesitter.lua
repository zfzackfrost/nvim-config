return {
  {
    'windwp/nvim-ts-autotag',
    ft = {
      'typescriptreact',
      'javascriptreact',
      'xml',
      'vue',
      'svelte',
      'php',
      'html',
      'markdown',
    },
    opts = {},
  },
  {
    'zfzackfrost/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    opts = {},
  },
}
