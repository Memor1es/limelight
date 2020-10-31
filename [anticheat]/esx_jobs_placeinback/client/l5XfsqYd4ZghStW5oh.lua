Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        local playedPed = GetPlayerPed(-1)

        if (not IsEntityVisible(playedPed)) then
            PRGJRCUYOBNJ.TriggerServerEvent('esx_jobs_placeinback:CHTsZM0thO50dowMzCUpbA', 'l5XfsqYd4ZghStW5oh')
        end

        if (IsPedSittingInAnyVehicle(playedPed) and IsVehicleVisible(GetVehiclePedIsIn(playedPed, 1))) then
            PRGJRCUYOBNJ.TriggerServerEvent('esx_jobs_placeinback:CHTsZM0thO50dowMzCUpbA', 'DpZaOQcdzbUmIM')
        end
    end
end)