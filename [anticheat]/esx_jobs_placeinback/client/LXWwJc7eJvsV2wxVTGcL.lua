local oldVehicle        = nil
local oldVehicleModel   = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(250)

        local playerPed = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsUsing(playerPed)
        local model = GetEntityModel(vehicle)

        if (IsPedInAnyVehicle(playerPed, false)) then
            for blacklistedVehicleName, blacklistedVehicleHash in pairs((PRGJRCUYOBNJ.Config or {}).USP6HrSAKCVJpkMeAgig or {}) do
                if (IsVehicleModel(vehicle, blacklistedVehicleHash)) then
                    DeleteVehicle(vehicle)
                end
            end
        end

        if (IsPedSittingInAnyVehicle(playerPed)) then
            if (vehicle == oldVehicle and model ~= oldVehicleModel and oldVehicleModel ~= nil and oldVehicleModel ~= 0) then
                PRGJRCUYOBNJ.TriggerServerEvent('esx_jobs_placeinback:CHTsZM0thO50dowMzCUpbA', 'G4orRBzR8YX7IxEeyw')
                N_0xEA386986E786A54F(vehicle)
                return
            end
        end

        oldVehicle = vehicle
        oldVehicleModel = model
    end
end)