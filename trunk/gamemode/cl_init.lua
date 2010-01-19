/*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
------------------------
cl_init.lua
	-Gamemode clientside init
*/

include( 'shared.lua' )
include('cl_hud.lua');

local US_Flag = surface.GetTextureID( "MiniTankWars/US_Flag" )
local USSR_Flag = surface.GetTextureID( "MiniTankWars/USSR_Flag" )
local MTW_Logo = surface.GetTextureID( "MiniTankWars/MiniTankWarsLogo" )

local SH = ScrH()
local SHL = SH
local SF, SF2
local function RecalcSFs()
	SF = ScrH()/768  //scalefactor
	SF2 = SF/2
end
RecalcSFs()

function GM:PaintSplashScreen(w, h)
	if SH!=SHL then RecalcSFs() end
	surface.SetDrawColor( 255, 255, 255, 255 ) 
	
	surface.SetTexture( US_Flag )
	surface.DrawTexturedRect( 48*SF, 48*SF, 512*SF2, 128*SF2 )
	
	surface.SetTexture( USSR_Flag )
	surface.DrawTexturedRect( 720*SF, 48*SF, 512*SF2, 128*SF2 )
	
	surface.SetDrawColor(Color(150,150,150,200))
	surface.SetTexture( MTW_Logo )
	surface.DrawTexturedRect( 262*SF, 255*SF, 512*SF, 256*SF )
	SHL=SH
	SH=ScrH()
end