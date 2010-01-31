  /*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
------------------------
ProtoTank_Tracks cl_init.lua
	-ProtoTank Tracks Entity clientside init
*/

include('shared.lua');
 
function ENT:Initialize()
	self.Entity.MyTrackMat=Material("models/BMCha/MiniTanks/ProtoTank/Tracks")
	self.Entity.MyTrackMat:SetMaterialVector("$color", Vector(1.0,0,0) )
	self.Entity:SetMaterial(self.Entity.MyTrackMat)
	
	self.Entity.LeftWheelsRot=0
	self.Entity.RightWheelsRot=0
	self.Entity.LastPos=self.Entity:GetPos()
end
 
function ENT:Draw()
	self.Entity:DrawModel();
end

function ENT:Think()
	local Vel = (self.Entity:GetPos()-self.Entity.LastPos):Length()
	self.Entity.MyTrackMat:SetMaterialFloat("texturescrollrate", Vel/64)
	self.Entity.LastPos=self.Entity:GetPos()
end