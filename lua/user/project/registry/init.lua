local M = {}
local Fs = Utils.fs
local F = Utils.functional

local create_project = require('user.project.registry.project')
local projects

M.config_path = function()
  return Fs.Path:new(Fs.Path.join(vim.fn.stdpath('data'), 'user-projects.json'))
end

local function validate_project_config(project, notify)
  notify = notify or false
  local success = true
  local function make_notify_lines(msg)
    if type(msg) ~= 'table' then
      msg = { msg }
    end
    return {
      unpack(msg),
      'Project table:',
      string.format('  cwd:   %s', vim.inspect(project.cwd)),
      string.format('  label: %s', vim.inspect(project.label)),
      string.format('  icon:  %s', vim.inspect(project.icon)),
    }
  end
  if type(project.cwd) ~= 'string' then
    if notify then
      local lines = make_notify_lines({ 'Type of `cwd` must be `string`.', 'Value is either missing or invalid!' })
      vim.notify(lines, vim.log.levels.ERROR, {
        title = 'Error in user-projects.json',
      })
    end
    success = false
  end

  local ty_label = type(project.label)
  if ty_label ~= 'nil' and ty_label ~= 'string' then
    if notify then
      local lines = make_notify_lines('If defined, type of `label` must be `string`!')
      vim.notify(lines, vim.log.levels.ERROR, {
        title = 'Error in user-projects.json',
      })
    end
    success = false
  end

  local ty_icon = type(project.icon)
  if ty_icon ~= 'nil' and ty_icon ~= 'string' then
    if notify then
      local lines = make_notify_lines('If defined, type of `icon` must be `string`!')
      vim.notify(lines, vim.log.levels.ERROR, {
        title = 'Error in user-projects.json',
      })
    end
    success = false
  end

  return success
end

local function process_projects()
  local function map_proj(proj)
    if validate_project_config(proj, true) then
      proj.cwd = Fs.Path:new(proj.cwd):expand()
    end
    return proj
  end
  projects = F.totable(F.map(map_proj, projects))
end

local function default_projects()
  return {
    {
      label = 'Neovim Config',
      icon = 'config',
      cwd = vim.fn.stdpath('config'),
    },
  }
end

local function ensure_config()
  if M.config_path():exists() then
    M.read_registry_file()
  else
    projects = default_projects()
    M.write_registry_file()
  end
end

function M.read_registry_file()
  local path = M.config_path()
  local projects_src = path:read()
  projects = Utils.json.decode(projects_src)
  process_projects()
end

function M.write_registry_file()
  process_projects()
  local path = M.config_path()
  local projects_src = Utils.json.encode(projects)
  path:write(projects_src, 'w')
end

function M.get_project_with_cwd(cwd)
  local matching = F.filter(function(_, x)
    return x.cwd == cwd
  end, F.enumerate(projects))
  if F.is_null(matching) then
    return 0
  else
    local i, _ = F.head(matching)
    return i
  end
end

function M.add_project(cwd, label, icon)
  local existing_index = M.get_project_with_cwd(cwd)
  if existing_index >= 1 then
    projects[existing_index].label = label
    projects[existing_index].icon = icon
    vim.notify({ 'Project exists in registry.', 'Updated it instead!' }, vim.log.levels.INFO, {
      title = 'Add project',
    })
  else
    table.insert(projects, {
      label = label,
      cwd = cwd,
      icon = icon,
    })
    vim.notify('Project added to registry!', vim.log.levels.INFO, {
      title = 'Add project',
    })
  end
  M.write_registry_file()
end

function M.remove_project_by_index(index)
  if index ~= nil and projects[index] ~= nil then
    table.remove(projects, index)
    vim.notify({ 'Project removed from registry!' }, vim.log.levels.INFO, {
      title = 'Remove project',
    })
  else
    vim.notify({ 'Project does not exist in registry!', 'Cannot remove a non-existing project!' }, vim.log.levels.WARN, {
      title = 'Remove project',
    })
  end
  M.write_registry_file()
end

function M.remove_project_by_cwd(cwd)
  local index = M.get_project_with_cwd(cwd)
  if index >= 1 then
    M.remove_project_by_index(index)
  end
end

function M.change_label_by_index(index, label)
  local proj = projects[index]
  if proj == nil or type(label) ~= 'string' then
    return
  end
  proj.label = label
  M.write_registry_file()
end

function M.change_label_by_cwd(cwd, label)
  local index = M.get_project_with_cwd(cwd)
  if index >= 1 then
    M.change_label_by_index(index, label)
  end
end

function M.change_icon_by_index(index, icon)
  local proj = projects[index]
  if proj == nil or type(icon) ~= 'string' then
    return
  end
  proj.icon = icon
  M.write_registry_file()
end

function M.change_icon_by_cwd(cwd, icon)
  local index = M.get_project_with_cwd(cwd)
  if index >= 1 then
    M.change_icon_by_index(index, icon)
  end
end

function M.get_projects()
  return F.totable(F.map(create_project, projects))
end

function M.setup()
  ensure_config()
end

return M
