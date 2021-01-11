local eventtap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
    local keyCode = event:getKeyCode()
    if (keyCode == 38) then
        local scroll = hs.eventtap.event.newScrollEvent({0, -5},{},'pixel')
        scroll:post()
    elseif (keyCode == 40) then 
        local scroll = hs.eventtap.event.newScrollEvent({0, 5},{},'pixel')
        scroll:post()
    end
end)

-- Enable j and k to scroll in Acrobat Reader
function applicationWatcher(appName, eventType, appObject)
  if (eventType == hs.application.watcher.activated) then
    print(appName)
    if (appName == "Acrobat Reader") then
        eventtap:start()
    else
        eventtap:stop()
    end
  end
end

local appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

function moveLeft()
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.x = f.x - 20
	win:setFrame(f)
end

function moveRight()
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.x = f.x + 20
	win:setFrame(f)
end

-- Move focused window left and right by 20px
hs.hotkey.bind({"cmd", "shift", "ctrl"}, "A", moveLeft, nil, moveLeft)
hs.hotkey.bind({"cmd", "shift", "ctrl"}, "D", moveRight, nil, moveRight)

