fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author "DokaDoka"
description "DokaDoka's Menus"
version "1.0.0"

dependencies {
	'es_extended',
	'esx_menu_default',
	'esx_menu_dialog',
}

shared_scripts { 
    '@es_extended/imports.lua',
}

client_scripts {
	'client/main.lua',
}

exports {
	'nearbyPlayers',
	'amount',
	'text',
	'areYouSure',
}
