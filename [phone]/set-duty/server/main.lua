ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


AddEventHandler("playerDropped", function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade

    if job == 'police' or job == 'ambulance' or job == 'mechanic' then
        xPlayer.setJob('off' ..job, grade)
        TriggerEvent("TokoVoip:removePlayerFromAllRadio", _source)
        TriggerEvent("eblips:remove", _source)
        print("Set job to off for a player")
    end
end)

RegisterServerEvent('duty:onoff')
AddEventHandler('duty:onoff', function(job)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    
    if job == 'police' or job == 'ambulance' or job == 'mechanic' or job == 'ballas' or job == 'vagos' or job == 'blackmarket' then
        xPlayer.setJob('off' ..job, grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'status = off', length = 9000})
        TriggerEvent("TokoVoip:removePlayerFromAllRadio", _source)
        TriggerEvent("eblips:remove", _source)
    elseif job == 'offpolice' then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '!נכנסת לשירות', length = 9000})

        xPlayer.setJob('police', grade)
        if xPlayer.getInventoryItem('radio').count >= 1 then
            TriggerEvent("TokoVoip:addPlayerToRadio", 1, _source)
        end
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'status = on', length = 9000})
        TriggerEvent("eblips:add", {name = "Police", src = _source, color = 42})
    elseif job == 'offambulance' then
    
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '!נכנסת לשירות', length = 9000})
        xPlayer.setJob('ambulance', grade)
        if xPlayer.getInventoryItem('radio').count >= 1 then
            TriggerEvent("TokoVoip:addPlayerToRadio", 2, _source)
        end
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'status = on', length = 9000})
        TriggerEvent("eblips:add", {name = "Ballas", src = _source, color = 42})
    elseif job == 'offballas' then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '!נכנסת לשירות', length = 9000})
        xPlayer.setJob('ballas', grade)
        if xPlayer.getInventoryItem('radio').count >= 1 then
            TriggerEvent("TokoVoip:addPlayerToRadio", 2, _source)
        end
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ' status = on', length = 9000})
        TriggerEvent("eblips:add", {name = "Vagos", src = _source, color = 42})
    elseif job == 'offvagos' then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '!נכנסת לשירות', length = 9000})
        xPlayer.setJob('vagos', grade)
        if xPlayer.getInventoryItem('radio').count >= 1 then
            TriggerEvent("TokoVoip:addPlayerToRadio", 2, _source)
        end
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ' status = on', length = 9000})
        TriggerEvent("eblips:add", {name = "Blackmarket", src = _source, color = 42})
    elseif job == 'offblackmarket' then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '!נכנסת לשירות', length = 9000})
        xPlayer.setJob('blackmarket', grade)
        if xPlayer.getInventoryItem('radio').count >= 1 then
            TriggerEvent("TokoVoip:addPlayerToRadio", 2, _source)
        end
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ' status = on', length = 9000})
        TriggerEvent("eblips:add", {name = "Mechanic", src = _source, color = 1})
    elseif job == 'offmechanic' then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '!נכנסת לשירות', length = 9000})
        xPlayer.setJob('mechanic', grade) 
        if xPlayer.getInventoryItem('radio').count >= 1 then
            TriggerEvent("TokoVoip:addPlayerToRadio", 11, _source)
        end
    end
end)