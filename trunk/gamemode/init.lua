/*
MiniTank Wars
Copyright (c) 2010 BMCha
This gamemode is licenced under the MIT License, reproduced in shared.lua
*/

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

// This is called every second to see if we can end the round
function GM:CheckRoundEnd()
 /*
	if ( !GAMEMODE:InRound() ) then return end 
 
	for k,v in pairs( team.GetPlayers( TEAM_HUMAN ) ) do
 
		if v:Frags() >= 10 then
 
		      GAMEMODE:RoundEndWithResult( v )
 
                end
 
        end
 */
end
 
// This is called after a player wins in a free for all
function GM:OnRoundWinner( ply, resulttext )
 
	//ply:AddScore( 1 ) // Let's pretend we have AddScore for brevity's sake
 
end
 
// Called when the round ends
function GM:OnRoundEnd( num )
 /*
       for k,v in pairs( team.GetPlayers( TEAM_HUMAN ) ) do
             v:SetFrags( 0 ) // Reset their frags for next round
       end
 */
end