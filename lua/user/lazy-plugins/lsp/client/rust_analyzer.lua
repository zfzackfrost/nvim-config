local config = require('user.lazy-plugins.lsp.make_config')('rust_analyzer', 'rust-analyzer', function(base)
  local opts = { server = base }
  opts.tools = {}
  opts.tools.inlay_hints = {
    show_variable_name = true,
    parameter_hints_prefix = " <- ",
    other_hints_prefix = " => ",
  }
  return opts
end, {enable_format = true})
require('rust-tools').setup(config)
