return {
  {
    'MagicDuck/grug-far.nvim',
    cmd = { 'GrugFar' },
    opts = function()
      return {
        keymaps = {
          replace = { n = '<C-r>' },
          qflist = { n = '<C-q>' },
          syncLocations = { n = 's' },
          syncLine = { n = 'L' },
          close = { n = '<Esc>' },
          historyOpen = { n = 'ht' },
          historyAdd = { n = 'ha' },
          pickHistoryEntry = { n = 'hh' },
          refresh = { n = 'R' },
          openLocation = { n = 'oo' },
          openNextLocation = { n = 'on' },
          openPrevLocation = { n = 'op' },
          gotoLocation = { n = '<Cr>' },
          abort = { n = 'b' },
          help = { n = 'g?' },
          toggleShowCommand = { n = 'w' },
          swapEngine = { n = 'e' },
          previewLocation = { n = 'p' },
          swapReplacementInterpreter = { n = 'x' },
          applyNext = { n = 'an' },
          applyPrev = { n = 'ap' },
          syncNext = { n = 'sn' },
          syncPrev = { n = 'sp' },
          syncFile = { n = 'sf' },
          nextInput = { n = '<tab>' },
          prevInput = { n = '<s-tab>' },
        },
      }
    end,
  },
}
