local M = {}
local F = Utils.functional

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local entry_display = require('telescope.pickers.entry_display')

local registry = Project.registry

local registry_actions = require('user.project.registry.telescope.actions')

function M.picker(opts)
  opts = opts or {}

  local projects = registry.get_projects() or {}
  local label_col_len = F.is_null(projects) and 0 or F.max(F.map_path(F.op.length, 'label', projects))

  local displayer = entry_display.create({
    separator = ' ',
    items = {
      { width = 2 },
      { width = label_col_len },
      { remaining = true },
    },
  })
  local make_display = function(entry)
    local icon_info = entry.value.icon_info

    return displayer({
      { icon_info.text, icon_info.hl },
      { entry.value.label or '', 'TelescopeResultsField' },
      { entry.value.cwd, 'TelescopeResultsComment' },
    })
  end

  pickers.new(opts, {
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        selection.value:switch_to()
      end)

      map('n', 'r', registry_actions.change_project_label)
      map('n', 'o', registry_actions.change_project_icon)
      map('n', 'd', registry_actions.remove_project)
      map('n', 'a', registry_actions.new_project)

      map('i', '<C-r>', registry_actions.change_project_label)
      map('i', '<C-o>', registry_actions.change_project_icon)
      map('i', '<C-d>', registry_actions.remove_project)
      map('i', '<C-a>', registry_actions.new_project)

      return true
    end,
    prompt_title = 'Projects',
    finder = finders.new_table({
      results = projects,
      entry_maker = function(entry)
        return {
          value = entry,
          display = make_display,
          ordinal = entry.label .. entry.cwd,
        }
      end,
    }),
    sorter = conf.generic_sorter(opts),
  }):find()
end

function M.setup()
  local m = require('user.utils.map')
  m.map('n', '<Space>sp', function()
    M.picker({})
  end, { desc = 'Switch project (fuzzy)' })
end

return M
