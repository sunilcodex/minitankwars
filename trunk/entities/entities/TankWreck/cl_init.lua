 /*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
------------------------
Tank Wreck cl_init.lua
	-Tank Wreck Entity clientside init
*/

include('shared.lua');
 
function ENT:Draw()
	self.Entity:DrawModel();
end
/*
function ENT:Initialize()
	self.Entity.emitter = ParticleEmitter(self.Entity:GetPos())
end

function ENT:Think()
	//smoke tiem
	self.Entity.emitter=ParticleEmitter(self.Entity:GetPos())
	local particle = self.Entity.emitter:Add(
end*/

function ENT:OnRemove()
	self.Entity.emitter:Finish()
end