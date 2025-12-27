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
      -- Copy `mappings`, because wk clears the table (WHY?!)
      wk.add(vim.deepcopy(mappings), opts)
    end,
  })
end

function M.unimplemented()
  vim.notify('Mapping has not been implemented yet!', vim.log.levels.WARN)
end

--- Add mappings to which-key, all with the same icon
---@param mappings wk.Spec
---@param icon wk.Icon
---@param opts? wk.Parse
function M.add_with_icon(mappings, icon, opts)
  mappings = vim.deepcopy(mappings)
  for _, v in pairs(mappings) do
    if v.icon == nil then
      v.icon = icon
    end
  end
  require('which-key').add(mappings, opts)
end

return M
