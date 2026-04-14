local wk = require('which-key')
local prefix = '<leader>d'
wk.add({
  { prefix, group = 'debug' },
  {
    prefix .. '<Cr>',
    [[<Cmd>DebugStart<Cr>]],
    desc = 'Start debugging',
  },
  {
    prefix .. 'q',
    [[<Cmd>DebugStop<Cr>]],
    desc = 'Terminate debugging',
  },
  {
    prefix .. 'v',
    [[<Cmd>DapViewOpen<Cr>]],
    desc = 'Open debugging view',
  },
  {
    prefix .. 'r',
    function()
      require('dap').continue()
    end,
    desc = 'Continue',
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
  },
  {
    prefix .. 'o',
    function()
      require('dap').step_over()
    end,
    desc = 'Step over',
  },
  {
    prefix .. 'u',
    function()
      require('dap').step_out()
    end,
    desc = 'Step out',
  },
})
