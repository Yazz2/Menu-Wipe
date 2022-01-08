fx_version 'adamant' 
game 'gta5'


data_file "SCALEFORM_DLC_FILE" "stream/cpminimap/int3232302352.gfx"


client_scripts {


    'vendors/RageUI/RMenu.lua',
    'vendors/RageUI/menu/RageUI.lua',
    'vendors/RageUI/menu/Menu.lua',
    'vendors/RageUI/menu/MenuController.lua',
    'vendors/RageUI/components/*.lua',
    'vendors/RageUI/menu/elements/*.lua',
    'vendors/RageUI/menu/items/*.lua',
    'vendors/RageUI/menu/panels/*.lua',
    'vendors/RageUI/menu/windows/*.lua',


    'cl_wipe.lua',

}

server_scripts {
	'@mysql-async/lib/MySQL.lua',

    'sv_wipe.lua',
}

