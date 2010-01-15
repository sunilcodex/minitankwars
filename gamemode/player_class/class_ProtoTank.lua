/*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in shared.lua
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
 
	pl:Give( "weapon_pistol" )
	pl:GiveAmmo( 255,	"Pistol", 		true )
 
end
 
function CLASS:OnSpawn( pl )
	//pl:SetScale(0,0,0)
	local TankEnt = ents.Create( "ProtoTank" )
	TankEnt:SetPos(pl:GetPos())
	TankEnt:SetAngles(pl:GetAngles())	
	TankEnt:Spawn()
	TankEnt:SetParent(pl)	
	TankEnt:SetAngles(TankEnt:GetAngles()+Angle(0,180,0))
	TankEnt:SetPlayerModel(pl:GetModel())
	TankEnt:SetMyPlayer(pl)
	pl:SetPos(pl:GetPos()+Vector(0,0,200))
	pl:DrawShadow(false)
	pl:SetColor( Color(0,0,0,100) )
	pl.TankEnt = TankEnt
end
 
function CLASS:OnDeath( pl, attacker, dmginfo )
end
 
function CLASS:Think( pl )
end
 
function CLASS:Move( pl, mv )
end
 
function CLASS:OnKeyPress( pl, key )
end
 
function CLASS:OnKeyRelease( pl, key )
end

/*
function CLASS:ShouldDrawLocalPlayer(ply)  //don't show the player themselves, not that it really matters, as they're invisible anyway, and the visuals are done by an attached SENT
    return true
end  */
 
player_class.Register( "ProtoTank", CLASS )  