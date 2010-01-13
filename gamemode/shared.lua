/*
This gamemode is licenced under the MIT License, reproduced below:

Copyright (c) 2010 BMCha

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

GM.Name 	= "MiniTank Deathmatch"
GM.Author 	= "BMCha"
GM.Email 	= ""
GM.Website 	= ""
GM.Help		= "Rack up the most kills"
 
GM.Data = {}
 
DeriveGamemode( "fretta" )
IncludePlayerClasses()
 
GM.TeamBased = true					// Team based game or a Free For All game?
GM.AllowAutoTeam = true
GM.AllowSpectating = true
GM.SecondsBetweenTeamSwitches = 10
GM.GameLength = 15
GM.RoundLimit = 10					// Maximum amount of rounds to be played in round based games
GM.VotingDelay = 5					// Delay between end of game, and vote. if you want to display any extra screens before the vote pops up
 
GM.NoPlayerSuicide = false
GM.NoPlayerDamage = false
GM.NoPlayerSelfDamage = true		// Allow players to hurt themselves?
GM.NoPlayerTeamDamage = true		// Allow team-members to hurt each other?
GM.NoPlayerPlayerDamage = false 	// Allow players to hurt each other?
GM.NoNonPlayerPlayerDamage = true 	// Allow damage from non players (physics, fire etc)
GM.NoPlayerFootsteps = true		// When true, all players have silent footsteps
GM.PlayerCanNoClip = true		// When true, players can use noclip without sv_cheats
GM.TakeFragOnSuicide = false		// -1 frag on suicide
 
GM.MaximumDeathLength = 10			// Player will respawn if death length > this (can be 0 to disable)
GM.MinimumDeathLength = 5			// Player has to be dead for at least this long
GM.AutomaticTeamBalance = false     // Teams will be periodically balanced 
GM.ForceJoinBalancedTeams = false	// Players won't be allowed to join a team if it has more players than another team
GM.RealisticFallDamage = false
GM.AddFragsToTeamScore = true		// Adds player's individual kills to team score (must be team based)
 
GM.NoAutomaticSpawning = false		// Players don't spawn automatically when they die, some other system spawns them
GM.RoundBased = false				// Round based, like CS
GM.RoundLength = 60 * 5					// Round length, in seconds
GM.RoundPreStartTime = 5			// Preperation time before a round starts
GM.RoundPostLength = 5				// Seconds to show the 'x team won!' screen at the end of a round
GM.RoundEndsWhenOneTeamAlive = false	// CS Style rules
 
GM.EnableFreezeCam = true			// TF2 Style Freezecam
GM.DeathLingerTime = 3				// The time between you dying and it going into spectator mode, 0 disables
 
GM.SelectModel = true               // Can players use the playermodel picker in the F1 menu?
GM.SelectColor = false			// Can players modify the colour of their name? (ie.. no teams)
 
GM.PlayerRingSize = 48              // How big are the colored rings under the player's feet (if they are enabled) ?
GM.HudSkin = "SimpleSkin"
 
GM.ValidSpectatorModes = { OBS_MODE_CHASE, OBS_MODE_IN_EYE, OBS_MODE_ROAMING }
GM.ValidSpectatorEntities = { "player" }	// Entities we can spectate
GM.CanOnlySpectateOwnTeam = false // you can only spectate players on your own team

 
TEAM_USA = 1
TEAM_USSR = 2
 
function GM:CreateTeams()
 
	if ( !GAMEMODE.TeamBased ) then return end
 
	team.SetUp( TEAM_USA, "USA", Color( 0, 0, 150 ), true )
	team.SetSpawnPoint( TEAM_USA, { "info_player_start", "info_player_counterterrorist" } )
	team.SetClass( TEAM_USA, { "ProtoTank"}) //, "M4_Sherman", "M1A2_Abrams", "M60_Patton", "M551_Sheridan" } )
	
	team.SetUp( TEAM_USSR, "USSR", Color( 128, 0, 0 ), true )
	team.SetSpawnPoint( TEAM_USSR, { "info_player_start", "info_player_terrorist" } )
	team.SetClass( TEAM_USSR, { "ProtoTank"} ) //, "T34", "T72" } )
 
	team.SetUp( TEAM_SPECTATOR, "Spectators", Color( 200, 200, 200 ), true )
	team.SetSpawnPoint( TEAM_SPECTATOR, { "info_player_start", "info_player_terrorist", "info_player_counterterrorist", "info_player_combine", "info_player_rebel" } ) 
 
end
 