require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',
  highlight = {
    enable = true,
    disable = { 'help' },
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = { 'wgsl' },
  },
  context_commentstring = {
    enable = true,
    disable = { 'wgsl' },
    enable_autocmd = false,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['atf'] = '@function.outer',
        ['itf'] = '@function.inner',

        ['at('] = '@call.outer',
        ['it('] = '@call.inner',

        ['atb'] = '@block.outer',
        ['itb'] = '@block.inner',

        ['atl'] = '@loop.outer',
        ['itl'] = '@loop.inner',

        ['ati'] = '@conditional.outer',
        ['iti'] = '@conditional.inner',

        ['itp'] = '@parameter.inner',
        ['at;'] = '@statement.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<Space>>;'] = '@statement.outer',
        ['<Space>>p'] = '@parameter.inner',
      },
      swap_previous = {
        ['<Space><;'] = '@statement.outer',
        ['<Space><p'] = '@parameter.inner',
      },
    },
  },
})

local m = require('user.utils.map')
m.map_name('n', '<Space>>;', 'Swap next @statement.outer')
m.map_name('n', '<Space>>p', 'Swap next @parameter.inner')
m.map_name('n', '<Space><lt>;', 'Swap prev @statement.outer')
m.map_name('n', '<Space><lt>p', 'Swap prev @parameter.inner')
