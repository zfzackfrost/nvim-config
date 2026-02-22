local M = {}

local default_opts = {}
local tsls_hints_settings = {
  inlayHints = {
    includeInlayVariableTypeHints = true,
    includeInlayFunctionLikeReturnTypeHints = true,
    includeInlayFunctionParameterTypeHints = true,
    includeInlayPropertyDeclarationTypeHints = true,
    includeInlayParameterNameHints = 'all',
  },
}
local tsls_settings = {
  typescript = tsls_hints_settings,
  javascript = tsls_hints_settings,
}

local svelte_settings = {
  svelte = {},
}

---@module "lspconfig.configs"
local server_opts = {
  arduino_language_server = {},
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
  ts_ls = {
    settings = tsls_settings,
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
    settings = vim.tbl_deep_extend('keep', svelte_settings, tsls_settings),
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
