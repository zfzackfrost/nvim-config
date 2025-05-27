return {
  {
    'williamboman/mason.nvim',
    opts = {
      max_concurrent_installers = 8,
      pip = {
        upgrade_pip = true,
      },
      ui = {
        border = 'single',
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      automatic_enable = {
        exclude = { 'rust_analyzer' },
      },
    },
  },
}
