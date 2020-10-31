local chatInputActive = false
local chatInputActivating = false
local chatHidden = true
local chatLoaded = false
local chatVisibilityToggle = false

RegisterNetEvent('chatMessage')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:addSuggestions')
RegisterNetEvent('chat:removeSuggestion')
RegisterNetEvent('chat:client:ClearChat')
RegisterNetEvent('chat:toggleChat')

-- internal events
RegisterNetEvent('__cfx_internal:serverPrint')

RegisterNetEvent('_chat:messageEntered')

--deprecated, use chat:addMessage
AddEventHandler('chatMessage', function(author, color, text)
  local args = { text }
  if author ~= "" then
    table.insert(args, 1, author)
  end
  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      color = color,
      args = args
    }
  })
end)

AddEventHandler('__cfx_internal:serverPrint', function(msg)
  print(msg)

  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      templateId = 'print',
      args = { msg }
    }
  })
end)

AddEventHandler('chat:addMessage', function(message)
  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = message
  })
end)

AddEventHandler('chat:addSuggestion', function(name, help, params)
  SendNUIMessage({
    type = 'ON_SUGGESTION_ADD',
    suggestion = {
      name = name,
      help = help,
      params = params or nil
    }
  })
end)

AddEventHandler('chat:addSuggestions', function(suggestions)
  for _, suggestion in ipairs(suggestions) do
    SendNUIMessage({
      type = 'ON_SUGGESTION_ADD',
      suggestion = suggestion
    })
  end
end)

AddEventHandler('chat:removeSuggestion', function(name)
  SendNUIMessage({
    type = 'ON_SUGGESTION_REMOVE',
    name = name
  })
end)

RegisterNetEvent('chat:resetSuggestions')
AddEventHandler('chat:resetSuggestions', function()
  SendNUIMessage({
    type = 'ON_COMMANDS_RESET'
  })
end)

AddEventHandler('chat:addTemplate', function(id, html)
  SendNUIMessage({
    type = 'ON_TEMPLATE_ADD',
    template = {
      id = id,
      html = html
    }
  })
end)

AddEventHandler('chat:client:ClearChat', function(name)
  SendNUIMessage({
    type = 'ON_CLEAR'
  })
end)





RegisterNUICallback('chatResult', function(data, cb)
  chatInputActive = false
  SetNuiFocus(false)

  if not data.canceled then
    local id = PlayerId()

    --deprecated
    local r, g, b = 0, 0x99, 255

    if data.message:sub(1, 1) == '/' then
      ExecuteCommand(data.message:sub(2))
    else
      TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, data.message)
    end
  end

  cb('ok')
end)

local function refreshCommands()
  if GetRegisteredCommands then
    local registeredCommands = GetRegisteredCommands()

    local suggestions = {}

    for _, command in ipairs(registeredCommands) do
        if IsAceAllowed(('command.%s'):format(command.name)) then
            table.insert(suggestions, {
                name = '/' .. command.name,
                help = ''
            })
        end
    end

    TriggerEvent('chat:addSuggestions', suggestions)
  end
end

local function refreshThemes()
  local themes = {}

  for resIdx = 0, GetNumResources() - 1 do
    local resource = GetResourceByFindIndex(resIdx)

    if GetResourceState(resource) == 'started' then
      local numThemes = GetNumResourceMetadata(resource, 'chat_theme')

      if numThemes > 0 then
        local themeName = GetResourceMetadata(resource, 'chat_theme')
        local themeData = json.decode(GetResourceMetadata(resource, 'chat_theme_extra') or 'null')

        if themeName and themeData then
          themeData.baseUrl = 'nui://' .. resource .. '/'
          themes[themeName] = themeData
        end
      end
    end
  end

  SendNUIMessage({
    type = 'ON_UPDATE_THEMES',
    themes = themes
  })
end

AddEventHandler('onClientResourceStart', function(resName)
  Wait(500)

  refreshCommands()
  refreshThemes()
end)

AddEventHandler('onClientResourceStop', function(resName)
  Wait(500)

  refreshCommands()
  refreshThemes()
end)

RegisterNUICallback('loaded', function(data, cb)
  TriggerServerEvent('chat:init');

  refreshCommands()
  refreshThemes()

  chatLoaded = true

  cb('ok')
end)

Citizen.CreateThread(function()
  SetTextChatEnabled(false)
  SetNuiFocus(false)

  while true do
    Wait(0)

    if not chatInputActive then
      if IsControlPressed(0, 245) --[[ INPUT_MP_TEXT_CHAT_ALL ]] then
        chatInputActive = true
        chatInputActivating = true

        SendNUIMessage({
          type = 'ON_OPEN'
        })
      end
    end

    if chatInputActivating then
      if not IsControlPressed(0, 245) then
        SetNuiFocus(true)

        chatInputActivating = false
      end
    end

    if chatLoaded then
      local shouldBeHidden = false

      if IsScreenFadedOut() or IsPauseMenuActive() then
        shouldBeHidden = true
      end

      if (shouldBeHidden and not chatHidden) or (not shouldBeHidden and chatHidden) then
        chatHidden = shouldBeHidden

        SendNUIMessage({
          type = 'ON_SCREEN_STATE_CHANGE',
          shouldHide = shouldBeHidden
        })
      end
    end
  end
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/ooc', 'Out Of Character Chat')
    ---TriggerEvent('chat:addSuggestion', '/g1', 'Glasses On')
    --TriggerEvent('chat:addSuggestion', '/g0', 'Glasses Off')
    --TriggerEvent('chat:addSuggestion', '/e1', 'Earrings On')
    --TriggerEvent('chat:addSuggestion', '/e0', 'Earrings Off')
    --TriggerEvent('chat:addSuggestion', '/m1', 'Mask On')
    --TriggerEvent('chat:addSuggestion', '/m0', 'Mask Off')
    --TriggerEvent('chat:addSuggestion', '/h1', 'Helmet On')
	--TriggerEvent('chat:addSuggestion', '/h0', 'Helmet Off')
	--TriggerEvent('chat:addSuggestion', '/outfitadd', 'Save your outfit')
	--TriggerEvent('chat:addSuggestion', '/outfituse', 'Use your saved outfit')
	--TriggerEvent('chat:addSuggestion', '/removeoutfit', 'Remove your saved outfit')
	--TriggerEvent('chat:addSuggestion', '/outfits', 'Display Saved Outfits List')
	--TriggerEvent('chat:addSuggestion', '/coords', 'Display Coordinates (Dev)')
	TriggerEvent('chat:addSuggestion', '/e', 'Play Emote')
	--TriggerEvent('chat:addSuggestion', '/emote', 'Play Emote')
	--TriggerEvent('chat:addSuggestion', '/emotebind', 'Bind an emote')
	--TriggerEvent('chat:addSuggestion', '/emotebinds', 'Display current binded emotes')
	--TriggerEvent('chat:addSuggestion', '/emotemenu', 'Toggle Emote Menu')
	--TriggerEvent('chat:addSuggestion', '/emotes', 'Display Emote Names')
	--TriggerEvent('chat:addSuggestion', '/emotes', 'Play Player WalkStyle')
	--TriggerEvent('chat:addSuggestion', '/walks', 'Display Walk Style Names')
	--TriggerEvent('chat:addSuggestion', '/nearby', 'Player a synced emote with a player')
	TriggerEvent('chat:addSuggestion', '/invin', 'Invite a player into your motel room')
	TriggerEvent('chat:addSuggestion', '/logout', 'Log out into character selection')
	--TriggerEvent('chat:addSuggestion', '/ping', 'Ping a player your current location')
	TriggerEvent('chat:addSuggestion', '/answer', 'Answer a phone call')
	TriggerEvent('chat:addSuggestion', '/hangup', 'Hang a phone call')
	TriggerEvent('chat:addSuggestion', '/number', 'Display your phone number')
	TriggerEvent('chat:addSuggestion', '/payphone', 'Use a payphone')
	TriggerEvent('chat:addSuggestion', '/cash', 'Display Cash')
	TriggerEvent('chat:addSuggestion', '/bank', 'Display Bank Balance')
	TriggerEvent('chat:addSuggestion', '/atm', 'Access ATM')
	--TriggerEvent('chat:addSuggestion', '/choplist', 'Get current vehicle chop list (Updates every 30 minutes)')
	--TriggerEvent('chat:addSuggestion', '/impound', 'Impound a Vehicle (Police Only)')
	--TriggerEvent('chat:addSuggestion', '/fix', 'Fix your vehicle (Police Only at PD Station)')
	--TriggerEvent('chat:addSuggestion', '/corner', 'Corner Sell drugs, 1-5 (Use /drugtypes)')
	--TriggerEvent('chat:addSuggestion', '/drugtypes', 'Displays Drug List for sale (corner 1-5)')
	--TriggerEvent('chat:addSuggestion', '/endcorner', 'End Corner Selling Drugs')
	TriggerEvent('chat:addSuggestion', '/breach', 'Breach House (Police Only)')
	--TriggerEvent('chat:addSuggestion', '/removetracker', 'Remove tracker device from vehicle')
	TriggerEvent('chat:addSuggestion', '/jailmenu', 'Access Jail Menu (Police Only)')
	TriggerEvent('chat:addSuggestion', '/jail', 'Jail Player (Police Only)')
	TriggerEvent('chat:addSuggestion', '/unjail', 'Unjail Player (Police Only)')
	--TriggerEvent('chat:addSuggestion', '/policestate', 'Change Livery (Police Only)')
	--TriggerEvent('chat:addSuggestion', '/policeextras', 'Equip All Extras (Police Only)')
	--TriggerEvent('chat:addSuggestion', '/spike', 'Deploy Spikes (Police Only)')
	--TriggerEvent('chat:addSuggestion', '/barrier', 'Deploy Barrier (Police Only)')
	TriggerEvent('chat:addSuggestion', '/givekeys', 'Give your vehicle keys')
	--TriggerEvent('chat:addSuggestion', '/hidemenu', 'Hide Radial Menu')
	--TriggerEvent('chat:addSuggestion', '/race', 'Setup a race (start/record/clear/leave/save/delete/list/load')
	--TriggerEvent('chat:addSuggestion', '/autopilot', 'Toggle Auto Pilot 1-4 (Electric Vehicles Only)')
	--TriggerEvent('chat:addSuggestion', '/entertrunk', 'Enter Trunk')
	--TriggerEvent('chat:addSuggestion', '/shuff', 'Shuffle Seat')
	--TriggerEvent('chat:addSuggestion', '/seat', 'Switch Seat (Number)')
	--TriggerEvent('chat:addSuggestion', '/check', 'Check Available Seat (Number)')
	--TriggerEvent('chat:addSuggestion', '/takehostage', 'Grab a person')
	--TriggerEvent('chat:addSuggestion', '/steal', 'Rob a person')
	--TriggerEvent('chat:addSuggestion', '/rob', 'Rob a dead body')
	--TriggerEvent('chat:addSuggestion', '/search', 'Search a person (Police Only)')
	TriggerEvent('chat:addSuggestion', '/tpm', 'Teleport to marker (Staff Only)')
	TriggerEvent('chat:addSuggestion', '/train', 'Order a train')
	TriggerEvent('chat:addSuggestion', '/shirt', 'Toggle Shirt')
	TriggerEvent('chat:addSuggestion', '/pants', 'Toggle Pants')
	TriggerEvent('chat:addSuggestion', '/gloves', 'Toggle Gloves')
	TriggerEvent('chat:addSuggestion', '/neck', 'Toggle Necklace')
	TriggerEvent('chat:addSuggestion', '/vest', 'Toggle Vest')
	TriggerEvent('chat:addSuggestion', '/bag', 'Toggle Bag')
	TriggerEvent('chat:addSuggestion', '/watch', 'Toggle Watch')
	TriggerEvent('chat:addSuggestion', '/bracelet', 'Toggle Bracelet')
	TriggerEvent('chat:addSuggestion', '/shoes', 'Toggle Shoes')
	TriggerEvent('chat:addSuggestion', '/cam', 'Toggle Cam')
	TriggerEvent('chat:addSuggestion', '/bmic', 'Toggle Boom Microphone')
	TriggerEvent('chat:addSuggestion', '/mic', 'Toggle Microphone')
	TriggerEvent('chat:addSuggestion', '/givecash', 'Give Cash (ID)')
	TriggerEvent('chat:addSuggestion', '/carry', 'Carry Player')
	--TriggerEvent('chat:addSuggestion', '/carryped', 'Carry Ped NPC')
	--TriggerEvent('chat:addSuggestion', '/taximin', 'Set Minimum Fare (Taxi)')
	--TriggerEvent('chat:addSuggestion', '/taxifare', 'Base Fare (Taxi)')
	--TriggerEvent('chat:addSuggestion', '/taxireset', 'Reset Fare (Taxi)')
	--TriggerEvent('chat:addSuggestion', '/taxifreeze', 'Freeze Fare (Taxi)')
	--TriggerEvent('chat:addSuggestion', '/freezeweather', 'Enable/disable dynamic weather changes. (Staff Only)')
	--TriggerEvent('chat:addSuggestion', '/freezetime', 'Freeze / unfreeze time. (Staff Only)')
	TriggerEvent('chat:addSuggestion', '/weather', 'Change the weather. (Staff Only)')
	--TriggerEvent('chat:addSuggestion', '/blackout', 'Toggle blackout mode. (Staff Only)')
	--TriggerEvent('chat:addSuggestion', '/morning', 'Set the time to 09:00 (Staff Only)')
	--TriggerEvent('chat:addSuggestion', '/noon', 'Set the time to 12:00 (Staff Only)')
	--TriggerEvent('chat:addSuggestion', '/evening', 'Set the time to 18:00 (Staff Only)')
	--TriggerEvent('chat:addSuggestion', '/night', 'Set the time to 23:00 (Staff Only)')
	--TriggerEvent('chat:addSuggestion', '/timechange', 'Change the time. (Staff Only)')
	TriggerEvent('chat:addSuggestion', '/ensureInv', 'Refresh Inventory')
	TriggerEvent('chat:addSuggestion', '/hideinv', 'Hide Inventory')
	TriggerEvent('chat:addSuggestion', '/transfervehicle', 'Transfer Vehicle Ownership (Plate + ID)')
	TriggerEvent('chat:addSuggestion', '/hideinv', 'Hide Inventory')
	TriggerEvent('chat:addSuggestion', '/police', 'Police Announcement (Police Only)')
	TriggerEvent('chat:addSuggestion', '/ems', 'EMS Announcement (EMS Only)')
	TriggerEvent('chat:addSuggestion', '/court', 'Court House Announcement (Judge Only)')
	TriggerEvent('chat:addSuggestion', '/id', 'Display ID')
	TriggerEvent('chat:addSuggestion', '/staff', 'Staff Announcement (Staff Only)')
	TriggerEvent('chat:addSuggestion', '/me', 'display /me')
	TriggerEvent('chat:addSuggestion', '/do', 'display /do')
	TriggerEvent('chat:addSuggestion', '/clear', 'Clear Chat')
	--TriggerEvent('chat:addSuggestion', '/dice', 'Roll a Dice (1-6)')
	--TriggerEvent('chat:addSuggestion', '/rps', 'Play Rock Paper Scissors')
	TriggerEvent('chat:addSuggestion', '/100', 'Call Police (Emergency Call)')
	TriggerEvent('chat:addSuggestion', '/101', 'Call EMS (Emergency Call)')
	--TriggerEvent('chat:addSuggestion', '/fine', 'Fine a player (Police/EMS)')
	--TriggerEvent('chat:addSuggestion', '/putplate', 'Put Vehicle Plate')
	--TriggerEvent('chat:addSuggestion', '/removeplate', 'Remove Vehicle Plate')
	TriggerEvent('chat:addSuggestion', '/notepad', 'Open Notepad')
end)