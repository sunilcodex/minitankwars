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

/*function GM:CalcView( pl, origin, angles, fov )
	local View = pl:CallClassFunction( "CalcView", origin, angles, fov ) or { ["origin"] = origin, ["angles"] = angles, ["fov"] = fov };
	View.origin = origin+(pl:GetForward() * -400)+Vector(0,0,100)
	View.angles = pl:EyeAngles()
	View.fov = fov 
	return View
	//return the modified values
    //return GM:CalcView(ply,origin,angles,fov)
end*/