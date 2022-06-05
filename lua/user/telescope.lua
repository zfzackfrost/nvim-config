local telescope = require('telescope')
local themes = require('telescope.themes')
local actions = require('telescope.actions')

local defaults = themes.get_ivy({
  prompt_prefix = ' ',
  mappings = {
    i = {
      ["<C-j>"] = actions.cycle_history_next,
      ["<C-k>"] = actions.cycle_history_prev,
    }
  },
  history = {
    limit = 250,
  }
})

---@diagnostic disable-next-line: redundant-parameter
telescope.setup({
  defaults = defaults,
  pickers = {
    buffers = {
      sort_lastused = true,
      sort_mru = true,
      ignore_current_buffer = false,
    },
    diagnostics = {
      previewer = false,
    }
  },
  extensions = {
    ['ui-select'] = {
      themes.get_dropdown({}),
    },
  },
})
telescope.load_extension('fzf')
telescope.load_extension('ui-select')

local m = Utils.map

m.map('n', { '<Space>sf', '<Leader>f' }, '<Cmd>Telescope find_files<Cr>', { desc = 'Find files (fuzzy)' })
m.map('n', '<Space>sr', '<Cmd>Telescope oldfiles<Cr>', { desc = 'Recent files (fuzzy)' })
m.map('n', '<Space>sg', '<Cmd>Telescope live_grep<Cr>', { desc = 'Live grep (fuzzy)' })
m.map('n', { '<Space>sb', '<Leader>b' }, '<Cmd>Telescope buffers<Cr>', { desc = 'Buffers (fuzzy)' })
m.map('n', '<Space>sh', '<Cmd>Telescope help_tags<Cr>', { desc = 'Help tags (fuzzy)' })
m.map('n', '<Space>sm', '<Cmd>Telescope man_pages<Cr>', { desc = 'System man pages (fuzzy)' })
m.map('n', '<Space>st', '<Cmd>Telescope treesitter<Cr>', { desc = 'Treesitter (fuzzy)' })
m.map('n', { '<Space>sd', '<leader>d' }, '<Cmd>Telescope diagnostics<Cr>', { desc = 'Diagnostics (fuzzy)' })
