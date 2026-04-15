local wk = require('which-key')
local prefix = '<leader>d'

local function open_debug_view()
  local win = nvim.get_current_win()
  vim.cmd.DapViewOpen()
  vim.defer_fn(function()
    nvim.set_current_win(win)
  end, 200)
end

---@type wk.Icon
local play_icon = {
  icon = '',
  color = 'green',
}
---@type wk.Icon
local continue_icon = {
  icon = '',
  color = 'orange',
}
---@type wk.Icon
local terminate_icon = {
  icon = '',
  color = 'red',
}
---@type wk.Icon
local step_into_icon = {
  icon = '',
  color = 'blue',
}
---@type wk.Icon
local step_out_icon = {
  icon = '',
  color = 'blue',
}
---@type wk.Icon
local step_over_icon = {
  icon = '',
  color = 'blue',
}

wk.add({
  { prefix, group = 'debug' },
  {
    prefix .. '<Cr>',
    [[<Cmd>DebugStart<Cr>]],
    desc = 'Start debugging',
    icon = play_icon,
  },
  {
    prefix .. 'q',
    [[<Cmd>DebugStop<Cr>]],
    desc = 'Terminate debugging',
    icon = terminate_icon,
  },
  {
    prefix .. 'v',
    open_debug_view,
    desc = 'Open debugging windows',
  },
  {
    prefix .. 'r',
    function()
      require('dap').continue()
    end,
    desc = 'Continue',
    icon = continue_icon,
  },
  {
    prefix .. 'b',
    function()
      require('dap').toggle_breakpoint()
    end,
    desc = 'Toggle breakpoint',
  },
  {
    prefix .. 'i',
    function()
      require('dap').step_into()
    end,
    desc = 'Step into',
    icon = step_into_icon,
  },
  {
    prefix .. 'o',
    function()
      require('dap').step_over()
    end,
    desc = 'Step over',
    icon = step_over_icon,
  },
  {
    prefix .. 'u',
    function()
      require('dap').step_out()
    end,
    desc = 'Step out',
    icon = step_out_icon,
  },
})

local prefix_view = prefix .. 'V'
utils.vim.map.add_with_icon({
  { prefix_view, group = 'show-view' },
  { prefix_view .. 'w', [[<Cmd>DapViewShow watches<Cr>]], desc = 'Show Watches' },
  { prefix_view .. 's', [[<Cmd>DapViewShow scopes<Cr>]], desc = 'Show Scopes' },
  { prefix_view .. 'e', [[<Cmd>DapViewShow exceptions<Cr>]], desc = 'Show Exceptions' },
  { prefix_view .. 'b', [[<Cmd>DapViewShow breakpoints<Cr>]], desc = 'Show Breakpoints' },
  { prefix_view .. 't', [[<Cmd>DapViewShow threads<Cr>]], desc = 'Show Threads' },
  { prefix_view .. 'r', [[<Cmd>DapViewShow repl<Cr>]], desc = 'Show REPL' },
}, {
  icon = '󰈈',
  color = 'azure',
})
