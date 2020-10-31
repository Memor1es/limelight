ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('twt', function(source, args, rawCommand)
    local src = source
	local msg = rawCommand:sub(5)
	local args = msg
    if player ~= false then
        local name = GetPlayerName(source)
        local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Twitter', ''..name..'', ''..msg..'', 'CHAR_STRETCH', 0)
        end
    end
end, false)

RegisterCommand('fab', function(source, args, rawCommand)
    local src = source
	local msg = rawCommand:sub(5)
	local args = msg
    if player ~= false then
        local name = GetPlayerName(source)
        local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Facebook', ''..name..'', ''..msg..'', 'CHAR_DAVE', 0)
        end
    end
end, false)

RegisterCommand('amz', function(source, args, rawCommand)
    local src = source
	local msg = rawCommand:sub(5)
	local args = msg
    if player ~= false then
        local name = GetPlayerName(source)
        local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Amazon', ''..name..'', ''..msg..'', 'CHAR_BEVERLY', 0)
        end
    end
end, false)

RegisterCommand('ist', function(source, args, rawCommand)
    local src = source
	local msg = rawCommand:sub(5)
	local args = msg
    if player ~= false then
        local name = GetPlayerName(source)
        local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Instagram', ''..name..'', ''..msg..'', 'CHAR_BARRY', 0)
        end
    end
end, false)

RegisterCommand('ano', function(source, args, rawCommand)
    local src = source
	local msg = rawCommand:sub(5)
	local args = msg
    if player ~= false then
        local name = GetPlayerName(source)
        local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Anonymous', '', ''..msg..'', 'CHAR_ARTHUR', 0)
        end
    end
end, false)


RegisterCommand('bcso', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "police" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'BCSO', '~b~Broadcast', ''..msg..'', 'CHAR_ABIGAIL', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'BCSO', '~b~Not Authorized!' , '~b~You need to be an officer to be able to run this command.', 'CHAR_ABIGAIL', 0)
    end
    else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'BCSO', '~b~Not Authorized!' , '~b~You need to be an officer to be able to run this command.', 'CHAR_ABIGAIL', 0)
    end
 end, false)
 
 RegisterCommand('ems', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "ambulance" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'EMS', '~b~Broadcast', ''..msg..'', 'CHAR_MICHAEL', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'EMS', '~b~Not Authorized!' , '~b~You need to be an emergency services operator to be able to run this command.', 'CHAR_MICHAEL', 0)
    end
    else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'EMS', '~b~Not Authorized!' , '~b~You need to be an emergency services operator to be able to run this command.', 'CHAR_MICHAEL', 0)
    end
 end, false)
 

 
 
 
 
    
    
    
    
