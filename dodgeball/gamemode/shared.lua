for k,v in pairs (file.Find("dodgeball/gamemode/shared/*.lua","LUA")) do
   MsgN("[D.O.D.G.E]: Loaded shared file: " .. v)
   include("dodgeball/gamemode/shared/" .. v); 
end
print("I LIVE!!!")
--[[---------------------------------------------------------

  This file should contain variables and functions that are 
   the same on both client and server.

  This file will get sent to the client - so don't add 
   anything to this file that you don't want them to be
   able to see.

-----------------------------------------------------------]]


GM.Name 		= "Ultimate Dodgeball"
GM.Author 		= "Freezebug"
GM.Email 		= ""
GM.Website 		= "frostybox.tk"
GM.TeamBased 	= true


--[[---------------------------------------------------------
   Name: gamemode:PlayerHurt( )
   Desc: Called when a player is hurt.
-----------------------------------------------------------]]
function GM:PlayerHurt( player, attacker, healthleft, healthtaken )
end


--[[---------------------------------------------------------
   Name: gamemode:KeyPress( )
   Desc: Player pressed a key (see IN enums)
-----------------------------------------------------------]]
function GM:KeyPress( player, key )
end


--[[---------------------------------------------------------
   Name: gamemode:KeyRelease( )
   Desc: Player released a key (see IN enums)
-----------------------------------------------------------]]
function GM:KeyRelease( player, key )
end


--[[---------------------------------------------------------
   Name: gamemode:PlayerConnect( )
   Desc: Player has connects to the server (hasn't spawned)
-----------------------------------------------------------]]
function GM:PlayerConnect( name, address )

end

--[[---------------------------------------------------------
   Name: gamemode:PlayerAuthed( )
   Desc: Player's STEAMID has been authed
-----------------------------------------------------------]]
function GM:PlayerAuthed( ply, SteamID, UniqueID )
end



--[[---------------------------------------------------------
   Name: gamemode:PropBreak( )
   Desc: Prop has been broken
-----------------------------------------------------------]]
function GM:PropBreak( attacker, prop )
end


--[[---------------------------------------------------------
   Name: gamemode:PhysgunPickup( )
   Desc: Return true if player can pickup entity
-----------------------------------------------------------]]
function GM:PhysgunPickup( ply, ent )
	return false
end


--[[---------------------------------------------------------
   Name: gamemode:PhysgunDrop( )
   Desc: Dropped an entity
-----------------------------------------------------------]]
function GM:PhysgunDrop( ply, ent )
end

--[[---------------------------------------------------------
   Name: gamemode:PlayerShouldTakeDamage
   Return true if this player should take damage from this attacker
-----------------------------------------------------------]]
function GM:PlayerShouldTakeDamage( ply, attacker )
	return true
end

--[[---------------------------------------------------------
   Name: Text to show in the server browser
-----------------------------------------------------------]]
function GM:GetGameDescription()
	return self.Name
end


--[[---------------------------------------------------------
   Name: Saved
-----------------------------------------------------------]]
function GM:Saved()
end


--[[---------------------------------------------------------
   Name: Restored
-----------------------------------------------------------]]
function GM:Restored()
end


--[[---------------------------------------------------------
   Name: EntityRemoved
   Desc: Called right before an entity is removed. Note that this
   isn't going to be totally reliable on the client since the client
   only knows about entities that it has had in its PVS.
-----------------------------------------------------------]]
function GM:EntityRemoved( ent )
end


--[[---------------------------------------------------------
   Name: Tick
   Desc: Like Think except called every tick on both client and server
-----------------------------------------------------------]]
function GM:Tick()
end

--[[---------------------------------------------------------
   Name: OnEntityCreated
   Desc: Called right after the Entity has been made visible to Lua
-----------------------------------------------------------]]
function GM:OnEntityCreated( Ent )
end

--[[---------------------------------------------------------
   Name: gamemode:EntityKeyValue( ent, key, value )
   Desc: Called when an entity has a keyvalue set
	      Returning a string it will override the value
-----------------------------------------------------------]]
function GM:EntityKeyValue( ent, key, value )
end

--[[---------------------------------------------------------
   Name: gamemode:CreateTeams()
   Desc: Note - HAS to be shared.
-----------------------------------------------------------]]
function GM:CreateTeams()

   print("Beginning team creation...")
	-- Don't do this if not teambased. But if it is teambased we
	-- create a few teams here as an example. If you're making a teambased
	-- gamemode you should override this function in your gamemode
	if ( !GAMEMODE.TeamBased ) then return end
	
	TEAM_BLUE = 1
	team.SetUp( TEAM_BLUE, "Blue Balls", Color( 0, 0, 255 ) )
	team.SetSpawnPoint( TEAM_BLUE, "info_player_combine" ) 
	
	TEAM_RED = 2
	team.SetUp( TEAM_RED, "Ball Busters", Color( 255, 0, 0 ) )
	team.SetSpawnPoint( TEAM_RED, "info_player_rebel" ) 
	

	team.SetSpawnPoint( TEAM_SPECTATOR, "worldspawn" ) 

end


--[[---------------------------------------------------------
   Name: gamemode:ShouldCollide( Ent1, Ent2 )
   Desc: This should always return true unless you have 
		  a good reason for it not to.
-----------------------------------------------------------]]
function GM:ShouldCollide( Ent1, Ent2 )
	return true
end


--[[---------------------------------------------------------
   Name: gamemode:Move
   This basically overrides the NOCLIP, PLAYERMOVE movement stuff.
   It's what actually performs the move. 
   Return true to not perform any default movement actions. (completely override)
-----------------------------------------------------------]]
function GM:Move( ply, mv )

end


--[[---------------------------------------------------------
-- Purpose: This is called pre player movement and copies all the data necessary
--          from the player for movement. Copy from the usercmd to move.
-----------------------------------------------------------]]
function GM:SetupMove( ply, mv, cmd )

end

--[[---------------------------------------------------------
   Name: gamemode:FinishMove( player, movedata )
-----------------------------------------------------------]]
function GM:FinishMove( ply, mv )

end

--[[---------------------------------------------------------
   Name: gamemode:FinishMove( player, movedata )
-----------------------------------------------------------]]
function GM:VehicleMove( ply, vehicle, mv )

end

--[[---------------------------------------------------------
	Called after the player's think.
-----------------------------------------------------------]]
function GM:PlayerPostThink( ply ) 

end

--[[---------------------------------------------------------
	A player has started driving an entity
-----------------------------------------------------------]]
function GM:StartEntityDriving( ent, ply ) 

	drive.Start( ply, ent )

end

--[[---------------------------------------------------------
	A player has stopped driving an entity
-----------------------------------------------------------]]
function GM:EndEntityDriving( ent, ply ) 


end

--[[---------------------------------------------------------
	To update the player's animation during a drive
-----------------------------------------------------------]]
function GM:PlayerDriveAnimate( ply ) 

end


--[[---------------------------------------------------------
	The gamemode has been reloaded
-----------------------------------------------------------]]
function GM:OnReloaded() 

end

function GM:PreGamemodeLoaded()
	
end

function GM:OnGamemodeLoaded()
	
end
function GM:PostGamemodeLoaded()
	
end

--
-- Name: GM:OnViewModelChanged
-- Desc: Called when the player changes their weapon to another one - and their viewmodel model changes
-- Arg1: Entity|viewmodel|The viewmodel that is changing
-- Arg2: string|old|The old model
-- Arg3: string|new|The new model
-- Ret1:
--
function GM:OnViewModelChanged( vm, old, new ) 

	local ply = vm:GetOwner()


end