return {
  'nvim-mini/mini-git',
  version = false,
  main = 'mini.git',
  cmd = { 'Git' },
  opts = {
    job = {
      git_executable = 'git',
      timeout = 30000, -- Force quit after 30 seconds
    },
    command = {
      split = 'auto',
    },
  },
}
