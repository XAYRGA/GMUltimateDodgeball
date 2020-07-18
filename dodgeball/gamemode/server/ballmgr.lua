BallMGR = {} -- Ball manager is just our database for balltypes
BallMGR.BallTypes = {}


function BallMGR.AddBallType(type,data)
	print("ADDED TYPE " .. type)
	BallMGR.BallTypes[type] = data
end

local BALL = {}

BALL.Icon = ""
BALL.StrictInit = false -- this defines if you're going to need to set the model and hitbounds specially
function BALL:Think(self)

end
function BALL:Init(self)
	

end
function BALL:Bounce(self,ent)
	self:EmitSound( "Rubber.BulletImpact" )
	self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS)  
 	 local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass( 1 )		

	end
	ent:TakeDamage(10, self:GetOwner())
	--self:TakeDamage(100, self:GetOwner())

end

function BALL:PlayerImpact(self,plr)
	
	plr:EmitSound( "dodgeball/ball_impact" .. math.random(1,2) ..".wav" )
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
BallMGR.AddBallType("default",BALL)
for k,v in pairs(file.Find("dodgeball/gamemode/server/balls/*.lua","LUA")) do
	include("dodgeball/gamemode/server/balls/" .. v)
end