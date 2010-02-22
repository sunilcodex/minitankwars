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
	
	self.Entity:SetModel( "models/BMCha/MiniTanks/T-90/T-90_Body.mdl") //ProtoTank/ProtoTank_   T-90/T-90_ M1A2_Abrams_
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
	self.Entity:SetNWFloat("TopSpeed", 448)
	self.Entity:SetNWFloat("Acceleration", 448) 
	self.Entity:SetNWFloat("Speed", 0)
	
	self.Entity:SetNWFloat("TurnTopSpeed", 85)
	self.Entity:SetNWFloat("TurnSpeed", 0)
	self.Entity:SetNWFloat("SpeedMul", 1)
	//-----------------------------------------------
	
	self.Entity.LastSpeed=0
	self.Entity.LastTime=CurTime()
end

function ENT:OnRemove() 
	self.TurretEnt:Remove()
	self.TracksEnt:Remove()
end


function ENT:SetPlayerModel( playersmodel )
	self.TurretEnt:SetPlayerModel( playersmodel)
end


function ENT:SetMyPlayer( pl )
	self.Entity.MyPlayer=pl
	self.Entity:SetNWEntity("MyPlayer", pl)
	self.Entity:SetOwner(pl)
	self.TurretEnt.MyPlayer=pl
	self.TurretEnt:SetOwner(pl)
	self.TracksEnt.MyPlayer=pl
	self.TracksEnt:SetOwner(pl)
end

function ENT:Think()
	self.Entity:GetPhysicsObject():Wake()
end

function ENT:FlipTank()
	self.Entity:SetAngles(Angle(0, self.Entity:GetAngles().y, 0))
	self.Entity:SetPos(self.Entity:GetPos()+Vector(0,0,100))
	self.Entity:SetNWFloat("Speed", 0)
	local phys=self.Entity:GetPhysicsObject()
	phys:SetVelocity(Vector(0,0,100))
	phys:AddAngleVelocity(phys:GetAngleVelocity()*-1)
end

function ENT:Recoil(force, vec)
	self.Entity:GetPhysicsObject():AddVelocity(vec*-force)
end

//**************************************Powerups**********************************
function ENT:PU_SpeedBoost_Start()
	self.Entity:SetNWFloat("SpeedMul", 1.5)
	//self.Entity:SetNWInt("Powerup", PowerupTable["SpeedBoost"])
	timer.Simple(10, self.Entity:PU_SpeedBoost_Stop())
end
function ENT:PU_SpeedBoost_Stop()
	self.Entity:SetNWFloat("SpeedMul", 1)
	self.Entity:SetNWInt("Powerup", 0)
end
//*********************************************************************************
//------------------TAnk Movement-------------------------------------
function ENT:PhysicsUpdate( phys )
	local dt=CurTime()-self.Entity.LastTime
	self.Entity.LastTime=CurTime()
	
	phys:Wake()
	local pl = self.Entity.MyPlayer
	if !pl:IsValid() then return end
	if pl:Alive() then
		local up = phys:GetAngle():Up()
		if ( up.z < 0.6 ) then
			phys:Wake()
			if (pl:GetNWBool("FlipPrompt", false)==false) then
				pl:SetNWBool("FlipPrompt", true)
			end
			return
		else
			if (pl:GetNWBool("FlipPrompt", true)==true) then
				pl:SetNWBool("FlipPrompt", false)
			end
		end
		
		//if self.Entity:IsOnGround() then
		////////////////////////////////////////////////////////////////////////////////////////////////////////
		self.TurretEnt:Update(dt)
		local tankSpeed = self.Entity:GetNWFloat("Speed")
		local tankTopSpeed = self.Entity:GetNWFloat("TopSpeed")
		local tankAcceleration = self.Entity:GetNWFloat("Acceleration")
		local tankTurnTopSpeed = self.Entity:GetNWFloat("TurnTopSpeed")
		local tankTurnSpeed = self.Entity:GetNWFloat("TurnSpeed")
		local tankSpeedMul = self.Entity:GetNWFloat("SpeedMul")
		tankTopSpeed=tankTopSpeed*tankSpeedMul
		
		if pl:KeyDown( IN_FORWARD ) then
			tankSpeed = math.Clamp(tankSpeed+(tankAcceleration*dt), -tankTopSpeed/2, tankTopSpeed)
		end
		if pl:KeyDown( IN_BACK ) then
			tankSpeed = math.Clamp(tankSpeed-(tankAcceleration*dt), -tankTopSpeed/2, tankTopSpeed)
		end
		if not (pl:KeyDown( IN_FORWARD ) or pl:KeyDown( IN_BACK )) then
			if (tankSpeed > 0) then
				tankSpeed = math.Clamp(tankSpeed-(tankAcceleration*dt), 0, tankTopSpeed)
			elseif (tankSpeed < 0) then
				tankSpeed = math.Clamp(tankSpeed+(tankAcceleration*dt), -tankTopSpeed/2, 0)
			end
		end
		self.Entity:SetNWFloat("Speed", tankSpeed)
		
		if pl:KeyDown( IN_MOVELEFT ) then
			tankTurnSpeed=math.Clamp(tankTurnSpeed+(tankTurnTopSpeed*dt), -tankTurnTopSpeed, tankTurnTopSpeed)
			tankSpeed=tankSpeed*(1-((math.abs(tankTurnSpeed)/tankTurnTopSpeed)*0.5))
		elseif pl:KeyDown( IN_MOVERIGHT ) then
			tankTurnSpeed=math.Clamp(tankTurnSpeed-(tankTurnTopSpeed*dt), -tankTurnTopSpeed, tankTurnTopSpeed)
			tankSpeed=tankSpeed*(1-((math.abs(tankTurnSpeed)/tankTurnTopSpeed)*0.5))
		else
			if (tankTurnSpeed > 0) then
				tankTurnSpeed = math.Clamp(tankTurnSpeed-(tankTurnTopSpeed*dt*2), 0, tankTurnTopSpeed)
			elseif (tankTurnSpeed < 0) then
				tankTurnSpeed = math.Clamp(tankTurnSpeed+(tankTurnTopSpeed*dt*2), -tankTurnTopSpeed, 0)
			end
		end
		self.Entity:SetNWFloat("TurnSpeed", tankTurnSpeed)
		
		local Vel = phys:GetVelocity()
		local RightVel = phys:GetAngle():Right():Dot( Vel )
		
		//****************LINEAR TEIM************************
		//stop skidding(tracks (well, wheels too) don't go sideways)
		RightVel = RightVel * -0.5
		
		if tankSpeed>0 then
			Linear=tankSpeed-math.Clamp(self.Entity:GetForward():Dot(Vel), 0, tankSpeed)
			Linear=Linear*(  0.6  -  math.Clamp(self.Entity:GetForward():Dot(Vector(0,0,1)), -0.6,0.6)  )*1.67
		else
			Linear=tankSpeed+math.Clamp(-self.Entity:GetForward():Dot(Vel), 0, -tankSpeed)
			Linear=Linear*(  0.6  -  math.Clamp((self.Entity:GetForward()*-1):Dot(Vector(0,0,1)), -0.6,0.6)  )*1.67
		end
		Linear=Vector(Linear,-RightVel,0)  //rightvel
		Linear=(self.Entity:LocalToWorld(Linear)-self.Entity:GetPos())
		phys:AddVelocity(Linear)
		//**************ANGULAR TIEM************************
		local AngVel=Vector( 0, 0, ((-1*phys:GetAngleVelocity().z)+tankTurnSpeed) )
		if not (math.abs(tankSpeed) < 5 and math.abs(tankTurnSpeed) < 1) then
			phys:AddAngleVelocity(AngVel)
		end
		
		//end
	end
	return
end
