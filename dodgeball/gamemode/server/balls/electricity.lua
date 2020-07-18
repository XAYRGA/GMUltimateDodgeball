local BALL = {}
BALL.Icon = ""
BALL.StrictInit = false -- this defines if you're going to need to set the model and hitbounds specially
function BALL:Think(self)

end
function BALL:Init(self)
	self.ZapSnd = CreateSound(self,"ambient/machines/combine_shield_loop3.wav")
	self.ZapSnd:Play()
	self.ZapSnd:ChangePitch( 255, 0 ) 
	self.ZapSnd:ChangePitch( 50, 2.5 ) 
	util.SpriteTrail(self, 0, Color(0,0,255), false, 15, 1, 4, 1/(15+1)*0.5, "trails/plasma.vmt")
 
 

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
	
	
		local selplr = plr
	for k,v in pairs(ents.FindInSphere(self:GetPos(),500)) do
		if v:IsPlayer() and v~=plr then selplr = v break end		
	end
	Lightning.Strike(plr,selplr)
	plr:TakeDamage(100, self:GetOwner())
	selplr:TakeDamage(100, self:GetOwner())


end

function BALL:WeaponThink(self)

	

end

function BALL:WeaponThrow(self,ball) -- THIS IS CALLED RIGHT BEFORE THE INIT
									 -- GREAT WAY TO PASS YOUR TYPE
end

function BALL:RemFunc(self)
	self.ZapSnd:Stop()
	self.ZapSnd = nil
	self:Remove()

end
BallMGR.AddBallType("electro",BALL)
--
