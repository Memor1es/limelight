fx_version 'bodacious'
games { 'rdr3', 'gta5' }

mod 'mf-multicharacter'
version '1.0.2'

ui_page 'nui/index.html'

client_scripts {  
  '@es_extended/locale.lua',
  'locales/en.lua',

  'config.lua',
  
  'src/shared/main.lua',
  'src/shared/functions.lua',

  'src/client/controls.lua',
  'src/client/main.lua',
  'src/client/functions.lua',
}

server_scripts {
  '@es_extended/locale.lua',
  '@mysql-async/lib/MySQL.lua',
  'locales/en.lua',

  'config.lua',
  'credentials.lua',

  'src/shared/main.lua',
  'src/shared/functions.lua',

  'src/server/main.lua',
  'src/server/functions.lua',
  'src/server/convert.lua',
}

dependencies {
  'mysql-async',
  'es_extended',
  'esx_skin',
}

files {
  'nui/index.html',
  'nui/*.png',
}

provide 'esx_identity'