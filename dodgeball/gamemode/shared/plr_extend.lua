
local meta = FindMetaTable( "Player" )
if (!meta) then return end



--[[---------------------------------------------------------
	This table will persist between client deaths and reconnects
-----------------------------------------------------------]]
function meta:UniqueIDTable( key )

	local id = 0
	if ( SERVER ) then id = self:UniqueID() end
	
	g_UniqueIDTable[ id ] = g_UniqueIDTable[ id ]  or {}
	g_UniqueIDTable[ id ][ key ] = g_UniqueIDTable[ id ][ key ] or {}
	
	return g_UniqueIDTable[ id ][ key ]

end

--[[---------------------------------------------------------
	Player Eye Trace
-----------------------------------------------------------]]
function meta:GetEyeTrace()

	if ( self.LastPlayerTrace == CurTime() ) then
		return self.PlayerTrace
	end

	self.PlayerTrace = util.TraceLine( util.GetPlayerTrace( self ) )
	self.LastPlayerTrace = CurTime()
	
	return self.PlayerTrace

end

--[[---------------------------------------------------------
	GetEyeTraceIgnoreCursor
	Like GetEyeTrace but doesn't use the cursor aim vector..
-----------------------------------------------------------]]
function meta:GetEyeTraceNoCursor()

	if ( self:GetTable().LastPlayerAimTrace == CurTime() ) then
		return self:GetTable().PlayerAimTrace
	end

	-- Use the players eye angles rather than their aim vector..
	local fwd = self:EyeAngles():Forward()

	self:GetTable().PlayerAimTrace = util.TraceLine( util.GetPlayerTrace( self, fwd ) )
	self:GetTable().LastPlayertAimTrace = CurTime()
	
	return self:GetTable().PlayerAimTrace

end
