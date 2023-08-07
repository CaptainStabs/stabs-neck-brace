fx_version 'bodacious'
game 'gta5'

author 'Stabs'
version '1.0.0'

server_script 'server/server.lua'
shared_script 'config.lua'

client_scripts {
    'client/client.lua',
    'client/target.lua'
}

dependencies {
    'qb-core',
    'qb-ambulancejob',
    'qb-target'
}