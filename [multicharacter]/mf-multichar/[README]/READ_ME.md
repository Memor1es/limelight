# Conversion
To convert from regular ESX install, or Kashacters install, check the file at src/server/convert.lua.
You will need to modify the "tables" table inside of said file to correspond with all database tables and identifier values that need to be modified.
Once you have filled out the tables correctly, firing the command (once) prior to players joining should convert all of your previous character data to this multi characters system. 
You will then need to restart the server to complete the conversion process.

# Installation
The following resources/files must be changed in order for this script to work correctly.
Take note of the version number regarding ESX framework modifications, and also note
the type of change required (remove, modify, insert) and in which file.

## RESOURCE: ESX V1 Final
### FILE: client/main.lua
#### TYPE: REMOVE CODE
--[[
if NetworkIsPlayerActive(PlayerId()) then
  TriggerServerEvent('esx:onPlayerJoined')
  break
end
]]

## RESOURCE ESX V1.2
### FILE: client/main.lua
#### TYPE: REMOVE CODE
--[[
if isFirstSpawn then
  TriggerServerEvent('esx:playerJoined')
end
]]

## RESOURCE: ESSENTIALMODE (USING ESX V1.1)
### FILE: client/main.lua
#### TYPE: REMOVE CODE
--[[
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

    if NetworkIsSessionStarted() then
      TriggerServerEvent('es:firstJoinProper')
      TriggerEvent('es:allowedToSpawn')
      return
    end
  end
end)

TriggerServerEvent('es:firstJoinProper')
--]]

## RESOURCE: ESX V1 Final
### FILE: server/main.lua
#### TYPE: MODIFY FUNCTION
function onPlayerJoined(playerId)
  TriggerEvent("Multichar:GetCharacterIdentifier",playerId,function(identifier)
    if identifier then
      if ESX.GetPlayerFromIdentifier(identifier) then
        DropPlayer(playerId, ('there was an error loading your character!\nError code: identifier-active-ingame\n\nThis error is caused by a player on this server who has the same identifier as you have. Make sure you are not playing on the same Rockstar account.\n\nYour Rockstar identifier: %s'):format(identifier))
      else
        MySQL.Async.fetchScalar('SELECT 1 FROM users WHERE identifier = @identifier', {
          ['@identifier'] = identifier
        }, function(result)
          if result then
            loadESXPlayer(identifier, playerId)
          else
            local accounts = {}

            for account,money in pairs(Config.StartingAccountMoney) do
              accounts[account] = money
            end

            MySQL.Async.execute('INSERT INTO users (accounts, identifier) VALUES (@accounts, @identifier)', {
              ['@accounts'] = json.encode(accounts),
              ['@identifier'] = identifier
            }, function(rowsChanged)
              loadESXPlayer(identifier, playerId)
            end)
          end
        end)
      end
    else
      DropPlayer(playerId, 'there was an error loading your character!\nError code: identifier-missing-ingame\n\nThe cause of this error is not known, your identifier could not be found. Please come back later or report this problem to the server administration team.')
    end
  end)
end

## RESOURCE: ESX V1.2
### FILE: server/main.lua
#### TYPE: MODIFY FUNCTION
function onPlayerJoined(playerId)
  TriggerEvent("Multichar:GetCharacterIdentifier",playerId,function(identifier)
    if identifier then
      MySQL.Async.fetchScalar('SELECT 1 FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
      }, function(result)
        if result then
          loadESXPlayer(identifier, playerId)
        else
          MySQL.Async.execute('INSERT INTO users (identifier) VALUES (@identifier)', {
            ['@identifier'] = identifier
          }, function(rowsChanged)
            loadESXPlayer(identifier, playerId)
          end)
        end
      end)
    else
      DropPlayer(playerId, 'Your Rockstar license could not be found')
    end
  end)
end

## RESOURCE: ESSENTIALMODE (USING ESX V1.1)
### FILE: server/main.lua
#### TYPE: MODIFY FUNCTION
RegisterServerEvent('es:firstJoinProper')
AddEventHandler('es:firstJoinProper', function()
  local Source = source
  TriggerEvent("Multichar:GetCharacterIdentifier",Source,function(id)
    if not id then
      DropPlayer(Source, "SteamID not found, please try reconnecting with Steam open.")
    else
      registerUser(id, Source)
      justJoined[Source] = true

      if(settings.defaultSettings.pvpEnabled)then
        TriggerClientEvent("es:enablePvp", Source)
      end
    end
  end)
end)

## RESOURCE: ESX (ALL VERSIONS)
### FILE: server/main.lua
#### TYPE: INSERT FUNCTION
AddEventHandler('esx:playerLogout', function(source,callback)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer then
    TriggerEvent('esx:playerDropped', source, reason)

    ESX.SavePlayer(xPlayer, function()
      ESX.Players[source] = nil
      callback()
    end)
  end
  
  TriggerClientEvent("esx:onPlayerLogout",source)
end)

## RESOURCE: ESX (ALL VERSIONS)
### FILE: client/main.lua
#### TYPE: INSERT FUNCTION
RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function(source,callback)
  ESX.PlayerLoaded = false
end)

## RESOURCE: ESX SKIN
### FILE: client/main.lua
#### TYPE: REMOVE FUNCTION
--[[
AddEventHandler('playerSpawned', function()
  Citizen.CreateThread(function()
    while not PlayerLoaded do
      Citizen.Wait(10)
    end

    if FirstSpawn then
      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        if skin == nil then
          TriggerEvent('skinchanger:loadSkin', {sex = 0}, OpenSaveableMenu)
        else
          TriggerEvent('skinchanger:loadSkin', skin)
        end
      end)

      FirstSpawn = false
    end
  end)
end)
]]

## RESOURCE: SKINCHANGER
### FILE: client.lua
#### TYPE: MODIFY FUNCTION
function LoadDefaultModel(malePed, cb)
  local playerPed = PlayerPedId()
  local characterModel

  if malePed then
    characterModel = GetHashKey('mp_m_freemode_01')
    Character["sex"] = 0
  else
    characterModel = GetHashKey('mp_f_freemode_01')
    Character["sex"] = 1
  end

  RequestModel(characterModel)  

  Citizen.CreateThread(function()
    while not HasModelLoaded(characterModel) do
      RequestModel(characterModel)
      Citizen.Wait(0)
    end

    if IsModelInCdimage(characterModel) and IsModelValid(characterModel) then
      SetPlayerModel(PlayerId(), characterModel)
      SetPedDefaultComponentVariation(playerPed)
      for i=1, #Components, 1 do
        if Components[i].name ~= "sex" then
          Character[Components[i].name] = Components[i].value
        end
      end
      ApplySkin(Character)
    end

    SetModelAsNoLongerNeeded(characterModel)

    if cb ~= nil then
      cb()
    end

    TriggerEvent('skinchanger:modelLoaded')
  end)
end