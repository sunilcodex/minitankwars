/*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in shared.lua
------------------------
init.lua
	-Gamemode serverside init
*/

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_hud.lua" )
AddCSLuaFile('cl_gmchanger.lua')
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function GM:Initialize()
	timer.Simple(PowerupSpawn(), 10)
end


PowerupEnts = {
"Powerup_SpeedBoost",
}
function PowerupSpawn()
	local PU = ents.Create(table.Random(PowerupEnts)) 
	PU:SetPos(Vector(0,0,1000))
	PU:SetAngles(Angle(math.random(60)-30, math.random(60)-30, math.random(359)))
	PU:Spawn()
	timer.Simple(PowerupSpawn(), 10)
end

// This is called every second to see if we can end the round
function GM:CheckRoundEnd()
 /*
	if ( !GAMEMODE:InRound() ) then return end 
 
		if team.GetScore(TEAM_USA) >= 50 then
			GAMEMODE:RoundEndWithResult( TEAM_USA )
		elseif team.GetScore(TEAM_USSR) >= 50 then
			GAMEMODE:RoundEndWithResult(TEAM_USSR)
		end
    end
 */
end
 
// This is called after a player wins in a free for all
function GM:OnRoundWinner( pl, resulttext )
 
	//pl:AddScore( 1 ) // Let's pretend we have AddScore for brevity's sake
 
end
 
// Called when the round ends
function GM:OnRoundEnd( num )
 /*
       for k,v in pairs( team.GetPlayers( TEAM_HUMAN ) ) do
             v:SetFrags( 0 ) // Reset their frags for next round
       end
 */
end