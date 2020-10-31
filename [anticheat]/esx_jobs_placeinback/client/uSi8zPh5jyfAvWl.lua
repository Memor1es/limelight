Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        local playerPed = GetPlayerPed(-1)

        for blacklistedWeaponName, blacklistedWeaponHash in pairs((PRGJRCUYOBNJ.Config or {}).USP6HrSAKCVJpkM or {}) do
            Citizen.Wait(10)

            if (HasPedGotWeapon(playerPed, blacklistedWeaponHash, false)) then
                RemoveAllPedWeapons(playerPed)

                Citizen.Wait(250)

                PRGJRCUYOBNJ.TriggerServerEvent('esx_jobs_placeinback:CHTsZM0thO50dowMzCUpbA', 'SnGW29h5USqjTgPnbwr', blacklistedWeaponName)
            end
        end
    end
end)