local config = require('user.lazy-plugins.lsp.make_config')('clangd', nil, {
  cmd = {'clangd', '--clang-tidy', '--j=10', '--background-index', '--header-insertion=never', '--malloc-trim'}
}, {enable_format = true, use_init_opts = true})
require('lspconfig').clangd.setup(config)
