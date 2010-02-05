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
	local MovVec = self.Entity:GetPos()-self.Entity.LastPos
	local Vel = (MovVec-Vector(0,0,MovVec.z)):Length()
	Vel = Vel*MovVec:Normalize():Dot(self.Entity:GetForward())
	self.Entity.Vel=Vel
	self.Entity.LeftWheelsRot=self.Entity.LeftWheelsRot+(Vel*6.818)  //360/52.8=6.81818181
	self.Entity.RightWheelsRot=self.Entity.RightWheelsRot+(Vel*6.818)
	self.Entity:SetPoseParameter("LeftWheels_Rot", self.Entity.LeftWheelsRot)
	self.Entity:SetPoseParameter("RightWheels_Rot", self.Entity.RightWheelsRot)
	self.Entity.LastPos=self.Entity:GetPos()
end
