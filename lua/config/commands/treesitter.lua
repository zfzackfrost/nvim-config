local function ts_info()
  vim.cmd.checkhealth('vim.treesitter')
end
nvim.create_user_command('TSInfo', ts_info, {})
