fx_version 'cerulean'
game 'gta5'

author 'BelgaMods'
description 'Standalone Voertuig Spawn Menu via ox_lib'
version '1.0.0'

dependencies {
    'ox_lib'
}

shared_scripts {
    '@ox_lib/init.lua'
}

client_scripts {
    'client/client.lua'
}
