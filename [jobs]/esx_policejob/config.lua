Config                            = {}

Config.DrawDistance               = 60.0 -- How close do you need to be for the markers to be drawn (in GTA units).
Config.MarkerType                 = {Cloakrooms = 20, Armories = 21, BossActions = 22, Vehicles = 36, Helicopters = 34}
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = {r = 50, g = 50, b = 204}

Config.EnablePlayerManagement     = false -- Enable if you want society managing.
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- Enable if you're using esx_identity.
Config.EnableLicenses             = true -- Enable if you're using esx_license.

Config.EnableHandcuffTimer        = true -- Enable handcuff timer? will unrestrain player after the time ends.
Config.HandcuffTimer              = 10 * 60000 -- 10 minutes.

Config.EnableJobBlip              = true -- Enable blips for cops on duty, requires esx_society.
Config.EnableCustomPeds           = false -- Enable custom peds in cloak room? See Config.CustomPeds below to customize peds.

Config.EnableESXService           = false -- Enable esx service?
Config.MaxInService               = -1 -- How much people can be in service at once?

Config.Locale                     = 'en'

Config.PoliceStations = {

	BCSO = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(452.6, -992.8, 30.6)
		},

		Armories = {
			vector3(451.7, -980.1, 30.6)
		},

		Vehicles = {
			{
				Spawner = vector3(454.6, -1017.4, 28.4),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0},
					{coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0},
					{coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0},
					{coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0}
				}
			},

			{
				Spawner = vector3(473.3, -1018.8, 28.0),
				InsideShop = vector3(228.5, -993.5, -99.0),
				SpawnPoints = {
					{coords = vector3(475.9, -1021.6, 28.0), heading = 276.1, radius = 6.0},
					{coords = vector3(484.1, -1023.1, 27.5), heading = 302.5, radius = 6.0}
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(461.1, -981.5, 43.6),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0}
				}
			}
		},

		BossActions = {
			vector3(448.4, -973.2, 30.6)
		}

	}

}

Config.AuthorizedWeapons = {
	cadet = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
		{weapon = 'WEAPON_FLAREGUN', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_KNIFE', price = 0}
	},

	deputy = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 0},
		{weapon = 'WEAPON_FLAREGUN', price = 0},
		{weapon = 'WEAPON_KNIFE', price = 0}
	},
	
	seniordeputy = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 0},
		{weapon = 'WEAPON_FLAREGUN', price = 0},
		{weapon = 'WEAPON_KNIFE', price = 0}
	},
	
	corporal = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 0},
		{weapon = 'WEAPON_FLAREGUN', price = 0},
		{weapon = 'WEAPON_KNIFE', price = 0}
	},
	
	sergeant = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 0},
		{weapon = 'WEAPON_FLAREGUN', price = 0},
		{weapon = 'WEAPON_KNIFE', price = 0}
	},

	lieutenant = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
		{weapon = 'WEAPON_CARBINERIFLE', price = 0},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 0},
		{weapon = 'WEAPON_FLAREGUN', price = 0},
		{weapon = 'WEAPON_KNIFE', price = 0}
	},

	captain = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
		{weapon = 'WEAPON_CARBINERIFLE', price = 0},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 0},
		{weapon = 'WEAPON_FLAREGUN', price = 0},
		{weapon = 'WEAPON_KNIFE', price = 0}
	},

	chief = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
		{weapon = 'WEAPON_CARBINERIFLE', price = 0},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 0},
		{weapon = 'WEAPON_FLAREGUN', price = 0},
		{weapon = 'WEAPON_HEAVYSNIPER', price = 0},
		{weapon = 'WEAPON_KNIFE', price = 0}
	},

	deputysheriff = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
		{weapon = 'WEAPON_CARBINERIFLE', price = 0},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 0},
		{weapon = 'WEAPON_FLAREGUN', price = 0},
		{weapon = 'WEAPON_HEAVYSNIPER', price = 0},
		{weapon = 'WEAPON_KNIFE', price = 0}

	},

	sheriff = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_SMG', price = 0},
		{weapon = 'WEAPON_COMBATPISTOL', price = 0},
		{weapon = 'WEAPON_CARBINERIFLE', price = 0},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 0},
		{weapon = 'WEAPON_FLAREGUN', price = 0},
		{weapon = 'WEAPON_HEAVYSNIPER', price = 0},
		{weapon = 'WEAPON_KNIFE', price = 0}
	}
}

Config.AuthorizedVehicles = {
	car = {
		cadet = {
		    	{model = 'police', price = 1000},
		    	{model = 'police2', price = 1000},
		    	{model = 'police3', price = 1000},
				{model = 'polic4', price = 1000},
				{model = 'policeold2', price = 1000},
		    	{model = 'policeb', price = 1000},
		    	{model = 'riot', price = 100000},
		    	{model = 'pranger', price = 1000}
		},
		deputy = {
		    	{model = 'police', price = 1000},
		    	{model = 'police2', price = 1000},
		    	{model = 'police3', price = 1000},
				{model = 'polic4', price = 1000},
				{model = 'policeold2', price = 1000},
		    	{model = 'policeb', price = 1000},
		    	{model = 'riot', price = 100000},
		    	{model = 'pranger', price = 1000},
		    	{model = 'policebicycle5M', price = 500}
		},
		seniordeputy = {
		    	{model = 'police', price = 1000},
		    	{model = 'police2', price = 1000},
		    	{model = 'police3', price = 1000},
				{model = 'polic4', price = 1000},
				{model = 'policeold2', price = 1000},
		    	{model = 'policeb', price = 1000},
		    	{model = 'riot', price = 100000},
				{model = 'pranger', price = 1000},
				{model = 'policebicycle5M', price = 500}
		},
		corporal = {
		    	{model = 'police', price = 1000},
		    	{model = 'police2', price = 1000},
		    	{model = 'police3', price = 1000},
				{model = 'polic4', price = 1000},
				{model = 'policeold2', price = 1000},
		    	{model = 'policeb', price = 1000},
		    	{model = 'riot', price = 100000},
				{model = 'pranger', price = 1000},
				{model = 'policebicycle5M', price = 500}
		},
		sergeant = {
		    	{model = 'police', price = 1000},
		    	{model = 'police2', price = 1000},
		    	{model = 'police3', price = 1000},
				{model = 'polic4', price = 1000},
				{model = 'policeold2', price = 1000},
		    	{model = 'policeb', price = 1000},
		    	{model = 'riot', price = 100000},
				{model = 'pranger', price = 1000},
				{model = 'policebicycle5M', price = 500}
		},
		lieutenant = {
		    	{model = 'police', price = 1000},
		    	{model = 'police2', price = 1000},
		    	{model = 'police3', price = 1000},
				{model = 'polic4', price = 1000},
				{model = 'policeold2', price = 1000},
		    	{model = 'policeb', price = 1000},
		    	{model = 'riot', price = 100000},
				{model = 'pranger', price = 1000},
				{model = 'policebicycle5M', price = 500}
		},
		captain = {
		    	{model = 'police', price = 1000},
		    	{model = 'police2', price = 1000},
		    	{model = 'police3', price = 1000},
				{model = 'polic4', price = 1000},
				{model = 'policeold2', price = 1000},
		    	{model = 'policeb', price = 1000},
		    	{model = 'riot', price = 100000},
				{model = 'pranger', price = 1000},
				{model = 'policebicycle5M', price = 500}
		},
		chief = {
		    	{model = 'police', price = 1000},
		    	{model = 'police2', price = 1000},
		    	{model = 'police3', price = 1000},
				{model = 'polic4', price = 1000},
				{model = 'policeold2', price = 1000},
		    	{model = 'policeb', price = 1000},
		    	{model = 'riot', price = 100000},
				{model = 'pranger', price = 1000},
				{model = 'policebicycle5M', price = 500}
		},
		deputysheriff = {
		    	{model = 'police', price = 1000},
		    	{model = 'police2', price = 1000},
		    	{model = 'police3', price = 1000},
				{model = 'polic4', price = 1000},
				{model = 'policeold2', price = 1000},
		    	{model = 'policeb', price = 1000},
		    	{model = 'riot', price = 100000},
				{model = 'pranger', price = 1000},
				{model = 'policebicycle5M', price = 500}
		},
		sheriff = {
		    	{model = 'police', price = 1000},
		    	{model = 'police2', price = 1000},
		    	{model = 'police3', price = 1000},
				{model = 'polic4', price = 1000},
				{model = 'policeold2', price = 1000},
		    	{model = 'policeb', price = 1000},
		    	{model = 'riot', price = 100000},
				{model = 'pranger', price = 1000},
				{model = 'policebicycle5M', price = 500}
		}
	},

	helicopter = {
		cadet = {
		    	{model = 'polmav', props = {modLivery = 0}, price = 10}
		},
		deputy = {
		    	{model = 'polmav', props = {modLivery = 0}, price = 10}
		},
		seniordeputy = {
		    	{model = 'polmav', props = {modLivery = 0}, price = 10}
		},
		corporal = {
		    	{model = 'polmav', props = {modLivery = 0}, price = 10}
		},
		sergeant = {
		    	{model = 'polmav', props = {modLivery = 0}, price = 10}
		},
		lieutenant = {
		    	{model = 'polmav', props = {modLivery = 0}, price = 10}
		},
		captain = {
		    	{model = 'polmav', props = {modLivery = 0}, price = 10}
		},
		chief = {
		    	{model = 'polmav', props = {modLivery = 0}, price = 10}
		},
		deputysheriff = {
		    	{model = 'polmav', props = {modLivery = 0}, price = 10}
		},
		sheriff = {
		    	{model = 'polmav', props = {modLivery = 0}, price = 10}
		}
	}
}

Config.CustomPeds = {
	shared = {}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements
Config.Uniforms = {
	cadet = {
		male = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 200,   torso_2 = 1,
			arms = 4,
			pants_1 = 49,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 10,  bproof_2 = 3

		},
		female = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 200,   torso_2 = 1,
			arms = 4,
			pants_1 = 49,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 10,  bproof_2 = 3
		}
	},
	deputy = {
		male = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 200,   torso_2 = 1,
			arms = 1,
			pants_1 = 49,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 0,  bproof_2 = 0,
			helmet_1 = 13, helmet_2 = 2
		},
		female = {
			tshirt_1 = 96,  tshirt_2 = 0,
			torso_1 = 200,   torso_2 = 1,
			arms = 1,
			pants_1 = 49,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 0,  bproof_2 = 0,
			helmet_1 = 13, helmet_2 = 2
		}
	},
	seniordeputy = {
		male = {
			tshirt_1 = 75,  tshirt_2 = 5,
			torso_1 = 154,   torso_2 = 2,
			arms = 1,
			pants_1 = 49,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 0,  bproof_2 = 0,
			helmet_1 = 13, helmet_2 = 2
		},
		female = {
			tshirt_1 = 75,  tshirt_2 = 5,
			torso_1 = 154,   torso_2 = 2,
			arms = 1,
			pants_1 = 49,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 0,  bproof_2 = 0,
			helmet_1 = 13, helmet_2 = 2
		}
	},
	corporal = {
		male = {
			tshirt_1 = 122,  tshirt_2 = 1,
			torso_1 = 183,   torso_2 = 2,
			arms = 5,
			pants_1 = 49,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 0,  bproof_2 = 0,
			helmet_1 = 10, helmet_2 = 1

		},
		female = {
			tshirt_1 = 122,  tshirt_2 = 1,
			torso_1 = 183,   torso_2 = 2,
			arms = 5,
			pants_1 = 49,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 0,  bproof_2 = 0,
			helmet_1 = 10, helmet_2 = 1
		}
	},
	sergeant = {
		male = {
			tshirt_1 = 122,  tshirt_2 = 1,
			torso_1 = 183,   torso_2 = 2,
			arms = 5,
			pants_1 = 49,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 0,  bproof_2 = 0,
			helmet_1 = 10, helmet_2 = 1

		},
		female = {
			tshirt_1 = 122,  tshirt_2 = 1,
			torso_1 = 183,   torso_2 = 2,
			arms = 5,
			pants_1 = 49,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 0,  bproof_2 = 0,
			helmet_1 = 10, helmet_2 = 1
		}
	},
	sheriff = {
		male = {
			tshirt_1 = 122,  tshirt_2 = 1,
			torso_1 = 183,   torso_2 = 5,
			arms = 30,
			pants_1 = 49,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 11,  bproof_2 = 1,
			helmet_1 = 10, helmet_2 = 1

		},
		female = {
			tshirt_1 = 122,  tshirt_2 = 1,
			torso_1 = 183,   torso_2 = 5,
			arms = 30,
			pants_1 = 49,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 11,  bproof_2 = 1,
			helmet_1 = 10, helmet_2 = 1
		}
	},
	bikecop = {
		male = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 183,   torso_2 = 2,
			arms = 23,
			pants_1 = 32,   pants_2 = 3,
			shoes_1 = 33,   shoes_2 = 0,
			bproof_1 = 1,  bproof_2 = 0,
			helmet_1 = 17, helmet_2 = 2

		},
		female = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 183,   torso_2 = 2,
			arms = 23,
			pants_1 = 32,   pants_2 = 3,
			shoes_1 = 33,   shoes_2 = 0,
			bproof_1 = 1,  bproof_2 = 0,
			helmet_1 = 17, helmet_2 = 2
		}
	},
	detective = {
		male = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 93,   torso_2 = 0,
			arms = 0,
			pants_1 = 49,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 21,  bproof_2 = 2,
			helmet_1 = 10,  helmet_2 = 1

		},
		female = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 93,   torso_2 = 0,
			arms = 0,
			pants_1 = 49,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 21,  bproof_2 = 2,
			helmet_1 = 10,  helmet_2 = 1
		}
	},
	gangunit = {
		male = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 73,   torso_2 = 18,
			arms = 0,
			pants_1 = 49,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 12,  bproof_2 = 1,
			helmet_1 = 10,  helmet_2 = 1

		},
		female = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 73,   torso_2 = 18,
			arms = 0,
			pants_1 = 49,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 12,  bproof_2 = 1,
			helmet_1 = 10,  helmet_2 = 1
		}
	},
	lt2casual = {
		male = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 93,   torso_2 = 2,
			arms = 0,
			pants_1 = 49,   pants_2 = 3,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 1,  bproof_2 = 0,
			helmet_1 = 10, helmet_2 = 1

		},
		female = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 93,   torso_2 = 2,
			arms = 0,
			pants_1 = 49,   pants_2 = 3,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 1,  bproof_2 = 0,
			helmet_1 = 10, helmet_2 = 1
		}
	},
	helopilot = {
		male = {
			tshirt_1 = 72,  tshirt_2 = 1,
			torso_1 = 49,   torso_2 = 2,
			arms = 1,
			pants_1 = 49,   pants_2 = 3,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 25,  bproof_2 = 2,
			helmet_1 = 79,  helmet_2 = 2

		},
		female = {
			tshirt_1 = 72,  tshirt_2 = 1,
			torso_1 = 49,   torso_2 = 2,
			arms = 1,
			pants_1 = 49,   pants_2 = 3,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 25,  bproof_2 = 2,
			helmet_1 = 79,  helmet_2 = 2
		}
	},
	bicyclecop = {
		male = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 183,   torso_2 = 2,
			arms = 23,
			pants_1 = 6,   pants_2 = 1,
			shoes_1 = 2,   shoes_2 = 0,
			bproof_1 = 1,  bproof_2 = 0,
			helmet_1 = 49, helmet_2 = 0,
			bag_1 = 33

		},
		female = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 183,   torso_2 = 2,
			arms = 23,
			pants_1 = 6,   pants_2 = 1,
			shoes_1 = 2,   shoes_2 = 0,
			bproof_1 = 1,  bproof_2 = 0,
			helmet_1 = 49, helmet_2 = 0,
			bag_1 = 33
		}
	},
	k9unit = {
		male = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 93,   torso_2 = 1,
			arms = 0,
			pants_1 = 49,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 12,  bproof_2 = 2,
			helmet_1 = 10,  helmet_2 = 1

		},
		female = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 93,   torso_2 = 1,
			arms = 0,
			pants_1 = 49,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			bproof_1 = 12,  bproof_2 = 2,
			helmet_1 = 10,  helmet_2 = 1
		}
	},
	bullet_wear = {
		male = {
			bproof_1 = 11,  bproof_2 = 1
		},
		female = {
			bproof_1 = 11,  bproof_2 = 1
		}
	},
	gilet_wear = {
		male = {
			bproof_1 = 10,  bproof_2 = 3
		},
		female = {
			bproof_1 = 10,  bproof_2 = 3
		}
	}
}
