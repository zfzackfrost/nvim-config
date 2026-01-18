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
    branch = 'master',
    lazy = false,
    main = 'nvim-treesitter.configs',
    opts = {
      ignore_insall = { 'comment', 'ipkg' },
      sync_install = false,
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
