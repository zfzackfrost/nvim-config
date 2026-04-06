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
    'nvim-treesitter/nvim-treesitter-context',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    opts = {},
    config = function(_, opts)
      local ts = require('nvim-treesitter')
      ts.setup(opts)
    end,
  },
}
