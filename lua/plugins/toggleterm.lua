return {
  {
    'akinsho/toggleterm.nvim',
    version = false,
    opts = function()
      return {
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<C-\>]],
        hide_numbers = false,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = 'horizontal',
        close_on_exit = true,
        auto_scroll = true,
        winbar = {
          enabled = true,
        },
      }
    end,
  },
}
