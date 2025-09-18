fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'
author 'Lekedog'
description 'ds-candyshop'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client/client.lua',
    'client/crafting.lua',
    'client/npcs.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua',
    'server/versionchecker.lua'
}

dependencies {
    'rsg-core',
    'rsg-target',
    'ox_lib',
}

files {
  'locales/*.json'
}

lua54 'yes'