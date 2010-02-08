  /*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
------------------------
ProtoTank_Turret cl_init.lua
	-ProtoTank Turret Entity clientside init
*/

include('shared.lua');
 
	
 function ENT:Initialize()
	self.PlayerEntModel="NULLMODEL"
	self.PlayerEnt = ClientsideModel( self.Entity:GetNWString("PlayerModel"), RENDERGROUP_OPAQUE )
	if not (self.PlayerEnt and self.PlayerEnt:IsValid()) then self.PlayerEnt = ClientsideModel("models/player/kleiner.mdl", RENDERGROUP_OPAQUE) 
		self.PlayerEntModel = "models/player/kleiner.mdl" end
	self.PlayerEntModel = self.Entity:GetNWString("PlayerModel")
	self.PlayerEnt:SetParent(self.Entity)
	self.PlayerEnt:SetPos( self.Entity:GetAttachment(self.Entity:LookupAttachment("PlayerOrigin")).Pos  )
	self.PlayerEnt:SetAngles(self.Entity:GetAngles())
	self.PlayerEnt:Spawn()
	////////////////
	function self.PlayerEnt.BuildBonePositions(entity)  
		if entity:GetModel()!="models/player/gman_high.mdl" then
		local index = entity:LookupBone("ValveBiped.Bip01_L_UpperArm")    
		local matrix = entity:GetBoneMatrix(index)  
		matrix:Rotate(Angle(35,0,0))
		entity:SetBoneMatrix(index, matrix) 
		index = entity:LookupBone("ValveBiped.Bip01_R_UpperArm")    
		matrix = entity:GetBoneMatrix(index)  
		matrix:Rotate(Angle(-35,0,0))
		entity:SetBoneMatrix(index, matrix)
		local HideBonesL= {
			"ValveBiped.Bip01_L_Forearm",
			"ValveBiped.Bip01_L_Hand",
			"ValveBiped.Anim_Attachment_LH",
			"ValveBiped.Bip01_L_Wrist",
			"ValveBiped.Bip01_L_Ulna",
		}
		local HideBonesR= {
			"ValveBiped.Bip01_R_Forearm",
			"ValveBiped.Bip01_R_Hand",
			"ValveBiped.Anim_Attachment_RH",
			"ValveBiped.Bip01_R_Wrist",
			"ValveBiped.Bip01_R_Ulna",
		}
		local LB = entity:GetBoneMatrix(entity:LookupBone("ValveBiped.Bip01_L_UpperArm"))
		local RB = entity:GetBoneMatrix(entity:LookupBone("ValveBiped.Bip01_R_UpperArm"))
		for k,v in pairs(HideBonesL) do
			index = entity:LookupBone(v)    
			matrix = entity:GetBoneMatrix(index)  
			matrix = LB
			matrix:Scale(Vector(0))
			entity:SetBoneMatrix(index, matrix)
		end
		for k,v in pairs(HideBonesR) do
			index = entity:LookupBone(v)    

			matrix = RB
			matrix:Scale(Vector(0))
			entity:SetBoneMatrix(index, matrix)
		end
		end
	end
	////////////////
 end
 
function ENT:Draw()
	self.Entity:DrawModel();
end


function ENT:Think()
	if (self.PlayerEntModel!=self.Entity:GetNWString("PlayerModel")) then
		//print("updating model from'"..self.PlayerEntModel.."' to '"..self.Entity:GetNWString("PlayerModel").."'")
		if self.PlayerEnt and self.PlayerEnt:IsValid() then self.PlayerEnt:Remove() end
		self.PlayerEnt = ClientsideModel( self.Entity:GetNWString("PlayerModel"), RENDERGROUP_OPAQUE )
		self.PlayerEntModel = self.Entity:GetNWString("PlayerModel")
		self.PlayerEnt:SetParent(self.Entity)
		self.PlayerEnt:SetPos( self.Entity:GetAttachment(self.Entity:LookupAttachment("PlayerOrigin")).Pos  )
		self.PlayerEnt:SetAngles(self.Entity:GetAngles())
		self.PlayerEnt:Spawn()		
		////////////////
		function self.PlayerEnt.BuildBonePositions(entity)  
			if entity:GetModel()!="models/player/gman_high.mdl" then
			local index = entity:LookupBone("ValveBiped.Bip01_L_UpperArm")    
			local matrix = entity:GetBoneMatrix(index)  
			matrix:Rotate(Angle(35,0,0))
			entity:SetBoneMatrix(index, matrix) 
			index = entity:LookupBone("ValveBiped.Bip01_R_UpperArm")    
			matrix = entity:GetBoneMatrix(index)  
			matrix:Rotate(Angle(-35,0,0))
			entity:SetBoneMatrix(index, matrix)
			local HideBonesL= {
				"ValveBiped.Bip01_L_Forearm",
				"ValveBiped.Bip01_L_Hand",
				"ValveBiped.Anim_Attachment_LH",
				"ValveBiped.Bip01_L_Wrist",
				"ValveBiped.Bip01_L_Ulna",
			}
			local HideBonesR= {
				"ValveBiped.Bip01_R_Forearm",
				"ValveBiped.Bip01_R_Hand",
				"ValveBiped.Anim_Attachment_RH",
				"ValveBiped.Bip01_R_Wrist",
				"ValveBiped.Bip01_R_Ulna",
			}
			local LB = entity:GetBoneMatrix(entity:LookupBone("ValveBiped.Bip01_L_UpperArm"))
			local RB = entity:GetBoneMatrix(entity:LookupBone("ValveBiped.Bip01_R_UpperArm"))
			for k,v in pairs(HideBonesL) do
				index = entity:LookupBone(v)    
				matrix = entity:GetBoneMatrix(index)  
				matrix = LB
				matrix:Scale(Vector(0))
				entity:SetBoneMatrix(index, matrix)
			end
			for k,v in pairs(HideBonesR) do
				index = entity:LookupBone(v)    
				matrix = entity:GetBoneMatrix(index)  
				matrix = RB
				matrix:Scale(Vector(0))
				entity:SetBoneMatrix(index, matrix)
			end
			end
		end
		////////////////
	end
	//fix any PVS issues
	//self.PlayerEnt:SetPos( self.Entity:GetAttachment(self.Entity:LookupAttachment("PlayerOrigin")).Pos  )
	//self.PlayerEnt:SetAngles(self.Entity:GetAngles())
end

function ENT:OnRemove() 
	self.PlayerEnt:SetColor(Color(0,0,0,0))
	self.PlayerEnt:Remove()
end
		