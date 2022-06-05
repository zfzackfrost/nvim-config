local nls = require('null-ls')
nls.setup({
  on_attach = require('user.lazy-plugins.lsp.on_attach')(true),
  sources = {
    nls.builtins.formatting.stylua,
  },
})
