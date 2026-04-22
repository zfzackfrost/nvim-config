local s = utils.str
local M = {}

local function increname_prepend_expr()
  local cword = vim.fn.expand('<cword>')
  local nav = s.rep('<Left>', #cword)
  local keys = [[:IncRename ]] .. cword .. nav
  return keys
end
local function increname()
  local keys = [[:IncRename ]]
  return keys
end

---LSP on attach handler
---@param args vim.api.keyset.create_autocmd.callback_args
function M.on_attach(args)
  -- Only create mappings for the first client
  if not vim.b._has_lsp_maps then
    local wk = require('which-key')

    vim.keymap.set('n', '<leader>c<C-r>', increname_prepend_expr, {
      desc = 'Rename under cursor (prepend)',
      buffer = args.buf,
      expr = true,
      replace_keycodes = true,
    })
    vim.keymap.set('n', '<leader>cr', increname, {
      desc = 'Rename under cursor (replace)',
      buffer = args.buf,
      expr = true,
      replace_keycodes = true,
    })
    wk.add({
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

function M.setup()
  local augroup = augroup('user_lsp_attach', {})
  autocmd('LspAttach', {
    group = augroup,
    callback = M.on_attach,
  })
  autocmd('LspAttach', {
    group = augroup,
    callback = on_tailwind_attach,
  })
end
return M
