---NewFile command function
local function new_file()
  local function impl(i)
    if i == nil then
      return
    end
    local script_file = vim.fs.joinpath(vim.fn.stdpath('config'), 'scripts', 'new_file_helper.zsh')
    vim.system({ 'zsh', '-c', script_file .. ' ' .. i }):wait()
  end
  vim.ui.input({ prompt = 'File name' }, impl)
end
nvim.create_user_command('NewFile', new_file, { force = true })
