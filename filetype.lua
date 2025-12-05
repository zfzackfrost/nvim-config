vim.filetype.add({
  extension = {
    ['scad'] = 'openscad',
    -- SPICE circuit/netlist/module/library
    ['spi'] = 'spice',
    ['cir'] = 'spice',
    ['ckt'] = 'spice',
    ['lib'] = 'spice',
    ['mod'] = 'spice',
    ['inc'] = 'spice',
    ['sub'] = 'spice',
  },
  pattern = {
    ['.*/SKSE/.*%.json'] = 'jsonc', -- Skyrim SKSE json file
  },
})
