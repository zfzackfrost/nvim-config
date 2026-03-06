---NewFile command function
local function new_file()
  local function impl(i)
    if i == nil then
      return
    end
    vim.system({ 'zsh', '-c', 'mf ' .. i }):wait()
  end
  vim.ui.input({ prompt = 'File name' }, impl)
end
nvim.create_user_command('NewFile', new_file, { force = true })
