local s = require('utils.str')

local function increname_prepend_expr()
  local cword = vim.fn.expand('<cword>')
  local nav = s.rep('<Left>', #cword)
  local keys = [[:IncRename ]] .. cword .. nav
  return keys
end

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
    vim.keymap.set('n', '<leader>c<C-r>', increname_prepend_expr, {
      desc = 'Rename under cursor (prepend)',
      buffer = args.buf,
      expr = true,
      replace_keycodes = true,
    })
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
        function()
          Snacks.picker.lsp_symbols()
        end,
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

---Tailwind LSP on attach handler
---@param args vim.api.keyset.create_autocmd.callback_args
local function on_tailwind_attach(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if client == nil then
    return
  end
  if client.name ~= 'tailwindcss' then
    return
  end
  vim.cmd.TailwindColorDisable()
end

local augroup = augroup('user_lsp_attach', {})
autocmd('LspAttach', {
  group = augroup,
  callback = on_attach,
})
autocmd('LspAttach', {
  group = augroup,
  callback = on_tailwind_attach,
})
