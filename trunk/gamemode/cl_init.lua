/*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
------------------------
cl_init.lua
	-Gamemode clientside init
*/

include( 'shared.lua' )
include('cl_hud.lua')

local US_Flag = surface.GetTextureID( "MiniTankWars/US_Flag" )
local USSR_Flag = surface.GetTextureID( "MiniTankWars/USSR_Flag" )
local MTW_Logo = surface.GetTextureID( "MiniTankWars/MiniTankWarsLogo" )

local SH = ScrH()
local SHL = SH
local SF, SF2
local function RecalcSFs()
	SF = ScrH()/768  //scalefactor
	SF2 = SF/2
	XMV=(ScrW()/2)-512*SF
end
RecalcSFs()

function GM:PaintSplashScreen(w, h)
	if SH!=SHL then RecalcSFs() end
	surface.SetDrawColor( 255, 255, 255, 255 ) 
	
	surface.SetTexture( US_Flag )
	surface.DrawTexturedRect( 48*SF+XMV, 48*SF, 512*SF2, 128*SF2 )
	
	surface.SetTexture( USSR_Flag )
	surface.DrawTexturedRect( 720*SF+XMV, 48*SF, 512*SF2, 128*SF2 )
	
	surface.SetDrawColor(Color(150,150,150,200))
	surface.SetTexture( MTW_Logo )
	surface.DrawTexturedRect( 262*SF+XMV, 255*SF, 512*SF, 256*SF )
	SHL=SH
	SH=ScrH()
end

function GM:ShowClassChooser( TEAMID )
	if ( !GAMEMODE.SelectClass ) then return end
	if ( ClassChooser ) then ClassChooser:Remove() end

	ClassChooser = vgui.CreateFromTable( vgui_Splash )
	ClassChooser:SetHeaderText( "Choose Tank" )
	ClassChooser:SetHoverText( "What tank do you want to use?" );

	Classes = team.GetClass( TEAMID )
	for k, v in SortedPairs( Classes ) do
		
		local displayname = v
		local Class = player_class.Get( v )
		if ( Class && Class.DisplayName ) then
			displayname = Class.DisplayName
		end
		
		local description = "Click to Deploy as " .. displayname  //for somereason it cuts off at the space in "M1A2 Abrams" and "M551 Sheridan" >_>
		
		if( Class and Class.Description ) then
			description = Class.Description
		end
		
		local func = function() if( cl_classsuicide:GetBool() ) then RunConsoleCommand( "kill" ) end RunConsoleCommand( "changeclass", k ) end
		local btn = ClassChooser:AddSelectButton( displayname, func, description )
		btn.m_colBackground = team.GetColor( TEAMID )
		
	end
	
	ClassChooser:MakePopup()
	ClassChooser:NoFadeIn()

end