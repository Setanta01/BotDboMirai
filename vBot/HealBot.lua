local standBySpells = false
local standByItems = false

local red = "#ff0800" -- "#ff0800" / #ea3c53 best
local blue = "#7ef9ff"

setDefaultTab("HP")

local level = player:getLevel()
macro(200, "HEALBOT", function()
  if (hppercent() <= 99) and (level >= 250) then

  say('big regeneration')
  elseif (hppercent() <= 96) then
    say('regeneration')
  end
  end)




  macro(100, "Anti Paralyze", nil, function()
    if isParalyzed() and (hppercent() >= 50) and (level >= 100) then
      saySpell('Super Speed')
    elseif isParalyzed() and (hppercent() >= 50) then
      saySpell('Speed UP')
      
  
  end
  end)
  
  
  
macro(100, "Correr", nil, function()
    if not hasHaste() and (hppercent() >= 50) and (level >= 100) then
      saySpell('Super Speed')
    elseif not hasHaste() and (hppercent() >= 50) then
      saySpell('Speed UP')

  
  end
  end)
  UI.Label("Healbot,correr e anti lyse configurados para usar as spells a partir do level certo automaticamente!")