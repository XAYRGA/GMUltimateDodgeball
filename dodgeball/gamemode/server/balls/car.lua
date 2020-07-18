local BALL = {}
BALL.Icon = ""
BALL.StrictInit = true -- this defines if you're going to need to set the model and hitbounds specially
function BALL:Think(self)
	self:SetLocalAngularVelocity( -self:GetLocalAngularVelocity( ) )
	self.thinks = self.thinks + 1
	if self.thinks > 50 then self:Remove() end
end
function BALL:Init(self)
	self:EmitSound("dodgeball/car.wav",400)
	self:SetModel("models/props_vehicles/van001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
		local phys = self.Entity:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
			phys:SetMass( 500 )			
		end
		self.thinks = 0
		// Set collision bounds exactly
	

end
function BALL:Bounce(self)
	self:EmitSound("vehicles/v8/vehicle_impact_heavy" .. math.random(1,4) .. ".wav",400)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS)  
 	 local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass( 500 )		
	end

end

function BALL:PlayerImpact(self,plr)
	
		plr:TakeDamage(100, self:GetOwner())

end

function BALL:WeaponThink(self)

	

end

function BALL:WeaponThrow(self,ball) -- THIS IS CALLED RIGHT BEFORE THE INIT
									 -- GREAT WAY TO PASS YOUR TYPE
end

function BALL:RemFunc(self)

	self:Remove()

end
BallMGR.AddBallType("car",BALL)
--
