AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
	self.Entity:SetModel( "models/props_junk/wood_crate001a.mdl" )
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)

	self.Pwrs = {
		"dodge_auto",
		"dodge_hole",
		"dodge_bomb"
	}
	
	local t = {}
	t.start = self:GetPos()
	t.endpos = self:LocalToWorld(Vector(0,0,-100000)) 
	t.filter = {self,unpack(player.GetAll()),unpack(ents.FindByClass("sent_powerup"))} // Exclude ourselves AND players.
		
	local tr = util.TraceLine(t)
	pos = tr.HitPos
	if tr.HitPos then self:SetPos(tr.HitPos + Vector(0,0,20) ) end

	self.PUType = ""
	local keys = {}
	for k,v in pairs(GAMEMODE.PowerUps) do
		keys[#keys + 1] = k
	end

	self.PowerUp = keys[math.random(1,#keys)]
	self:SetNWString("TYPE",self.PowerUp)
end

function ENT:OnRemove()
end

function ENT:GivePower(player)
	local a = ents.Create("prop_physics")
	a:SetPos(self:GetPos())
	a:SetModel(self:GetModel())
	a:Spawn()
	a:Activate()
	a:Fire("break")

	if GAMEMODE.PowerUps[self.PowerUp].bad==false then 
		player:AddScreenMessage(GAMEMODE.PowerUps[self.PowerUp].name, Color(255,255,255), 5, "none")
	else
		local XTAB = GAMEMODE.Strings.Jeers[player:Team()]
		player:EmitSound(XTAB[math.random(1,#XTAB)])
		player:AddScreenMessage(GAMEMODE.PowerUps[self.PowerUp].name, Color(255,0,0), 5, "none")
	end 
	
	player:AddScreenMessage(GAMEMODE.PowerUps[self.PowerUp].desc, Color(255,255,255), 5, "small")
	GAMEMODE.PowerUps[self.PowerUp].func(player)
end


function ENT:Think()
	self:SetColor(Color(255,255,255,255))
	for k,v in pairs(ents.FindInSphere(self:GetPos(),100)) do
		if v==self then return end 

		if v:IsPlayer() and v:Team()~=TEAM_SPECTATOR and v:Team()~=TEAM_UNASSIGNED then 
			self:GivePower(v)
			self:Remove() 
		end 

		if v:GetClass()==self:GetClass() then 
			v:Remove() 
			
		end
	end
end

function ENT:PhysicsCollide( data, physobj)
end
		
function ENT:Use( activator, caller )
end

function ENT:UpdateTransmitState()	
    return TRANSMIT_ALWAYS 
end