--Local BAC level variables
--Legal limit set by law
local legalBacLevel = 0.08
--Limit that is set to change how drunk ped looks
local pedSlightDrunkBAC = 0.04

--BAC level used for checking against variables above.
local pedBacLevel = 0.0



RegisterNetEvent("bacclear")
RegisterNetEvent("bacset")
AddEventHandler("bacset", function(args, bacLevel)
    pedBacLevel = bacLevel
    TriggerEvent("chatMessage",  "[Breathalyzer]", {0,255,0}, args)
end)

RegisterNetEvent('breathalyzer')
AddEventHandler('breathalyzer', function(args)
    for i = 1, 5 do
        TriggerEvent("chat:addMessage", {
            color = {0, 255, 0},
            multiline = true,
            args = { 'Breathalyzer', 'beep' }
        })
        Citizen.Wait(1000)
    end
    
    TriggerEvent("chat:addMessage", {
        color = {0, 255, 0},
        multiline = true,
        args = { 'Breathalyzer', '^1results ... ' .. args }
    })
end)


Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(-1)
        if pedBacLevel >= legalBacLevel then
            RequestAnimSet("move_m@drunk@verydrunk")
            SetPedMovementClipset(ped, "move_m@drunk@verydrunk", true)
            SetPedIsDrunk(ped, true)
        end

        if (pedBacLevel >= pedSlightDrunkBAC and pedBacLevel < legalBacLevel) then
            RequestAnimSet("move_m@drunk@slightlydrunk")
            SetPedMovementClipset(ped, "move_m@drunk@slightlydrunk", true)
            SetPedIsDrunk(ped, true)
        end

        if (pedBacLevel == 0.0) then
            ResetPedMovementClipset(ped, 0.0)
        end
        Citizen.Wait(500)
    end
end)