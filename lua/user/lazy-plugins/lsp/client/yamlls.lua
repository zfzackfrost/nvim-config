local config = require('user.lazy-plugins.lsp.make_config')('yamlls', nil, {}, {enable_format = true})
require('lspconfig').yamlls.setup(config)
