local wezterm = require 'wezterm';
local mykeys = {}
local envs = {}
local launch_menu = {}

local my_default_prog = {"bash", "-i", "-l"}
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  my_default_prog = {"C:\\msys64\\usr\\bin\\bash.exe", "-i", "-l"}
  envs = {
    MSYSTEM = "MINGW64"
  }
end

table.insert(launch_menu, {
  label = 'cmd',
  args = { 'cmd.exe' }
})

table.insert(mykeys, {
  key = "l",
  mods = "LEADER",
  action = wezterm.action.ShowLauncher
})

for i = 1, 8 do
  -- CTRL+ALT + number to move to that position
  table.insert(mykeys, {
    key = tostring(i),
    mods = 'CTRL|ALT',
    action = wezterm.action.MoveTab(i - 1),
  })
  table.insert(mykeys, {
    key = tostring(i),
    mods = 'LEADER',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

table.insert(mykeys, {
  key = "l",
  mods = "LEADER",
  action= wezterm.action.ShowLauncher
})

table.insert(mykeys, {
  key = "[",
  mods = "LEADER",
  action="ActivateCopyMode"
})

return {
  font = wezterm.font("Cica"),
  font_size = 21,
  default_prog = {"C:\\msys64\\usr\\bin\\bash.exe", "-i", "-l"},
  window_background_opacity = 0.8,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  tab_bar_at_bottom = true,
  leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 },
  keys = mykeys,
  launch_menu = launch_menu,
  set_environment_variables = envs
}
