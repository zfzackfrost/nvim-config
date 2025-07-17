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
      { '<leader>cr', [[:IncRename ]], buffer = args.buf, desc = 'Rename under cursor (replace)' },
      {
        '<leader>cR',
        [[:IncRename <C-r>=expand('<cword>')<Cr>]],
        buffer = args.buf,
        desc = 'Rename under cursor (append)',
      },
      {
        '<leader>cs',
        [[<Cmd>Telescope lsp_document_symbols theme=ivy<Cr>]],
        desc = 'Symbols',
      },
      {
        '<leader>ca',
        buffer = args.buf,
        vim.lsp.buf.code_action,
        desc = 'Code action',
      },
      {
        '<leader>ch',
        toggle_hints,
        buffer = args.buf,
        desc = 'Toggle inlay hints',
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
