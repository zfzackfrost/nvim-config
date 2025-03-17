local wk = require('which-key')

local function toggle_hints()
  local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
  vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
end

wk.add({
  { '<leader>c', group = 'code' },
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

require('config.keymaps.code.language')
require('config.keymaps.code.gen')
