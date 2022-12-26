setDefaultTab("Main")

-- securing storage namespace
local panelName = "extras"
if not storage[panelName] then
  storage[panelName] = {}
end
local settings = storage[panelName]

-- basic elements
extrasWindow = UI.createWindow('ExtrasWindow', rootWidget)
extrasWindow:hide()
extrasWindow.closeButton.onClick = function(widget)
  extrasWindow:hide()
end

extrasWindow.onGeometryChange = function(widget, old, new)
  if old.height == 0 then return end
  
  settings.height = new.height
end

extrasWindow:setHeight(settings.height or 360)

-- available options for dest param
local rightPanel = extrasWindow.content.right
local leftPanel = extrasWindow.content.left

-- objects made by Kondrah - taken from creature editor, minor changes to adapt
local addCheckBox = function(id, title, defaultValue, dest, tooltip)
  local widget = UI.createWidget('ExtrasCheckBox', dest)
  widget.onClick = function()
    widget:setOn(not widget:isOn())
    settings[id] = widget:isOn()
    if id == "checkPlayer" then
      local label = rootWidget.newHealer.targetSettings.vocations.title
      if not widget:isOn() then
        label:setColor("#d9321f")
        label:setTooltip("! WARNING ! \nTurn on check players in extras to use this feature!")
      else
          label:setColor("#dfdfdf")
          label:setTooltip("")
      end
    end
  end
  widget:setText(title)
  widget:setTooltip(tooltip)
  if settings[id] == nil then
    widget:setOn(defaultValue)
  else
    widget:setOn(settings[id])
  end
  settings[id] = widget:isOn()
end

local addItem = function(id, title, defaultItem, dest, tooltip)
  local widget = UI.createWidget('ExtrasItem', dest)
  widget.text:setText(title)
  widget.text:setTooltip(tooltip)
  widget.item:setTooltip(tooltip)
  widget.item:setItemId(settings[id] or defaultItem)
  widget.item.onItemChange = function(widget)
    settings[id] = widget:getItemId()
  end
  settings[id] = settings[id] or defaultItem
end

local addTextEdit = function(id, title, defaultValue, dest, tooltip)
  local widget = UI.createWidget('ExtrasTextEdit', dest)
  widget.text:setText(title)
  widget.textEdit:setText(settings[id] or defaultValue or "")
  widget.text:setTooltip(tooltip)
  widget.textEdit.onTextChange = function(widget,text)
    settings[id] = text
  end
  settings[id] = settings[id] or defaultValue or ""
end

local addScrollBar = function(id, title, min, max, defaultValue, dest, tooltip)
  local widget = UI.createWidget('ExtrasScrollBar', dest)
  widget.text:setTooltip(tooltip)
  widget.scroll.onValueChange = function(scroll, value)
    widget.text:setText(title .. ": " .. value)
    if value == 0 then
      value = 1
    end
    settings[id] = value
  end
  widget.scroll:setRange(min, max)
  widget.scroll:setTooltip(tooltip)
  if max-min > 1000 then
    widget.scroll:setStep(100)
  elseif max-min > 100 then
    widget.scroll:setStep(10)
  end
  widget.scroll:setValue(settings[id] or defaultValue)
  widget.scroll.onValueChange(widget.scroll, widget.scroll:getValue())
end

UI.Button("Extras", function()
  extrasWindow:show()
  extrasWindow:raise()
  extrasWindow:focus()
end)
UI.Separator()

---- to maintain order, add options right after another:
--- add object
--- add variables for function (optional)
--- add callback (optional)
--- optionals should be addionaly sandboxed (if true then end)


addCheckBox("pathfinding", "CaveBot Pathfinding", true, leftPanel, "Cavebot will automatically search for first reachable waypoint after missing 10 goto's.")
addScrollBar("talkDelay", "Global NPC Talk Delay", 0, 2000, 1000, leftPanel, "Breaks between each talk action in cavebot (time in miliseconds).")
addScrollBar("looting", "Max Loot Distance", 0, 50, 40, leftPanel, "Every loot corpse futher than set distance (in sqm) will be ignored and forgotten.")
addScrollBar("lootDelay", "Loot Delay", 0, 1000, 200, leftPanel, "Wait time for loot container to open. Lower value means faster looting. \n WARNING if you are having looting issues(e.g. container is locked in closing/opnening), increase this value.")
addScrollBar("huntRoutes", "Hunting Rounds Limit", 0, 300, 50, leftPanel, "Round limit for supply check, if character already made more rounds than set, on next supply check will return to city.")
addScrollBar("killUnder", "Kill monsters below", 0, 100, 1, leftPanel, "Force TargetBot to kill added creatures when they are below set percentage of health - will ignore all other TargetBot settings.")
addScrollBar("gotoMaxDistance", "Max GoTo Distance", 0, 127, 30, leftPanel, "Maximum distance to next goto waypoint for the bot to try to reach.")
addCheckBox("reachable", "Target only pathable mobs", false, leftPanel, "Ignore monsters that can't be reached.")

addCheckBox("title", "Custom Window Title", true, rightPanel, "Personalize OTCv8 window name according to character specific.")
if true then
  local vocText = ""

  if voc() == 1 or voc() == 11 then
      vocText = "- EK"
  elseif voc() == 2 or voc() == 12 then
      vocText = "- RP"
  elseif voc() == 3 or voc() == 13 then
      vocText = "- MS"
  elseif voc() == 4 or voc() == 14 then
      vocText = "- ED"
  end

  macro(5000, function()
    if settings.title then
      if hppercent() > 0 then
          g_window.setTitle("Tibia - " .. name() .. " - " .. lvl() .. "lvl " .. vocText)
      else
          g_window.setTitle("Tibia - " .. name() .. " - DEAD")
      end
    else
      g_window.setTitle("Tibia - " .. name())
    end
  end)
end

addCheckBox("separatePm", "Abrir PM em  nova janela", false, rightPanel, "PM automaticamente abrirao uma nova aba")
if true then
  onTalk(function(name, level, mode, text, channelId, pos)
    if mode == 4 and settings.separatePm then
        local g_console = modules.game_console
        local privateTab = g_console.getTab(name)
        if privateTab == nil then
            privateTab = g_console.addTab(name, true)
            g_console.addPrivateText(g_console.applyMessagePrefixies(name, level, text), g_console.SpeakTypesSettings['private'], name, false, name)
        end
        return
    end
  end)
end










addCheckBox("autoOpenDoors", "Auto abrir portas", true, rightPanel, "abre portas automaticamente")
if true then
  local doorsIds = { 5007, 8265, 1629, 1632, 5129, 6252, 6249, 7715, 7712, 7714, 
                     7719, 6256, 1669, 1672, 5125, 5115, 5124, 17701, 17710, 1642, 
                     6260, 5107, 4912, 6251, 5291, 1683, 1696, 1692, 5006, 2179, 5116, 
                     1632, 11705, 30772, 30774, 6248, 5735, 5732, 5120, 23873, 5736,
                     6264, 5122, 30049, 30042, 7727 }

  function checkForDoors(pos)
    local tile = g_map.getTile(pos)
    if tile then
      local useThing = tile:getTopUseThing()
      if useThing and table.find(doorsIds, useThing:getId()) then
        g_game.use(useThing)
      end
    end
  end

  onKeyPress(function(keys)
    local wsadWalking = modules.game_walking.wsadWalking
    if not settings.autoOpenDoors then return end
    local pos = player:getPosition()
    if keys == 'Up' or (wsadWalking and keys == 'W') then
      pos.y = pos.y - 1
    elseif keys == 'Down' or (wsadWalking and keys == 'S') then
      pos.y = pos.y + 1
    elseif keys == 'Left' or (wsadWalking and keys == 'A') then
      pos.x = pos.x - 1
    elseif keys == 'Right' or (wsadWalking and keys == 'D') then
      pos.x = pos.x + 1
    elseif wsadWalking and keys == "Q" then
      pos.y = pos.y - 1
      pos.x = pos.x - 1
    elseif wsadWalking and keys == "E" then
      pos.y = pos.y - 1
      pos.x = pos.x + 1
    elseif wsadWalking and keys == "Z" then
      pos.y = pos.y + 1
      pos.x = pos.x - 1
    elseif wsadWalking and keys == "C" then
      pos.y = pos.y + 1
      pos.x = pos.x + 1
    end
    checkForDoors(pos)
  end)
end





addCheckBox("reUse", "ReUse", false, rightPanel, "Seleciona o item novamente apos uso")
if true then
  local excluded = {268, 237, 238, 23373, 266, 236, 239, 7643, 23375, 7642, 23374, 5908, 5942} 

  onUseWith(function(pos, itemId, target, subType)
    if settings.reUse and not table.find(excluded, itemId) then
      schedule(50, function()
        item = findItem(itemId)
        if item then
          modules.game_interface.startUseWith(item)
        end
      end)
    end
  end)
end






addCheckBox("checkPlayer", "Mostrar Lvl", true, rightPanel, "Mostra o Level dos players na tela")
if true then
  local found
  local function checkPlayers()
    for i, spec in ipairs(getSpectators()) do
      if spec:isPlayer() and spec:getText() == "" and spec:getPosition().z == posz() and spec ~= player then
          g_game.look(spec)
          found = now
      end
    end
  end
  if settings.checkPlayer then 
    schedule(500, function()
      checkPlayers()
    end)
  end

  onPlayerPositionChange(function(x,y)
    if not settings.checkPlayer then return end
    if x.z ~= y.z then
      schedule(20, function() checkPlayers() end)
    end
  end)

  onCreatureAppear(function(creature)
    if not settings.checkPlayer then return end
    if creature:isPlayer() and creature:getText() == "" and creature:getPosition().z == posz() and creature ~= player then
        g_game.look(creature)
        found = now
    end
  end)

  local regex = [[You see ([^\(]*) \(Level ([0-9]*)\)((?:.)* of the ([\w ]*),|)]]
  onTextMessage(function(mode, text)
    if not settings.checkPlayer then return end

    local re = regexMatch(text, regex)
    if #re ~= 0 then
        local name = re[1][2]
        local level = re[1][3]
        local guild = re[1][5] or ""

        if guild:len() > 10 then
          guild = guild:sub(1,10) -- change to proper (last) values
          guild = guild.."..."
        end

        local creature = getCreatureByName(name)
        if creature then
            creature:setText("\n"..level.."\n".. guild)
        end
        if found and now - found < 500 then
          modules.game_textmessage.clearMessages()
        end
    end
  end)
end


