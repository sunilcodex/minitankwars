  /*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
------------------------
cl_hud.lua
	-Clientside(duh) HUD setup
*/
local SH = ScrH()
local SHL = SH
//textures
local US_Flag = surface.GetTextureID( "MiniTankWars/US_Flag" )
local USSR_Flag = surface.GetTextureID( "MiniTankWars/USSR_Flag" )
local ReticleTex = surface.GetTextureID( "MiniTankWars/Reticle" )
local TankHealthThumbs = {}
TankHealthThumbs["ProtoTank"] = surface.GetTextureID( "MiniTankWars/Tanks/HealthThumbs/ProtoTankThumb" )
local TankHealthThumbsBlur = {}
TankHealthThumbsBlur["ProtoTank"] = surface.GetTextureID( "MiniTankWars/Tanks/HealthThumbs/ProtoTankThumb_Blur" )
//colors
local Color_USABlue = Color(41,41,222)
local Color_USSRRed = Color(189,0,0)
local Color_White = Color(255,255,255)
local Color_Black = Color(0,0,0)
local Color_Gray = Color(60,60,60)
local Color_Gray_75A = Color(60,60,60,191)
local Color_Gray2 = Color(80,80,80)
local Color_HUDYellow = Color(228,185,9)
//fonts
surface.CreateFont( "Trebuchet MS", 24*(ScrH()/768), 400, true, false, "CV22")
surface.CreateFont( "Coolvetica", 22*(ScrH()/768), 300, true, false, "CV22" )
surface.CreateFont( "Coolvetica", 34*(ScrH()/768), 250, true, false, "CV27" )
surface.CreateFont( "Coolvetica", 18*(ScrH()/768), 300, true, false, "CV18" )
//scalefactors
local SF, SF2, SF3, SF4, VC, HC
local function ScaleFactors() 
	SF = ScrH()/768  //scalefactor
	SF2 = SF/2
	SF3 = SF/3
	SF4 = SF/4
	VC = ScrH()/2
	HC = ScrW()/2
end
ScaleFactors()
//misc
local fadenum=0
local fadenumchange=2
local TankHealthThumb = TankHealthThumbs["ProtoTank"]
local TankHealthThumbBlur = TankHealthThumbsBlur["ProtoTank"]
local PlayerTank=LocalPlayer():GetNWString("TankName")

function CheckTankChange()
	if LocalPlayer():GetNWString("TankName") !=PlayerTank then
		TankHealthThumb = TankHealthThumbs[LocalPlayer():GetNWString("TankName")]
		TankHealthThumbBlur = TankHealthThumbsBlur[LocalPlayer():GetNWString("TankName")]
	end
end

function GM:OnHUDPaint()
	if SH!=SHL then
		ScaleFactors()
	end

	fadenum=fadenum+fadenumchange
	if (fadenum >=255 or fadenum <=0) then
		fadenum = math.Clamp(fadenum, 0, 255)
		fadenumchange = fadenumchange*-1
	end
	
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
	draw.DrawText(team.GetScore(TEAM_USA), "CV22", (((math.Clamp(team.GetScore(TEAM_USA), 4, 50)*.01)*280)+231)*SF, 29*SF, Color_White, 1)
	
	//USSR
	draw.RoundedBox(4, 834*SF, 12*SF, 536*SF3, 152*SF3, Color_Gray)
	surface.SetDrawColor(Color_White)
	surface.SetTexture( USSR_Flag)
	surface.DrawTexturedRect( 838*SF, 16*SF, 512*SF3, 128*SF3 )
	
	draw.RoundedBox(6, (798-((math.Clamp(team.GetScore(TEAM_USSR), 4, 50)/50)*280))*SF, 29*SF, ((math.Clamp(team.GetScore(TEAM_USSR), 4, 50)/50)*280)*SF, 22*SF, Color_USSRRed)
	draw.DrawText(team.GetScore(TEAM_USSR), "CV22", (798-((math.Clamp(team.GetScore(TEAM_USSR), 4, 50)*.01)*280))*SF, 29*SF, Color_White, 1)
	
	//---
	surface.SetDrawColor(Color_Gray2)
	surface.DrawRect(HC-(2*SF), 29*SF, 4*SF, 22*SF)
	draw.DrawText("-50-", "CV22", HC, 29*SF, Color_White, 1)
	//---------------End Score Indicator---------------------------------

	if LocalPlayer():Alive() then
		//----------------Armor Display--------------------------------------
		draw.RoundedBox(8, 11*SF, 665*SF, 174*SF, 84*SF, Color_Gray)
		draw.RoundedBox(8, 163*SF, 707*SF, 55*SF, 49*SF, Color_Gray)
		local HealthColor = HSVToColor((LocalPlayer():Health()/100)*120, 1, 1)
		
		surface.SetDrawColor(HealthColor)
		surface.SetTexture( TankHealthThumbBlur )
		surface.DrawTexturedRect( 20*SF, 672*SF, 148*SF, 69*SF )
		surface.SetDrawColor(Color_White)
		surface.SetTexture( TankHealthThumb )
		surface.DrawTexturedRect( 20*SF, 672*SF, 148*SF, 69*SF )

		draw.DrawText(LocalPlayer():Health(), "CV27", 191*SF, 712*SF, HealthColor, 1)
		draw.DrawText("Armor", "CV18", 192*SF, 738*SF, Color_HUDYellow, 1)
		//--------------End Armor Display------------------------------------
		
		//---------------Ammo Display----------------------------------------
		draw.RoundedBox(8, 823*SF, 700*SF, 180*SF, 54*SF, Color_Gray_75A)
		if (LocalPlayer():GetActiveWeapon():IsWeapon()) then
			draw.DrawText(LocalPlayer():GetActiveWeapon():GetPrintName(), "CV27", 832*SF, 700*SF, Color_HUDYellow, 0)
			draw.DrawText(LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "CV27", 969*SF, 715*SF, Color_HUDYellow, 1)
		end
		local fadecolor = Color(228,185,9, fadenum)
		draw.DrawText("reloading...", "CV18", 897*SF, 735*SF, fadecolor, 1)
		//---------------End Ammo Display------------------------------------
		
		//Crosshair
		surface.SetDrawColor(Color_White)
		surface.SetTexture( ReticleTex )
		surface.DrawTexturedRect( (HC-32)*SF, (VC-32)*SF, 64*SF, 64*SF )
	end
	
	
	SHL=SH
	SH=ScrH()
end

function GM:HUDShouldDraw( name )
	if (name == "CHudHealth" or name == "CHudBattery" or name == "CHudWeaponSelection" or name=="CHudWeapon" or name=="CHudAmmo" or name=="CHudSecondaryAmmo" or name=="CHudCrosshair") then
		return false
	end
	return true
end


