local config = require('user.lazy-plugins.lsp.make_config')('cmake', nil, {}, {enable_format = true, use_init_opts = true})
require('lspconfig').cmake.setup(config)
