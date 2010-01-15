 /*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
*/

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )
MyPlayer = NULL
/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()

	self.Entity:SetModel( "models/BMCha/MiniTanks/ProtoTank/ProtoTank_Body.mdl" )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	
	self.TurretEnt= ents.Create( "ProtoTank_Turret" )
	self.TurretEnt:SetParent(self.Entity)
	self.TurretEnt:SetPos(self.Entity:GetPos())
	self.TurretEnt:Spawn()
	
	self.TracksEnt= ents.Create( "ProtoTank_Tracks" )
	self.TracksEnt:SetParent(self.Entity)
	self.TracksEnt:SetPos(self.Entity:GetPos())
	self.TracksEnt:Spawn()
	
end

/*---------------------------------------------------------
   Name: SetPlayerModel
---------------------------------------------------------*/
function ENT:SetPlayerModel( playersmodel )
	self.TurretEnt:SetPlayerModel( playersmodel)
end

function ENT:SetMyPlayer( pl )
	MyPlayer=pl
	self.TurretEnt.MyPlayer=pl
	self.TrackEnt.MyPlayer=pl
end