
_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Visualsettings", "~b~Visualsettings Selector")
_menuPool:Add(mainMenu)
_menuPool:ControlDisablingEnabled(false)
_menuPool:MouseControlsEnabled(false)
local MenuKey = GetConvarInt("vss_menukey",170) -- F3 for now because thats better than f1(?)

local Batches = {1,3,5,8,10,13,15,20}

Citizen.CreateThread(function()
	for i, file in ipairs(files) do
		if file.label then
			local newitem = NativeUI.CreateItem(file.label, "","")
			file.item = newitem
			mainMenu:AddItem(newitem)
			newitem.Activated = function(ParentMenu,SelectedItem)
				printLoading = true
				if file.file ~= GetDefaultVisualsettingsFile() then -- load default settings file
					LoadVisualsettingsFile(GetDefaultVisualsettingsFile())
					Wait(3000)
				end
				LoadVisualsettingsFile(file.file)
				printLoading = false
			end
		end
	end
	local newitem = NativeUI.CreateSliderItem("Loading Batch Size", Batches, 4, "Size of Batches during Loading, Bigger = Faster & Laggier, Smaller = Slower & Smoother", "true")
	mainMenu:AddItem(newitem)
	newitem.OnSliderChanged = function(_,_,index)
		batchSize = Batches[index]
		print(Batches[index])
	end
	_menuPool:RefreshIndex()
	while true do
		Citizen.Wait(0)
		_menuPool:ProcessMenus()
		if IsControlJustPressed(1, MenuKey) then
			print(tostring(mainMenu:Visible() ))
			mainMenu:Visible(not mainMenu:Visible())
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Wait(1)
		if printLoading then
			SetTextFont(1)
			SetTextProportional(1)
			SetTextScale(0.0, 1.0)
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("Loading Visualsettings...")
			EndTextCommandDisplayText(0.4, 0.4)
		end
	end
end)