-- tools tab
setDefaultTab("Tools")

if type(storage.moneyItems) ~= "table" then
  storage.moneyItems = {3031, 3035}
end
macro(1000, "Trocar dinheiro", function()
  if not storage.moneyItems[1] then return end
  local containers = g_game.getContainers()
  for index, container in pairs(containers) do
    if not container.lootContainer then -- ignore monster containers
      for i, item in ipairs(container:getItems()) do
        if item:getCount() == 100 then
          for m, moneyId in ipairs(storage.moneyItems) do
            if item:getId() == moneyId.id then
              return g_game.use(item)            
            end
          end
        end
      end
    end
  end
end)

local moneyContainer = UI.Container(function(widget, items)
  storage.moneyItems = items
end, true)
moneyContainer:setHeight(35)
moneyContainer:setItems(storage.moneyItems)

UI.Separator()

macro(60000, "Send message on trade", function()
  local trade = getChannelId("advertising")
  if not trade then
    trade = getChannelId("trade")
  end
  if trade and storage.autoTradeMessage:len() > 0 then    
    sayChannel(trade, storage.autoTradeMessage)
  end
end)
UI.TextEdit(storage.autoTradeMessage or "Dbo Mirai o melhor dboserver da galera!", function(widget, text)    
  storage.autoTradeMessage = text
end)

UI.Separator()


local keys = "Escape"
onKeyPress(function(keyss)
   if (keyss == keys) then
    targetName = ""
   end
end)


local targetName = ""
macro(1000, "Sense last target", function()
 if g_game.isAttacking() and g_game.getAttackingCreature():isPlayer() then
   targetName = g_game.getAttackingCreature():getName()
 end
if targetName:len() >= 1  and not g_game.isAttacking() then
  say('sense "'.. targetName)
delay(3000)
 end
end)


UI.Label("ESC limpa o sense")
