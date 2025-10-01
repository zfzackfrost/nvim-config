local m = require('utils.vim.map')

local language_prefix = '<leader>cl'
local function language_maps(mod)
  local opts = require('config.keymaps.code.language.' .. mod)

  local ft = opts.ft
  local mappings = opts.mappings
  local name = opts.name
  local cond = opts.cond

  local group = ft
  if name ~= nil then
    group = name
  end
  if opts.group == '' then
    group = nil
  end

  for _, map in pairs(mappings) do
    if group ~= nil then
      map[1] = language_prefix .. map[1]
    end
    if map.cond == nil then
      map.cond = cond
    end
  end
  if group ~= nil then
    table.insert(mappings, {
      language_prefix,
      group = group,
    })
  end
  m.map_filetype({ ft }, mappings)
end

language_maps('rust')
language_maps('crates')
language_maps('markdown')
language_maps('cpp_global')
