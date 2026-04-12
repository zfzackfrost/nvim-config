---NewFile command function
---@param t vim.api.keyset.create_user_command.command_args
local function new_file(t)
  ---@type string[]
  local paths = utils.brace_expand.expand(t.args)
  for _, p in ipairs(paths) do
    p = vim.fs.abspath(p)
    if utils.str.ends_with(p, '/') then
      utils.fs.mkdirp(p)
    else
      utils.fs.mkdirp(vim.fs.dirname(p))
      utils.fs.create_file(p)
    end
  end
end
nvim.create_user_command('NewFile', new_file, { nargs = 1 })
