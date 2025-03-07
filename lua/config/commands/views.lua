local function clean_views()
  local views = vim.fs.find(function()
    return true
  end, { path = vim.go.viewdir, type = 'file', limit = math.huge })
  for _, v in ipairs(views) do
    vim.uv.fs_unlink(v)
  end
  vim.notify(string.format('Cleaned %d views', #views), vim.log.levels.INFO, {})
end

vim.api.nvim_create_user_command('CleanViews', clean_views, { bar = true })
