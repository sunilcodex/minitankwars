 /*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
*/

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )
MyPlayer=NULL
/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()

	self.Entity:SetModel( "models/BMCha/MiniTanks/ProtoTank/ProtoTank_Turret.mdl" )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	
	self.PlayerEnt= ents.Create( "prop_dynamic" )
	self.PlayerEnt:SetParent(self.Entity)
	self.PlayerEnt:SetPos( self.Entity:GetAttachment(self.Entity:LookupAttachment("PlayerOrigin")).Pos  )
	self.PlayerEnt:SetModel( "models/player/police.mdl" )
	self.PlayerEnt:Spawn()
end

/*---------------------------------------------------------
   Name: SetPlayerModel
---------------------------------------------------------*/
function ENT:SetPlayerModel( playersmodel )
	self.PlayerEnt:SetModel( playersmodel )
	local index = self.PlayerEnt:LookupBone("ValveBiped.Bip01_Head1")
	local matrix = self.PlayerEnt:GetBoneMatrix(index) 
    matrix:Scale(Vector(0,0,0))
    self.PlayerEnt:SetBoneMatrix(index, matrix)
	index = self.PlayerEnt:LookupBone("ValveBiped.Bip01_Spine")
	matrix = self.PlayerEnt:GetBoneMatrix(index) 
    matrix:Rotate(Angle(0,45,0))
    self.PlayerEnt:SetBoneMatrix(index, matrix)
	//local BonePos , BoneAng = self.PlayerEnt:GetBonePosition( self.PlayerEnt:LookupBone("ValveBiped.Bip01_R_UpperArm") )
	//self.PlayerEnt:SetBonePosition(BonePos, BoneAng + Angle(-45,0,0))
	//local BonePos , BoneAng = self.PlayerEnt:GetBonePosition( self.PlayerEnt:LookupBone("ValveBiped.Bip01_L_UpperArm") )
	//self.PlayerEnt:SetBonePosition(BonePos, BoneAng + Angle(0,45,0))
end