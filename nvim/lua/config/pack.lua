-- File-based plugin loader for vim.pack (lazy.nvim-style spec files).
--
-- Each lua/plugins/<name>.lua returns ONE spec or a LIST of specs:
--   {
--     "owner/repo",                 -- or src = "https://github.com/owner/repo"
--     dependencies = { "owner/dep" },-- optional extra sources
--     name = "...", version = "...", -- optional (version: branch/tag or vim.version.range)
--     priority = 50,                 -- optional; higher = config() runs earlier
--     build = ":TSUpdate",           -- optional; string :cmd or function, run on install/update
--     config = function() ... end,   -- optional setup
--   }
--
-- vim.pack has no lazy-loading and no auto-deps, so the loader:
--   1. gathers every spec,
--   2. does ONE vim.pack.add() of all sources (so everything is on the
--      runtimepath before any config runs -> dependency order is solved),
--   3. runs config() callbacks in priority order.

local plugins_dir = vim.fn.stdpath("config") .. "/lua/plugins"

local function to_url(s)
  if type(s) == "table" then
    s = s.src or s[1]
  end
  if s:match("^%w[%w+.%-]*://") or s:match("^%w+:%w") then
    return s -- already a URL or shorthand (gh:user/repo)
  end
  return "https://github.com/" .. s
end

local function spec_name(s)
  if s.name then
    return s.name
  end
  return (to_url(s):gsub("%.git$", ""):match("([^/]+)$"))
end

-- 1. Collect specs from every module under lua/plugins/.
local specs = {}
for _, file in ipairs(vim.fn.globpath(plugins_dir, "**/*.lua", false, true)) do
  local mod = file:match("/lua/(.+)%.lua$")
  if mod then
    mod = mod:gsub("/", ".")
    local ok, ret = pcall(require, mod)
    if ok and type(ret) == "table" then
      -- A single spec has `.src` or a STRING `[1]`. A list has table elements.
      if ret.src or type(ret[1]) == "string" then
        specs[#specs + 1] = ret
      else
        for _, s in ipairs(ret) do
          specs[#specs + 1] = s
        end
      end
    elseif not ok then
      vim.schedule(function()
        vim.notify("plugin spec error in " .. mod .. ":\n" .. tostring(ret), vim.log.levels.ERROR)
      end)
    end
  end
end

-- 2. Build the deduped vim.pack.add list. A plugin may also appear as another
-- plugin's dependency (a bare string with no version); when the same URL is
-- pushed more than once, keep/fill in any name/version so the versioned spec
-- (e.g. nvim-treesitter -> "master") wins regardless of push order.
local add, index = {}, {}
local function push(item)
  local url = to_url(item)
  local name = type(item) == "table" and item.name or nil
  local version = type(item) == "table" and item.version or nil
  local entry = index[url]
  if entry then
    if name and not entry.name then
      entry.name = name
    end
    if version and not entry.version then
      entry.version = version
    end
    return
  end
  entry = { src = url, name = name, version = version }
  index[url] = entry
  add[#add + 1] = entry
end
for _, s in ipairs(specs) do
  for _, d in ipairs(s.dependencies or {}) do
    push(d)
  end
  push(s)
end

-- 3. Register build hooks BEFORE add() (see :h vim.pack).
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(args)
    local data = args.data or {}
    if data.kind == "delete" or not data.spec then
      return
    end
    for _, s in ipairs(specs) do
      if s.build and spec_name(s) == data.spec.name then
        if type(s.build) == "function" then
          pcall(s.build)
        else
          pcall(vim.cmd, s.build)
        end
      end
    end
  end,
})

-- 4. Install (first run) + load everything.
vim.pack.add(add)

-- 5. Run config() callbacks, highest priority first.
table.sort(specs, function(a, b)
  return (a.priority or 50) > (b.priority or 50)
end)
for _, s in ipairs(specs) do
  if type(s.config) == "function" then
    local ok, err = pcall(s.config)
    if not ok then
      vim.schedule(function()
        vim.notify("config error (" .. spec_name(s) .. "):\n" .. tostring(err), vim.log.levels.ERROR)
      end)
    end
  end
end
