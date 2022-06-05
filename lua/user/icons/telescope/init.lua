local M = {}
local F = Utils.functional

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local entry_display = require('telescope.pickers.entry_display')

local on_select_default = function(callback, prompt_bufnr)
  actions.close(prompt_bufnr)
  local selection = action_state.get_selected_entry()
  callback(selection.value)
end

local attach_mappings = function(callback, prompt_bufnr, _)
  actions.select_default:replace(F.partial(on_select_default, callback, prompt_bufnr))
  return true
end

local function make_icons_picker(icons_path, callback, prompt_override)
  local icons_mod = require(icons_path)
  local icons_name = icons_mod._ICONS_NAME
  local icons = icons_mod.icons

  local displayer = entry_display.create({
    separator = ' ',
    items = {
      { width = 2 },
      { remaining = true },
    },
  })

  local make_display = function(entry)
    local value = entry.value
    local key = value.key

    local text = value.text
    local label = value.label
    local hl = icons_mod.icon_hl_group(key)

    return displayer({
      { text, hl },
      { label or '', 'TelescopeResultsIdentifier' },
    })
  end

  return function(opts)
    opts = opts or {}
    pickers.new(opts, {
      attach_mappings = F.partial(attach_mappings, callback),
      prompt_title = prompt_override or (icons_name .. ' Icons'),
      finder = finders.new_table({
        results = icons,
        entry_maker = function(entry)
          return {
            value = entry,
            display = make_display,
            ordinal = entry.label or '',
          }
        end,
      }),
      sorter = conf.generic_sorter(opts),
    }):find()
  end
end

M.select_symbolic_icons = function(callback, prompt_override)
  make_icons_picker('user.icons.symbolic', callback, prompt_override)()
end

return M
