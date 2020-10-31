---------------------------------------
--      ESX_WASHLAB by Dividerz      --
-- FOR SUPPORT: Arne#7777 on Discord --
---------------------------------------

Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
unProcessedMoneySheets = unProcessedMoneySheets or 0
moneySheets = moneySheets or 0
cuttedMoney = cuttedMoney or 0
isProducingSheets = false
isCountingMoney = false
producingTime = Config.ProducingTime
countingTime = Config.CountingTime

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

AddEventHandler('onResourceStart', function(resource)
	isLoggedIn = true
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    isLoggedIn = true
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        local playerPed = GetPlayerPed(-1)
        local playerPosition = GetEntityCoords(playerPed)


        -- ENTER TELEPORTER
        if (GetDistanceBetweenCoords(playerPosition, Config.Locations.washinglab.teleporters.enter.x, Config.Locations.washinglab.teleporters.enter.y, Config.Locations.washinglab.teleporters.enter.z, true) < 5) then
            DrawMarker(2, Config.Locations.washinglab.teleporters.enter.x, Config.Locations.washinglab.teleporters.enter.y, Config.Locations.washinglab.teleporters.enter.z-0.20, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
            if (GetDistanceBetweenCoords(playerPosition, Config.Locations.washinglab.teleporters.enter.x, Config.Locations.washinglab.teleporters.enter.y, Config.Locations.washinglab.teleporters.enter.z, true) < 1.5) then
                DrawText3D(Config.Locations.washinglab.teleporters.enter.x, Config.Locations.washinglab.teleporters.enter.y, Config.Locations.washinglab.teleporters.enter.z+0.15, '~g~E~w~ - Enter')
                if IsControlJustReleased(0, Keys["E"]) then
                    teleportToWashingOffice()
                end 
            elseif (GetDistanceBetweenCoords(playerPosition, Config.Locations.washinglab.teleporters.enter.x, Config.Locations.washinglab.teleporters.enter.y, Config.Locations.washinglab.teleporters.enter.z, true) < 4) then
                DrawText3D(Config.Locations.washinglab.teleporters.enter.x, Config.Locations.washinglab.teleporters.enter.y, Config.Locations.washinglab.teleporters.enter.z+0.15, 'Office')
            end
        end

        -- EXIT TELEPORTER
        if (GetDistanceBetweenCoords(playerPosition, Config.Locations.washinglab.teleporters.exit.x, Config.Locations.washinglab.teleporters.exit.y, Config.Locations.washinglab.teleporters.exit.z, true) < 5) then
            DrawMarker(2, Config.Locations.washinglab.teleporters.exit.x, Config.Locations.washinglab.teleporters.exit.y, Config.Locations.washinglab.teleporters.exit.z-0.20, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
            if (GetDistanceBetweenCoords(playerPosition, Config.Locations.washinglab.teleporters.exit.x, Config.Locations.washinglab.teleporters.exit.y, Config.Locations.washinglab.teleporters.exit.z, true) < 1.5) then
                DrawText3D(Config.Locations.washinglab.teleporters.exit.x, Config.Locations.washinglab.teleporters.exit.y, Config.Locations.washinglab.teleporters.exit.z+0.15, '~g~E~w~ - Leave')
                if IsControlJustReleased(0, Keys["E"]) then
                    teleportOutOfWashingOffice()
                end
            end
        end

        -- WASH START
        if (GetDistanceBetweenCoords(playerPosition, Config.Locations.washinglab.process.start.x, Config.Locations.washinglab.process.start.y, Config.Locations.washinglab.process.start.z, true) < 1.5) then
            DrawText3D(Config.Locations.washinglab.process.start.x, Config.Locations.washinglab.process.start.y, Config.Locations.washinglab.process.start.z+0.15, '~g~E~w~ - Load machine')
            if IsControlJustReleased(0, Keys["E"]) then
                ESX.TriggerServerCallback('esx_washlab:callback:getBlackMoneyAmount', function(amount)
                    if amount >= 2500 and amount <= 10000 then
                        if unProcessedMoneySheets < 10000 and moneySheets < 10000 then
                            TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                            exports['progressBars']:startUI(Config.WaitingTime, "Loading up machine...")
                            Citizen.Wait(Config.WaitingTime)
                            unProcessedMoneySheets = unProcessedMoneySheets + amount
                            TriggerServerEvent('esx_washlab:server:removeBlackMoney', amount)
                            startProducingTimer(amount)
                            ClearPedTasksImmediately(playerPed)
                        else
                            ESX.ShowNotification('The machine is fully loaded...')
                        end
                    else
                        ESX.ShowNotification('This machine can hold $2.5K minimum and $10K maximum.')
                    end
                end)
            end
        end

        -- WASH TIMER
        if isProducingSheets and producingTime > 0 then
            if (GetDistanceBetweenCoords(playerPosition, Config.Locations.washinglab.process.timer.x, Config.Locations.washinglab.process.timer.y, Config.Locations.washinglab.process.timer.z, true) < 10) then
                DrawText3D(Config.Locations.washinglab.process.timer.x, Config.Locations.washinglab.process.timer.y, Config.Locations.washinglab.process.timer.z+0.28, 'Amount: ~g~$' .. unProcessedMoneySheets .. '~w~')
                DrawText3D(Config.Locations.washinglab.process.timer.x, Config.Locations.washinglab.process.timer.y, Config.Locations.washinglab.process.timer.z+0.15, 'Production process: ~y~' .. producingTime .. ' seconds~w~')
            end
        end

        -- WASH MACHINE OUTPUT
        if (GetDistanceBetweenCoords(playerPosition, Config.Locations.washinglab.process.output.x, Config.Locations.washinglab.process.output.y, Config.Locations.washinglab.process.output.z, true) < 2.5) then
            DrawText3D(Config.Locations.washinglab.process.output.x, Config.Locations.washinglab.process.output.y, Config.Locations.washinglab.process.output.z+0.15, 'Output: ~y~$' .. moneySheets .. '~w~ worth of sheets')
        end

        -- WASH CUTTER
        if (GetDistanceBetweenCoords(playerPosition, Config.Locations.washinglab.process.cutter.x, Config.Locations.washinglab.process.cutter.y, Config.Locations.washinglab.process.cutter.z, true) < 2.5) then
            DrawText3D(Config.Locations.washinglab.process.cutter.x, Config.Locations.washinglab.process.cutter.y, Config.Locations.washinglab.process.cutter.z+0.25, 'Sheets: ~y~' .. moneySheets .. '~w~')
            DrawText3D(Config.Locations.washinglab.process.cutter.x, Config.Locations.washinglab.process.cutter.y, Config.Locations.washinglab.process.cutter.z+0.15, '~g~E~w~ - Start cutting')
            if IsControlJustReleased(0, Keys["E"]) then
                if moneySheets >= 50 then
                    TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                    exports['progressBars']:startUI(Config.WaitingTime, "Cutting...")
                    Citizen.Wait(Config.WaitingTime)
                    moneySheets = moneySheets - 100
                    cuttedMoney = cuttedMoney + 100
                    ClearPedTasksImmediately(playerPed)
                else
                    ESX.ShowNotification('There are not enough sheets...')
                end 
            end
        end

        -- WASH COUNTER
        if (GetDistanceBetweenCoords(playerPosition, Config.Locations.washinglab.process.counter.x, Config.Locations.washinglab.process.counter.y, Config.Locations.washinglab.process.counter.z, true) < 2.5) then
            DrawText3D(Config.Locations.washinglab.process.counter.x, Config.Locations.washinglab.process.counter.y, Config.Locations.washinglab.process.counter.z+0.25, 'Cutted amount: ~y~$' .. cuttedMoney .. '~w~')
            if isCountingMoney and countingTime > 0 then
                DrawText3D(Config.Locations.washinglab.process.counter.x, Config.Locations.washinglab.process.counter.y, Config.Locations.washinglab.process.counter.z+0.15, 'Counting process: ~y~' .. countingTime .. ' seconds~w~')
            else
                DrawText3D(Config.Locations.washinglab.process.counter.x, Config.Locations.washinglab.process.counter.y, Config.Locations.washinglab.process.counter.z+0.15, '~g~E~w~ - Count money')
            end
            if IsControlJustReleased(0, Keys["E"]) then
                if cuttedMoney > 0 then
                    startCountingTimer(cuttedMoney)
                else
                    ESX.ShowNotification('There is no money left to count...')
                end
            end
        end

    end
end)

startProducingTimer = function(amount)
    isProducingSheets = true
    Citizen.CreateThread(function()
        while isProducingSheets do
            producingTime = producingTime - 1
            if producingTime <= 0 then
                moneySheets = moneySheets + amount
                isProducingSheets = false
                producingTime = producingTime + Config.ProducingTime
            end
            Citizen.Wait(1000)
        end
    end)
end

startCountingTimer = function(amount)
    isCountingMoney = true
    Citizen.CreateThread(function()
        while isCountingMoney do
            countingTime = countingTime - 1
            if countingTime <= 0 then
                cuttedMoney = cuttedMoney - amount
                TriggerServerEvent('esx_washlab:server:giveCleanMoney', amount)
                isCountingMoney = false
                countingTime = countingTime + Config.CountingTime
            end
            Citizen.Wait(1000)
        end
    end)
end

teleportOutOfWashingOffice = function()
    local entity = GetPlayerPed(-1)
    
    DoScreenFadeOut(200)
    Citizen.Wait(200)
    SetEntityCoords(entity, Config.Locations.washinglab.teleporters.enter.x, Config.Locations.washinglab.teleporters.enter.y, Config.Locations.washinglab.teleporters.enter.z, 0, 0, 0, false)

    PlaceObjectOnGroundProperly(entity)
    Citizen.Wait(1500)
    DoScreenFadeIn(200)
end

teleportToWashingOffice = function()
    local entity = GetPlayerPed(-1)
    
    DoScreenFadeOut(200)
    Citizen.Wait(200)
    SetEntityCoords(entity, Config.Locations.washinglab.teleporters.exit.x, Config.Locations.washinglab.teleporters.exit.y, Config.Locations.washinglab.teleporters.exit.z, 0, 0, 0, false)

    PlaceObjectOnGroundProperly(entity)
    Citizen.Wait(1500)
    DoScreenFadeIn(200)
end

DrawText3D = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- LOAD IPL
Citizen.CreateThread(function()
    BikerCounterfeit = exports['bob74_ipl']:GetBikerCounterfeitObject()
    BikerCounterfeit.Ipl.Interior.Load()

    BikerCounterfeit.Printer.Set(BikerCounterfeit.Printer.upgradeProd)
    BikerCounterfeit.Security.Set(BikerCounterfeit.Security.upgrade)
    BikerCounterfeit.Dryer1.Set(BikerCounterfeit.Dryer1.on)
    BikerCounterfeit.Dryer2.Set(BikerCounterfeit.Dryer2.on)
    BikerCounterfeit.Dryer3.Set(BikerCounterfeit.Dryer3.on)
    BikerCounterfeit.Dryer4.Set(BikerCounterfeit.Dryer4.on)
    BikerCounterfeit.Details.Enable(BikerCounterfeit.Details.chairs, true)
    BikerCounterfeit.Details.Enable(BikerCounterfeit.Details.furnitures, true)

    RefreshInterior(BikerCounterfeit.interiorId)
end)