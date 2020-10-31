ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

DiscordName = ""

RegisterNetEvent("bb_donatorsys:savePlayer")
AddEventHandler("bb_donatorsys:savePlayer", function(discname)
    DiscordName = discname
end)

CreateThread(function()
    TriggerServerEvent("bb_donatorsys:checkPlayer")
end)

RegisterCommand('refreshname', function()
    TriggerServerEvent("bb_donatorsys:checkPlayer")
end)

RegisterCommand('ooc', function(source, args, rawCommand)
	local msg = rawCommand:sub(4)
	TriggerServerEvent('bb-chat:sendOocGlobally', DiscordName, msg)
end, false)

RegisterCommand('ac', function(source, args, rawCommand)
	local msg = rawCommand:sub(4)
	TriggerServerEvent('bbcha:adminchatpermmision', DiscordName, msg)
end, false)

RegisterCommand('report', function(source, args, rawCommand)
	local msg = rawCommand:sub(7)
	--TriggerServerEvent('bbcha:sendReport', DiscordName, msg)
	src = source
	--GetPlayerName(src)
		local name = GetPlayerName(PlayerId())
  		local pId = GetPlayerServerId(PlayerId())
	TriggerServerEvent('bbcha:sendReport', name, pId, msg)
end, false)
