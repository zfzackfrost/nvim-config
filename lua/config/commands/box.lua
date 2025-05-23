local s = require('utils.str')
local c = require('utils.vim.comments')

local defaults = {
  width = 80,
  height = 1,
  dash = '-',
}

local function process_dash_input(value)
  if value == nil then
    return
  end
  if #value > 1 then
    vim.notify('dash must be a 1-character string!', vim.log.levels.ERROR)
    return
  elseif #value == 0 then
    value = defaults.dash
  end
  return value
end
local function process_int_input(value, name, default)
  if value == nil then
    return
  end
  value = vim.trim(value)
  if not string.match(value, '^%d*$') then
    vim.notify(string.format('%s must be an integer!', name), vim.log.levels.ERROR)
    return
  end
  if value == '' then
    value = default
  end
  value = tonumber(value)
  if value < 1 then
    vim.notify(string.format('%s must be >= 1!', name), vim.log.levels.ERROR)
    return
  end
  return value
end

local function make_comment_box(text, visual, width, height, dash)
  text = vim.trim(text)
  if #text > 0 then
    text = ' ' .. text .. ' '
  end

  local start_dashes = math.floor((width - #text) / 2.0 + 0.5)
  local end_dashes = width - start_dashes - #text

  local commentstring = vim.trim(string.gsub(vim.bo.commentstring, '%%s', ''))
  local remove_spaces = s.ends_with(commentstring, dash)

  local text_line = s.rep(dash, start_dashes) .. text .. s.rep(dash, end_dashes)
  local dash_line = s.rep(dash, width)
  text_line = c.commented_text(text_line, nil, remove_spaces)
  dash_line = c.commented_text(dash_line, nil, remove_spaces)

  local start_dash_lines = math.floor(height / 2.0)
  local end_dash_lines = (height - start_dash_lines - 1)
  local lines = {}

  for _ = 1, start_dash_lines, 1 do
    table.insert(lines, dash_line)
  end
  table.insert(lines, text_line)
  for _ = 1, end_dash_lines, 1 do
    table.insert(lines, dash_line)
  end

  -- Remember defaults
  defaults.width = width
  defaults.height = height
  defaults.dash = dash

  -- Started from visual mode?
  if visual then
    local old_x = vim.fn.getreginfo()
    vim.fn.setreg('x', lines, 'v')
    vim.cmd('normal! gv"xp')
    vim.fn.setreg('x', old_x)
  else
    vim.api.nvim_put(lines, 'l', true, false)
  end
end

local function dash_callback(text, visual, width, height)
  return function(dash)
    dash = process_dash_input(dash)
    if dash == nil then
      return
    end
    make_comment_box(text, visual, width, height, dash)
  end
end
local function height_callback(text, visual, width)
  return function(height)
    height = process_int_input(height, 'height', defaults.height)
    if height == nil then
      return
    end
    vim.ui.input({
      default = defaults.dash,
      prompt = 'Dash: ',
    }, dash_callback(text, visual, width, height))
  end
end
local function width_callback(text, visual)
  return function(width)
    width = process_int_input(width, 'width', '' .. defaults.width)
    if width == nil then
      return
    end
    vim.ui.input({
      default = '' .. defaults.height,
      prompt = 'Height: ',
    }, height_callback(text, visual, width))
  end
end
local function text_callback(visual)
  return function(text)
    if text == nil then
      return
    end
    vim.ui.input({
      default = '' .. defaults.width,
      prompt = 'Width: ',
    }, width_callback(text, visual))
  end
end

local function comment_box()
  local selection = require('utils.vim.selection').get()
  local default_text = ''
  if selection ~= nil then
    default_text = table.concat(selection, ' ')
  end
  local mode = vim.fn.mode()
  local visual = (mode == 'v') or (mode == 'V')
  vim.ui.input({
    default = default_text,
    prompt = 'Text: ',
  }, text_callback(visual))
end
vim.api.nvim_create_user_command('CommentBox', comment_box, {})
