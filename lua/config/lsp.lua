local lspconfig = require('lspconfig')

---LSP on attach handler
---@param args vim.api.keyset.create_autocmd.callback_args
local function on_attach(args)
  -- Only create mappings for the first client
  if not vim.b._has_lsp_maps then
    local wk = require('which-key')
    wk.add({
      { '<leader>cr', ':IncRename ', buffer = args.buf, desc = 'Rename under cursor' },
    })
    vim.b._has_lsp_maps = true
  end
end

local augroup = vim.api.nvim_create_augroup('user_lsp', {})
vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup,
  callback = on_attach,
})

local default_opts = {}

local ts_settings = {
  typescript = {
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
  },
}
local svelte_settings = {
  svelte = {},
}

---@module "lspconfig.configs"
local servers = {
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
  pyright = {},
  tailwindcss = {},
  taplo = {},
  vtsls = {
    settings = ts_settings,
  },
  glsl_analyzer = {},
  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          -- You must disable built-in schemaStore support if you want to use
          -- this plugin and its advanced options like `ignore`.
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
          url = '',
        },
        schemas = require('schemastore').yaml.schemas(),
      },
    },
  },
  svelte = {
    settings = vim.tbl_deep_extend('keep', svelte_settings, ts_settings),
  },
  zls = {},
}

for name, opts in pairs(servers) do
  lspconfig[name].setup(vim.tbl_deep_extend('keep', {}, opts, default_opts))
end
