local installer = require('nvim-lsp-installer')
installer.setup({
  automatic_installation = true,
  ui = {
    border = 'rounded',
    icons = {
      server_installed = '✓',
      server_pending = '➜',
      server_uninstalled = '✗',
    },
  },
})
