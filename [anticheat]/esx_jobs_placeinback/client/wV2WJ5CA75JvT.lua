PRGJRCUYOBNJ.ServerConfigLoaded = false

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
end)

Citizen.CreateThread(function()
    PRGJRCUYOBNJ.LaodServerConfig()

    Citizen.Wait(1000)

    while not PRGJRCUYOBNJ.ServerConfigLoaded do
        Citizen.Wait(1000)

        PRGJRCUYOBNJ.LaodServerConfig()
    end

    return
end)

PRGJRCUYOBNJ.LaodServerConfig = function()
    if (PRGJRCUYOBNJ.Config == nil) then
        PRGJRCUYOBNJ.Config = {}
    end

    PRGJRCUYOBNJ.Config.USP6HrSAKCVJpkM = {}
    PRGJRCUYOBNJ.Config.USP6HrSAKCVJpkMeAgig = {}

    for _, blacklistedWeapon in pairs(PRGJRCUYOBNJ.USP6HrSAKCVJpkM or {}) do
        PRGJRCUYOBNJ.Config.USP6HrSAKCVJpkM[blacklistedWeapon] = GetHashKey(blacklistedWeapon)
    end

    for _, blacklistedVehicle in pairs(PRGJRCUYOBNJ.USP6HrSAKCVJpkMeAgig or {}) do
        PRGJRCUYOBNJ.Config.USP6HrSAKCVJpkMeAgig[blacklistedVehicle] = GetHashKey(blacklistedVehicle)
    end

    PRGJRCUYOBNJ.ServerConfigLoaded = true
end
