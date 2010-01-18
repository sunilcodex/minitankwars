  /*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
------------------------
cl_hud.lua
	-Clientside(duh) HUD setup
*/

//textures
local US_Flag = surface.GetTextureID( "MiniTankWars/US_Flag" )
local USSR_Flag = surface.GetTextureID( "MiniTankWars/USSR_Flag" )
//colors
local Color_USABlue = Color(41,41,222)
local Color_USSRRed = Color(189,0,0)
local Color_White = Color(255,255,255)
local Color_Black = Color(0,0,0)
local Color_Gray = Color(60,60,60)
local Color_Gray2 = Color(80,80,80)


function GM:OnHUDPaint()
	SF = ScrH()/768  //scalefactor
	SF2 = SF/2
	SF3 = SF/3
	SF4 = SF/4
	VC = ScrH()/2
	HC = ScrW()/2
	
	surface.SetDrawColor( Color_White ) 
	
	//-----------------Score Indicator-----------------------------------
	draw.RoundedBox(6, 229*SF, 27*SF, 572*SF, 26*SF, Color_Black)
	draw.RoundedBox(6, 231*SF, 29*SF, 568*SF, 22*SF, Color_Gray)
	
	//USA
	draw.RoundedBox(6, 12*SF, 12*SF, 536*SF3, 152*SF3, Color_Gray)
	surface.SetDrawColor(Color_White)
	surface.SetTexture( US_Flag )
	surface.DrawTexturedRect( 16*SF, 16*SF, 512*SF3, 128*SF3 )
	
	draw.RoundedBox(6, 231*SF, 29*SF, ((math.Clamp(team.GetScore(TEAM_USA), 4, 50)/50)*280)*SF, 22*SF, Color_USABlue)
	draw.DrawText(team.GetScore(TEAM_USA), "Trebuchet22", (((math.Clamp(team.GetScore(TEAM_USA), 4, 50)*.01)*280)+231)*SF, 29*SF, Color_White, 1)
	
	//USSR
	draw.RoundedBox(4, 834*SF, 12*SF, 536*SF3, 152*SF3, Color_Gray)
	surface.SetDrawColor(Color_White)
	surface.SetTexture( USSR_Flag)
	surface.DrawTexturedRect( 838*SF, 16*SF, 512*SF3, 128*SF3 )
	
	draw.RoundedBox(6, (798-((math.Clamp(team.GetScore(TEAM_USSR), 4, 50)/50)*280))*SF, 29*SF, ((math.Clamp(team.GetScore(TEAM_USSR), 4, 50)/50)*280)*SF, 22*SF, Color_USSRRed)
	draw.DrawText(team.GetScore(TEAM_USSR), "Trebuchet22", (798-((math.Clamp(team.GetScore(TEAM_USSR), 4, 50)*.01)*280))*SF, 29*SF, Color_White, 1)
	
	//
	surface.SetDrawColor(Color_Gray2)
	surface.DrawRect(HC-(2*SF), 29*SF, 4*SF, 22*SF)
	draw.DrawText("-50-", "Trebuchet22", HC, 29*SF, Color_White, 1)
	//---------------End Score Indicator----------------------------------------
	
	
end