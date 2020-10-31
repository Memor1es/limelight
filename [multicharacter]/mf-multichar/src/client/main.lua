Multichar.Player    = PlayerId()
Multichar.Debug     = false

Multichar.Init = function()
  DoScreenFadeOut(0)

  while not NetworkIsPlayerActive(Multichar.Player) and not Multichar.Debug do Wait(0) end
  DoScreenFadeOut(0)

  while not Multichar.UiReady do
    Multichar.ConfigureUI()
    Wait(1000)
  end
  DoScreenFadeOut(0)

  if Multichar.Debug then
    SetEntityCoords(GetPlayerPed(-1),0.0,0.0,0.0)
    Wait(1000)
  end

  ESX.TriggerServerCallback("Multichar:Login",function(slots,characters)
    Multichar.Slots       = (slots or 4)
    Multichar.Characters  = (characters or {})
    Multichar.Start()
  end)
end

Multichar.ConfigureUI = function()
  SendNUIMessage({
    func = "Configure",
    args = {
      OnConfig            = string.format("https://%s/OnConfig",            Multichar.Resource),
      OnRotate            = string.format("https://%s/OnRotate",            Multichar.Resource),
      OnSelect            = string.format("https://%s/OnSelect",            Multichar.Resource),
      OnCreate            = string.format("https://%s/OnCreate",            Multichar.Resource),
      OnDelete            = string.format("https://%s/OnDelete",            Multichar.Resource),
      OnCloseRegistration = string.format("https://%s/OnCloseRegistration", Multichar.Resource),
    }
  })
end

Multichar.Start = function()
  local ped = GetPlayerPed(-1)
  SetEntityCoords       (ped, Config.SelectorLocation.x,Config.SelectorLocation.y,Config.SelectorLocation.z-5.0)
  SetEntityHeading      (ped, Config.SelectorHeading)
  FreezeEntityPosition  (ped,true)

  ShutdownLoadingScreen     ()
  ShutdownLoadingScreenNui  ()
  Wait                      (1000)

  DisplayHud      (false)
  DisplayRadar    (false)
  DoScreenFadeIn  (1000)

  Citizen.CreateThread(Multichar.Selector)

  Wait(1000)
  Multichar.SetOpacity(1.0)
  SetNuiFocus(true,true)
end

Multichar.SetOpacity = function(o)
  SendNUIMessage({
    func = "SetOpacity",
    args = {
      opacity = o
    }
  })
end

Multichar.Selector = function()
  Multichar.Cam = Multichar.CreateCam(Config.SelectorLocation,Config.SelectorHeading,true)
  while not IsCamActive(Multichar.Cam) do Wait(0); end
  while not IsCamRendering(Multichar.Cam) do Wait(0); end

  Multichar.Selecting = true
  Multichar.Selection = 1
  Multichar.Displays  = Multichar.Display(Multichar.Selection)

  SetFocusPosAndVel(Multichar.Displays[2].pos.x,Multichar.Displays[2].pos.y,Multichar.Displays[2].pos.z,0.0,0.0,0.0)

  while Multichar.Selecting do    
    -- NetworkOverrideClockTime(1,1,1)

    Multichar.DrawSpotlight(Multichar.Displays[1].pos, 07.0, 0.1)
    Multichar.DrawSpotlight(Multichar.Displays[2].pos, 10.0, 0.5)
    Multichar.DrawSpotlight(Multichar.Displays[3].pos, 07.0, 0.1)

    Wait(0)
  end
end

Multichar.DisplayCleanup = function()
  if Multichar.Displays then
    for k,v in ipairs(Multichar.Displays) do
      if v.ent then        
        SetEntityAsMissionEntity(v.ent,true,true)
        DeleteEntity(v.ent)
      end
    end
  end
end

Multichar.SetSkin = function(ped,skin)
  if ped == GetPlayerPed(-1) then
    local hash = GetHashKey((skin.sex == 0 and 'mp_m_freemode_01' or 'mp_f_freemode_01'))
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(0); end

    SetPlayerModel(PlayerId(),hash)
    while GetEntityModel(GetPlayerPed(-1)) ~= hash do Wait(0); end
    ped = GetPlayerPed(-1)
  end
  
  SetPedHeadBlendData (ped, skin['face'], skin['face'], skin['face'], skin['skin'], skin['skin'], skin['skin'], 1.0, 1.0, 1.0, true)
  while not HasPedHeadBlendFinished(ped) do Wait(0); end

  SetPedHairColor           (ped,       skin['hair_color_1'],  skin['hair_color_2'])          
  SetPedHeadOverlay         (ped, 3,    skin['age_1'],         (skin['age_2'] / 10) + 0.0)
  SetPedHeadOverlay         (ped, 1,    skin['beard_1'],       (skin['beard_2'] / 10) + 0.0)     
  SetPedEyeColor            (ped,       skin['eye_color'],     0, 1)                  
  SetPedHeadOverlay         (ped, 2,    skin['eyebrows_1'],    (skin['eyebrows_2'] / 10) + 0.0)   
  SetPedHeadOverlay         (ped, 4,    skin['makeup_1'],      (skin['makeup_2'] / 10) + 0.0)   
  SetPedHeadOverlay         (ped, 8,    skin['lipstick_1'],    (skin['lipstick_2'] / 10) + 0.0)  
  SetPedComponentVariation  (ped, 2,    skin['hair_1'],        skin['hair_2'], 2)        
  SetPedHeadOverlayColor    (ped, 1, 1, skin['beard_3'],       skin['beard_4'])       
  SetPedHeadOverlayColor    (ped, 2, 1, skin['eyebrows_3'],    skin['eyebrows_4'])    
  SetPedHeadOverlayColor    (ped, 4, 1, skin['makeup_3'],      skin['makeup_4'])         
  SetPedHeadOverlayColor    (ped, 8, 1, skin['lipstick_3'],    skin['lipstick_4'])      
  SetPedHeadOverlay         (ped, 5,    skin['blush_1'],       (skin['blush_2'] / 10) + 0.0)     
  SetPedHeadOverlayColor    (ped, 5, 2, skin['blush_3'])                   
  --SetPedHeadOverlay         (ped, 6,    skin['complexion_1'],  (skin['complexion_2'] / 10) + 0.0) 
  --SetPedHeadOverlay         (ped, 7,    skin['sun_1'],         (skin['sun_2'] / 10) + 0.0)
  --SetPedHeadOverlay         (ped, 9,    skin['moles_1'],       (skin['moles_2'] / 10) + 0.0)    
  --SetPedHeadOverlay         (ped, 10,   skin['chest_1'],       (skin['chest_2'] / 10) + 0.0)   
  --SetPedHeadOverlayColor    (ped, 10, 1,skin['chest_3'])                      
  --SetPedHeadOverlay         (ped, 11,   skin['bodyb_1'],       (skin['bodyb_2'] / 10) + 0.0)   

  if skin['ears_1'] == -1 then
    ClearPedProp(ped, 2)
  else
    SetPedPropIndex         (ped, 2,    skin['ears_1'],      skin['ears_2'], 2)
  end

  SetPedComponentVariation(ped, 8,    skin['tshirt_1'],    skin['tshirt_2'], 2)    
  SetPedComponentVariation(ped, 11,   skin['torso_1'],     skin['torso_2'], 2)     
  SetPedComponentVariation(ped, 3,    skin['arms'],        skin['arms_2'], 2)          
  SetPedComponentVariation(ped, 10,   skin['decals_1'],    skin['decals_2'], 2) 
  SetPedComponentVariation(ped, 4,    skin['pants_1'],     skin['pants_2'], 2)     
  SetPedComponentVariation(ped, 6,    skin['shoes_1'],     skin['shoes_2'], 2)      
  SetPedComponentVariation(ped, 1,    skin['mask_1'],      skin['mask_2'], 2)         
  SetPedComponentVariation(ped, 9,    skin['bproof_1'],    skin['bproof_2'], 2)      
  SetPedComponentVariation(ped, 7,    skin['chain_1'],     skin['chain_2'], 2)      
  SetPedComponentVariation(ped, 5,    skin['bags_1'],      skin['bags_2'], 2)          

  if skin['helmet_1'] == -1 then
    ClearPedProp(ped, 0)
  else
    SetPedPropIndex(ped, 0,    skin['helmet_1'],      skin['helmet_2'], 2)  
  end

  if skin['glasses_1'] == -1 then
    ClearPedProp(ped, 1)
  else
    SetPedPropIndex(ped, 1,    skin['glasses_1'],     skin['glasses_2'], 2)  
  end

  if skin['watches_1'] == -1 then
    ClearPedProp(ped, 6)
  else
    SetPedPropIndex(ped, 6,    skin['watches_1'],     skin['watches_2'], 2)   
  end

  if skin['bracelets_1'] == -1 then
    ClearPedProp(ped, 7)
  else
    SetPedPropIndex(ped, 7,    skin['bracelets_1'],   skin['bracelets_2'], 2)    
  end
end

Multichar.ClonePed = function(index,pos)
  local char = Multichar.Characters[index]
  local hash = GetHashKey((char.skin.sex == 0 and 'mp_m_freemode_01' or 'mp_f_freemode_01'))

  RequestModel(hash)
  while not HasModelLoaded(hash) do Wait(0); end

  local clone = CreatePed(4,hash,pos.x,pos.x,pos.z,Config.SelectorHeading-180.0,false,false)

  FreezeEntityPosition(clone,true)
  while not DoesEntityExist(clone) do Wait(0); end

  Multichar.SetSkin(clone,char.skin)
  while not HasCollisionLoadedAroundEntity(clone) do Wait(0); end
  FreezeEntityPosition(clone,false)

  return clone
end

Multichar.Display = function(center)
  if not Multichar.Rotating then
    Multichar.Rotating = true
    Multichar.DisplayCleanup()

    local cam = Multichar.Cam
    local ped = GetPlayerPed(-1)
    local right,forward,up,pos = GetCamMatrix(cam)
    local start = pos + (forward*5) - vector3(0.0,0.0,1.0)

    local left  = Multichar.Rotator(Multichar.Slots,center,-1)
    local right = Multichar.Rotator(Multichar.Slots,center,1)

    local char_left   = Multichar.Characters[left]
    local char_center = Multichar.Characters[center]
    local char_right  = Multichar.Characters[right]

    local pos_left    = (Multichar.PointOnSphere(0.00,180.0,1.0) + start)
    local pos_center  = (Multichar.PointOnSphere(0.00,270.0,1.0) + start)
    local pos_right   = (Multichar.PointOnSphere(0.00,360.0,1.0) + start)

    local ent_left    = (char_left    and Multichar.ClonePed(left,pos_left)     or false)
    local ent_center  = (char_center  and Multichar.ClonePed(center,pos_center) or false)
    local ent_right   = (char_right   and Multichar.ClonePed(right,pos_right)   or false)

    if ent_left then
      SetEntityCoords       (ent_left, pos_left)
      SetEntityHeading      (ent_left, 90.0)
      SetEntityAlpha        (ent_left, 50)
      FreezeEntityPosition  (ent_left, true)
    end

    if ent_center then
      SetEntityCoords       (ent_center, pos_center)
      SetEntityHeading      (ent_center, 90.0)
      FreezeEntityPosition  (ent_center, true)
    end

    if ent_right then
      SetEntityCoords       (ent_right, pos_right)
      SetEntityHeading      (ent_right, 90.0)
      SetEntityAlpha        (ent_right, 50)
      FreezeEntityPosition  (ent_right, true)
    end

    local characters = {
      [1] = { character = char_left,   pos = pos_left,    index = left,   ent = ent_left   },
      [2] = { character = char_center, pos = pos_center,  index = center, ent = ent_center },
      [3] = { character = char_right,  pos = pos_right,   index = right,  ent = ent_right  },
    }

    SendNUIMessage({
      func = 'SetCharacter',
      args = {
        character = char_center
      }
    })

    Multichar.Rotating = false
    return characters
  else
    return Multichar.Displays
  end
end

Multichar.CreateCam = function(pos,rot,active)
  local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA")

  if pos then 
    SetCamCoord(cam,pos.x,pos.y,pos.z)
  end

  if rot then 
    if type(rot) == "vector3" or type(rot) == "table" then
      SetCamRot(cam,rot.x,rot.y,rot.z,2)
    elseif type(rot) == "number" then
      SetCamRot(cam,0.0,0.0,rot,2)
    end
  end

  if active then
    SetCamActive(cam,true)
    RenderScriptCams(true,true)
  end

  return cam
end

Multichar.Rotator = function(len,val,mod)
  local v = val+mod
  if v <= 0 then
    return len
  elseif v > len then
    return 1
  else
    return v
  end
end

Multichar.DestroyCam = function(cam)
  RenderScriptCams(false,false)
  SetCamActive(cam,false)
  DestroyCam(cam)
end

Multichar.DrawSpotlight = function(p,s,d)
  local pos = vector3(p.x,p.y,p.z + 5.0)
  local direction = p - pos
  local normal = norm(direction)
  DrawSpotLight(pos.x,pos.y,pos.z, normal.x,normal.y,normal.z, 255,255,255, s, d, 0.0, 8.0, 1.0)
end

Multichar.PointOnSphere = function(alt,azu,radius,orgX,orgY,orgZ)
  local toradians = 0.017453292384744
  alt,azu,radius,orgX,orgY,orgZ = ( tonumber(alt or 0) or 0 ) * toradians, ( tonumber(azu or 0) or 0 ) * toradians, tonumber(radius or 0) or 0, tonumber(orgX or 0) or 0, tonumber(orgY or 0) or 0, tonumber(orgZ or 0) or 0
  if      vector3
  then
      return
      vector3(
           orgX + radius * math.sin( azu ) * math.cos( alt ),
           orgY + radius * math.cos( azu ) * math.cos( alt ),
           orgZ + radius * math.sin( alt )
      )
  end
end

Multichar.NewCharacter = function(slot)
  Multichar.SelectedSlot = slot
  SendNUIMessage({
    func = "NewCharacter"
  })
end

Multichar.SelectCharacter = function(slot,skin)
  ESX.TriggerServerCallback("Multichar:CharacterSelected",function()
    TriggerEvent('skinchanger:loadSkin',skin)
    Multichar.Skin = skin

    FreezeEntityPosition(GetPlayerPed(-1),false)
    DoScreenFadeOut(1000)
    Wait(1000)
    Multichar.DestroyCam()
    Multichar.Selecting = false

    if Config.EsxVersion <= 1.1 then
      TriggerServerEvent('es:firstJoinProper') 
      TriggerEvent('es:allowedToSpawn')
    elseif Config.EsxVersion == 1.2 then
      TriggerServerEvent("esx:playerJoined")
    elseif Config.EsxVersion == 1.3 then
      TriggerServerEvent("esx:onPlayerJoined")
    end
  end,slot)
end

Citizen.CreateThread(Multichar.Init)

-- RegisterCommand('set:time', function(source,args)
--   local hr,min = (tonumber(args[1]) or 1),(tonumber(args[2]) or 1)
--   NetworkOverrideClockTime(hr,min,1)
-- end)

RegisterNUICallback("OnRotate",function(data)
  Multichar.Selection = Multichar.Rotator(Multichar.Slots,Multichar.Selection,data.rotation)
  Multichar.Displays  = Multichar.Display(Multichar.Selection)
end)

RegisterNUICallback("OnConfig",function(data)
  Multichar.UiReady = true
end)

RegisterNUICallback("OnSelect",function()
  if not Multichar.Characters[Multichar.Selection] then
    Multichar.DisplayCleanup()
    Multichar.NewCharacter(Multichar.Selection)
  else
    SetNuiFocus(false,false)
    Multichar.SetOpacity(0.0)
    Multichar.DisplayCleanup()
    Multichar.SelectCharacter(Multichar.Selection,Multichar.Characters[Multichar.Selection].skin)
  end
end)

RegisterNUICallback("OnCreate",function(data)
  SetNuiFocus(false,false)
  Multichar.SetOpacity(0.0)

  local done = function()
    ESX.UI.Menu.CloseAll()
    TriggerEvent('skinchanger:getSkin', function(skin)
      TriggerServerEvent("Multichar:CharacterCreated",data,skin,Multichar.Selection)
      Multichar.SelectCharacter(Multichar.Selection,skin)
    end)
  end

  TriggerEvent('skinchanger:loadDefaultModel',(data.gender == "Male" and true or false), function()
    local ped = GetPlayerPed(-1)
    SetEntityCoords(ped, Multichar.Displays[2].pos)
    SetEntityHeading(ped, Config.SelectorHeading-180.0)
    TriggerEvent("esx_skin:openMenu",done,done)
  end)
end)

RegisterNUICallback("OnDelete",function()
  local selection = Multichar.Selection
  ESX.TriggerServerCallback("Multichar:DeleteCharacter",function(characters)
    Multichar.Characters  = characters
    Multichar.Displays    = Multichar.Display(selection)
  end,selection)
end)

RegisterNUICallback("OnCloseRegistration",function()
  Multichar.Displays = Multichar.Display(Multichar.Selection)
end)

RegisterCommand("multichar:relog",function()
  ESX.UI.HUD.SetDisplay(0.0)
  ESX.TriggerServerCallback("Multichar:Relog",function(slots,characters)
    DoScreenFadeOut(1000)
    Wait(1000)

    Multichar.Slots       = (slots or 4)
    Multichar.Characters  = (characters or {})
    Multichar.Start()
  end)
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded",function()
  while not ESX.IsPlayerLoaded() do Wait(100); end

  local data = ESX.GetPlayerData()
  local ped = GetPlayerPed(-1)

  if data.coords then
    SetEntityCoords(ped, data.coords.x, data.coords.y, data.coords.z)
  elseif data.lastPosition then
    SetEntityCoords(ped, data.lastPosition.x, data.lastPosition.y, data.lastPosition.z)
  else
    SetEntityCoords(ped, Config.SpawnLocation.x, Config.SpawnLocation.y, Config.SpawnLocation.z)
    SetEntityHeading(ped, Config.SpawnHeading)
  end

  Wait(0)

  local pos = GetEntityCoords(ped)
  TriggerServerEvent("esx:updateLastPosition",{x = pos.x, y = pos.y, z = pos.z})
  SetFocusEntity(ped)

  while not HasCollisionLoadedAroundEntity(ped) do Wait(0); end
  while GetEntityHeightAboveGround(ped) > 1.1 do Wait(0); end
  DoScreenFadeIn(1000)
  Wait(1000)

  ESX.UI.HUD.SetDisplay (1.0)
  DisplayHud            (true)
  DisplayRadar          (true)

  TriggerEvent('esx:restoreLoadout')
  TriggerEvent("esx_skin:setLastSkin",Multichar.Skin)
  TriggerServerEvent("esx_skin:save",Multichar.Skin)
end)