 /*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
------------------------
AP_Shell init.lua
	-AP Tank Round Entity serverside init
*/

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )
util.PrecacheSound("weapons/explode4.wav")
/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()
	self.Entity:SetModel( "models/BMCha/MiniTanks/TankRounds/Shell.mdl" )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_NONE )  //custom 'physics'
	self.Entity:SetSolid( SOLID_VPHYSICS )
	util.SpriteTrail(self.Entity, 0, Color(255,175,175,50), false, 8, 1, 2, 1/(15+1)*0.5, "trails/smoke.vmt")
end

function ENT:Think()
	//setup teh trace
	traceres=util.QuickTrace(self.Entity:GetPos(), self.Entity:GetForward()*450, self.Entity)
	if traceres.Hit==true then  //time to kablooey
		self.Entity:SetPos(traceres.HitPos)
		self.Entity:KABLOOEY(traceres.Entity)
		self.Entity:NextThink(CurTime()+3)//which will never come
		return true
	end
	//drop off and move forward
	local NewAng = (self.Entity:GetForward()+Vector(0,0,-0.001)):Angle()
	self.Entity:SetAngles(NewAng)
	self.Entity:SetPos(self.Entity:GetPos()+(NewAng:Forward()*400))
	
	//we'll do it live!
	self.Entity:NextThink(CurTime())
	return true
end

function ENT:KABLOOEY(ent)
	//ow
	util.BlastDamage(self.Entity, self.Entity:GetOwner(), self.Entity:GetPos(), 500, 10)
	if ent:IsValid() then
		if ent.MyPlayer then
			ent.MyPlayer:SetHealth(ent.MyPlayer:Health()-40)
		end
	end
	//boom
	self.Entity:EmitSound("weapons/explode4.wav", 150, 125)
	local ed = EffectData()
	ed:SetOrigin(self.Entity:GetPos())
	util.Effect("ShellExplode", ed, true, true)
	//poof
	self.Entity:SetNoDraw(true)
	self.Entity:SetNotSolid(true)
	timer.Simple(2, function() self.Entity:Remove() end)   //give the trail time to fade
end