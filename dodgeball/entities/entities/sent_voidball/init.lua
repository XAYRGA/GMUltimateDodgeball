
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
		if self.Owner:Team() == TEAM_BLUE then self:SetColor(Color(0,0,255)) end
		self:SetColor(Color(1,1,1,255))
		self:SetMaterial("models/debugwhite")
		self.BounceCount = 0
		self.Bounced = false
		self.SlTime = 0.8
		
		self.Entity:SetModel( "models/dodgeball/dodgeball.mdl" )
		self.Entity:PhysicsInitSphere( 10, "metal_bouncy" )
		self.Entity.__NPD = true 
	
	
		local phys = self.Entity:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
			phys:SetMass( 50 )			
		end
	
		// Set collision bounds exactly
		self.Entity:SetCollisionBounds( Vector( -13, -13, -13 ), Vector( 13, 13, 13 ) )
		self.Snds = {}
		local x = {}
		x[1] = CreateSound(self,"ambient/energy/whiteflash.wav")
		x[2] = CreateSound(self,"ambient/energy/force_field_loop1.wav")
		x[3] = CreateSound(self,"items/suitcharge1.wav")
		x[4] = CreateSound(self,"ambient/nucleus_electricity.wav")
		for I=1,4 do 
			x[I]:Play()
		end 
		self.Snds = x
	
	
end

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	 local SpawnPos = tr.HitPos + tr.HitNormal * 16
	  local ent = ents.Create( "sent_dodgedall" )
	   ent:SetPos( SpawnPos )
	   ent:Spawn()
	   ent:Activate()
	  // ent:SetOwner( self.Owner )
	return ent
   
end

function ENT:OnRemove()
	for I=1,4 do 
		self.Snds[I]:Stop()
	end
end





function ENT:Think()
	for k,v in pairs(ents.FindInSphere(self:GetPos(),200)) do
		if v~=self	then
			local x = v:GetPhysicsObject()
			if IsValid(x) and not v:IsPlayer() then 
				v:SetPhysicsAttacker(self.Owner)
				x:SetVelocity((self:GetPos() - x:GetPos()) * 2)
				v:TakeDamage(5,self.Owner,self)
			end 
			if v:IsPlayer() and (v:Team()~= self.Owner:Team() == (v~=self.Owner)) then 
				v:SetVelocity((self:GetPos() - v:GetPos())  )
				v:TakeDamage(0.1,self.Owner,self)
			end
		end
		
	end
	self:NextThink(CurTime())
	return true
end



	


  

function ENT:PhysicsCollide( data, physobj)
	local he = data.HitEntity
	local x = self:GetPos()


		local phys = self:GetPhysicsObject()
 
		if phys and phys:IsValid() then
			phys:EnableMotion(false) -- Freezes the object in place.
		end
		if self.Bounced == false then 
			timer.Simple(5,function() self:Remove() end)
		end
	


  self.Bounced = true
end
		

function ENT:Use( activator, caller )
	--[[
	self.Entity:Remove()
	
	if ( activator:IsPlayer() ) then
	  
		activator:Give( "dodge_Ball" )
	    activator:GiveAmmo( 1, "thumper" )
		
	end
	--]]

end

function usereply(self)
end