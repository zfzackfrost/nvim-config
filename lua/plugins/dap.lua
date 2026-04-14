return {
  {
    'mfussenegger/nvim-dap',
    dependencies = { 'rcarriga/nvim-dap-ui' },
    cmd = { 'DapNew', 'DapTerminate' },
  },
  {
    'igorlfs/nvim-dap-view',
    -- let the plugin lazy load itself
    lazy = false,
    version = '1.*',
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {},
  },
}
