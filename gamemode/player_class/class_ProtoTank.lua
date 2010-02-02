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
CLASS.WalkSpeed 			= 256
CLASS.CrouchedWalkSpeed 	= 0.3
CLASS.RunSpeed				= 512
CLASS.DuckSpeed				= 0.3
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
	pl:SetNWString("TankName", pl:GetPlayerClassName())
	pl:SetHull( Vector( -33, -65, 0 ), Vector( 33, 52, 80 ) )
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
/*
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
			plSpeed = math.Clamp(plSpeed-(60*FT), -plTopSpeed/2, plTopSpeed)
		elseif (plSpeed < 0) then
			plSpeed = math.Clamp(plSpeed+(60*FT), -plTopSpeed/2, plTopSpeed)
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
end*/

function CLASS:OnKeyPress( pl, key )
end
 
function CLASS:OnKeyRelease( pl, key )
end


function CLASS:CalcView( ply, origin, angles, fov )
	
	if ( !ply:Alive() ) then return end
	
	local DistanceAngle = angles:Forward() * - 0.8 + angles:Up() * 0.2
	
	local ret = {}
	ret.origin = origin + Vector(100,100,0) + DistanceAngle * 350
	
	//ret.angles 		= angles
	//ret.fov 		= fov
	return ret
end
 
player_class.Register( "ProtoTank", CLASS )  
