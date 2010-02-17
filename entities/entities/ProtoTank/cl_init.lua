 /*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
------------------------
ProtoTank cl_init.lua
	-ProtoTank Entity clientside init
*/

include('shared.lua');
 
function ENT:Draw()
	self.Entity:DrawModel();
end

function ENT:Initialize()
	self.Entity.WheelsRot=0
	self.Entity.LastPos=self.Entity:GetPos()
end

function ENT:Think()
	if (self.Entity.WheelsRot > 360) then self.Entity.WheelsRot = self.Entity.WheelsRot-360 end
	if (self.Entity.WheelsRot < 0) then self.Entity.WheelsRot = self.Entity.WheelsRot+360 end
	local MovVec = self.Entity:GetPos()-self.Entity.LastPos
	local Vel = (MovVec-Vector(0,0,MovVec.z)):Length()
	Vel = Vel*MovVec:Normalize():Dot(self.Entity:GetForward())
	self.Entity.Vel=Vel
	self.Entity.WheelsRot=self.Entity.WheelsRot+(Vel*6.295)  //360/57.18=6.295
	self.Entity:SetPoseParameter("Wheels_Rot", self.Entity.WheelsRot)
	self.Entity.LastPos=self.Entity:GetPos()
end
