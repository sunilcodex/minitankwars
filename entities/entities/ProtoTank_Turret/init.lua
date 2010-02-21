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
	
	self.Entity:SetModel( "models/BMCha/MiniTanks/M1A2_Abrams/M1A2_Abrams_Turret.mdl")//ProtoTank/ProtoTank_Turret.mdl" )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	
	self.Entity:SetNWString("PlayerModel", "models/player/kleiner.mdl")
	
	self.Entity.TurretYaw = 0
	self.Entity.TurretElev = 0
	
	self.Entity.TraversePatch  = CreateSound(self.Entity, TraverseSound)
	self.Entity.TraversePatch:ChangePitch(10)
	self.Entity.SoundPlaying = false
end

function ENT:Update(dt)
	if (self.Entity.MyPlayer!=NULL) then
		local tankEnt = self.Entity.MyPlayer.TankEnt
		/*print("---")
		print(self.Entity.MyPlayer:EyeAngles().y)
		local EyeVec = Angle(0, self.Entity.MyPlayer:EyeAngles().y, 0):Forward()
		print(EyeVec)
		EyeVec:Rotate(tankEnt:GetAngles())
		print(EyeVec:Angle())
		print(tankEnt:GetAngles())
		self.Entity:SetAngles(EyeVec:Angle()+Angle(0,0,tankEnt:GetAngles().r))*/
		self.MyPlayer:ChatPrint("----")
		local TAng=tankEnt:GetAngles()
		local DesiredRot=math.NormalizeAngle(self.Entity.MyPlayer:EyeAngles().y-TAng.y)
		local AngDiff = self.Entity.TurretYaw - DesiredRot
		self.Entity.MyPlayer:ChatPrint(self.Entity.TurretYaw)// 43  -43
		self.Entity.MyPlayer:ChatPrint(DesiredRot)// -169    169
		self.Entity.MyPlayer:ChatPrint(AngDiff)// 212   -212
		/*
		local DeltaRot = math.Clamp((90*dt), -math.abs(AngDiff), math.abs(AngDiff))
		if ((AngDiff > 0 or AngDiff < -180) and (AngDiff < 180)) then   //first
			self.Entity.TurretYaw=self.Entity.TurretYaw-DeltaRot//math.Approach(math.NormalizeAngle(self.Entity.TurretYaw), math.NormalizeAngle(DesiredRot), -90*dt)
			self.Entity.MyPlayer:ChatPrint("first")
		elseif AngDiff < 0 or AngDiff > 180 then
			self.Entity.TurretYaw=self.Entity.TurretYaw+DeltaRot//math.Approach(math.NormalizeAngle(self.Entity.TurretYaw), math.NormalizeAngle(DesiredRot), 90*dt)
			self.Entity.MyPlayer:ChatPrint("second")
		end*/
		
		/*if self.Entity.TurretYaw > 360 then
			self.Entity.TurretYaw = self.Entity.TurretYaw-360
		end
		if self.Entity.TurretYaw < 0 then
			self.Entity.TurretYaw = self.Entity.TurretYaw+360
		end*/
		
		if (math.Round(self.Entity.TurretYaw)==math.Round(DesiredRot)) then
			if self.Entity.SoundPlaying==true then
				self.Entity.TraversePatch:Stop()
				self.Entity.SoundPlaying = false
			end
		else	
			if self.Entity.SoundPlaying==false then
				self.Entity.TraversePatch:Play()
				self.Entity.SoundPlaying = true
			end
		end
		
		//TAng:RotateAroundAxis(tankEnt:GetUp(), math.NormalizeAngle(self.Entity.TurretYaw))
		self.Entity:SetAngles(TAng)
		local DesiredElev=math.Round(math.Rad2Deg(math.acos(self.Entity.MyPlayer:EyeAngles():Forward():Dot(TAng:Forward()))))
		//self.Entity.TurretElev=math.Approach(self.Entity.TurretElev, DesiredElev, 1)
		//self.Entity.MyPlayer:ChatPrint(math.Clamp(DesiredElev, -24, 24))
		self.Entity:SetPoseParameter("Turret_Elevate", math.Clamp(DesiredElev, -24, 24))
	end
end

function ENT:SetPlayerModel( playersmodel )
	self.Entity:SetNWString("PlayerModel", playersmodel)
end