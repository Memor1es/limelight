---------------------------------------
--      ESX_WASHLAB by Dividerz      --
-- FOR SUPPORT: Arne#7777 on Discord --
---------------------------------------

Config = {}

Config.WaitingTime = 5000
Config.TakePercentage = true
Config.WashPercentage = 0.70
Config.ProducingTime = math.random(300, 480) -- IN SECONDS, NOT MS (!)
Config.CountingTime = math.random(90, 120) -- IN SECONDS, NOT MS (!)

Config.Locations = {
    washinglab = {
        teleporters = {
            enter = vector3(818.69, -2365.04, 30.15),
            exit = vector3(1138.13, -3199.07, -39.67)
        },
        process = {
            start = vector3(1136.11, -3197.95, -39.82),
            timer = vector3(1131.17, -3197.92, -39.67),
            output = vector3(1126.08, -3197.54, -39.67),
            cutter = vector3(1122.07, -3198.53, -40.39),
            counter = vector3(1116.17, -3196.13, -40.40)
        }
    }
}
