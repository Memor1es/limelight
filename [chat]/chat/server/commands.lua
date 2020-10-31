ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
		}
	else
		return nil
	end
end

--[[ COMMANDS ]]--

RegisterCommand('clear', function(source, args, rawCommand)
    TriggerClientEvent('chat:client:ClearChat', source)
end, false)


TriggerEvent('es:addGroupCommand', 'clearall', "superadmin", function(source, args, user)
	TriggerClientEvent('chat:client:ClearChat', -1)
end)

RegisterServerEvent('bb-chat:sendOocGlobally')
AddEventHandler('bb-chat:sendOocGlobally', function(playername, msg)
	local name = playername

	TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message" style="background-color: rgba(0, 213, 255, 0.75);"><b>OOC | {0}</b> {1}</div>',
        args = { name, msg}
    })
end)

RegisterCommand('police', function(source, args, rawCommand)
	-- If From Console
	if source == 0 then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(3, 0, 173, 0.75);">{0} <b>משטרת ישראל</b> <img src=' .. Config.Images.Police .. ' style="width:22px; padding-right: 5px; position:relative ; top: 3px;height:20px ;"></img></div>',
        	args = { args }
    	})
		
		TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, "CONSOLE", "```[Police] " .. args .. "```" )
		return
	end

	-- Emojis Stuff
	args = table.concat(args, ' ')
	args = args:gsub("%:heart:", "❤️")
    args = args:gsub("%:smile:", "🙂")
    args = args:gsub("%:thinking:", "🤔")
    args = args:gsub("%:check:", "✅")
    args = args:gsub("%:hot:", "🥵")
    args = args:gsub("%:sad:", "😦")

    -- Permmisions Stuff
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job ~= nil and xPlayer.job.name == 'police' or xPlayer.getPermissions() > 1 then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(52, 67, 235, 0.75);"><b>משטרת ישראל</b> {0}<img src=' .. Config.Images.Police .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img></div>',
        	args = { args }
    	})
	else
		TriggerClientEvent('chat:addMessage', source, {
        	template = '<div class="chat-message" style="background-color: rgba(66, 66, 66, 0.75); color: white;"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img><b>ADMIN</b> You are not a police officer</div>',
        	args = {}
    	})
	end
	
	-- Logs Stuff
	TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, GetPlayerName(source) .. " | " .. GetPlayerIdentifiers(source)[1], "```[Police] " .. args .. "```" )
end, false)

RegisterCommand('ems', function(source, args, rawCommand)
	-- If From Console
	if source == 0 then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(204, 7, 0, 0.75);">{0} <b>מגן דוד-אדום</b> <img src=' .. Config.Images.Ems .. ' style="width:22px; padding-right: 5px; position:relative ; top: 3px;height:20px ;"></img></div>',
        	args = { args }
    	})
		
		TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, "CONSOLE", "```[Police] " .. args .. "```" )
		return
	end

	-- Emojis Stuff
	args = table.concat(args, ' ')
	args = args:gsub("%:heart:", "❤️")
    args = args:gsub("%:smile:", "🙂")
    args = args:gsub("%:thinking:", "🤔")
    args = args:gsub("%:check:", "✅")
    args = args:gsub("%:hot:", "🥵")
    args = args:gsub("%:sad:", "😦")

    -- Permmisions Stuff
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job ~= nil and xPlayer.job.name == 'ambulance' or xPlayer.getPermissions() > 1 then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(204, 7, 0, 0.75);"><b>מגן דוד-אדום</b> {0}<img src=' .. Config.Images.Ems .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img></div>',
        	args = { args }
    	})
	else
		TriggerClientEvent('chat:addMessage', source, {
        	template = '<div class="chat-message" style="background-color: rgba(66, 66, 66, 0.75); color: white;"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img><b>ADMIN</b> You are not an EMS employer</div>',
        	args = {}
    	})
	end
	
	-- Logs Stuff
	TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, GetPlayerName(source) .. " | " .. GetPlayerIdentifiers(source)[1], "```[Police] " .. args .. "```" )
end, false)


RegisterCommand('court', function(source, args, rawCommand)
	-- If From Console
	if source == 0 then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(153, 71, 0, 0.75);">{0} <b>בית המשפט</b> <img src=' .. Config.Images.Court .. ' style="width:22px; padding-right: 5px; position:relative ; top: 3px;height:20px ;"></img></div>',
        	args = { args }
    	})
		
		TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, "CONSOLE", "```[Police] " .. args .. "```" )
		return
	end

	-- Emojis Stuff
	args = table.concat(args, ' ')
	args = args:gsub("%:heart:", "❤️")
    args = args:gsub("%:smile:", "🙂")
    args = args:gsub("%:thinking:", "🤔")
    args = args:gsub("%:check:", "✅")
    args = args:gsub("%:hot:", "🥵")
    args = args:gsub("%:sad:", "😦")

    -- Permmisions Stuff
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job ~= nil and xPlayer.job.name == 'mayor' or xPlayer.getPermissions() > 2 then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(153, 71, 0, 0.75);"><b>בית המשפט</b> {0}<img src=' .. Config.Images.Court .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img></div>',
        	args = { args }
    	})
	else
		TriggerClientEvent('chat:addMessage', source, {
        	template = '<div class="chat-message" style="background-color: rgba(66, 66, 66, 0.75); color: white;"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img><b>ADMIN</b> You are not an court employer</div>',
        	args = {}
    	})
	end
	
	-- Logs Stuff
	TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, GetPlayerName(source) .. " | " .. GetPlayerIdentifiers(source)[1], "```[Police] " .. args .. "```" )
end, false)

RegisterCommand('court', function(source, args, rawCommand)
	-- If From Console
	if source == 0 then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(153, 71, 0, 0.75);">{0} <b>בית המשפט</b> <img src=' .. Config.Images.Court .. ' style="width:22px; padding-right: 5px; position:relative ; top: 3px;height:20px ;"></img></div>',
        	args = { args }
    	})
		
		TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, "CONSOLE", "```[Police] " .. args .. "```" )
		return
	end

	-- Emojis Stuff
	args = table.concat(args, ' ')
	args = args:gsub("%:heart:", "❤️")
    args = args:gsub("%:smile:", "🙂")
    args = args:gsub("%:thinking:", "🤔")
    args = args:gsub("%:check:", "✅")
    args = args:gsub("%:hot:", "🥵")
    args = args:gsub("%:sad:", "😦")

    -- Permmisions Stuff
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job ~= nil and xPlayer.job.name == 'mayor' or xPlayer.getPermissions() > 1 then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(153, 71, 0, 0.75);"><b>בית המשפט</b> {0}<img src=' .. Config.Images.Court .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img></div>',
        	args = { args }
    	})
	else
		TriggerClientEvent('chat:addMessage', source, {
        	template = '<div class="chat-message" style="background-color: rgba(66, 66, 66, 0.75); color: white;"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img><b>ADMIN</b> You are not an court employer</div>',
        	args = {}
    	})
	end
	
	-- Logs Stuff
	TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, GetPlayerName(source) .. " | " .. GetPlayerIdentifiers(source)[1], "```[Police] " .. args .. "```" )
end, false)



--RegisterCommand('id', function(source, args, rawCommand)
--	if source == 0 then
--		return
--	end

--	TriggerClientEvent('bb_chat:id', -1, source, GetPlayerName(source))
--end, false)

RegisterCommand('stats', function(source, args, rawCommand)
	if source == 0 then
		return
	end

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('chat:addMessage', source, {
    	template = '<div class="chat-message" style="background-color: rgba(66, 66, 66, 0.75); color: white;"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img><b>ADMIN STATS</b> Group: {0} | Level: {1}</div>',
    	args = {xPlayer.getGroup(), xPlayer.getPermissions()}
    })
end, false)

--RegisterCommand('id', function(source, args, rawCommand)
--	TriggerClientEvent('chat:addMessage', source, {
  --  	template = '<div class="chat-message" style="background-color: rgba(66, 66, 66, 0.75); color: white;"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img><b>ID Info</b> Your ID: {0}</div>',
  --  	args = {GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1)))}
 --   })
--end)



RegisterServerEvent('bbcha:adminchatpermmision')
AddEventHandler('bbcha:adminchatpermmision', function(name, msg)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getPermissions() > 1 then
		sendToAllPlayers(name, msg)
	else
		TriggerClientEvent('chat:addMessage', _source, {
        	template = '<div class="chat-message" style="background-color: rgba(66, 66, 66, 0.75); color: white;"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img><b>ADMIN</b> You are not a staff member</div>',
        	args = {}
    	})
	end
end)

RegisterServerEvent('bbcha:adminchatsystem')
AddEventHandler('bbcha:adminchatsystem', function(name, msg)
	local _source = source
	sendToAllPlayers(name, GetPlayerName(_source) .. msg)
end)


RegisterNetEvent('bbcha:sendReport')
AddEventHandler('bbcha:sendReport', function(name, id, message)
  --local myId = ESX.GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))
  	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local NAME1 = GetPlayerName(_source)

	TriggerClientEvent('chat:addMessage', xPlayer.source, {
    	template = '<div class="chat-message" style="background-color: rgba(50, 117, 168, 0.75);"><b>Report ¦ {0} ({1}) ¦ </b> {2}</div>',
    	args = {NAME1, id, message}
    })  
			
	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers, 1 do
		xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.getPermissions() > 1 then
			TriggerClientEvent('chat:addMessage', xPlayer.source, {
    	template = '<div class="chat-message" style="background-color: rgba(255, 26, 26);"><b>Report ¦ {0} ({1}) ¦ </b> {2}</div>',
    			args = {NAME1, id, message}
    		})
    	end
    end
end)       	



function sendToAllPlayers(name, msg)
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.getPermissions() > 1 then
			TriggerClientEvent('chat:addMessage', xPlayer.source, {
    			template = '<div class="chat-message" style="background-color: rgba(171, 0, 14, 0.75);"><b>STAFF CHAT | {0}</b> {1}</div>',
    			args = {name, msg}
    		})
    	end
    end
end



RegisterCommand('staff', function(source, args, rawCommand)
	-- If From Console
	if source == 0 then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(138, 0, 0, 0.75);"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 3px;height:20px ;"></img><b>ADMIN:</b> {0}</div>',
        	args = { args }
    	})
		
		return
	end

	-- Emojis Stuff
	args = table.concat(args, ' ')
	args = args:gsub("%:heart:", "❤️")
    args = args:gsub("%:smile:", "🙂")
    args = args:gsub("%:thinking:", "🤔")
    args = args:gsub("%:check:", "✅")
    args = args:gsub("%:hot:", "🥵")
    args = args:gsub("%:sad:", "😦")

    -- Permmisions Stuff
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getPermissions() > 1 then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(138, 0, 0, 0.75);"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 3px;height:20px ;"></img><b>ADMIN:</b> {0}</div>',
        	args = { args }
    	})
	else
		TriggerClientEvent('chat:addMessage', source, {
        	template = '<div class="chat-message" style="background-color: rgba(66, 66, 66, 0.75); color: white;"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img><b>ADMIN</b> You are not a staff member</div>',
        	args = {}
    	})
	end
	
	-- Logs Stuff
	TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, GetPlayerName(source) .. " | " .. GetPlayerIdentifiers(source)[1], "```[Police] " .. args .. "```" )
end, false)
