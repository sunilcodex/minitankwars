 /*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
------------------------
PowerUp_Repair init.lua
	-Repair Powerup Entity serverside init
*/

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

util.PrecacheSound("MiniTankWars/repair.wav")
/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()
	
	self.Entity:SetModel( "models/BMCha/MiniTanks/Powerups/Crate.mdl" )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	local chute = ents.Create( "Powerup_Chute" )
	chute:SetPos( self.Entity:GetPos() )
	chute:SetAngles(self.Entity:GetAngles())
	chute:Spawn()
	chute:SetParent(self.Entity)
	self.Entity.Chute=chute
	self.Entity.Dropping=true
end

function ENT:Think()
	if (self.Entity.Dropping==true) then
		local TD = util.QuickTrace(self.Entity:GetPos(), Vector(0,0,-64), {self.Entity, self.Entity.Chute})
		if (TD.HitWorld == true and self.Entity:GetVelocity().z < 10) then
			self.Entity.Chute:Remove()
			self.Entity.Dropping=false
		end
		local phys = self.Entity:GetPhysicsObject()
		phys:ApplyForceCenter(Vector(0,0, 10000)) //math.random(100)/200,math.random(100)/200
	end
end

function ENT:StartTouch( ent )
	if ent:IsValid() then
		if ent:IsValid() and ent.MyPlayer then
			ent:EmitSound("MiniTankWars/repair.wav", 150, 90)
			ent.MyPlayer:SetHealth(math.Clamp(ent.MyPlayer:Health()+25, 0, 100))
			ent.MyPlayer:ChatPrint("+25 Armor")
			ActivePowerups=ActivePowerups-1
			self.Entity:Remove()
			if (self.Entity.Chute:IsValid()) then
				self.Entity.Chute:Remove()
			end
		end
	end
end