local config = require('user.lazy-plugins.lsp.make_config')('taplo', nil, {}, {enable_format = true})
require('lspconfig').taplo.setup(config)
