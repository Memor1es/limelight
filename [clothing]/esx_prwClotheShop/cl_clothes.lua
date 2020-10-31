ESX                  = nil
_menuPool = NativeUI.CreatePool()
_menuPool:RefreshIndex()
local MaskTab  = {}
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
RegisterNetEvent('parow:SyncAccess')
AddEventHandler('parow:SyncAccess', function()
    ESX.TriggerServerCallback("parow:getMask", function(result)
        MaskTab = result
    end)
end)
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction6           = nil
local CurrentAction6Msg        = ''
local CurrentAction6Data       = {}
local IsInShopMenu            = false
local Categories              = {}
local Vehicles                = {}
local LastVehicles            = {}
local CurrentVehicleData      = nil
local MenuOn = false
local curSex = 0
function ClotheShopAdd(menu)

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, _)
		curSex = skin.sex
		--TriggerEvent('skinchanger:loadSkin', skin)
	end)
	playerPed = GetPlayerPed(-1)
	local tenues = NativeUI.CreateItem("My outfits","")
	menu:AddItem(tenues)
	local haut = _menuPool:AddSubMenu(menu, "Top","",true,true)
	local bras = _menuPool:AddSubMenu(menu, "Arms","",true,true)
	local tsh = _menuPool:AddSubMenu(menu, "T-shirt","",true,true)
	local bas = _menuPool:AddSubMenu(menu, "Pants","",true,true)
	local chaussure = _menuPool:AddSubMenu(menu, "Shoes","",true,true)
	local lunette = _menuPool:AddSubMenu(menu, "Glasses","",true,true)
	local chapeau = _menuPool:AddSubMenu(menu, "Hats","",true,true)
	local gil = _menuPool:AddSubMenu(menu, "Bulletproof vest","",true,true)
	local sac = _menuPool:AddSubMenu(menu, "Backpacks","",true,true)
	--local montre = _menuPool:AddSubMenu(menu, "Montre","",true,true)
	local chain = _menuPool:AddSubMenu(menu, "Chains","",true,true)
	local boucle = _menuPool:AddSubMenu(menu, "Earpieces","",true,true)

 	chaussureFct(chaussure)
 	gilFct(gil)
 	basFct(bas)
 	casqueFct(chapeau)
	torsomenu(bras)
	tshirtmenu(tsh)
 	lunetteFct(lunette)
	--montreMenu(montre)
 	sacFct(sac)
 	boucleFct(boucle)
 	hautFct(haut)
	chainFct(chain)
	 
	menu.OnItemSelect = function(_,_,ind)
		if ind == 1 then
			_menuPool:CloseAllMenus()
			local clotheShop2 = NativeUI.CreateMenu("", "Store", 5, 100,"shopui_title_midfashion","shopui_title_midfashion")
			_menuPool:Add(clotheShop2)
			SavedTenues(clotheShop2)
			clotheShop2:Visible(not clotheShop2:Visible())
		end

	end

	menu.OnMenuClosed = function(_, _, _)

		RecupTenues()
		MenuOn = false
		
	end

end
function refreshthisshit()
	_menuPool:CloseAllMenus(

	)
	local clotheShop2 = NativeUI.CreateMenu("", "Shop", 5, 100,"shopui_title_midfashion","shopui_title_midfashion")
	_menuPool:Add(clotheShop2)
	SavedTenues(clotheShop2)
	clotheShop2:Visible(not clotheShop2:Visible())
end
function SavedTenues(menu)
	p = NativeUI.CreateItem("Save this outfit","")
	menu:AddItem(p)
	local sqk = nil
	menu.OnItemSelect = function(_,ix,ind)
		sqk = ind - 1
		if ind == 1 then
			k = gettxt2("Outfit")
			if k ~= nil then
				if tostring(k) ~= nil and tostring(k) ~= "" then

					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
						TriggerServerEvent("parow:SaveTenueS",k,skin)
					end)
					Wait(550)
					refreshthisshit()
				end
			end
		end
	end
	ESX.TriggerServerCallback('parow:GetTenues', function(skin)
		if #skin == 0 then
			menu:AddItem(NativeUI.CreateItem("Empty",""))
		end
		for i = 1, #skin,1 do
			local m = _menuPool:AddSubMenu(menu, skin[i].label,"",true,true)
			p = NativeUI.CreateItem("Wear","")
			k = NativeUI.CreateItem("Rename","")
			l = NativeUI.CreateItem("Remove","")
			m:AddItem(p)
			m:AddItem(k)
			m:AddItem(l)
			

			m.OnItemSelect = function(_,ix,v)
				clothes = skin[i]

				for k,v in pairs(clothes) do
					if k == "outfit" then
					clothes = v
					break
					end
				end
				if v == 1 then

					TriggerEvent('skinchanger:getSkin', function(skin)

					TriggerEvent('skinchanger:loadClothes', skin, json.decode(clothes))
					TriggerEvent('esx_skin:setLastSkin', skin)
  
					TriggerEvent('skinchanger:getSkin', function(skin)
					  TriggerServerEvent('esx_skin:save', skin)
					end)
					_menuPool:CloseAllMenus()
				end)
				end
				if v == 2 then
					kx = gettxt2(skin[i].label)
					if tostring(kx) ~= nil then
						TriggerServerEvent('parow:RenameTenue', skin[i].id,kx)
						Wait(550)
						refreshthisshit()
					end
				end
				if v == 3 then
					TriggerServerEvent('parow:DeleteTenue', skin[i].id)
					Wait(550)
					refreshthisshit()
				end
			end
		end
		_menuPool:RefreshIndex()
	end)

end

function gettxt2(txtt)
    AddTextEntry('FMMC_MPM_NA', "Text")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", txtt, "", "", "", 100)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
		local result = GetOnscreenKeyboardResult()
		if tonumber(result) ~= nil then
			if tonumber(result) >= 1 then

				return tonumber(result)
			else
				
			end
		else
		return result
		end
    end

end
function montreMenu(menu)

	for i = -1,19,1 do
		--
		chapeauItem = {}
		local amount = {}
		local ind = i+2
		for c = 1, GetNumberOfPedPropTextureVariations(playerPed, 6, i+1), 1 do

			amount[c] = c 
			
		end

		v = NativeUI.CreateListItem("Watches #"..ind, amount, 1, "",5)
	
		menu:AddItem(v)
		

	end
	--chapeauItem= {}
	_menuPool:RefreshIndex()
	
	menu.OnIndexChange = function(menu,index6)
		local index2 = 1
		
		playerPed = GetPlayerPed(-1)
		SetPedPropIndex(playerPed, 6, index6-1, 0, 2)
		menu.OnListSelect = function(_, _, _)
			ESX.TriggerServerCallback("parow:GetMoneyVet", function(result)
				if result then
			
			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
	
				clothesSkin = {

				   ['montre'] = index6-1,
				   ['montre2'] = index2-1,
				   


			   }
			   TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			   
		   
		   
	   end)

	   TriggerEvent('skinchanger:getSkin', function(skin)

		   
		   TriggerServerEvent('esx_skin:save', skin)
		   
	   
	   
	   end)
	end
	end)

		end
		menu.OnListChange = function(_, _, index26)
			index2 = index26
			SetPedPropIndex(playerPed, 6, index6-1, index26-1, 2)
		end
	end

end

function RecupTenues()
    --("ou")

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, _)
--		curSex = skin.sex
		TriggerEvent('skinchanger:loadSkin', skin)
	end)

end
function chainFct(menu)



	for i = -1,GetNumberOfPedDrawableVariations(playerPed,7),1 do
		--
		chapeauItem = {}
		local amount = {}
		local ind = i+2
		for c = 1, GetNumberOfPedTextureVariations(playerPed, 7, i+1), 1 do

			amount[c] = c 
			
		end

		v = NativeUI.CreateListItem("Chains #"..ind, amount, 1, "",5)
	
		menu:AddItem(v)
		

	end
	--chapeauItem= {}
	_menuPool:RefreshIndex()
	
	menu.OnIndexChange = function(menu,index6)
		local index2 = 1
		
		playerPed = GetPlayerPed(-1)
		SetPedComponentVariation(playerPed,7, index6-1, 0, 2)
		menu.OnListSelect = function(_, _, _)
			ESX.TriggerServerCallback("parow:GetMoneyVet", function(result)
				if result then
			
			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
	
				clothesSkin = {

				   ['chain_1'] = index6-1,
				   ['chain_2'] = index2-1,
				   


			   }
			   TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			   
		   
		   
	   end)

	   TriggerEvent('skinchanger:getSkin', function(skin)

		   
		   TriggerServerEvent('esx_skin:save', skin)
		   
	   
	   
	   end)
	end
	end)

		end
		menu.OnListChange = function(_, _, index26)
			index2 = index26
			SetPedComponentVariation(playerPed, 7, index6-1, index26-1, 2)
		end
	end

end

function torsomenu(menu)

	for i = 0,GetNumberOfPedDrawableVariations(playerPed,8)-1,1 do
		--		Citizen.Wait(2)
				local amount = {}
				local ind = i+1
				for c = 1, GetNumberOfPedTextureVariations(playerPed, 8, i), 1 do
		
					amount[c] = c 
					
				end

				x = NativeUI.CreateItem("Arms #"..i,"")
			
				menu:AddItem(x)
				
		
	end
		
	menu.OnIndexChange = function(menu,index6)
		playerPed = GetPlayerPed(-1)

		local index2 = 1

		
--		SetPedComponentVariation(playerPed,3, brasInd[index6], 0, 2)
--		SetPedComponentVariation(playerPed,8, sousTorse[index6], 0, 2)

		SetPedComponentVariation(playerPed,3, index6-1, 0, 2)
		menu.OnItemSelect = function(menu, _, _)
			
			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
	
					 clothesSkin = {

						['arms'] = index6-1


					}
					print(json.encode(skin))
					print(json.encode(clothesSkin))
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					
				
				
			end)

			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
				TriggerServerEvent('esx_skin:save', skin)
				
			
			
			end)
			menu.OnMenuClosed = function(_)
				gilItem= {}
				sousTorse = {}
			end
		end

	end



end
function tshirtmenu(menu)

	for i = 0,GetNumberOfPedDrawableVariations(playerPed,8)-1,1 do
		--		Citizen.Wait(2)
				local amount = {}
				local ind = i+1
				for c = 1, GetNumberOfPedTextureVariations(playerPed, 8, i), 1 do
		
					amount[c] = c 
					
				end

				x = NativeUI.CreateListItem("Undershirts #"..i, amount, 1, "",5)
			
				menu:AddItem(x)
				
		
	end
		
	menu.OnIndexChange = function(menu,index6)
		playerPed = GetPlayerPed(-1)

		local index2 = 1

		
--		SetPedComponentVariation(playerPed,3, brasInd[index6], 0, 2)
--		SetPedComponentVariation(playerPed,8, sousTorse[index6], 0, 2)

		SetPedComponentVariation(playerPed,8, index6-1, 0, 2)
		menu.OnListSelect = function(menu, _, _)
			ESX.TriggerServerCallback("parow:GetMoneyVet", function(result)
				if result then
			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
	
					 clothesSkin = {

						['tshirt_1'] =index6-1, ['tshirt_2'] = index2-1,


					}
					print(json.encode(skin))
					print(json.encode(clothesSkin))
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					
				
				
			end)

			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
				TriggerServerEvent('esx_skin:save', skin)
				
			
			
			end)
		end
		end)
			menu.OnMenuClosed = function(_)
				gilItem= {}
				sousTorse = {}
			end
		end
		menu.OnListChange = function(_, _, index24)
			index2 = index24
			SetPedComponentVariation(playerPed,8, index6-1, index24-1, 2)

			

		end
	end

end

function hautFct(menu)



	playerPed = GetPlayerPed(-1)

	 if curSex == 0 then
		--hautItems = {"T-shirt","T-shirt","Maillot de basket","Tracksuit","Jacket","Tank top","Leather jacket","Jacket capuche","Sweatshirt","Polo","Costard","Shirt","Shirt","Shirt","Shirt à carreaux","Torse nu","T-shirt","Tank top","T-shirt noël","Jacket classe","Jacket classe","s"}
		sousTorse = {15,15,15,1,1,15,2,1,15,15,10,6 ,15,15,15,15,15,15,15,6,4,13,7,15,1,4,6,15,4,4,31,31,31,31,15,15,4 ,15,2,15,15,6,15,15,15,15,6,0}
		brasInd =   {0 ,0 ,2 ,0,1,5 ,1,1,8 ,0 ,1 ,11,6 ,11 ,1  ,15 ,0 ,5 ,0,1,1,11,0,1,1,11,11,1,1,1,1,1,1,0,0,1		,5 ,1,8 ,0 ,0,1 ,11,11,0, 0,1}
	hautItems = {"T-shirt","T-shirt","Basketball jersey","Tracksuit jacket","Classic jacket","Tank top","Leather jacket","Hoodie","Sweatshirt","Polo","Suit jacket","Class","Long-sleeved shirt","Shirt","Checkered shirt","Nothing","T-shirt","Tank top","T-shirt","Suit Jacket","Suit Jacket","Jacket","T-shirt","Suit Jacket","Suit Jacket","Jacket","Shirt","Suit Jacket","Suit Jacket","Suit Jacket","Suit Jacket","Suit Jacket","Suit Jacket","T-shirt","T-shirt","Suit Jacket","Tank top","Leather jacket","Sweatshirt","Polo","Jacket","Shirt","Shirt with suspender","Shirt with suspender","T-shirt","Shirt","Suit Jacket","T-shirt","Flight overalls","Sweater","Sweater","Christmas sweater","Christmas sweatshirt","Sweater","Flight jacket","Police top","Dirty T-shirt","Jacket","Suit Jacket","Suit Jacket","Suit Jacket","Gillet","Jacket","Shirt","Leather jacket","Weird jacket","Weird jacket","Latex top","","Jacket","Fur jacket","T-shirt","Long-sleeved jacket","T-shirt","Luxury jacket","Luxury jacket","Long-sleeved jacket","Long-sleeved jacket","Luxury sweatere","College jacket","T-shirt long","T-shirt long","Polo long","T-shirt long","Street sweater","Jacket","Hooded sweatshirt","College jacket","College jacket","","Gillet","Nothing","Jacket","Polo","Polo","Shirt","Hooded sweatshirt","T-shirt","Haut commando","Suit Jacket","Suit Jacket","Suit Jacket","Suit Jacket","Suit Jacket","Suit Jacket","Tourist shirt","Luxury jacket","Asian jacket","Luxury jacket","Strange tank top","Leather jacket","Turtleneck","Long-sleeved jacket","Jacket","Karate outfit","Long-sleeved jacket","Santa Claus","Shirt","Jacket","Suit Jacket","Jacket","Strange top","","Polo","Fisherman's jacket","Jacket","Checkered jacket","Checkered jacket","T-shirt long","Safety jacket","","","","Chill shirt","Hooded sweatshirt","Luxury jacket","Jacket","Old sweater","Jacket","Turtleneck","Long-sleeved jacket","Jacket","Long-sleeved jacket","Jacket","Pyjamas","Pyjamas","T-shirt","Flight jacket","Flight jacket","Cowboy jacket","Asian jacket","Leather jacket","Sports top","Jacket","Jacket","Cowboy jacket","Leather jacket","Jacket","Jacket","Jacket","","Leather jacket","Jacket","T-shirt","Special top","Jacket","Puffy jacket","Jacket","Denim jacket","Denim jacket","Hooded sweatshirt","Denim jacket","Denim jacket","Leather jacket","Leather jacket","Jacket","","Tron top","Jacket","Jacket","Jacket","Sweatshirt","Suit Jacket","Long-sleeved jacket","Open Long-sleeved jacket","Special gillet","Long-sleeved jacket","Long-sleeved jacket","Open Long-sleeved jacket","Pattern sweater","Jacket","Long-sleeved jacket","T-shirt","Christmas sweater","Christmas sweater","Christmas sweater","Christmas sweater","Christmas jacket","Christmas jacket","Hooded sweatshirt","Luminous T-shirt","Hooded sweater","Hooded sweatshirt","Hooded long-sleeved jacket","Hooded sweater","Camouflage jacket","Hooded camouflage jacket","T-shirt","Long-sleeved jacket","Long-sleeved jacket","Hooded long-sleeved jacket","","","Camouflage jacket","Camouflage jacket","Camouflage jacket","Long-sleeved jacket","Hooded long-sleeved jacket","Camouflage jacket","Camouflage top","Camouflage top","Camouflage T-shirt","Short-sleeved jacket","Jacket","Long-sleeved jacket","T-shirt","Flight jacket","Flight jacket","Jacket","Jacket","Flight jacket","Polo","Polo","Tank top","Very-short-sleeved T-shirt","Camouflage tank top","Fur jacket","Polo","Polo","Jacket","Jacket","Winter jacket","Super hero jacket","Short-sleeved jacket","Jacket","Jacket","Polo","Jacket","Nothing","Hooded jacket","Pilot overalls","Original sweater","Original jacket","Oldschool jacket","Diamond jacket","Special sweater","Special T-shirt","Special open jacket","Hooded sweatshirt","Hooded sweatshirt","Leather jacket","Checkered jacket","Checkered jacket","Jacket","Jacket","Puffy jacket","Pilot overalls","T-shirt"}

	for i = 0,GetNumberOfPedDrawableVariations(playerPed,11)-1,1 do
--		Citizen.Wait(2)
		local amount = {}
		local ind = i+1
		for c = 1, GetNumberOfPedTextureVariations(playerPed, 11, i), 1 do

			amount[c] = c 
			
		end
		if hautItems[ind] == nil then
			hautItems[ind] = "Top #"..i
		end
		x = NativeUI.CreateListItem(hautItems[ind], amount, 1, "",5)
	
		menu:AddItem(x)
		

	end




	menu.OnIndexChange = function(menu,index6)
		playerPed = GetPlayerPed(-1)

		local index2 = 1

		if brasInd[index6] == nil then
			brasInd[index6] = 1

		end
		if sousTorse[index6] == nil then
			sousTorse[index6] = 1

		end
		
--		SetPedComponentVariation(playerPed,3, brasInd[index6], 0, 2)
--		SetPedComponentVariation(playerPed,8, sousTorse[index6], 0, 2)

		SetPedComponentVariation(playerPed,11, index6-1, 0, 2)
		menu.OnListSelect = function(menu, _, _)
			ESX.TriggerServerCallback("parow:GetMoneyVet", function(result)
				if result then
			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
	
					 clothesSkin = {
						['torso_1'] = index6-1, ['torso_2'] = index2-1,


					}
					print(json.encode(skin))
					print(json.encode(clothesSkin))
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					
				
				
			end)

			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
				TriggerServerEvent('esx_skin:save', skin)
				
			
			
			end)
		end
	end)
			menu.OnMenuClosed = function(_)
				gilItem= {}
				sousTorse = {}
			end
		end
		menu.OnListChange = function(_, _, index24)
			index2 = index24
			SetPedComponentVariation(playerPed,11, index6-1, index24-1, 2)

			

		end
	end
	gilItem={}
	_menuPool:RefreshIndex()
	
else
	
end
hautItems = {}
gilItem= {}
sousTorse = {}
end





function sacFct(menu)
	playerPed = GetPlayerPed(-1)
	n = NativeUI.CreateItem("Tactical backpack","")
	menu:AddItem(n)
	c = NativeUI.CreateItem("Black backpack","")
	menu:AddItem(c)
	cx = NativeUI.CreateItem("No bag","")
	menu:AddItem(cx)
	menu.OnItemSelect = function (_, _, index)
		if index == 1 then
			SetPedComponentVariation(playerPed, 5, 40, 0, 2)
			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
	
				clothesSkin = {
				   ['bags_1'] = 40, ['torso_2'] = 0,


			   }

			   TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			   
		   
		   
	   end)

	   TriggerEvent('skinchanger:getSkin', function(skin)

		   
		   TriggerServerEvent('esx_skin:save', skin)
		   
	   
	   
	   end)
	elseif index == 2 then
			SetPedComponentVariation(playerPed, 5, 44, 0, 2)
			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
	
				clothesSkin = {
				   ['bags_1'] = 44, ['torso_2'] = 0,


				}
			   TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			   
		   
		   
	   end)

	   TriggerEvent('skinchanger:getSkin', function(skin)

		   
		   TriggerServerEvent('esx_skin:save', skin)
		   
	   
	   
	   end)
	else

		SetPedComponentVariation(playerPed, 5, 0, 0, 2)
		TriggerEvent('skinchanger:getSkin', function(skin)

			

			clothesSkin = {
			   ['bags_1'] = 0, ['torso_2'] = 0,


			}
		   TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		   
	   
	   
   end)

   TriggerEvent('skinchanger:getSkin', function(skin)

	   
	   TriggerServerEvent('esx_skin:save', skin)
	   
   
   
   end)
		end

	end


end



function gilFct(menu)


	playerPed = GetPlayerPed(-1)

	 if curSex == 0 then

		gilItem = {
			"None","Light gillet","Medium gillet","Gillet","Heavy gillet","Gillet","Large gillet","Large gillet","/","/","Large gillet","Large gillet","Large gillet","None","None","Heavy gillet","Very heavy gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet","Colorful gillet"

		}

	

	for i = 0,GetNumberOfPedDrawableVariations(playerPed,9)-1,1 do
		--
		local amount = {}
		local ind = i+1
		for c = 1, GetNumberOfPedTextureVariations(playerPed, 9, i), 1 do

			amount[c] = c 
			
		end
		if gilItem[ind] == nil then
			gilItem[ind] =  "Gillet #"..i
		end
		x = NativeUI.CreateListItem(gilItem[ind], amount, 1, "",5)
	
		menu:AddItem(x)
		

	end

else
	
end
_menuPool:RefreshIndex()

	
	menu.OnIndexChange = function(menu,index)
		playerPed = GetPlayerPed(-1)
		SetPedComponentVariation(playerPed, 9, index-1, 0, 2)
		menu.OnListChange = function(menu, _, index2)
			SetPedComponentVariation(playerPed, 9, index-1, index2-1, 2)
			
			menu.OnListSelect = function(menu, _, _)
				TriggerEvent('skinchanger:getSkin', function(skin)
					TriggerServerEvent('esx_skin:save', skin)
				end)
				menu.OnMenuClosed = function(_)
					gilItem= {}
				end
			end
		end
	end
	gilItem={}
end


function basFct(menu)
	playerPed = GetPlayerPed(-1)

	 if curSex == 0 then

		botItem = {
			"Jeans",
			"Jeans",
			"Shorts",
			"Tracksuit",
			"Jeans",
			"Large tracksuit",
			"Shorts",
			"Jeans",
			"Chinos",
			"Chinos with belt",
			"Black jeans",
			"/",
			"Shorts","Black jeans with belt","Underpants","Shorts","Colorful shorts","Short chinos","Underpants","Pants with belt","Pants","Underpants","Chinos","Chinos with belt","Black jeans","Black jeans","Patterned jeans","Colorful Pants","Black jeans","Special Pants","Pilot pants","Track pants","Leggings","Large pants","Operation pants","Classy pants","Worker's pants","Classy pants","Papel pants","Papel pants","Tracksuit","Pilot pants","Long shorts","Large jeans","/","Tracksuit","Combat pants","Pants déterminé","Classy pants","Classy pants","Classy pants","Luxury pants","Luxury pants","Luxury pants","Patterned shorts", "Tracksuit","Skirt","Christmas pants","Special Pants","Pixie pants","Patterned  pants","Underpants","Long shorts","Jeans","Tracksuit","Pyjamas","Pants chill","Skydiver pants","Cowboy pants","The Pants of Death","Cowboy pants","Skinny pants","Skinny pants","Skinny pants","Skinny pants","Jeans","Jeans","Tron pants","Tracksuit","Leather pants","Too small pants","Too small pants","Jeans","Pants latex","Special Operation pants","Luminous pants"


		}

	

	for i = 0,GetNumberOfPedDrawableVariations(playerPed,4)-1,1 do
		--
		local amount = {}
		local ind = i+1
		for c = 1, GetNumberOfPedTextureVariations(playerPed, 4, i), 1 do

			amount[c] = c 
			
		end
		if botItem[ind] == nil then
			botItem[ind] = "Pants #"..i
		end
		x = NativeUI.CreateListItem(botItem[ind], amount, 1, "",5)
	
		menu:AddItem(x)
		

	end

else
		botItem = {"Jeans","Large jeans","Jogging shorts","Simple pants","Hem jeans","Short","Elephant paw-patterned pants","Work shirts","Short skirt","Short skirt with glitter","Shorts","Denim jeans","Schoolgirl skirt","I AM THE 13","Shorts 1","Pants 1","Shorts 2","Pants 2","Long skirt","Shorty","Porte Jartelle","Pants","Porte Jartelle","Elephant paw-patterned pants","Long skirt","Short","Short skirt","Slim","Skirt","Pilot pants","Trellis","Mercenary pants","Large pants","Garbage pants","Long skirt","Costume pants","Work pants","Work pants 2","Simple pants","Costume pants","Flight pants","Closed pants","Holed leggings","Work pants","BUUUG","Costume pants","Mercenary pants","Work pants","Elephant paw pants","Slim","Elephant paw pants 1","Elephant paw pants 2","Slim 1","Slim 2","Pants","Open skirt","Jogging","Christmas pants","Elephant paw Christmas pants","Trellis","Shorty","Porte jartel","High-waist pants","Joggings","Pyjamas","Biker pants","Biker pants 2","Cowboy pants","Competition pants","Simple pants","Cowboy pants 2","Slim Jeans","Slim Jeans 2","Slim 1","Slim 2","Slim 3","Fishnet tights","Biker pants","Joggings 1","Joggings 2","Joggings 3","Joggings 4","Joggings 5","Joggings 6","Disguise","Military pants","Illuminated leggings","Military pants","Tucked-in Military pants","Military shorts","Large Military pants","Large jeans","Biker competition","Pilot pants 1","Pilot pants 2","Leggings","Colorful leggings","Work pants","Tucked-in tracksuit","Tracksuit","Leggings","Large pants"}



	for i = 0,GetNumberOfPedDrawableVariations(playerPed,4)-1,1 do
		--
		local amount = {}
		local ind = i+1
		for c = 1, GetNumberOfPedTextureVariations(playerPed, 4, i), 1 do

			amount[c] = c 
			
		end
		if botItem[ind] == nil then
			botItem[ind] = "Pants #"..i
		end
		x = NativeUI.CreateListItem(botItem[ind], amount, 1, "",5)

		menu:AddItem(x)
		

	end
end
_menuPool:RefreshIndex()


	menu.OnIndexChange = function(menu,index6)
		playerPed = GetPlayerPed(-1)
		SetPedComponentVariation(playerPed, 4, index6-1, 0, 2)
		local index2 = 1
		menu.OnListSelect = function(menu, _, _)
			ESX.TriggerServerCallback("parow:GetMoneyVet", function(result)
				if result then
			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
	
					 clothesSkin = {
						['pants_1'] = index6-1, ['pants_2'] = index2-1,


					}

					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					
				
				
			end)

			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
				TriggerServerEvent('esx_skin:save', skin)
				
			
			
			end)
		end
	end)
			menu.OnMenuClosed = function(_)
				gilItem= {}
				sousTorse = {}
			end
		end
		menu.OnListChange = function(_, _, index24)
			index2 = index24
			SetPedComponentVariation(playerPed, 4, index6-1, index24-1, 2)

		end
	end
	botItem={}
end



function chaussureFct(menu)
	--("s")
	playerPed = GetPlayerPed(-1)

	 if curSex == 0 then

						chaussureItem = {
							"Sneakers",
							"Half shoes",
							"Sneakers",
							"Luxury shoes",
							"Classical shoes",
							"Tap shoes",
							"Tap shoes chaussette",
							"High sock shoes",
							"High sock shoes",
							"High sock shoes",
							"Luxury high sock shoes",
							"Luxury shoes",
							"Adventurer shoes",
							"/",
							"Adventurer shoes",
							"Luxury shoes",
							"Tap shoes",
							"Elf shoes",
							"Luxury shoes",
							"Luxury shoes",
							"Luxury shoes",
							"Luxury shoes",
							"Classical shoes",
							"Ankle boots",
							"Ankle boots",
							"Ankle boots",
							"Classical shoes",
							"Ankle boots",
							"Extravagant shoes",
							"Luxury shoes",
							"Luxury shoes",
							"Sneakers",
							"Street shoes",
							"/",
							"Barefoot",
							"Ankle boots",
							"Luxury shoes",
							"Boots",
							"High-heel shoes",
							"Boots",
							"Luxury shoes",
							"Slippers",
							"Simple sneakers",
							"Classy shoes",
							"Boots",
							"Half shoes",
							"Sneakers",
							"Boots",
							"Classical shoes",
							
							"Classical shoes",
							
							"Boots",
							"Hiking boots",
							"Chaussure",
							"Boots",
							"Hiking boots",
							"Hiking boots",
							"Hiking boots",
							"Hiking boots",
							"Tron shoes",
							"Shoes",
							"Sneakers",
							"Luminous slippers"

						}

						for i = 0,GetNumberOfPedDrawableVariations(playerPed,6)-1,1 do
							--
							local amount = {}
							local ind = i+1
							for c = 1, GetNumberOfPedTextureVariations(playerPed, 6, i), 1 do

								amount[c] = c 
								
							end
							if chaussureItem[ind] == nil then
								chaussureItem[ind] = "Shoes #"..i
							end
							x = NativeUI.CreateListItem(chaussureItem[ind], amount, 1, "",5)
						
							menu:AddItem(x)
							

						end

					_menuPool:RefreshIndex()

						
						menu.OnIndexChange = function(menu,index6)
							playerPed = GetPlayerPed(-1)
							SetPedComponentVariation(playerPed, 6, index6-1, 0, 2)
							local index2 = 1
							menu.OnListSelect = function(menu, _, index)
								print(index)
								ESX.TriggerServerCallback("parow:GetMoneyVet", function(result)
										if result then
												TriggerEvent('skinchanger:getSkin', function(skin)
										
													
										
														clothesSkin = {
															['shoes_1'] = index6-1, ['shoes_2'] = index2-1,


														}

														TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
														
													
													
												end)

												TriggerEvent('skinchanger:getSkin', function(skin)
										
													
													TriggerServerEvent('esx_skin:save', skin)
													
												
												
												end)
											
											
										end	
									 				
										menu.OnMenuClosed = function(_)
											gilItem= {}
											sousTorse = {}
										end
								end)
							end
							
							menu.OnListChange = function(menu, _, index23)
							index2 = index23
								SetPedComponentVariation(playerPed, 6, index6-1, index23-1, 2)

									menu.OnMenuClosed = function(_)
										chaussureItem= {}
									end
								
							end
						end
	else
		chaussureItem= {"High heels","Street shoes","Boots","Converse","Sport shoes","Flip flops","Pointed high heels","Ankle bootss","Open-ended high heels","Short shoes","Sport shoes","Basketball shoes","Barefoot","Ballerina shoes","Sandals","Sandals","Elf shoes","High heels","High heels","Pointed high heels","Boots","Pointed high heels 2","High heels","Safety boots","Safety boots 2","Ankle boots","Street shoes","Sport shoes","Costume boots","Ankle boots","Boots","Basketball shoes","Converse","Barefoot","Barefoot 2","Mountain boots","Mocassin","Western boots","Cowboy boots","Costume boots","High heels","High heels 2","High heels","Pointed high heels 2","Western boots 2","Western shoes","Sport shoes","Ski boots","Converse 2","Converse 3","Biker boots","Biker shoes","Leather ankle boots","Biker boots 2","Biker shoes 2","Biker boots 3","Biker shoes 3","Illuminated sports shoes","Leather shoes","Basketball shoes","Slippers","Safety shoes","Mountain boots","Mountain shoes","Mountain boots 2","Mountain shoes 2","Tennis shoes","Boots","Street shoes","Palm shoes","Slippers","Basket","Boots","Safety shoes","Mountain boots","Hiking boots","Big high heels"}
		for i = 0,#chaussureItem,1 do
			--
			local amount = {}
			local ind = i+1
			for c = 1, GetNumberOfPedTextureVariations(playerPed, 6, i), 1 do
	
				amount[c] = c 
				
			end
			if chaussureItem[ind] == nil then
				chaussureItem[ind] = "Shoes #"..i
			end
			x = NativeUI.CreateListItem(chaussureItem[ind], amount, 1, "",5)
		
			menu:AddItem(x)
			
	
		end
	end
end


function boucleFct(menu)
	--("s")
	if curSex == 0 or 1 then
	playerPed = GetPlayerPed(-1)
	boucleItem = {
		"Headset",
		"Headset",
		"Headset",
		"None",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",
		"Earrings",

		"Earrings",



	}
	for i = 0,36,1 do
		--
		local amount = {}
		local ind = i+1
		for c = 1, GetNumberOfPedPropTextureVariations(playerPed, 2, i), 1 do

			amount[c] = c 
			
		end
		if boucleItem[i] == nil then
			boucleItem[i] = "Earpiece #"..i
		end
		x = NativeUI.CreateListItem(boucleItem[ind], amount, 1, "",5)
	
		menu:AddItem(x)
		

	end
	--boucleItem= {}
	_menuPool:RefreshIndex()
	local index2 = 1
	menu.OnIndexChange = function(menu,index6)
		playerPed = GetPlayerPed(-1)
		SetPedPropIndex(playerPed, 2, index6-1, 0, 2)
		index2 = 1
		menu.OnListSelect = function(_, _, _)
			TriggerServerEvent("parow:SetNewMasque",index6-1,index2-1,"Earpiece",boucleItem[index6],2)
		end
		menu.OnListChange = function(_, _, index26)
			index2 = index26
			SetPedPropIndex(playerPed, 2, index6-1, index26-1, 2)

		end
	end
end

end


function lunetteFct(menu)
	--("s")
	if curSex == 0 then
	playerPed = GetPlayerPed(-1)
	lunetteItem = {
		"None",
		"Sports glasses",
		"Sunglasses",
		"Oldschool glasses",
		"Middle-aged glasses",
		"Sunglasses",
		"None",
		"Sunglasses",
		"Glasses",
		"Sports glasses",
		"Mafia glasses",
		"None",
		"Luxury glasses",
		"Fancy glasses",
		"None",
		"Sports glasses",
		"Sports glasses",
		"Tinted glasses",
		"Glasses",
		"Fake glasses",
		"Modern glasses",
		"American glasses",
		"American glasses",
		"Sports glasses",
		
		"Pilot glasses",
		"Pilot glasses"
	}


	for i = 0,25,1 do
		--
		local amount = {}
		local ind = i+1
		for c = 1, GetNumberOfPedPropTextureVariations(playerPed, 1, i), 1 do

			amount[c] = c 
			
		end
		if lunetteItem[i] == nil then
			lunetteItem[i] = "Glasses #"..i
		end
		x = NativeUI.CreateListItem(lunetteItem[ind], amount, 1, "",5)
	
		menu:AddItem(x)
		

	end
	_menuPool:RefreshIndex()
--	lunetteItem= {}
	local index2 = 1
	menu.OnIndexChange = function(menu,index6)
		playerPed = GetPlayerPed(-1)
		print(index2)
		index2 = 1
		SetPedPropIndex(playerPed, 1, index6-1, 0, 2)
		
		menu.OnListSelect = function(_, _, _)
			print(index2)
			TriggerServerEvent("parow:SetNewMasque",index6-1,index2-1,"Glasses",lunetteItem[index6],1)


		end
		menu.OnListChange = function(menu, _, index24)
			print(index2)
			
			index2 = index24
			print(index2)

			SetPedPropIndex(playerPed, 1, index6-1, index24-1, 2)
			

				menu.OnMenuClosed = function(_)
					
				end
			
		end
		
	end
end

end
Citizen.CreateThread(function()

    for i = 1, #ConfigclotheShop.Map, 1 do
        local blip = AddBlipForCoord(ConfigclotheShop.Map[i].x, ConfigclotheShop.Map[i].y, ConfigclotheShop.Map[i].z)
        SetBlipSprite(blip, ConfigclotheShop.Map[i].id)
        SetBlipDisplay(blip, 4)
        SetBlipColour(blip, ConfigclotheShop.Map[i].color)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 1.0)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(ConfigclotheShop.Map[i].name)
        EndTextCommandSetBlipName(blip)
    end

end)
function casqueFct(menu)
	if curSex == 0 then
playerPed = GetPlayerPed(-1)
	
	
	local chapeauItem = {
		"Helmet",
		"Dunce cap",
		"Cap",
		"Bob",
		"LS Cap",
		"Cap",
		"Military cap",
		"Beret",
		"",
		"Inverse cap",
		"Cap",
		"",
		"Hat",
		"Cowboy hat",
		"Bandana",
		"Headphones",
		"Helmet",
		"Helmet",
		"Helmet",
		"Pilot Helmet",
		"Bob de pêcheur",
		"Chill hat",
		"Christmas hat",
		"Elf hat",
		"Reindeer atlers",
		"Hat",
		"Melon hat",
		"Tophat",
		"Cap",
		"Hat",
		"Hat",
		"USA Hat",
		"USA Hat",
		"USA Hat",
		"USA Cap",
		"USA",
		"USA Antenna",
		"Beer hat",
		"Pilot helmet",
		"SWAT Helmet",
		"Christmas hat",
		"Christmas hat",
		"Christmas hat",
		"Christmas hat",
		"Helmet",
		"Inverse cap",
		"LSPD Hat",
		"Pilot helmet",
		"Helmet",
		"Helmet",
		"Helmet",
		"Helmet",
		"Helmet",
		"Helmet",
		"Helmet",
		"Helmet",
		"Helmet",
		"Helmet",
		"Alien hat",
		"Helmet",
		"Helmet",
		"Helmet",
		"Hat",
		"Helmet",
		"Hat",
		"Helmet"
		
	}




	for i = -1,GetNumberOfPedDrawableVariations(playerPed, 0),1 do
		--
		local amount = {}
		local ind = i+2
		for c = 1, GetNumberOfPedPropTextureVariations(playerPed, 0, i+1), 1 do

			amount[c] = c 
			
		end
		if chapeauItem[i] == nil then
			chapeauItem[i] = i
		end
		v = NativeUI.CreateListItem(chapeauItem[ind], amount, 1, "",5)
	
		menu:AddItem(v)
		

	end
	_menuPool:RefreshIndex()
	
	menu.OnIndexChange = function(menu,index6)
		local index2 = 1
		
		playerPed = GetPlayerPed(-1)
		SetPedPropIndex(playerPed, 0, index6-1, 0, 2)
		menu.OnListSelect = function(_, _, _)
			pdka = index2 - 1 
			TriggerServerEvent("parow:SetNewMasque",index6-1,pdka,	"Hat",chapeauItem[index6],0)
		end
		menu.OnListChange = function(_, _, index26)
			index2 = index26
			SetPedPropIndex(playerPed, 0, index6-1, index26-1, 2)
		end
	end
else

end 

end






local menuLoaded = false
local clotheShop = NativeUI.CreateMenu("", "Shop", 5, 100,"shopui_title_midfashion","shopui_title_midfashion")
function OpenClotheShop()
	TriggerEvent("parow:exit")
	
	if menuLoaded == false  then
		
		_menuPool:Add(clotheShop)
		ClotheShopAdd(clotheShop)
		menuLoaded = true
	--	clotheShop:Visible(not clotheShop:Visible())
--	Citizen.Wait(200)
	_menuPool:RefreshIndex()
	clotheShop:Visible(not clotheShop:Visible())
	else
		_menuPool:CloseAllMenus()
		print("MENULOADED")
		clotheShop:Visible(not clotheShop:Visible())
		
end
	
	

end



_menuPool:RefreshIndex()



























-- function

Citizen.CreateThread(function()
	--OpenClotheShop()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)

	end
	
	TriggerEvent('parow:exit')
end)



AddEventHandler('clothesShop:hasEnteredMarker', function(zone)

	CurrentAction6     = 'shop_menu'
	CurrentAction6Msg  = 'Press ~INPUT_CONTEXT~ to open the shop.'
	CurrentAction6Data = {zone = zone}

end)

AddEventHandler('clothesShop:hasExitedMarker', function(_)

	CurrentAction6 = nil
	CurrentAction6Msg = nil
	TriggerEvent("parow:exit")
	_menuPool:CloseAllMenus()
	if MenuOn then
		RecupTenues()
		MenuOn = false
	end
end)
 


-- Display markers
Citizen.CreateThread(function()
  while true do
	Wait(0)
	--print("oyo")
    local coords = GetEntityCoords(GetPlayerPed(-1))
    for _,v in pairs(ConfigclotheShop.Zones) do
      for i = 1, #v.Pos, 1 do
        if(ConfigclotheShop.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < ConfigclotheShop.DrawDistance) then
          DrawMarker(ConfigclotheShop.Type, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, ConfigclotheShop.Size.x, ConfigclotheShop.Size.y, ConfigclotheShop.Size.z, ConfigclotheShop.Color.r, ConfigclotheShop.Color.g, ConfigclotheShop.Color.b, 100, false, true, 2, false, false, false, false)
        end
      end
    end
  end
end)
-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Wait(1000)
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(ConfigclotheShop.Zones) do
			for i = 1, #v.Pos, 1 do
				if(GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 1.5) then
					isInMarker  = true
					ShopItems   = v.Items
					currentZone = k
					LastZone    = k
				end
			end
		end
		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('clothesShop:hasEnteredMarker', currentZone)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('clothesShop:hasExitedMarker', LastZone)
			--("s")
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(0)
	  
	  if CurrentAction6 ~= nil then
		SetTextComponentFormat('STRING')
		AddTextComponentString(CurrentAction6Msg)
		DisplayHelpTextFromStringLabel(0, 0, 1, -1)
  
		if IsControlJustReleased(0, 38) then
		--	TriggerEvent("onClientMaspStart")
		
			
			OpenClotheShop()
			recp()
			MenuOn = true
	--	  CurrentAction6 = nil
  
		end
  
	  end
	end
  end)


  function recp()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
  end

  Citizen.CreateThread(function()

    while true do

        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        if (IsControlJustReleased(0, Keys["K"])) then
            _menuPool:CloseAllMenus()
            OpenAccessMenus()
		end
    end
end)
local mainMenu = nil
function OpenAccessMenus()
    _menuPool:CloseAllMenus()
    mainMenu = NativeUI.CreateMenu("My accessories", "Accessories available", 5, 200)
    _menuPool:Add(mainMenu)
    RefreshData()



end
function RefreshData()
    ESX.TriggerServerCallback("parow:getMask", function(result)
		MaskTab = result
		maskMenu(mainMenu)
    end)
end
function maskMenu(menu)
    local accessories = { "Mask", "Hat", "Glasses", "Earrings", "Bulletproof vest" }
    local accessoriesIndex = { "mask", "hat", "glasses", "ears", "gilet" }
    xss = NativeUI.CreateListItem("Take off", accessories, 1, "")
    menu:AddItem(xss)
    menu.OnListSelect = function(m, item, index)
        if item == xss then
            accessory = accessoriesIndex[index]

            if accessory == "mask" then
                SetPedComponentVariation(playerPed, 1, 0, 0, 2)
            end
            if accessory == "glasses" then
                ClearPedProp(playerPed, 1)


            end
            if accessory == "hat" then
                ClearPedProp(playerPed, 0)

            end
            if accessory == "ears" then
                ClearPedProp(playerPed, 2)


            end
        end


    end
        result = MaskTab
        --(json.encode(result))
        if #result == 0 then
            u = NativeUI.CreateItem("Empty", "")
            menu:AddItem(u)
        else

            for i = 1, #result, 1 do
				menumbk = menu
				_menuPool:RefreshIndex()
                local xfvde = _menuPool:AddSubMenu(menu, result[i].label, "", 5, 200)

                xl = NativeUI.CreateItem("Wear", "")
                xc = NativeUI.CreateItem("Rename", "")
                xv = NativeUI.CreateItem("Give", "")
                xb = NativeUI.CreateItem("Drop", "")
                xfvde:AddItem(xl)
                xfvde:AddItem(xc)
                xfvde:AddItem(xv)
                xfvde:AddItem(xb)
                xfvde.OnItemSelect = function(menu, _, index)
                 --   i = i+1
                    if index == 1 then
                        k = json.decode(result[i].mask)
                        ped = GetPlayerPed(-1)
                        uno = k.mask_1
                        dos = k.mask_2
                        typos = result[i].type
                        --(typos)
                        if typos == "Mask" then

                            if ped then
                                local dict = 'missfbi4'
                                local myPed = PlayerPedId()
                                RequestAnimDict(dict)

                                while not HasAnimDictLoaded(dict) do
                                    Citizen.Wait(0)
                                end

                                local animation = ''
                                local flags = 0 -- only play the animation on the upper body
                                animation = 'takeoff_mask'
                                TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                                Citizen.Wait(1000)
                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                playerPed = GetPlayerPed(-1)
                                SetPedComponentVariation(playerPed, 1, k.mask_1, k.mask_2, 2)
                                Citizen.Wait(200)
                                ClearPedTasks(playerPed)
                            end
                        elseif typos == "Glasses" then

                            if ped then
                                local dict = 'clothingspecs'
                                local myPed = PlayerPedId()
                                RequestAnimDict(dict)

                                while not HasAnimDictLoaded(dict) do
                                    Citizen.Wait(0)
                                end

                                local animation = ''
                                local flags = 0 -- only play the animation on the upper body
                                animation = 'try_glasses_positive_a'
                                TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                                Citizen.Wait(1000)
                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                playerPed = GetPlayerPed(-1)
                                SetPedPropIndex(playerPed, 1, k.mask_1, k.mask_2, 2)
                                Citizen.Wait(200)
                                ClearPedTasks(playerPed)
                            end

                        elseif typos == "Hat" then

                            if ped then
                                local dict = 'missheistdockssetup1hardhat@'
                                local myPed = PlayerPedId()
                                RequestAnimDict(dict)

                                while not HasAnimDictLoaded(dict) do
                                    Citizen.Wait(0)
                                end

                                local animation = ''
                                local flags = 0 -- only play the animation on the upper body
                                animation = 'put_on_hat'
                                TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                                Citizen.Wait(1000)
                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                playerPed = GetPlayerPed(-1)
                                SetPedPropIndex(playerPed, 0, k.mask_1, k.mask_2, 2)
                                Citizen.Wait(200)
                                ClearPedTasks(playerPed)
                            end
                        elseif typos == "Earring" then

                            if ped then
                                local dict = 'mp_masks@standard_car@rps@'
                                local myPed = PlayerPedId()
                                RequestAnimDict(dict)

                                while not HasAnimDictLoaded(dict) do
                                    Citizen.Wait(0)
                                end

                                local animation = ''
                                local flags = 0 -- only play the animation on the upper body
                                animation = 'put_on_mask'
                                TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                                Citizen.Wait(1000)
                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                playerPed = GetPlayerPed(-1)
                                SetPedPropIndex(playerPed, 2, k.mask_1, k.mask_2, 2)
                                Citizen.Wait(200)
                                ClearPedTasks(playerPed)
                            end


                        end
                    end
                    if index == 2 then
                        typos = result[i].type
                        txt = gettxt2(result[i].label)
                        txt = tostring(txt)
                        if txt ~= nil then
                            TriggerServerEvent("parow:RenameMasque", result[i].id, txt, typos)
                          --  _menuPool:CloseAllMenus()
                          k = menumbk:GetItemAt(i+1)
                          k:UpdateText(txt)
                          menu:GoBack()
                          result[i].label = txt

                        end

                    end
                    if index == 3 then
                        local myPed = PlayerPedId()
                        if result[i].index == 99 then
                            SetPedComponentVariation(playerPed, 1, 0, 0, 2)
                        else
                            ClearPedProp(myPed, result[i].index)
                        end
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        local closestPed = GetPlayerPed(closestPlayer)

                        if IsPedSittingInAnyVehicle(closestPed) then
                            ESX.ShowNotification('~r~Cannot give items in vehicles')
                            return
                        end

                        if closestPlayer ~= -1 and closestDistance < 3.0 then

                            TriggerServerEvent('prw:GiveAccessories', GetPlayerServerId(closestPlayer), result[i].id, result[i].label)


                            menu:GoBack()

                          --  _menuPool:RefreshIndex()
                            table.remove( MaskTab, i  )
                            menumbk:RemoveItemAt(i+1)

                        else
                            ESX.ShowNotification("~r~No nearby players")

                        end


                    end
                    if index == 4 then
                        TriggerServerEvent('prw:Delclo', result[i].id, result[i].label,result[i])

                        menu:GoBack()

                        --_menuPool:RefreshIndex()
                        table.remove( MaskTab, i  )
                        menumbk:RemoveItemAt(i+1)

                    end
                end
                --    menu:AddItem(psp)
                -- _menuPool:RefreshIndex()
            end
		end
		menu:Visible(true)
end


