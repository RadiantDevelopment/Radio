fx_version "cerulean"
game "gta5"

lua54 'yes'

author "<justcallme2k />"
description "Radio by 2k"

ui_page "dist/web/index.html"

files {
  "dist/web/index.html",
  "dist/web/assets/**"
}

client_scripts {
  "Client/*.lua",
  "Client/Modules/*.lua",
}

server_scripts {
  "@oxmysql/lib/MySQL.lua",
  -- "Server/*.lua",
  -- "Server/Modules/*.lua"
}

dependencies {
  'oxmysql',
  'pma-voice',
  'qb-core'
}