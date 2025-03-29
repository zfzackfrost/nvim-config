return {
  ft = 'toml',
  name = 'crates',
  cond = function()
    return vim.fn.expand('%:p:t') == 'Cargo.toml'
  end,
  mappings = {
    {
      'u',
      function()
        require('crates').upgrade_crate()
      end,
      desc = 'Upgrate crate',
    },
    {
      'U',
      function()
        require('crates').upgrade_all_crates()
      end,
      desc = 'Upgrate all crates',
    },
    {
      't',
      function()
        require('crates').expand_plain_crate_to_inline_table()
      end,
      desc = 'Expand crate to inline table',
    },
    {
      'T',
      function()
        require('crates').extract_crate_into_table()
      end,
      desc = 'Extract crate to table',
    },
    {
      'd',
      function()
        require('crates').open_documentation()
      end,
      desc = 'Open crate documentation',
    },
  },
}
