-- #############################################################################
-- ################################### State ###################################
-- #############################################################################

---@module 'toggleterm.terminal'
---@type Terminal?
local saved_terminal

-- #############################################################################
-- ################################## Options ##################################
-- #############################################################################

-- ~~~~~~~~~~~~~~~~~~~~ Hook Functions ~~~~~~~~~~~~~~~~~~~~~

local function should_block_hook(argv)
  -- Note that argv contains all the parts of the CLI command, including
  -- Neovim's path, commands, options and files.
  -- See: :help v:argv

  -- In this case, we would block if we find the `-b` flag
  -- This allows you to use `nvim -b file1` instead of
  -- `nvim --cmd 'let g:flatten_wait=1' file1`
  return vim.tbl_contains(argv, '-b')

  -- Alternatively, we can block if we find the diff-mode option
  -- return vim.tbl_contains(argv, "-d")
end

local function pre_open_hook()
  local term = require('toggleterm.terminal')
  local termid = term.get_focused_id()
  saved_terminal = term.get(termid)
end

local function post_open_hook(opts)
  if opts.is_blocking and saved_terminal then
    -- Hide the terminal while it's blocking
    saved_terminal:close()
  else
    vim.api.nvim_set_current_win(opts.winnr)
  end

  -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
  -- If you just want the toggleable terminal integration, ignore this bit
  if opts.filetype == 'gitcommit' or opts.filetype == 'gitrebase' then
    autocmd('BufWritePost', {
      buffer = opts.bufnr,
      once = true,
      callback = vim.schedule_wrap(function()
        vim.api.nvim_buf_delete(opts.bufnr, {})
      end),
    })
  end
end

local function block_end_hook()
  -- After blocking ends (for a git commit, etc), reopen the terminal
  vim.schedule(function()
    if saved_terminal then
      saved_terminal:open()
      saved_terminal = nil
    end
  end)
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~ Table ~~~~~~~~~~~~~~~~~~~~~~~~~
---@module 'flatten'
---@type Flatten.PartialConfig
local opts = {
  window = {
    open = 'tab',
  },
  hooks = {
    should_block = should_block_hook,
    pre_open = pre_open_hook,
    post_open = post_open_hook,
    block_end = block_end_hook,
  },
}

-- #############################################################################
-- ################################### Setup ###################################
-- #############################################################################

require('flatten').setup(opts)
