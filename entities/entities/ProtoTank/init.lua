 /*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
------------------------
ProtoTank init.lua
	-ProtoTank Entity serverside init
*/

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )



function ENT:Initialize()
	self.Entity.MyPlayer = NULL
	
	self.Entity:SetModel( "models/BMCha/MiniTanks/ProtoTank/ProtoTank_Body.mdl" )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	
	self.TurretEnt= ents.Create( "ProtoTank_Turret" )
	self.TurretEnt:SetParent(self.Entity)
	self.TurretEnt:SetPos(self.Entity:GetPos())
	self.TurretEnt:SetAngles(self.Entity:GetAngles())
	self.TurretEnt:Spawn()
	
	self.TracksEnt= ents.Create( "ProtoTank_Tracks" )
	self.TracksEnt:SetParent(self.Entity)
	self.TracksEnt:SetPos(self.Entity:GetPos())
	self.TracksEnt:SetAngles(self.Entity:GetAngles())
	self.TracksEnt:Spawn()	
	self.TracksEnt:SetNWEntity("TankBody", self.Entity )
	
	/*---------------------------------------------
			Tank Differentiating Variables
	---------------------------------------------*/
	self.Entity:SetNWFloat("TopSpeed", 512)
	self.Entity:SetNWFloat("Acceleration", 256) 
	self.Entity:SetNWFloat("Speed", 0)
	
	self.Entity:SetNWFloat("TurnSpeed", 65)  //  deg/sec?
	self.Entity:SetNWFloat("TurnAngle", self.Entity:GetAngles().y)
	//-----------------------------------------------
end

function ENT:OnRemove() 
	self.TurretEnt:Remove()
	self.TracksEnt:Remove()
end


function ENT:SetPlayerModel( playersmodel )
	self.TurretEnt:SetPlayerModel( playersmodel)
end


function ENT:SetMyPlayer( pl )
	MyPlayer=pl
	self.Entity:SetNWEntity("MyPlayer", pl)
	self.TurretEnt.MyPlayer=pl
	self.TracksEnt.MyPlayer=pl
end