local BALL = {}
BALL.StrictInit = false -- this defines if you're going to need to set the model and hitbounds specially
BALL.Icon = ""
function BALL:Think(self)

end
function BALL:Init(self)
	self:Ignite(5,1)

end
function BALL:Bounce(self)
	self:EmitSound( "Rubber.BulletImpact" )
	self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS)  
 	 local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass( 1 )		
	end

end

function BALL:PlayerImpact(self,plr)
	
	plr:EmitSound( "dodgeball/ball_impact" .. math.random(1,2) ..".wav" )
	plr:Ignite(10,200)
	

end

function BALL:WeaponThink(self)

	

end

function BALL:WeaponThrow(self,ball) -- THIS IS CALLED RIGHT BEFORE THE INIT
									 -- GREAT WAY TO PASS YOUR TYPE
end

function BALL:RemFunc(self)

	self:Remove()

end
BallMGR.AddBallType("fire",BALL)
--ambient\machines\combine_shield_loop3.wav
