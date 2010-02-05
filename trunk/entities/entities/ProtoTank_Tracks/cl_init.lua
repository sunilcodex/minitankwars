  /*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
------------------------
ProtoTank_Tracks cl_init.lua
	-ProtoTank Tracks Entity clientside init
*/

include('shared.lua');
 
//Tracks Materials
local TrackMats = {
[-256]="models/BMCha/MiniTanks/ProtoTank/RTracks256",
[-192]="models/BMCha/MiniTanks/ProtoTank/RTracks192",
[-128]="models/BMCha/MiniTanks/ProtoTank/RTracks128",
[-64]="models/BMCha/MiniTanks/ProtoTank/RTracks64",
[0]="models/BMCha/MiniTanks/ProtoTank/Tracks0",
[64]="models/BMCha/MiniTanks/ProtoTank/Tracks128",
[128]="models/BMCha/MiniTanks/ProtoTank/Tracks128",
[192]="models/BMCha/MiniTanks/ProtoTank/Tracks256",
[256]="models/BMCha/MiniTanks/ProtoTank/Tracks256",
[320]="models/BMCha/MiniTanks/ProtoTank/Tracks384",
[384]="models/BMCha/MiniTanks/ProtoTank/Tracks384",
[448]="models/BMCha/MiniTanks/ProtoTank/Tracks512",
[512]="models/BMCha/MiniTanks/ProtoTank/Tracks512"
}

function ENT:Initialize()
	self.Entity.LastPos=self.Entity:GetPos()
	self.Entity.OldMat = self.Entity:GetMaterial()
	self.Entity.LastTime = CurTime()
	self.Entity.BodyEnt = self.Entity:GetNWEntity("TankBody", self.Entity)
	self.Entity.Vel=0
end
 
function ENT:Draw()
	self.Entity:DrawModel();
end

function ENT:Think()
	local FT=CurTime()-self.Entity.LastTime
	if FT==0 then FT=0.1 end
	self.Entity.LastTime = CurTime()
	//local MovVec = self.Entity:GetPos()-self.Entity.LastPos
	//local Vel = (MovVec-Vector(0,0,MovVec.z)):Length()
	if self.Entity.BodyEnt == self.Entity then
		self.Entity.BodyEnt = self.Entity:GetNWEntity("TankBody", self.Entity)
	end
	local Vel=self.Entity.BodyEnt.Vel
	local NewMat=TrackMats[math.Clamp(math.Round((Vel/FT)/64),-4,8)*64]
	if self.Entity.OldMat!=NewMat then
		self.Entity:SetMaterial(NewMat)
		self.Entity.OldMat = NewMat
	end
	//self.Entity.LastPos=self.Entity:GetPos()
end