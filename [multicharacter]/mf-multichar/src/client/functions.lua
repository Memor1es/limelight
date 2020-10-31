function ShowNotification(msg)
  SetNotificationTextEntry('STRING')
  AddTextComponentSubstringPlayerName(msg)
  DrawNotification(false, true)
end

function ShowHelpNotification(msg, thisFrame, beep, duration)
  AddTextEntry('HelpNotification', msg)
  DisplayHelpTextThisFrame('HelpNotification', false)
end

function DrawText3D(_x,_y,_z, text, size)
  local coords = vector3(_x,_y,_z)
  local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
  local camCoords      = GetGameplayCamCoords()
  local dist           = GetDistanceBetweenCoords(camCoords, coords.x, coords.y, coords.z, true)
  local size           = size

  if size == nil then
    size = 1
  end

  local scale = (size / dist) * 2
  local fov   = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov

  if onScreen then
    SetTextScale(0.0 * scale, 0.55 * scale)
    SetTextFont(1)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry('STRING')
    SetTextCentre(1)

    AddTextComponentString(text)
    DrawText(x, y)
  end
end