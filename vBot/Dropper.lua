setDefaultTab("Tools")

macro(200, function()
if not spellhide == true then
  spell1:hide()
  spell2:hide()
    spell3:hide()
    spell4:hide()
    spell5:hide()
    spell6:hide()
    spell7:hide()
  spellhide = true

end
end)

local ui = setupUI([[
Panel
  height: 19

  BotSwitch
    id: title
    anchors.top: parent.top
    anchors.left: parent.left
    text-align: center
    width: 130
    !text: tr('Combo Maker')

  Button
    id: edit
    anchors.top: prev.top
    anchors.left: prev.right
    anchors.right: parent.right
    margin-left: 3
    height: 17
    text: Edit
]])

local edit = setupUI([[
Panel
  height: 20
    
  Label
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    margin-top: 5
    text-align: center
    text: Tecnicas do combo

  BotContainer
    id: TrashItems
    anchors.top: prev.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    height: 

  Label
    anchors.top: prev.bottom
    margin-top: 5
    anchors.left: parent.left
    anchors.right: parent.right
    text-align: center
    text: 

  BotContainer
    id: UseItems
    anchors.top: prev.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    height: 

  Label
    anchors.top: prev.bottom
    margin-top: 5
    anchors.left: parent.left
    anchors.right: parent.right
    text-align: center
    text: 

  BotContainer
    id: CapItems
    anchors.top: prev.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    height:    
]])
edit:hide()



local config = storage.dropper

local showEdit = false
ui.edit.onClick = function(widget)
  showEdit = not showEdit
  if showEdit then
    edit:show()
    spell1:show()
    spell2:show()
    spell3:show()
    spell4:show()
    spell5:show()
    spell6:show()
    spell7:show()

  else
    edit:hide()
    spell1:hide()
    spell2:hide()
    spell3:hide()
    spell4:hide()
    spell5:hide()
    spell6:hide()
    spell7:hide()

  end
end

ui.title:setOn(config.enabled)
ui.title.onClick = function(widget)
  config.enabled = not config.enabled
  ui.title:setOn(config.enabled)
end

spell1 = UI.TextEdit(storage.spell1 or "", function(widget, text)    
  storage.spell1 = text
end)

spell2 = UI.TextEdit(storage.spell2 or "", function(widget, text)    
  storage.spell1 = text
end)

spell3 = UI.TextEdit(storage.spell3 or "", function(widget, text)    
  storage.spell3 = text
end)

spell4 = UI.TextEdit(storage.spell4 or "", function(widget, text)    
  storage.spell4 = text
end)

spell5 = UI.TextEdit(storage.spell5 or "", function(widget, text)    
  storage.spell5 = text
end)

spell6 = UI.TextEdit(storage.spell6 or "", function(widget, text)    
  storage.spell6 = text
end)

spell7 = UI.TextEdit(storage.spell7 or "", function(widget, text)    
  storage.spell7 = text
end)






macro(200, function()
  if config.enabled and g_game.isAttacking() then
    say(storage.spell1)
    say(storage.spell2)
    say(storage.spell3)
    say(storage.spell4)
    say(storage.spell5)
    say(storage.spell6)
    say(storage.spell7)
  end

end)