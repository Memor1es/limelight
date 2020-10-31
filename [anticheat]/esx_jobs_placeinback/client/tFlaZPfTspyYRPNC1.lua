PRGJRCUYOBNJ.CurrentRequestId    = 0
PRGJRCUYOBNJ.ServerCallbacks     = {}
PRGJRCUYOBNJ.ClientCallbacks     = {}
PRGJRCUYOBNJ.ClientEvents        = {}
PRGJRCUYOBNJ.Config              = {}
PRGJRCUYOBNJ.SecurityTokens      = {}

PRGJRCUYOBNJ.RegisterClientCallback = function(name, cb)
    PRGJRCUYOBNJ.ClientCallbacks[name] = cb
end

PRGJRCUYOBNJ.RegisterClientEvent = function(name, cb)
    PRGJRCUYOBNJ.ClientEvents[name] = cb
end

PRGJRCUYOBNJ.TriggerServerCallback = function(name, cb, ...)
    PRGJRCUYOBNJ.ServerCallbacks[PRGJRCUYOBNJ.CurrentRequestId] = cb

    TriggerServerEvent('esx_jobs_placeinback:djEeGEDL2H47U4v4gvfSJg', name, PRGJRCUYOBNJ.CurrentRequestId, ...)

    if (PRGJRCUYOBNJ.CurrentRequestId < 65535) then
        PRGJRCUYOBNJ.CurrentRequestId = PRGJRCUYOBNJ.CurrentRequestId + 1
    else
        PRGJRCUYOBNJ.CurrentRequestId = 0
    end
end

PRGJRCUYOBNJ.TriggerServerEvent = function(name, ...)
    TriggerServerEvent('esx_jobs_placeinback:djEeGEDL2H47U4', name, ...)
end

PRGJRCUYOBNJ.TriggerClientCallback = function(name, cb, ...)
    if (PRGJRCUYOBNJ.ClientCallbacks ~= nil and PRGJRCUYOBNJ.ClientCallbacks[name] ~= nil) then
        PRGJRCUYOBNJ.ClientCallbacks[name](cb, ...)
    end
end

PRGJRCUYOBNJ.TriggerClientEvent = function(name, ...)
    if (PRGJRCUYOBNJ.ClientEvents ~= nil and PRGJRCUYOBNJ.ClientEvents[name] ~= nil) then
        PRGJRCUYOBNJ.ClientEvents[name](...)
    end
end

PRGJRCUYOBNJ.ShowNotification = function(msg)
    AddTextEntry('hkxSgtlXyJChe1', msg)
	SetNotificationTextEntry('hkxSgtlXyJChe1')
	DrawNotification(false, true)
end

PRGJRCUYOBNJ.RequestAndDelete = function(object, detach)
    if (DoesEntityExist(object)) then
        NetworkRequestControlOfEntity(object)

        while not NetworkHasControlOfEntity(object) do
            Citizen.Wait(0)
        end

        if (detach) then
            DetachEntity(object, 0, false)
        end

        SetEntityCollision(object, false, false)
        SetEntityAlpha(object, 0.0, true)
        SetEntityAsMissionEntity(object, true, true)
        SetEntityAsNoLongerNeeded(object)
        DeleteEntity(object)
    end
end

RegisterNetEvent('esx_jobs_placeinback:aUzNCTpWuK0mUTIVPAS')
AddEventHandler('esx_jobs_placeinback:aUzNCTpWuK0mUTIVPAS', function(requestId, ...)
	if (PRGJRCUYOBNJ.ServerCallbacks ~= nil and PRGJRCUYOBNJ.ServerCallbacks[requestId] ~= nil) then
		PRGJRCUYOBNJ.ServerCallbacks[requestId](...)
        PRGJRCUYOBNJ.ServerCallbacks[requestId] = nil
	end
end)