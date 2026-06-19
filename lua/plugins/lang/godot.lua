return {
  {
    'Mathijs-Bakker/godotdev.nvim',
    dependencies = { 'nvim-dap', 'nvim-dap-ui', 'nvim-treesitter' },
    ft = { 'gdscript', 'gdresource' },
    opts = {
      csharp = true, -- Enable C# Installation Support
      autostart_editor_server = true, -- opt-in: start a Neovim server automatically on setup
    },
  },
}
