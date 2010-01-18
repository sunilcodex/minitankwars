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
end
 
function CLASS:OnSpawn( pl )
	local TankEnt = ents.Create( "ProtoTank" )
	TankEnt:SetPos(pl:GetPos())
	TankEnt:SetAngles(pl:GetAngles())	
	TankEnt:Spawn()
	TankEnt:SetParent(pl)	
	TankEnt:SetAngles(TankEnt:GetAngles())
	TankEnt:SetPlayerModel(pl:GetModel())
	TankEnt:SetMyPlayer(pl)
	pl:SetPos(pl:GetPos()+Vector(0,0,200))
	pl:DrawShadow(false)
	pl:SetColor( Color(0,0,0,0) )
	pl.TankEnt = TankEnt
	/*---------------------------------------------
			Tank Differentiating Variables
	---------------------------------------------*/
		pl.TopSpeed=40  //-un/sec
		pl.TurnSpeed= 45  //-Degrees/sec
		pl.TurnAngle = pl:GetAngles().y
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
	if pl:KeyDown( IN_FORWARD ) then
		GO
	end
end
*/
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