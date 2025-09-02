-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	  -- If you want static names per index:
    local names = { "work", "work", "chroot", "misc", "doc" }
    local title = names[tab.tab_index + 1] or ("Tab " .. (tab.tab_index + 1))
    return { { Text = " " .. title .. " " } }
end)

-- helper: ensure at least `index+1` tabs exist, then switch
--
 local function activate_or_spawn_tab(index)

   return function(window, pane)
       local mux_win = wezterm.mux.get_window(window:window_id())
       local tabs = mux_win:tabs()
       local needed = (index + 1) - #tabs
       for _ = 1, needed > 0 and needed or 0 do
          window:perform_action(wezterm.action.SpawnTab "CurrentPaneDomain", pane)
       end
       window:perform_action(wezterm.action.ActivateTab(index), pane)
   end
end
                               -- register events for Ctrl+1..9
-- This will hold the configuration.
local config = wezterm.config_builder()

for i = 0, 5 do
    local name = "activate-or-spawn-tab-" .. (i + 1)
    wezterm.on(name, activate_or_spawn_tab(i))
end

-- Monokai-inspired palette
local colors = {
  background = "#272822",
  foreground = "#F8F8F2",
  accent = "#F92672",
  info = "#66D9EF",
  highlight = "#FD971F",
  red_complementary = "#3A3A3A",
}

-- Helper: cross-platform CPU usage
local function get_cpu_usage()
  local handle
  if wezterm.target_triple:find("windows") then
    return 0 -- Windows example, could be improved with PowerShell
  else
    handle = io.popen("top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}'")
  end
  if handle then
    local result = handle:read("*a")
    handle:close()
    local usage = tonumber(result:match("%d+%.?%d*")) or 0
    return usage
  end
  return 0
end

-- Battery info
local function get_battery()
  local batteries = wezterm.battery_info()
  if #batteries > 0 then
    local bat = batteries[1]
    return string.format("%.0f%%", bat.state_of_charge * 100)
  else
    return "N/A"
  end
end

-- Statusline: left (user@host:cwd)
wezterm.on("update-left-status", function(window, pane)
  local user = os.getenv("USER") or ""
  local host = wezterm.hostname()
  local cwd = pane:get_current_working_dir() or ""
  cwd = cwd:gsub("^file://", "")
  cwd = cwd:match(".*/(.+)$") or cwd

  window:set_left_status(wezterm.format({
    {Foreground={Color=colors.foreground}, Background={Color=colors.accent}, Text=" " .. user},
    {Foreground={Color=colors.foreground}, Background={Color=colors.accent}, Text="@"},
    {Foreground={Color=colors.foreground}, Background={Color=colors.accent}, Text=host},
    {Foreground={Color=colors.foreground}, Background={Color=colors.accent}, Text=":" .. cwd .. " "},
  }))
end)

-- Statusline: right (CPU | BAT | Tab X/Y | Time)
wezterm.on("update-right-status", function(window, pane)
  local mux_win = mux.get_window(window:window_id())
  local tabs = mux_win:tabs()
  local active_tab = mux_win:active_tab()
  local active_index = 1
  for i, t in ipairs(tabs) do
    if t:tab_id() == active_tab:tab_id() then
      active_index = i
      break
    end
  end

  local cpu = string.format("CPU: %.0f%%", get_cpu_usage())
  local bat = "BAT: " .. get_battery()
  local tab_text = string.format("Tab %d/%d", active_index, #tabs)
  local time = wezterm.strftime("%H:%M %d-%b-%Y")

  window:set_right_status(wezterm.format(
    {
       {Foreground={Color=colors.foreground}},
       {Background={Color=colors.highlight}},
       {Text=" " .. tab_text .. " "},
       "ResetAttributes",
       {Foreground={Color=colors.foreground}}, 
       {Background={Color=colors.info}}, 
       {Text=" " .. bat .. " "},
       "ResetAttributes",
       {Foreground={Color=colors.foreground}},
       {Background={Color=colors.red_complementary}}, 
       {Text=" " .. cpu .. " "},
       "ResetAttributes",
       {Foreground={Color=colors.foreground}},
       {Background={Color=colors.accent}}, 
       {Text=" " .. time .. " "},
       "ResetAttributes",
   })
  )
end)

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 13
--config.color_scheme = 'Monokai (dark) (terminal.sexy)'
--config.color_scheme = 'Monokai Dark (Gogh)'
config.color_scheme = 'Monokai Pro (Gogh)'
config.enable_tab_bar = true 
config.use_fancy_tab_bar = false   -- makes it more minimal (plain text)
config.tab_bar_at_bottom = true
config.tab_max_width = 16          -- limit width like tmux

local helpers = dofile(wezterm.config_dir .. "\\wezterm_helper.lua")

wezterm.on("session", function(window, pane, args)
  local subcmd = args[1]
  local name   = args[2]
  local cwdarg = args[3]
  local layoutarg = args[4]

  if subcmd == "new" then
    local final_name = name or ("default_session_" .. helpers.random_string(6))
    local default_cwd = pane:get_current_working_dir():gsub("file://[^/]+", "")

    -- parse layout
    local layout = {}
    if layoutarg then
      for s in string.gmatch(layoutarg, "([^;]+)") do
        table.insert(layout, s)
      end
    end
    if #layout == 0 then
      table.insert(layout, helpers.default_shell())
    end

    -- parse cwd(s)
    local cwd_list = {}
    if cwdarg then
      for s in string.gmatch(cwdarg, "([^;]+)") do
        table.insert(cwd_list, s)
      end
    end
    if #cwd_list == 0 then
      cwd_list[1] = default_cwd
    end
    while #cwd_list < #layout do
      table.insert(cwd_list, cwd_list[#cwd_list])
    end

    helpers.new_session(final_name, cwd_list, layout)

  elseif subcmd == "attach" then
    if not name then
      wezterm.log_error("session attach requires a session name")
      return
    end
    helpers.attach_session(name)

  elseif subcmd == "list" then
    helpers.list_sessions()

  elseif subcmd == "kill" then
    if not name then
      wezterm.log_error("session kill requires a session name")
      return
    end
    helpers.kill_session(name)

  else
    wezterm.log_error("Unknown session subcommand: " .. tostring(subcmd))
  end
end)

config.keys = {
    {
	    key = 'r',
	    mods = 'CTRL|SHIFT',
	    action = wezterm.action.ReloadConfiguration,
    },
    { key = "1", mods = "CTRL|SHIFT", action = wezterm.action.EmitEvent("activate-or-spawn-tab-"..1) },
    { key = "2", mods = "CTRL|SHIFT", action = wezterm.action.EmitEvent("activate-or-spawn-tab-"..2) },
    { key = "3", mods = "CTRL|SHIFT", action = wezterm.action.EmitEvent("activate-or-spawn-tab-"..3) },
    { key = "4", mods = "CTRL|SHIFT", action = wezterm.action.EmitEvent("activate-or-spawn-tab-"..4) },
    { key = "5", mods = "CTRL|SHIFT", action = wezterm.action.EmitEvent("activate-or-spawn-tab-"..5) },
    {
      key = "S",
      mods = "CTRL|SHIFT",
      action = wezterm.action.PromptInputLine {
        description = "session subcommand args...",
        action = wezterm.action_callback(function(window, pane, line)
          if not line then return end
          local parts = {}
          for s in string.gmatch(line, "([^|%s]+)") do
            table.insert(parts, s)
          end
          wezterm.emit("session", window, pane, parts)
        end),
      },
    },
--    {
--	    key = 'r',
--	    mods = 'CMD|SHIFT',
--	    action = wezterm.action.ReloadConfiguration,
--    },

}


return config
