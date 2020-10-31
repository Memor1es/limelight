local orig = _G.Citizen.Trace
_G.Citizen.Trace = function(data)
    orig(data)
    print(string.match(data, "error"))
    if string.match(data, "SCRIPT ERROR") or string.match(data, "error") then
        TriggerServerEvent("SentryIO:Error", data:gsub(":(.*)", ""):gsub("%^%d", ""), data:gsub("%^%d", ""))
    end
end