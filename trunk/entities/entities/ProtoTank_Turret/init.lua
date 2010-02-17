 /*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
------------------------
ProtoTank_Turret init.lua
	-ProtoTank Turret Entity serverside init
*/

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()
	self.Entity.MyPlayer = NULL
	
	self.Entity:SetModel( "models/BMCha/MiniTanks/T-90/T-90_Turret.mdl")//ProtoTank/ProtoTank_Turret.mdl" )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	
	self.Entity:SetNWString("PlayerModel", "models/player/kleiner.mdl")
	
	/*self.PlayerEnt= ents.Create( "prop_dynamic" )
	self.PlayerEnt:SetParent(self.Entity)
	self.PlayerEnt:SetPos( self.Entity:GetAttachment(self.Entity:LookupAttachment("PlayerOrigin")).Pos  )
	self.PlayerEnt:SetModel( "models/player/police.mdl" )
	self.PlayerEnt:Spawn()*/
end


function ENT:SetPlayerModel( playersmodel )
	self.Entity:SetNWString("PlayerModel", playersmodel)
end