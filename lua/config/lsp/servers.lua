local M = {}

local default_opts = {}
local vtsls_hints_settings = {
  inlayHints = {
    variableTypes = {
      enabled = true,
    },
    parameterTypes = {
      enabled = true,
    },
    propertyDeclarationTypes = {
      enabled = true,
    },
    parameterNames = {
      enabled = 'all',
    },
  },
}
local vtsls_settings = {
  typescript = vtsls_hints_settings,
  javascript = vtsls_hints_settings,
}

local svelte_settings = {
  svelte = {},
}

---@module "lspconfig.configs"
local server_opts = {
  clangd = {
    cmd = {
      'clangd',
      '--header-insertion=never',
    },
  },
  lua_ls = {},
  cmake = {},
  css_variables = {},
  cssls = {},
  cssmodules_ls = {},
  gdscript = {},
  glasgow = {},
  html = {},
  eslint = {},
  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  },
  basedpyright = {},
  tailwindcss = {},
  taplo = {},
  vtsls = {
    settings = vtsls_settings,
  },
  glsl_analyzer = {},
  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
          url = '',
        },
        schemas = require('schemastore').yaml.schemas(),
      },
    },
  },
  openscad_ls = {},
  svelte = {
    settings = vim.tbl_deep_extend('keep', svelte_settings, vtsls_settings),
  },
  zls = {},
}

function M.get_opts(name)
  return vim.tbl_deep_extend('keep', {}, server_opts[name], default_opts)
end

---@return string[] # Array of language servers which have configurations
function M.all_servers()
  local servers = {}
  for name, _ in pairs(server_opts) do
    table.insert(servers, name)
  end
  return servers
end
return M
