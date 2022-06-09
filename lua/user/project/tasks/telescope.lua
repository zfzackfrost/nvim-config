local M = {}

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local entry_display = require('telescope.pickers.entry_display')

local local_config = require('user.project.local_config')
local proj_tasks = require('user.project.tasks')

function M.picker(opts)
  opts = opts or {}

  local tasks_config = local_config.get('tasks') or {}
  local label_col_len = -1

  for i, t in ipairs(tasks_config) do
    local label = t.label
    if type(label) ~= 'string' then
      label = ''
    end
    local len = #label
    label_col_len = math.max(label_col_len, len)
    tasks_config[i].label = label
  end

  local displayer = entry_display.create({
    separator = ' ',
    items = {
      { width = label_col_len },
      { remaining = true },
    },
  })
  local make_display = function(entry)
    return displayer({
      { entry.value.label, 'TelescopeResultsField' },
      { entry.value.cmd, 'TelescopeResultsVariable' },
    })
  end

  pickers.new(opts, {
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.schedule(function()
          proj_tasks.run_task(selection.value)
        end)
      end)
      return true
    end,
    prompt_title = 'Tasks',
    finder = finders.new_table({
      results = tasks_config,
      entry_maker = function(entry)
        return {
          value = entry,
          display = make_display,
          ordinal = entry.label,
        }
      end,
    }),
    sorter = conf.generic_sorter(opts),
  }):find()
end

function M.setup()
  local m = require('user.utils.map')
  m.map('n', '<Space>sk', function()
    M.picker({})
  end, { desc = 'Project tasks (fuzzy)' })
end

return M
