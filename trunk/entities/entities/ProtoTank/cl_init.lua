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

function ENT:Initialize()
	self.Entity.LeftWheelsRot=0
	self.Entity.RightWheelsRot=0
	self.Entity.LastPos=self.Entity:GetPos()
end

function ENT:Think()
	if (self.Entity.LeftWheelsRot > 360) then self.Entity.LeftWheelsRot = self.Entity.LeftWheelsRot-360 end
	if (self.Entity.RightWheelsRot > 360) then self.Entity.RightWheelsRot = self.Entity.RightWheelsRot-360 end
	if (self.Entity.LeftWheelsRot < 0) then self.Entity.LeftWheelsRot = self.Entity.LeftWheelsRot+360 end
	if (self.Entity.RightWheelsRot < 0) then self.Entity.RightWheelsRot = self.Entity.RightWheelsRot+360 end
	local Vel = (self.Entity:GetPos()-self.Entity.LastPos):Length()
	self.Entity.LeftWheelsRot=self.Entity.LeftWheelsRot+(Vel*6.818)  //360/52.8=6.81818181
	self.Entity.RightWheelsRot=self.Entity.RightWheelsRot+(Vel*6.818)
	self.Entity:SetPoseParameter("LeftWheels_Rot", self.Entity.LeftWheelsRot)
	self.Entity:SetPoseParameter("RightWheels_Rot", self.Entity.RightWheelsRot)
	self.Entity.LastPos=self.Entity:GetPos()
end
