local iff = require('utils.func').iff

---@param t vim.api.keyset.create_user_command.command_args
local function clean_swap(t)
  local function impl()
    local files = vim.fs.find(function()
      return true
    end, { path = vim.go.directory, type = 'file', limit = math.huge })
    local ok_count = 0
    local err_count = 0
    for _, f in ipairs(files) do
      local _, err = vim.uv.fs_unlink(f)
      if err == nil then
        ok_count = ok_count + 1
      else
        err_count = err_count + 1
      end
    end
    if not t.smods.silent and not t.smods.emsg_silent then
      vim.notify(
        string.format(
          'Removed %d swap %s\nEncountered %d %s',
          ok_count,
          iff(ok_count == 1, 'file', 'files'),
          err_count,
          iff(err_count == 1, 'error', 'errors')
        ),
        vim.log.levels.INFO,
        {}
      )
    end
  end
  Snacks.picker.util.confirm("Delete swap files (can't be undone)?", impl)
end

nvim.create_user_command('CleanSwap', clean_swap, { bar = true })
