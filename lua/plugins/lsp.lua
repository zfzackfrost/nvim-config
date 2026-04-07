return {
  {
    'smjonas/inc-rename.nvim',
    event = 'CmdlineEnter',
    opts = {},
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
    event = 'User FiletypeLazy',
    config = function()
      require('config.lsp')
    end,
  },
}
