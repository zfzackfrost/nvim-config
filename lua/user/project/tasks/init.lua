local M = {}
local Window = require('user.utils.window')

local run_shell_task = function(opts)
  local cmd = opts.cmd
  local cwd = opts.cwd
  local label = opts.label
  local wait = opts.wait or false

  local window = Window:new({
    create = {
      edge = Window.config.DockEdge.Bottom,
      win_type = Window.config.WindowType.Split,
      size = 0.2,
      buffer = {
        mode = Window.config.OpenBufferMode.CreateEmptyDestroyOnClose,
        listed = false,
        scratch = true,
      },
    },
  })

  if type(label) == 'string' then
    window:buffer().vars.user_buffer_label = string.format('[Task] %s ', label)
  end
  window.opts.number = false
  window.opts.relativenumber = false
  window.opts.signcolumn = 'auto'

  local job_opts = {
    on_exit = function(_, code, _)
      local is_success = code == 0
      local should_close = (is_success and wait == 'error') or (wait == false)
      if should_close then
        window:close(true)
      elseif type(wait) == 'number' then
        vim.defer_fn(function()
          pcall(function()
            window:close(true)
          end)
        end, math.floor(wait))
      end
    end,
    cwd = cwd,
  }

  local job_id = window:call(function()
    return vim.fn.termopen(cmd, job_opts)
  end)

  window:focus()

  local count = 0
  while vim.wait(1000, function()
    local code = vim.fn.jobwait({ job_id }, 0)[1]
    return code == -1
  end) do
    vim.cmd([[normal! G]])
    count = count + 1
    if count == 15 then
      break
    end
  end

  vim.cmd([[startinsert]])
end

M.run_task = function(task)
  local cmd = task.cmd
  local cwd = task.cwd
  local label = task.label
  local wait = task.wait or false

  if type(cmd) ~= 'string' then
    error(('Expected `string` for task.cmd, got %s'):format(type(cmd)))
  elseif type(label) ~= 'string' then
    error(('Expected `string` or `nil` for task.label, got %s'):format(type(label)))
  elseif type(cwd) ~= 'string' and cwd ~= nil then
    error(('Expected `string` or `nil` for task.cwd, got %s'):format(type(label)))
  elseif type(wait) ~= 'boolean' and wait ~= 'error' and type(wait) ~= 'number' and wait ~= nil then
    error(('Expected `nil` or `boolean` or `number` or "error" for task.wait, got %s'):format(type(wait)))
  end

  run_shell_task(task)
end

return M
