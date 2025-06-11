return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    lazy = true,
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
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
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
