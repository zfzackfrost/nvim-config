local lsp_config = require('lspconfig.configs')
local local_config = require('user.project.local_config')

return function(key, nested_key, opts, gen_opts)
  gen_opts = gen_opts or {}
  local on_new_config = function(config, root_dir)
    local default_config = (lsp_config[key] or {}).default_config
    if default_config ~= nil then
      local default_on_new_config = default_config.on_new_config
      if type(default_on_new_config) == 'function' then
        default_on_new_config(config, root_dir)
      end
    end
    local project_cfg = local_config.get('lsp') or {}
    local project_lsp_cfg = project_cfg[key] or {}

    local settings = project_lsp_cfg.settings or {}
    if nested_key ~= nil then
      settings = { [nested_key] = settings }
    end
    config.settings = vim.tbl_deep_extend('force', config.settings or {}, settings)

    if gen_opts.use_init_opts or false then
      local init_options = project_lsp_cfg.init_options or {}
      if nested_key ~= nil then
        init_options = { [nested_key] = init_options }
      end
      config.init_options = vim.tbl_deep_extend('force', config.init_options or {}, init_options)
    end
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  local base_opts = {
    on_attach = require('user.lazy-plugins.lsp.on_attach')(gen_opts.enable_format),
    on_new_config = on_new_config,
    capabilities = capabilities,
  }
  if type(opts) == 'function' then
    return opts(base_opts)
  else
    return vim.tbl_deep_extend('force', base_opts, opts or {})
  end
end
