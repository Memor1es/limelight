---------------------------------------
--      ESX_WASHLAB by Dividerz      --
-- FOR SUPPORT: Arne#7777 on Discord --
---------------------------------------

fx_version 'adamant'

game 'gta5'

description 'ESX WASHLAB'
author 'Dividerz (Arne)'

version '1.0.0'

server_scripts {
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
	'progressBars',
	'bob74_ipl'
}