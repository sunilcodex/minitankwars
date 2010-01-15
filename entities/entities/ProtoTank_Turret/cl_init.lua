  /*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
*/

include('shared.lua');
 
local PlayerTankCommander
 
 /*
 function ENT:Initialize()
	//create the Clientside ragdoll that will be the player-in-tank model
	self.PlayerEnt:SetParent(self.Entity)
	self.PlayerEnt:SetPos( self.Entity:GetAttachment(self.Entity:LookupAttachment("PlayerOrigin")).Pos  )
	self.PlayerEnt:SetModel( "models/player/police.mdl" )
	self.PlayerEnt:Spawn()
	
	self.PlayerEnt:SetModel( playersmodel )
	local index = self.PlayerEnt:LookupBone("ValveBiped.Bip01_Head1")
	local matrix = self.PlayerEnt:GetBoneMatrix(index) 
    matrix:Scale(Vector(0,0,0))
    self.PlayerEnt:SetBoneMatrix(index, matrix)
	index = self.PlayerEnt:LookupBone("ValveBiped.Bip01_Spine")
	matrix = self.PlayerEnt:GetBoneMatrix(index) 
    matrix:Rotate(Angle(0,45,0))
    self.PlayerEnt:SetBoneMatrix(index, matrix)
 end
 */
 
function ENT:Draw()
	self.Entity:DrawModel();
end
