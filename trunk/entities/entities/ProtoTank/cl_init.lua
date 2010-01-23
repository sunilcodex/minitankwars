 /*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
------------------------
ProtoTank cl_init.lua
	-ProtoTank Entity clientside init
*/

include('shared.lua');

local Laser = Material( "cable/redlaser" )
 
function ENT:Draw()
	self.Entity:DrawModel();
 
	local Vector1 = self.Entity:GetPos()
	local plTurnAngle = self.Entity:GetNWEntity("MyPlayer"):GetNWFloat("TurnAngle")
	local plSpeed = self.Entity:GetNWEntity("MyPlayer"):GetNWFloat("Speed")
	local DaVec = Angle(0, plTurnAngle, 0):Forward()*-plSpeed
	local Vector2 = self.Entity:GetPos()-DaVec
 
	render.SetMaterial( Laser )
	render.DrawBeam( Vector1, Vector2, 5, 0, 0, Color( 255, 255, 255, 255 ) ) 
end
