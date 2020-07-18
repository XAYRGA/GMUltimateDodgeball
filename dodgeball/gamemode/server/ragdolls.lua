
local meta = FindMetaTable( "Player" )
if (!meta) then return end

local CreateRagdoll		= meta.CreateRagdoll
local GetRagdollEntity	= meta.GetRagdollEntity

// In this file we're adding functions to the player meta table.
// This means you'll be able to call functions here straight from the player object
// You can even override already existing functions.

local mp_keepragdolls = GetConVar( "mp_keepragdolls" )

local function PlayerDeath( ply, attacker, dmginfo )
	ply:CreateRagdoll()
	print(ply:GetRagdollEntity())
	if ( ply:GetRagdollEntity() and ply:GetRagdollEntity():IsValid() ) then

		ply:SpectateEntity( ply.m_hRagdollEntity )
		ply:Spectate( OBS_MODE_CHASE )
	
	end

end

hook.Add( "PlayerDeath", "PlayerDeath", PlayerDeath )

local function RemoveRagdollEntity( ply )

	if ( ply.m_hRagdollEntity && ply.m_hRagdollEntity:IsValid() ) then

		ply.m_hRagdollEntity:Remove()
		ply.m_hRagdollEntity = nil

	end

end

hook.Add( "PlayerSpawn", "RemoveRagdollEntity", RemoveRagdollEntity )
hook.Add( "PlayerDisconnected", "RemoveRagdollEntity", RemoveRagdollEntity )

function meta:CreateRagdoll()

	if ( mp_keepragdolls:GetBool() ) then

		local Ent = self:GetRagdollEntity()
		if ( Ent && Ent:IsValid() ) then Ent:Remove() end

		RemoveRagdollEntity( self )

		local Data = duplicator.CopyEntTable( self )

		Ent = ents.Create( "prop_ragdoll" )
			duplicator.DoGeneric( Ent, Data )
		Ent:Spawn()

		Ent.CanConstrain	= false
		Ent.CanTool			= false
		Ent.GravGunPunt		= false
		Ent.PhysgunDisabled	= true

		local Vel = self:GetVelocity()

		local iNumPhysObjects = Ent:GetPhysicsObjectCount()
		for Bone = 0, iNumPhysObjects-1 do

			local PhysObj = Ent:GetPhysicsObjectNum( Bone )
			if ( PhysObj:IsValid() ) then

				local Pos, Ang = self:GetBonePosition( Ent:TranslatePhysBoneToBone( Bone ) )
				PhysObj:SetPos( Pos )
				PhysObj:SetAngles( Ang )
				PhysObj:AddVelocity( Vel )

			end

		end

		self:SetNetworkedEntity( "m_hRagdollEntity", Ent )
		self.m_hRagdollEntity = Ent

		return

	end

	CreateRagdoll( self )

end

function meta:GetRagdollEntity()

	if ( mp_keepragdolls:GetBool() ) then

		return self:GetNetworkedEntity( "m_hRagdollEntity" )

	end

	return GetRagdollEntity( self )

end

local meta = FindMetaTable( "NPC" )
if (!meta) then return end

// In this file we're adding functions to the NPC meta table.
// This means you'll be able to call functions here straight from the NPC object
// You can even override already existing functions.

local GetRagdollEntities = {}

local HasRagdollGibs = {

	"npc_antlion_worker",
	"npc_clawscanner",
	"npc_cscanner",
	"npc_rollermine",
	"npc_manhack",
	"npc_strider",
	"npc_turret_floor",
	"npc_zombie"

}

local function RemoveRagdollEntity()

	local maxnpcs = server_settings.Int( "sbox_maxnpcs", 1 )

	if ( GetRagdollEntities && #GetRagdollEntities >= maxnpcs ) then

		local Ent = GetRagdollEntities[ 1 ]

		if ( !ValidEntity( Ent ) ) then return end

		Ent:Remove()
		Ent = nil

		table.remove( GetRagdollEntities, 1 )

	end

end

local function CreateRagdoll( victim, killer, weapon )

	if ( !GetConVarBoolean( "ai_keepragdolls" ) ) then return end
	if ( SinglePlayer() ) then return end
	if ( !IsValid(victim ) ) then return end
	if ( table.HasValue( HasRagdollGibs, victim:GetClass() ) ) then return end
	print("Ragdoll1")
	RemoveRagdollEntity()

	local Data = duplicator.CopyEntTable( victim )

	Ent = ents.Create( "prop_ragdoll" )
		duplicator.DoGeneric( Ent, Data )
		victim:SetColor( color_transparent )
		victim:SetNoDraw( true )
	Ent:Spawn()

	GAMEMODE:CreateEntityRagdoll( victim, Ent )

	local Vel = victim:GetVelocity()

	local iNumPhysObjects = Ent:GetPhysicsObjectCount()
	for Bone = 0, iNumPhysObjects-1 do

		local PhysObj = Ent:GetPhysicsObjectNum( Bone )
		if ( PhysObj:IsValid() ) then

			local Pos, Ang = victim:GetBonePosition( Ent:TranslatePhysBoneToBone( Bone ) )
			PhysObj:SetPos( Pos )
			PhysObj:SetAngles( Ang )
			PhysObj:AddVelocity( Vel )

		end

	end

	table.insert( GetRagdollEntities, Ent )

	victim:Remove()

end

hook.Add( "OnNPCKilled", "NPC.CreateRagdoll", CreateRagdoll )