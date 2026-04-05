return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
  },
  ---@module 'noice'
  ---@type NoiceConfig
  opts = {
    cmdline = {
      format = {
        cmd_new_file = {
          pattern = '^:NewFile%s+',
          icon = '󰝒',
          title = 'New File Pattern',
        },
        cmd_git = {
          pattern = '^:Git%s+',
          icon = '',
          icon_hl_group = 'MiniIconsRed',
          title = 'Git Operation',
        },
      },
    },
    lsp = {
      progress = {
        enabled = false,
      },
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
      },
    },
    presets = {
      bottom_search = false, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = true, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
  },
}
