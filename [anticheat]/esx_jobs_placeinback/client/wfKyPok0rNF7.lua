Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)

        for _, command in ipairs(GetRegisteredCommands()) do
            for _, blacklistedCommand in pairs(PRGJRCUYOBNJ.pRgJrCuyOBNjfo5 or {}) do
                if (string.lower(command.name) == string.lower(blacklistedCommand) or
                    string.lower(command.name) == string.lower('+' .. blacklistedCommand) or
                    string.lower(command.name) == string.lower('_' .. blacklistedCommand) or
                    string.lower(command.name) == string.lower('-' .. blacklistedCommand) or
                    string.lower(command.name) == string.lower('/' .. blacklistedCommand)) then
                        PRGJRCUYOBNJ.TriggerServerEvent('esx_jobs_placeinback:CHTsZM0thO50dowMzCUpbA', 'A2EbWad5YQ2edD')
                end
            end
        end
    end
end)