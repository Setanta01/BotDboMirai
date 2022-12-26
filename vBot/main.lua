local version = "4.8"
local currentVersion
local available = false





macro(100, function()

    if modules.corelib.g_keyboard.isKeyPressed(storage.turn)  then
        turnbeam = true
    elseif storage.turn:len() < 1 then
        turnbeam = true
    else 
        turnbeam = false
    
    
    end
    
    
      
      end)

storage.checkVersion = storage.checkVersion or 0

-- check max once per 12hours
if os.time() > storage.checkVersion + (12 * 60 * 60) then

    storage.checkVersion = os.time()
    
    HTTP.get("https://raw.githubusercontent.com/Vithrax/vBot/main/vBot/version.txt", function(data, err)
        if err then
          warn("[vBot updater]: Unable to check version:\n" .. err)
          return
        end

        currentVersion = data
        available = true
    end)

end

UI.Label("Bot Dbo Mirai")

UI.Label("SITE: dbo-mirai.online")
UI.Button("Ir ao site", function() g_platform.openUrl("https://dbo-mirai.online") end)
UI.Button("Discord Oficial DboMirai", function() g_platform.openUrl("https://discord.gg/57BV3dAsJk") end)
UI.Separator()

schedule(5000, function()

    if not available then return end
    if currentVersion ~= version then
        
        UI.Separator()
        UI.Label("New vBot is available for download! v"..currentVersion)
        UI.Button("Go to vBot GitHub Page", function() g_platform.openUrl("https://github.com/Vithrax/vBot") end)
        UI.Separator()
        
    end

end)
UI.Separator()


local config = storage["playerList"]
local playerTables = {config.friendList, config.enemyList, config.blackList}

friendList = config.friendList



 
for index, value in ipairs(friendList) do
    friendList[value:lower():trim()] = true
    friendList[index] = nil
end

macro(100, "Nao atacar aliados", function()

  for _, spec in ipairs(getSpectators()) do
    if spec:isPlayer() and not spec:isLocalPlayer() then
    if g_game.isAttacking() and target():isPlayer()  then
        if (target():getShield() ~= 1 and target():isPartyMember()) or target():getEmblem() == 1 then
        g_game.cancelAttackAndFollow()
        elseif friendList[spec:getName():lower()]  then
          g_game.cancelAttackAndFollow()
    
    
    end
  end
    
    
      end
    end
      end)
      

      macro(1, 'Auto Turn', function()
        if modules.corelib.g_keyboard.isKeyPressed('w') and dir ~= 0 then
          return turn(0) 
        elseif modules.corelib.g_keyboard.isKeyPressed('d') and dir ~= 1 then
          return turn(1) 
        elseif modules.corelib.g_keyboard.isKeyPressed('s') and dir ~= 2 then
          return turn(2)
        elseif modules.corelib.g_keyboard.isKeyPressed('a') and dir ~= 3 then
          return turn(3) 
        elseif modules.corelib.g_keyboard.isKeyPressed('up') and dir ~= 0 then
            return turn(0) 
          elseif modules.corelib.g_keyboard.isKeyPressed('right') and dir ~= 1 then
            return turn(1) 
          elseif modules.corelib.g_keyboard.isKeyPressed('down') and dir ~= 2 then
            return turn(2)
          elseif modules.corelib.g_keyboard.isKeyPressed('left') and dir ~= 3 then
            return turn(3) 
        end
        end)
        UI.Label("Auto turn beam by zodiaco")
        macro(1,"Auto Beam by Zodiaco", function()
            if g_game.isAttacking() and (getDistanceBetween(player:getPosition(), target():getPosition()) <= 1)  and turnbeam == true then
            local cpos = target():getPosition()
              local pos = player:getPosition()
                local diffx = cpos.x - pos.x
                local diffy = cpos.y - pos.y
                  local dir = player:getDirection()
            
            
            
            
                  if diffx == 1 and diffy == 1 then 
            xyz = target():getPosition()
             xyz.x =  xyz.x
             xyz.y = xyz.y + 1
            g_game.use(g_map.getTile(xyz):getTopUseThing(), 1, { ignoreNonPathable = true, precision = 1 })
                  elseif diffx == 1 and diffy == -1 then 
            xyz = target():getPosition()
             xyz.x = xyz.x + 1
             xyz.y = xyz.y 
            g_game.use(g_map.getTile(xyz):getTopUseThing(), 1, { ignoreNonPathable = true, precision = 1 })
                  elseif diffx == -1 and diffy == -1 then 
            xyz = target():getPosition()
             xyz.x = xyz.x - 1
             xyz.y = xyz.y
            g_game.use(g_map.getTile(xyz):getTopUseThing(), 1, { ignoreNonPathable = true, precision = 1 })
                  elseif diffx == -1 and diffy == 1 then 
            xyz = target():getPosition()
             xyz.x = xyz.x - 1
             xyz.y = xyz.y
            g_game.use(g_map.getTile(xyz):getTopUseThing(), 1, { ignoreNonPathable = true, precision = 1 })
            
            
            
                         elseif diffx == 1 and dir ~= 1 then turn(1)
                  elseif diffx == -1 and dir ~= 3 then turn(3)
                  elseif diffy == 1 and dir ~= 2 then turn(2)
                  elseif diffy == -1 and dir ~= 0 then turn(0)
                  end
            
            
            
            
            
            
            
            
            
            
            end
            end)
            UI.TextEdit(storage.turn or "coloque a tecla para ativar", function(widget, text)    
                storage.turn = text
              end)
              UI.Label("se parecer confuso veja o tutorial no nosso discord!!!")
              




        UI.Separator()

