/*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
*/

include( 'shared.lua' )

 
function GM:PaintSplashScreen(w, h) 
	SF = h/768  //scalefactor
	SF2 = SF/2
	surface.SetDrawColor( 255, 255, 255, 255 ) 
	
	surface.SetMaterial( Material( "MiniTankWars/US_Flag" ) )
	surface.DrawTexturedRect( 48*SF, 48*SF, 512*SF2, 128*SF2 )
	
	surface.SetMaterial( Material( "MiniTankWars/USSR_Flag" ) )
	surface.DrawTexturedRect( 720*SF, 48*SF, 512*SF2, 128*SF2 )
	
	surface.SetDrawColor(Color(150,150,150,200))
	surface.SetMaterial( Material( "MiniTankWars/MiniTankWarsLogo" ) )
	surface.DrawTexturedRect( 262*SF, 255*SF, 512*SF, 256*SF )
end