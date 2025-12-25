return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    lazy = true,
  },
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
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = 'all',
      ignore_insall = { 'comment' },
      sync_install = false,
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
