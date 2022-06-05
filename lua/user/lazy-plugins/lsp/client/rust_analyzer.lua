local installer = require('nvim-lsp-installer')

local ok, server = installer.get_server('rust_analyzer')
if ok and not server:is_installed() then
  server:install()
end

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
