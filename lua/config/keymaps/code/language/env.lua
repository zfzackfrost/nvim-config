return {
  ft = 'env',
  name = 'env',
  cond = function()
    return string.match(vim.fn.expand('%:p:t'), '.*%.env.*$')
  end,
  mappings = {
    {
      'c',
      '<Cmd>CloakToggle<Cr>',
      desc = 'Toggle variable cloak',
    },
    {
      'C',
      '<Cmd>CloakPreviewLine<Cr>',
      desc = 'Uncloak line variable',
    },
  },
}
