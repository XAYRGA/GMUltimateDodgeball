
ENT.Health = 500
ENT.Base = "base_anim"
ENT.PType = ""
function ENT:Initialize()
	self:SetModel("models/props_vehicles/van001a.mdl")
	if SERVER then
		self:SetSolid(SOLID_VPHYSICS)
	end
	if !self.PType then print("[POWERUP]: NO BALL TYPE DEFINED, Removing.") self:Remove() end
end

function ENT:StartTouch(E)
	if IsValid(E) and E:IsPlayer() then
		local wep = E:GetActiveWeapon()
		if IsValid(wep) and wep then 
			wep.BallType = self.PType
		end
	end
end





		