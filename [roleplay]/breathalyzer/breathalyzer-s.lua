RegisterCommand("bacset", function(source, args)
    local chatString = ""
    local bacLevel = 0.0
    if tonumber(table.concat(args, " ")) == nil then
        chatString = "^1[ERROR]: ^0BAC must be a number" .. "^0"
        TriggerClientEvent("bacset", source, chatString, bacLevel)
    else
        local bacLevel = tonumber(table.concat(args, " "))
        if bacLevel >= 1 then
            bacLevel = bacLevel / 10
        end
        chatString = "^2BAC set to " .. bacLevel .. "^0"
        WriteRecords(source, bacLevel)
    end
end)

RegisterCommand("bacclear", function(source, args)
    MySQL.Async.fetchAll('DELETE FROM breathalyzer where id=@id',
    {
        ['id'] = GetPlayerIdentifiers(source)[1]
    },
    function(result)
        chatString = '^2BAC cleared'
        TriggerClientEvent('bacset', source, chatString, 0.0)
    end)
end)

RegisterCommand('breathalyzer', function(source, args)
    if args[1] ~= nil then
        local ped = GetPlayerIdentifiers(tonumber(args[1]))[1]
        if ped ~= nil then
            MySQL.Async.fetchAll('SELECT * from breathalyzer where id=@id',
            {
                ['@id'] = ped
            },
            function(result)
                TriggerClientEvent('breathalyzer', source, result[1].level)
            end)
        end
    end
end)

---------------------------------------------------
function WriteRecords(source, bacLevel)
    MySQL.Async.fetchAll('INSERT INTO breathalyzer (id, name, level) VALUES(@source, @name, @level) ON DUPLICATE KEY UPDATE level = @level',
    {
        ["@source"] = GetPlayerIdentifiers(source)[1],
        ["@name"] = GetPlayerName(source),
        ["@level"] = bacLevel
    },
    function(r)
        chatString = "^2BAC set to " .. bacLevel .. "^0"
        TriggerClientEvent("bacset", source, chatString, bacLevel)
    end)
end