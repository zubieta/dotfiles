-- luacheck: globals hs
------------------------------------------------------------
-- Utils

-- Print the exit code, stdout and stderr
local function reportExit(commandName)
  local function printExit(code, out, error)
    print(string.format('%s exited with code %d', commandName, code))
    print('stdout: ' .. out)
    print('stderr: ' .. error)
  end
  return printExit
end

-- Don't report anything
local function skipExit(code, out, error)
end

------------------------------------------------------------
-- Key bindings

-- Lock screen
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'L', function()
  hs.task.new('/usr/bin/pmset', skipExit, {'displaysleepnow'}):start()
  -- **Note**: displaysleepnow requires to have set the
  -- option: `System Settings -> Security & Privacy
  -- -> Require password ... after sleep or screen saver
  -- begins` to _immediately_.
  --
  -- Another alternative is to use hs.caffeinate.lockScreen()
  -- but you won't be able to use TouchID to unlock.
end)

-- Manual reload HS configuration
hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'R', function()
  hs.reload()
  hs.notify.new({title='Hammerspoon config reloaded',
    informativeText='Manually via keyboard shortcut'}):send()
end)

-- Rotate keyboard layout
hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'K', function()
  current = hs.keycodes.currentLayout()
  layouts = hs.keycodes.layouts()
  for k, v in pairs(layouts) do
    if current == v then
      newLayout = layouts[k % #layouts + 1]
      hs.keycodes.setLayout(newLayout)
      hs.notify.new({title='Keyboard layout changed to ' .. newLayout,
                     contentImage=hs.keycodes.currentLayoutIcon()}):send()
    end
  end
end)

local function currentWindow()
  -- Focused window
  local window = hs.window.focusedWindow()
  if window ~= nil then
    return window
  end

  -- App main window
  local app = hs.application.frontmostApplication()
  window = app:mainWindow()
  if window ~= nil then
    return window
  end

  -- App first window
  for _, window in ipairs(app:allWindows()) do
    return window
  end

  -- No window found
  return nil
end

-- Current window to left side of the display
hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'Left', function()
  local window = currentWindow()
  if window ~= nil then
    window:unminimize()
    local frame = window:frame()
    local screen = window:screen()
    local max = screen:frame()

    frame.x = max.x
    frame.y = max.y
    frame.w = max.w / 2
    frame.h = max.h
    window:setFrame(frame)
  end
end)

-- Current window to the right side of the display
hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'Right', function()
  local window = currentWindow()
  if window ~= nil  then
    window:unminimize()
    local frame = window:frame()
    local screen = window:screen()
    local max = screen:frame()

    frame.x = max.x + (max.w / 2)
    frame.y = max.y
    frame.w = max.w / 2
    frame.h = max.h
    window:setFrame(frame)
  end
end)

-- Maximize current window
hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'Up', function()
  local window = currentWindow()
  if window ~= nil then
    window:unminimize()
    window:maximize()
  end
end)

-- Minimize current window
hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'Down', function()
  hs.window.focusedWindow():minimize()
end)

------------------------------------------------------------
-- Watchers

-- Auto reload HS configuration
local function reloadConfig(files)
  local doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == '.lua' then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
    hs.notify.new({title='Hammerspoon config reloaded',
      informativeText='Config change detected'}):send()
  end
end
local hsConfigWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/', reloadConfig)
hsConfigWatcher:start()

-- Auto mute on wake (So no music blast happens by surprise)
local function muteOnWake(eventType)
  if (eventType == hs.caffeinate.watcher.systemDidWake) then
    local output = hs.audiodevice.defaultOutputDevice()
    output:setMuted(true)
  end
end
local caffeinateWatcher = hs.caffeinate.watcher.new(muteOnWake)
caffeinateWatcher:start()


------------------------------------------------------------
-- Window Management

-- Make active window cycle through the different screens
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'm', function()
  hs.window.focusedWindow():moveToScreen(hs.window.focusedWindow():screen():next())
end)

------------------------------------------------------------
-- Caffeine

local caffeine = hs.menubar.new()
local firstlaunch = true
local function setCaffeineDisplay(state)
  if state then
    caffeine:setIcon('./assets/coffee-cup-color.tiff', true)
  else
    caffeine:setIcon('./assets/coffee-cup.tiff', true)
  end
  -- Don't show the notification if the configuration was just loaded
  if not firstlaunch then
    if state then
      hs.notify.new({title='Caffeine activated',
          informativeText='Inhibiting desktop idleness',
        contentImage='./assets/coffee-cup-color-256x256.png'}):send()
    else
      hs.notify.new({title='Caffeine deactivated',
          informativeText='No longer inhibiting desktop idleness',
        contentImage='./assets/coffee-cup-color-256x256.png'}):send()
    end
  else
    firstlaunch = false
  end
end

local function caffeineClicked()
  setCaffeineDisplay(hs.caffeinate.toggle('displayIdle'))
end

if caffeine then
  caffeine:setClickCallback(caffeineClicked)
  setCaffeineDisplay(hs.caffeinate.get('displayIdle'))
end

hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'c', function ()
  setCaffeineDisplay(hs.caffeinate.toggle('displayIdle'))
end)

------------------------------------------------------------
-- Pagekite

-- pagekite = hs.menubar.new(false)
-- function updateKitesMenu(kites)
--   if kites > 0 and pagekite:isInMenuBar() then
--     pagekite:removeFromMenuBar()
--   elseif not pagekite:isInMenuBar() then
--     pagekite:returnToMenuBar()
--     pagekite:setIcon('./assets/kite.tiff')
--   end
-- end

------------------------------------------------------------
-- Cli

-- Load IPC
require 'hs.ipc'
-- Install cli if not installed
if not hs.ipc.cliStatus() then
  hs.ipc.cliInstall()
end
