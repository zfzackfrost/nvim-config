local lspconfig = require('lspconfig')

---LSP on attach handler
---@param args vim.api.keyset.create_autocmd.callback_args
local function on_attach(args)
  -- Only create mappings for the first client
  if not vim.b._has_lsp_maps then
    local wk = require('which-key')

    local function toggle_hints()
      local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf })
      vim.lsp.inlay_hint.enable(not enabled, { bufnr = args.buf })
    end
    wk.add({
      { '<leader>cr', [[:IncRename <C-r>=expand('<cword>')<Cr>]], buffer = args.buf, desc = 'Rename under cursor' },
      {
        '<leader>cs',
        [[<Cmd>Telescope lsp_document_symbols theme=ivy<Cr>]],
        desc = 'Symbols',
      },
      {
        '<leader>cf',
        '<Cmd>Format<Cr>',
        desc = 'Format code',
      },
      {
        '<leader>ca',
        vim.lsp.buf.code_action,
        desc = 'Code action',
      },
      {
        '<leader>ch',
        toggle_hints,
        desc = 'Toggle hints,',
      },
    })
    vim.b._has_lsp_maps = true
  end
end

local augroup = augroup('user_lsp', {})
autocmd('LspAttach', {
  group = augroup,
  callback = on_attach,
})

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
  svelte = {
    settings = vim.tbl_deep_extend('keep', svelte_settings, vtsls_settings),
  },
  zls = {},
}

for name, opts in pairs(servers) do
  lspconfig[name].setup(vim.tbl_deep_extend('keep', {}, opts, default_opts))
end
