  /*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
------------------------
PowerUp_SpeedBoost cl_init.lua
	-SpeedBoost Powerup Entity clientside init
*/

include('shared.lua');

function ENT:Initialize()
	self.Entity.LastPos=self.Entity:GetPos()
	self.Entity.OldMat = self.Entity:GetMaterial()
	self.Entity.LastTime = CurTime()
end
 
function ENT:Draw()
	self.Entity:DrawModel();
end

function ENT:Think()
	local FT=CurTime()-self.Entity.LastTime
	if FT==0 then FT=0.1 end
	self.Entity.LastTime = CurTime()
	local MovVec = self.Entity:GetPos()-self.Entity.LastPos
	local Vel = (MovVec-Vector(0,0,MovVec.z)):Length()
	local NewMat=TrackMats[math.Clamp(math.Round((Vel/FT)/64),-4,8)*64]
	if self.Entity.OldMat!=NewMat then
		self.Entity:SetMaterial(NewMat)
		self.Entity.OldMat = NewMat
	end
	self.Entity.LastPos=self.Entity:GetPos()
end