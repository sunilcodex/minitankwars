 /*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
------------------------
PowerUp_SpeedBoost init.lua
	-SpeedBoost Powerup Entity serverside init
*/

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )
/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()
	self.Entity.MyPlayer = NULL
	
	self.Entity:SetModel( "models/BMCha/MiniTanks/PowerUps/SpeedBoost.mdl" )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	
	self.Entity:DrawShadow(false)
	
end

function ENT:Touch( ent )
	if ent:IsValid() then
		if ent:IsPlayer() then
			ent:ChatPrint("Speed Increased!")
			ent:SetHealth(ent:Health()+50)
			self.Entity.Kill()
		end
	end
end