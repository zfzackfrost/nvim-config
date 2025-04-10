return {
  {
    'smjonas/inc-rename.nvim',
    event = 'CmdlineEnter',
    opts = {},
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        'snacks.nvim',
        'nvim-dap-ui',
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'b0o/schemastore.nvim',
    lazy = true,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason-lspconfig.nvim',
    },
    event = 'VeryLazy',
    config = function()
      require('config.lsp')
    end,
  },
}
