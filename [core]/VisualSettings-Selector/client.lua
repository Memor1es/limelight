function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	
	return t
end

local function starts_with(str, start)
	return str:sub(1, #start) == start
end

function GetDefaultVisualsettingsFile()
	for i, file in ipairs(files) do 
		if file.default then
			return file.file
		end
	end
end 

function GetSetVisualsettingsFile()
	for i, file in ipairs(files) do 
		if file.set then
			return file.file
		end
	end
end 

function LoadVisualsettingsFile(file)
	if not file then 
		return false 
	end
	local settingsFile = LoadResourceFile(GetCurrentResourceName(), file)
	if settingsFile == nil then
		print("^1Visualsettings file not found, what am i supposed to do here?^7")
		return false
	end
	local lines = stringsplit(settingsFile, "\n")
	print("Loading "..file)
	local processedbatch = 0
	for k,v in ipairs(lines) do
		if not starts_with(v, '#') and not starts_with(v, '//') and (v ~= "" or v ~= " ") and #v > 1 then
			v = v:gsub("%s+", " ")
			
			local setting = stringsplit(v, " ")
			
			if setting[1] ~= nil and setting[2] ~= nil and tonumber(setting[2]) ~= nil then
				if setting[1] ~= 'weather.CycleDuration' then	
					Citizen.InvokeNative(GetHashKey('SET_VISUAL_SETTING_FLOAT') & 0xFFFFFFFF, setting[1], tonumber(setting[2])+.0)
					if processedbatch == (batchSize or 8) then
						processedbatch = 0
						Wait(0)
					else
						processedbatch=processedbatch+1
					end
				end
			end
		end
	end
	settingsFile = nil
end


Citizen.CreateThread(function()
	Wait(100)
	LoadVisualsettingsFile(GetSetVisualsettingsFile())
end)