return {
  {
    'mfussenegger/nvim-dap',
    cmd = { 'DapNew', 'DapTerminate' },
  },
  {
    'igorlfs/nvim-dap-view',
    lazy = false,
    version = '1.*',
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {},
  },
}
