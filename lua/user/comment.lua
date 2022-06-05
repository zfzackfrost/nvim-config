local bufmatch_commentstring = {
  -- Include
  {},
  -- Exclude
  {
    filetype = {
      '^wgsl$',
    },
  },
}

require('Comment').setup({
  pre_hook = function(ctx)
    local buf = Utils.Buffer:new({handle = 0})
    if not buf:match(unpack(bufmatch_commentstring)) then
      return
    end
    local U = require('Comment.utils')
    local location = nil
    if ctx.type == U.ctype.block then
      location = require('ts_context_commentstring.utils').get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require('ts_context_commentstring.utils').get_visual_start_location()
    end
    return require('ts_context_commentstring.internal').calculate_commentstring({
      key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
      location = location,
    })
  end,
})

local m = Utils.map
m.group_name('n', 'gc', 'comment-line')
m.map_name('n', 'gcc', 'Toggle')
m.map_name('n', 'gcA', 'EOL')
m.map_name('n', 'gcO', 'Above')
m.map_name('n', 'gco', 'Below')

m.group_name('n', 'gb', 'comment-block')
m.map_name('n', 'gbc', 'Toggle')

m.map_name('v', 'gc', 'Comment (line)')
m.map_name('v', 'gb', 'Comment (block)')
