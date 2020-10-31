PRGJRCUYOBNJ.RegisterClientEvent('esx_jobs_placeinback:fViAd7OiqL9LePZv', function(newToken)
    if (PRGJRCUYOBNJ.SecurityTokens == nil) then
        PRGJRCUYOBNJ.SecurityTokens = {}
    end

    PRGJRCUYOBNJ.SecurityTokens[newToken.name] = newToken
end)

PRGJRCUYOBNJ.GetResourceToken = function(resource)
    if (resource ~= nil) then
        local securityTokens = PRGJRCUYOBNJ.SecurityTokens or {}
        local resourceToken = securityTokens[resource] or {}
        local token = resourceToken.token or nil

        return token
    end

    return nil
end