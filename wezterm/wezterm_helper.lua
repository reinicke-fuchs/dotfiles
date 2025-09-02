-- wezterm_helpers.lua
local wezterm = require 'wezterm'
local mux = wezterm.mux

local M = {}

-- Generate random string for default session name
function M.random_string(len)
  local chars = "abcdefghijklmnopqrstuvwxyz0123456789"
  local s = ""
  for i = 1, len do
    local idx = math.random(#chars)
    s = s .. chars:sub(idx, idx)
  end
  return s
end

-- Determine default shell
function M.default_shell()
  for _, sh in ipairs({ "bash", "zsh", "sh" }) do
    local handle = io.popen("which " .. sh .. " 2>/dev/null")
    local result = handle:read("*a")
    handle:close()
    if result ~= "" then
      return sh
    end
  end
  return "sh"
end

-- Spawn a new session with tabs/panes
function M.new_session(name, cwd_list, layout)
  local first_cmd = layout[1] or M.default_shell()
  local win, first_pane, _ = mux.spawn_window {
    workspace = name,
    cwd = cwd_list[1],
    args = { first_cmd },
  }

  local current_pane = first_pane

  for i = 2, #layout do
    local entry = layout[i]
    local tab_cwd = cwd_list[i] or cwd_list[#cwd_list]

    if entry:match("^split:") then
      local parts = {}
      for s in string.gmatch(entry, "([^:]+)") do
        table.insert(parts, s)
      end
      local dir = parts[2] or "horizontal"
      local cmd = parts[3] or M.default_shell()
      local direction = (dir == "vertical") and "Right" or "Bottom"

      current_pane = current_pane:split {
        direction = direction,
        args = { cmd },
        cwd = tab_cwd,
      }
    else
      local _, pane, _ = win:spawn_tab {
        cwd = tab_cwd,
        args = { entry },
      }
      current_pane = pane
    end
  end

  wezterm.log_info("Created session: " .. name)
end

-- Attach, list, and kill session helpers
function M.attach_session(name)
  mux.set_active_workspace(name)
  wezterm.log_info("Attached to session: " .. name)
end

function M.list_sessions()
  local names = mux.get_workspace_names()
  wezterm.log_info("Sessions: " .. table.concat(names, ", "))
end

function M.kill_session(name)
  mux.kill_workspace(name)
  wezterm.log_info("Killed session: " .. name)
end

return M
