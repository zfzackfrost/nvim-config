local m = Utils.map

local function quit_restart()
  local status = os.getenv('NVIM_RESTART_STATUS')
  if status == nil then
    vim.cmd([[qall]])
  else
    vim.cmd(string.format([[cq %s]], status))
  end
end

m.group_name('n', '<Space>q', 'quit')
m.map('n', '<Space>qr', quit_restart, {desc = 'Quit and restart'})
