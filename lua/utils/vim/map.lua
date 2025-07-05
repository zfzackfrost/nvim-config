local M = {}

---@module 'which-key'

M.everywhere = {
  'c',
  'i',
  'n',
  'o',
  't',
  'v',
}
function M.disable_map(lhs, where)
  if where == nil then
    where = M.everywhere
  end
  vim.keymap.set(where, lhs, '<Nop>')
end

---@param filetypes string[]
---@param mappings wk.Spec
---@param opts? wk.Parse
function M.map_filetype(filetypes, mappings, opts)
  for _, m in ipairs(mappings) do
    m.buffer = true
  end
  autocmd('FileType', {
    pattern = filetypes,
    callback = function()
      local wk = require('which-key')
      wk.add(mappings, opts)
    end,
  })
end

function M.unimplemented()
  vim.notify('Mapping has not been implemented yet!', vim.log.levels.WARN)
end

return M
