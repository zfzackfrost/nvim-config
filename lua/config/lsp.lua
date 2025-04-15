local lspconfig = require('lspconfig')

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd('LspProgress', {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= 'table' then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ('[%3d%%] %s%s'):format(
            value.kind == 'end' and 100 or value.percentage or 100,
            value.title or '',
            value.message and (' **%s**'):format(value.message) or ''
          ),
          done = value.kind == 'end',
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
    vim.notify(table.concat(msg, '\n'), 'info', {
      id = 'lsp_progress',
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and ' '
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

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
