/*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in shared.lua
*/

include( 'shared.lua' )


local WScale = ScrW()/1024.0
 
function GM:PaintSplashScreen(w, h) 
	surface.SetDrawColor( 255, 255, 255, 255 ) 
	surface.SetTexture( Material( "MiniTankWars/US_Flag" ) )
	surface.DrawTexturedRect( 50, 50, 512, 128 )
	surface.SetTexture( Material( "MiniTankWars/USSR_Flag" ) )
	surface.DrawTexturedRect( 600, 50, 512, 128 )
	surface.SetMaterial( Material( "MiniTankWars/MiniTankWarsLogo" ) )
	surface.DrawTexturedRect( 50, 500, 512, 256 )
end