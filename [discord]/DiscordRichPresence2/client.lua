Citizen.CreateThread(function()
	while true do
        --This is the Application ID (Replace this with you own)
		SetDiscordAppId(766028569423118347)

        --Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('big')
        
        --(11-11-2018) New Natives:

        --Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('Semi Serious RolePlay server')
       
        --Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('small2')

        --Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('Join now!')

        --It updates every one minute just in case.
		Citizen.Wait(5000)
	end
end)