
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
	if !self.type then self.type = "default" end
		self.BounceCount = 0
		self.Bounced = false

	if BallMGR.BallTypes[self.type].StrictInit == false then

		self.Entity:SetModel( "models/dodgeball/dodgeball.mdl" )
		self.Entity:PhysicsInitSphere( 10, "metal_bouncy" )
	
	
	
		local phys = self.Entity:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
			phys:SetMass( 250 )			
		end
	
		// Set collision bounds exactly
		self.Entity:SetCollisionBounds( Vector( -13, -13, -13 ), Vector( 13, 13, 13 ) )
	end
	BallMGR.BallTypes[self.type]:Init(self)
end

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	 local SpawnPos = tr.HitPos + tr.HitNormal * 16
	  local ent = ents.Create( "sent_DodgeBall" )
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

	BallMGR.BallTypes[self.type]:Think(self)

end
  

function ENT:PhysicsCollide( data, physobj)
self.BounceCount = self.BounceCount + 1
if self.BounceCount > 5 then  BallMGR.BallTypes[self.type]:RemFunc(self) end

self:SetVelocity(-self:GetVelocity() * 0.7)
      

  
  local Ent = data.HitEntity
  BallMGR.BallTypes[self.type]:Bounce(self,Ent)
  if Ent:IsPlayer() then
  		BallMGR.BallTypes[self.type]:PlayerImpact(self,Ent)
  end

  self.Entity:SetOwner(NUL)
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