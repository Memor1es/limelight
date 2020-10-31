Config = {
  Translation       = "en",                               -- What translation/langauge do we want to use? Must add to "locales" folder if not already defined.

  EsxVersion        = 1.3,                                -- ESX Version number? (Must be float, if using ESX Final, set as 1.3)

  IdentifierPrefix  = "steam",                            -- What identifier do we want to use?
  RemovePrefix      = true,                               -- Remove prefix from identifier?
  AllowUnidentified = false,                              -- Allow people WITHOUT above identifier to connect to the server?

  MaxCharsDefault   = 4,                                  -- Max characters for regular players.
  MaxCharsDonor     = 8,                                  -- Max characters for donator players.

  SelectorHeading   = -91.3,                              -- Heading for character selector.
  SelectorLocation  = vector3(-82.99,-818.99,326.17),     -- Location for character selector.

  CreatorHeading    = 152.0,                              -- Heading for character creator.
  CreatorLocation   = vector3(-259.85,-975.42,32.22),     -- Location for character creator.

  SpawnHeading      = 204.28,                             -- Heading for character creator.
  SpawnLocation     = vector3(-268.48,-956.66,31.22),     -- Location for character creator.

  SelectorAnims     = {                                   -- Animations played by character when selected.
    Default = {ad = "", anim = ""},                       -- Fallback when animation is not defined below for selected character slot.
    [1]     = {ad = "", anim = ""},                       -- Animation for slot 1.
    [2]     = {ad = "", anim = ""},                       -- Animation for slot 2.
    [3]     = {ad = "", anim = ""},                       -- Animation for slot 3,
    [4]     = {ad = "", anim = ""},                       -- Ect...
    [5]     = {ad = "", anim = ""},
    [6]     = {ad = "", anim = ""},
    [7]     = {ad = "", anim = ""},
    [8]     = {ad = "", anim = ""},
  }
}

TriggerEvent("esx:getSharedObject",function(obj) ESX = obj; end)
Citizen.CreateThread(function()
  while not ESX do
    TriggerEvent("esx:getSharedObject",function(obj) ESX = obj; end)
    Wait(0)
  end
end)