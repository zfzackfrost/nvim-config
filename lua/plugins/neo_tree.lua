local local_opts = {
  filesystem = {
    filtered_items = {
      visible = true,
    },
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

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'echasnovski/mini.icons',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  keys = {
    { '<leader>e', [[<Cmd>Neotree toggle<Cr>]], desc = 'File tree' },
    { '<leader>E', [[<Cmd>Neotree toggle reveal<Cr>]], desc = 'File tree (current file)' },
  },
  cmd = { 'Neotree' },
  opts = local_opts,
}
