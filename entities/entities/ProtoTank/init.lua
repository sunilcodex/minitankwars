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
	//self.Entity:StartMotionController()  //Use a custom Physics Simulation
	
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
	self.Entity:SetNWFloat("Acceleration", 512) 
	self.Entity:SetNWFloat("Speed", 0)
	
	self.Entity:SetNWFloat("TurnSpeed", 65)  //  deg/sec?
	self.Entity:SetNWFloat("TurnAngle", self.Entity:GetAngles().y) 
	//-----------------------------------------------
	//self.Entity:GetPhysicsObject():SetMaterial("ice")
	
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
	local ply = self.Entity.MyPlayer
	if (ply:GetNWBool("FlipPrompt", false)==true) then
		if (ply:KeyDown( IN_USE )) then
			ply:SetNWBool("FlipPrompt", false)
			self.Entity:FlipTank()
		end
	end
end

function ENT:FlipTank()
	self.Entity:SetAngles(Angle(0, self.Entity:GetAngles().y, 0))
	self.Entity:SetPos(self.Entity:GetPos()+Vector(0,0,100))
end

//------------------TAnk Movement-------------------------------------

function ENT:PhysicsSimulate( phys, dt)
	local ply = self.Entity.MyPlayer
	if !ply:IsValid() then return SIM_NOTHING end
	if ply:Alive() then
		local up = phys:GetAngle():Up()
		if ( up.z < 0.5 ) then
			phys:Wake()
			if (ply:GetNWBool("FlipPrompt", false)==false) then
				ply:SetNWBool("FlipPrompt", true)
			end
			return SIM_NOTHING
		else
			if (ply:GetNWBool("FlipPrompt", true)==true) then
				ply:SetNWBool("FlipPrompt", false)
			end
		end
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		local tankSpeed = self.Entity:GetNWFloat("Speed")
		local tankTopSpeed = self.Entity:GetNWFloat("TopSpeed")
		local tankAcceleration = self.Entity:GetNWFloat("Acceleration")
		local tankTurnSpeed = self.Entity:GetNWFloat("TurnSpeed")
		local tankTurnAngle = self.Entity:GetNWFloat("TurnAngle")
		
		if ply:KeyDown( IN_FORWARD ) then
			tankSpeed = math.Clamp(tankSpeed+(tankAcceleration*dt), -tankTopSpeed/2, tankTopSpeed)
		end
		if ply:KeyDown( IN_BACK ) then
			tankSpeed = math.Clamp(tankSpeed-(tankAcceleration*dt), -tankTopSpeed/2, tankTopSpeed)
		end
		if not (ply:KeyDown( IN_FORWARD ) or ply:KeyDown( IN_BACK )) then
			if (tankSpeed > 0) then
				tankSpeed = math.Clamp(tankSpeed-(tankAcceleration*dt), 0, tankTopSpeed)
			elseif (tankSpeed < 0) then
				tankSpeed = math.Clamp(tankSpeed+(tankAcceleration*dt), -tankTopSpeed/2, 0)
			end
		end
		if ply:KeyDown( IN_MOVELEFT ) then
			tankTurnAngle=math.NormalizeAngle(tankTurnAngle+(tankTurnSpeed*dt))
		end
		if ply:KeyDown( IN_MOVERIGHT ) then
			tankTurnAngle=math.NormalizeAngle(tankTurnAngle-(tankTurnSpeed*dt))
		end
		
		self.Entity:SetNWFloat("Speed", tankSpeed)
		self.Entity:SetNWFloat("TurnAngle", tankTurnAngle)
		//ply:ChatPrint("Speed: "..tankSpeed)
		////////////////////////////////////////////////////////////////////////////////////////////////////////
		local Vel = phys:GetVelocity()
		local RightVel = phys:GetAngle():Right():Dot( Vel )
		local AngleVel = phys:GetAngleVelocity()
		
		//****************LINEAR TEIM************************
		//stop skidding(tracks (well, wheels too) don't go sideways)
		RightVel = RightVel * 0.5
		
		//local Linear = Vector( tankSpeed, RightVel, 0 ) * dt * 1000
		local Linear = Vector(0, tankSpeed, 0) * dt * 1000
		
		//print("Linear: "..Linear.x.." ---"..Linear.y.." ---"..Linear.z)
		AngleVel=Vector(AngleVel.x, AngleVel.y,0)

		return AngleVel, Linear, SIM_LOCAL_FORCE
		///////////////////////////////////////////////////////////////////////////////////////////////////////////
	end
	return SIM_NOTHING
end
