
local meta = FindMetaTable( "Player" )
if (!meta) then return end

local GetRagdollEntity = meta.GetRagdollEntity

// In this file we're adding functions to the player meta table.
// This means you'll be able to call functions here straight from the player object
// You can even override already existing functions.

local mp_keepragdolls = GetConVar( "mp_keepragdolls" )

function meta:GetRagdollEntity()

	if ( mp_keepragdolls:GetBool() ) then

		return self:GetNetworkedEntity( "m_hRagdollEntity" )

	end

	return GetRagdollEntity( self )

end

