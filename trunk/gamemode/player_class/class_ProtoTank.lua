/*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in shared.lua
------------------------
class_ProtoTank.lua
	-ProtoTank Class setup
*/


local CLASS = {}
 
CLASS.DisplayName			= "ProtoTank"
CLASS.WalkSpeed 			= 400
CLASS.CrouchedWalkSpeed 	= 0.2
CLASS.RunSpeed				= 600
CLASS.DuckSpeed				= 0.2
CLASS.JumpPower				= 0
CLASS.DrawTeamRing			= false
CLASS.DrawViewModel		= false
CLASS.CanUseFlashlight      = false
CLASS.MaxHealth				= 100
CLASS.StartHealth			= 100
CLASS.StartArmor			= 0
CLASS.RespawnTime           = 0 // 0 means use the default spawn time chosen by gamemode
CLASS.DropWeaponOnDie		= false
CLASS.TeammateNoCollide 	= false
CLASS.AvoidPlayers			= false // Automatically avoid players that we're no colliding
CLASS.Selectable			= true // When false, this disables all the team checking
CLASS.FullRotation			= false // Allow the player's model to rotate upwards, etc etc
 
function CLASS:Loadout( pl )
	pl:Give( "weapon_rpg" )
	pl:GiveAmmo( 255, "RPG_Round")
end
 
function CLASS:OnSpawn( pl )
	//pl:SetHull( Vector( -16, -16, -16 ), Vector( 16, 16, 16 ) )
	local TankEnt = ents.Create( "ProtoTank" )
	TankEnt:SetPos(pl:GetPos())
	TankEnt:SetAngles(pl:GetAngles())	
	TankEnt:Spawn()
	TankEnt:SetParent(pl)	
	TankEnt:SetAngles(TankEnt:GetAngles())
	TankEnt:SetPlayerModel(pl:GetModel())
	TankEnt:SetMyPlayer(pl)
	//pl:SetPos(pl:GetPos()+Vector(0,0,200))
	pl:DrawShadow(false)
	pl:SetColor( Color(0,0,0,0) )
	pl.TankEnt = TankEnt
	/*---------------------------------------------
			Tank Differentiating Variables
	---------------------------------------------*/
		pl:SetNWFloat("TopSpeed", 400)
		pl:SetNWFloat("Acceleration", 400) 
		pl:SetNWFloat("Speed", 0)
		
		pl:SetNWFloat("TurnSpeed", 65)  //  deg/sec?
		pl:SetNWFloat("TurnAngle", pl:GetAngles().y)
	//-----------------------------------------------
end
 
function CLASS:OnDeath( pl, attacker, dmginfo )
	pl.TankEnt:Remove()
	pl.TankEnt=nil
	/*local Wreck = ents.Create( "DeadProtoTank" )
	Wreck.SetPos(pl:GetPos())
	Wreck.SetAngles(pl:GetAngles())*/
end
 
function CLASS:Think( pl )
end

function CLASS:Move( pl, mv )
	if ( !pl:Alive() ) then return end
	local FT=FrameTime()
	
	local plSpeed = pl:GetNWFloat("Speed")
	local plTopSpeed = pl:GetNWFloat("TopSpeed")
	local plAcceleration = pl:GetNWFloat("Acceleration")
	local plTurnSpeed = pl:GetNWFloat("TurnSpeed")
	local plTurnAngle = pl:GetNWFloat("TurnAngle")
	
	if pl:KeyDown( IN_FORWARD ) then
		plSpeed = math.Clamp(plSpeed+(plAcceleration*FT), -plTopSpeed/2, plTopSpeed)
	end
	if pl:KeyDown( IN_BACK ) then
		plSpeed = math.Clamp(plSpeed-(plAcceleration*FT), -plTopSpeed/2, plTopSpeed)
	end
	if not (pl:KeyDown( IN_FORWARD ) or pl:KeyDown( IN_BACK )) then
		if (plSpeed > 0) then
			plSpeed = math.Clamp(plSpeed-(600*FT), -plTopSpeed/2, plTopSpeed)
		elseif (plSpeed < 0) then
			plSpeed = math.Clamp(plSpeed+(600*FT), -plTopSpeed/2, plTopSpeed)
		end
	end
	if pl:KeyDown( IN_MOVELEFT ) then
		plTurnAngle=math.NormalizeAngle(plTurnAngle+(plTurnSpeed*FT))
	end
	if pl:KeyDown( IN_MOVERIGHT ) then
		plTurnAngle=math.NormalizeAngle(plTurnAngle-(plTurnSpeed*FT))
	end
	
	pl:SetNWFloat("Speed", plSpeed)
	pl:SetNWFloat("TurnAngle", plTurnAngle)
	
	local MoveVec = Angle(0, plTurnAngle, 0):Forward()*plSpeed
	mv:SetVelocity(MoveVec)
	mv:SetOrigin(pl:GetPos() + MoveVec * FT)
	
	return true
end

function CLASS:OnKeyPress( pl, key )
end
 
function CLASS:OnKeyRelease( pl, key )
end


function CLASS:CalcView( ply, origin, angles, fov )
	
	if ( !ply:Alive() ) then return end
	
	local DistanceAngle = angles:Forward() * - 0.8 + angles:Up() * 0.2
	
	local ret = {}
	ret.origin = origin + DistanceAngle * 350
	
	//ret.angles 		= angles
	//ret.fov 		= fov
	return ret
end
 
player_class.Register( "ProtoTank", CLASS )  
