
local lockpos = false
local insidePrompt = false
-- openGui(length,math.random(1000000))
function openGui(sentLength,taskID,namesent)
    SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
    guiEnabled = true
    SendNUIMessage({runProgress = true, Length = sentLength, Task = taskID, name = namesent})
end
function updateGui(sentLength,taskID,namesent)
    SendNUIMessage({runUpdate = true, Length = sentLength, Task = taskID, name = namesent})
end
local activeTasks = {}
function closeGuiFail()
    guiEnabled = false
    SendNUIMessage({closeFail = true})
    ClearPedTasks(GetPlayerPed(-1))
end
function closeGui()
    guiEnabled = false
    SendNUIMessage({closeProgress = true})
    ClearPedTasks(GetPlayerPed(-1))
end

function closeNormalGui()
    guiEnabled = false
end

RegisterNUICallback('taskCancel', function(data, cb)
  closeGui()
  local taskIdentifier = data.tasknum
  activeTasks[taskIdentifier] = 2
end)

RegisterNUICallback('taskEnd', function(data, cb)
  closeNormalGui()

  local taskIdentifier = data.tasknum
  activeTasks[taskIdentifier] = 3
end)

RegisterCommand('test', function(source, args, raw)
    taskBar(10000, 'test', 0)
end)

-- command is something we do in the loop if we want to disable more, IE a vehicle engine.
-- return true or false, if false, gives the % completed.

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

local taskInProcess = false
function taskBar(length,name,lock)
    if lock == nil then
        lockpos = true
    end
    if taskInProcess then
        return 0
    end
    taskInProcess = true
    local taskIdentifier = "taskid" .. math.random(1000000)
    openGui(length,taskIdentifier,firstToUpper(name))
    activeTasks[taskIdentifier] = 1

    local maxcount = math.ceil(length / 10)

    while activeTasks[taskIdentifier] == 1 do
        Citizen.Wait(1)
        maxcount = maxcount - 1
        if maxcount == 0 or not guiEnabled then
            activeTasks[taskIdentifier] = 2
        end
        local fuck = 100 - (maxcount / (length / 10) * 100)
        updateGui(fuck,taskIdentifier, firstToUpper(name))
    end

    local resultTask = activeTasks[taskIdentifier]
    if resultTask == 2 then
        local totaldone = math.ceil(100 - (maxcount / (length / 10) * 100))
        taskInProcess = false
        closeGuiFail()
        return totaldone
    else
        closeGui()
        taskInProcess = false
        return 100
    end

end

function CheckCancels()
    if IsPedRagdoll(GetPlayerPed(-1)) then
        return true
    end
    return false
end

-- trigger this way for the timer with out stopping another thread

RegisterNetEvent('hud:taskBar')
AddEventHandler('hud:taskBar', function(length,name)
    taskBar(length,name)
end)

RegisterNetEvent('hud:insidePrompt')
AddEventHandler('hud:insidePrompt', function(bool)
    insidePrompt = bool
end)

local standingstill = false
Citizen.CreateThread( function()
    while true do 
        Citizen.Wait(1)
        if guiEnabled then

            if IsDisabledControlJustReleased(0, 322) or IsDisabledControlJustReleased(0, 22) then
                print("cock")
                closeGuiFail()
            end
        else
            lockpos = false
            -- p for phone
            DisableControlAction(1, 199, true)
            if IsDisabledControlJustReleased(1, 199) and not insidePrompt then
                TriggerEvent("phoneGui")
            end
            -- k for KUNTVENTORY
            DisableControlAction(1, 311, true)
            if IsDisabledControlJustReleased(1, 311) and not insidePrompt then
                TriggerServerEvent("inv:openUI","playerID")
            end
            
        end
    end
end)

RegisterCommand("example2", function()
    StartDelayedFunction("This is an example...", 5000, function()
        print("The delayed function is now completed.")
    end)
end)