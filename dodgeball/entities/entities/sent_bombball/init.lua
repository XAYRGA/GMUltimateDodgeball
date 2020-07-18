
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
		if self.Owner:Team() == TEAM_BLUE then self:SetColor(Color(0,0,255)) end

		self.BounceCount = 0
		self.Bounced = false
		self.SlTime = 0.8
		self.BC = 0
		self.Swi = 1
		self.LBT = CurTime()
		self.ET = true
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


function changeweight (self)
 if self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS) then 
  local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass( 1 )		
	end
end



end

function ENT:Think()
	if self.Bounced == true then 
		if self.LBT < CurTime() then 
		
					if self.Swi == 1 then 
						self:EmitSound("buttons/button17.wav")
						self:SetColor(Color(255,255,255))
						self.Swi = 2
				elseif self.Swi == 2 then 
						self:EmitSound("buttons/button17.wav")
						self:SetColor(Color(1,1,1))
						self.Swi = 1
					end
					self.ET = false
					self.SlTime = self.SlTime - 0.1
					self.BC = self.BC + 1
					if self.BC == 20 then 
						local explosive = ents.Create( "env_explosion" )
            			explosive:SetPos( self:GetPos() )
            			explosive:Fire("addoutput","spawnflags 64")
            			explosive:SetOwner( self.Owner )
            			explosive:Spawn()
            			explosive:SetKeyValue( "iMagnitude", "200" )
	            		explosive:Fire( "Explode", 0, 0 )
    	        		self:EmitSound( "ambient/explosions/explode_4.wav" )
						self:Remove()
						return 
					end
						self.LBT = CurTime() + self.SlTime

				end
				
			
	end
	self:NextThink(CurTime() + 0.05)
	return true 
end



	


  

function ENT:PhysicsCollide( data, physobj)
	local he = data.HitEntity
	local x = self:GetPos()
	if he~=game.GetWorld() then 
		self:SetParent(he)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetPos(x)
	else

		local phys = self:GetPhysicsObject()
 
		if phys and phys:IsValid() then
			phys:EnableMotion(false) -- Freezes the object in place.
		end

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