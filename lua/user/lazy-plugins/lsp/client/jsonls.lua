local config = require('user.lazy-plugins.lsp.make_config')('jsonls', nil, {}, {enable_format = true})
require('lspconfig').jsonls.setup(config)
