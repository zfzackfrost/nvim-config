local function local_opts(_, opts)
  local function on_move(data)
    Snacks.rename.on_rename_file(data.source, data.destination)
  end

  local events = require('neo-tree.events')
  ---@module 'neotree'
  ---@type neotree.Config
  return {
    filesystem = {
      filtered_items = {
        visible = true,
      },
    },
    event_handlers = {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    },
    default_component_configs = {
      git_status = {
        symbols = {
          -- Change type
          added = '✚',
          deleted = '✖',
          modified = '',
          renamed = '󰁕',
          -- Status type
          untracked = '',
          ignored = '',
          unstaged = '󰄱',
          staged = '',
          conflict = '',
        },
      },
    },
  }
end

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'echasnovski/mini.icons',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  cmd = { 'Neotree' },
  opts = local_opts,
}
