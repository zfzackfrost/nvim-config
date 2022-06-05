local Proj = {
  label = '',
  icon = 'project',
}

local Fs = Utils.fs
local symbolic_icons = Utils.lazy.require_on_index('user.icons.symbolic')

local function icon_info(self)
  local icon = self.icon
  local sym_icon = symbolic_icons.icon_by_key(icon)
  if sym_icon == nil then
    return
  end
  return {
    text = sym_icon.text,
    hl   = symbolic_icons.icon_hl_group(icon),
  }
end

function Proj:new(opts)
  opts = vim.deepcopy(opts) or {}

  setmetatable(opts, self)
  self.__index = function(t, key)
    if key == "icon_info" then
      return icon_info(t)
    end
    return self[key]
  end

  return opts
end

function Proj:icon_info()
end

function Proj:switch_to()
  local last_cwd = Fs.Path:new(vim.fn.getcwd()):absolute()
  local cwd = Fs.Path:new(self.cwd):absolute()

  local label = #self.label == 0 and nil or self.label
  if last_cwd == cwd then
    vim.notify({ self.cwd, label }, vim.log.levels.WARN, {
      title = 'Project already current!',
    })
    return
  end
  vim.cmd(string.format('cd %s', self.cwd))

  vim.notify({ self.cwd, label }, vim.log.levels.INFO, {
    title = 'Switched to Project',
  })
end

return setmetatable({}, {
  __call = function(_, ...)
    return Proj:new(...)
  end,
})
