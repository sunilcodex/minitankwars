 /*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
------------------------
Cannon_Shell init.lua
	-Tank Round Entity serverside init
*/

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )
/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()
	self.Entity:SetModel( "models/BMCha/MiniTanks/TankRounds/Shell.mdl" )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:GetPhysicsObject():EnableGravity(false)
	self.Entity:GetPhysicsObject():SetDamping(0,1000)
	util.SpriteTrail(self.Entity, 0, Color(255,255,200), false, 5, 1, 4, 1/(15+1)*0.5, "trails/smoke.vmt")
	self.Entity:SetVelocity(self.Entity:GetAngles():Forward()*600)
end

function ENT:PhysicsCollide(data, phys)
	local explode = ents.Create( "env_explosion" )
	explode:SetPos( data.HitPos )
	explode:SetOwner( self.Owner )
	explode:Spawn()
	explode:SetKeyValue( "iMagnitude", "500" )
	explode:Fire( "Explode", 0, 0 )
	self.Entity:Remove()
end

function ENT:Think()
	self.Entity:GetPhysicsObject():Wake()
end