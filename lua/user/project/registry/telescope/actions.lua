local actions = {}
local action_state = Utils.lazy.require_on_exported_call('telescope.actions.state')
local transform_mod = Utils.lazy.require_on_exported_call('telescope.actions.mt').transform_mod

local registry = Project.registry
local root = Utils.lazy.require_on_exported_call('user.project.root')
local select_symbolic_icons = require('user.icons.telescope').select_symbolic_icons


local input_label = function(default, callback)
  pcall(vim.ui.input, { prompt = 'Project label: ', default = default }, callback)
end

local input_new_project_cwd = function(callback)
  pcall(vim.ui.input, { prompt = 'Project root: ', completion='dir', default = root.guess('%') }, callback)
end

local input_new_project_label = function(cwd, callback)
  local parts = vim.split(cwd, Utils.fs.sep)
  pcall(vim.ui.input, { prompt = 'Project label: ', default = parts[#parts] }, callback)
end

actions.change_project_label = function(--[[ prompt_bufnr ]])
  local entry = action_state.get_selected_entry()
  local index = entry.index
  local old_label = entry.value.label
  input_label(old_label, function(label)
    registry.change_label_by_index(index, label)
  end)
end

actions.change_project_icon = function(--[[ prompt_bufnr ]])
  local entry = action_state.get_selected_entry()
  local index = entry.index
  select_symbolic_icons(function(icon)
    registry.change_icon_by_index(index, icon.key)
  end, 'Change Project Icon')
end

actions.remove_project = function(--[[ prompt_bufnr ]])
  local entry = action_state.get_selected_entry()
  local index = entry.index
  registry.remove_project_by_index(index)
end

actions.new_project = function()
  input_new_project_cwd(function(cwd)
    if cwd ~= nil then
      input_new_project_label(cwd, function(label)
        if label ~= nil then
          registry.add_project(cwd, label)
        end
      end)
    end
  end)
end

actions = transform_mod(actions)

local M = {}
local builtin_actions = require('telescope.actions')

M.change_project_label = builtin_actions.close + actions.change_project_label
M.change_project_icon  = builtin_actions.close + actions.change_project_icon
M.remove_project       = builtin_actions.close + actions.remove_project
M.new_project          = builtin_actions.close + actions.new_project

return M
