 /*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in /shared.lua
------------------------
ProtoTank_Turret init.lua
	-ProtoTank Turret Entity serverside init
*/

local TraverseSound = Sound("vehicles/tank_turret_loop1.wav")
local StartTraverseSound = Sound("vehicles/tank_turret_start1.wav")
local StopTraverseSound = Sound("vehicles/tank_turret_stop1.wav")


AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()
	self.Entity.MyPlayer = NULL
	
	self.Entity:SetModel( "models/BMCha/MiniTanks/T-90/T-90_Turret.mdl")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	
	self.Entity:SetNWString("PlayerModel", "models/player/kleiner.mdl")
	
	self.Entity.TurretYaw = 0
	self.Entity.TurretElev = 0
	
	self.Entity.TraversePatch  = CreateSound(self.Entity, TraverseSound)
	self.Entity.SoundPlaying = false
end

function ENT:Update(dt)
	if (self.Entity.MyPlayer!=NULL) then
		local tankEnt = self.Entity.MyPlayer.TankEnt
		
		local TAng=tankEnt:GetAngles()
		local DesiredRot=math.NormalizeAngle(self.Entity.MyPlayer:EyeAngles().y-TAng.y)
		local AngDiff = math.NormalizeAngle(self.Entity.TurretYaw) - DesiredRot
		local DeltaRot = math.Clamp((90*dt), -math.abs(AngDiff), math.abs(AngDiff))
		if ((AngDiff > 0 or AngDiff < -180) and (AngDiff < 180)) then
			self.Entity.TurretYaw=self.Entity.TurretYaw-DeltaRot
		elseif AngDiff < 0 or AngDiff > 180 then
			self.Entity.TurretYaw=self.Entity.TurretYaw+DeltaRot
		end
		
		if self.Entity.TurretYaw > 360 then
			self.Entity.TurretYaw = self.Entity.TurretYaw-360
		end
		if self.Entity.TurretYaw < 0 then
			self.Entity.TurretYaw = self.Entity.TurretYaw+360
		end
		
		if (math.Round(math.NormalizeAngle(self.Entity.TurretYaw))==math.Round(DesiredRot)) then
			if self.Entity.SoundPlaying==true then
				self.Entity.TraversePatch:Stop()
				self.Entity.SoundPlaying = false
			end
		else	
			if self.Entity.SoundPlaying==false then
				self.Entity.TraversePatch:Play()
				self.Entity.TraversePatch:ChangePitch(50)
				self.Entity.SoundPlaying = true
			end
		end
		
		TAng:RotateAroundAxis(tankEnt:GetUp(), math.NormalizeAngle(self.Entity.TurretYaw))
		self.Entity:SetAngles(TAng)
		local DesiredElev = self.Entity.MyPlayer:EyeAngles()
		self.Entity:WorldToLocalAngles(DesiredElev)
		DesiredElev = math.Clamp(-DesiredElev.p, -25, 25) 
		self.Entity:SetPoseParameter("Turret_Elevate", math.Round(math.sin(CurTime())))
		
	end
end

function ENT:SetPlayerModel( playersmodel )
	self.Entity:SetNWString("PlayerModel", playersmodel)
end