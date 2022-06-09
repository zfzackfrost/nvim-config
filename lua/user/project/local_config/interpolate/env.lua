local M = {}
local Fs = Utils.fs

local function get_default_project_name(root)
  local dir = Fs.Path:new(root):parent()
  return tostring(Fs.Path:new(root):make_relative(tostring(dir)))
end

local function get_default_project_author()
  return os.getenv('USER') or 'author-namr'
end

function M.make_env(root, is_env, cfg)
  cfg = cfg or {}
  if is_env then
    -- Available if in env.yml
    cfg.project_root = root
  else
    -- Available if NOT in env.yml
    cfg.project_root = cfg.project_root or root
    cfg.project_name = cfg.project_name or get_default_project_name(root)
    cfg.project_author = cfg.project_author or get_default_project_author()
  end
  return cfg
end

return M
