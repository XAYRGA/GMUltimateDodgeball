Lightning = {}
function Lightning.Zap(target)
	local effectdata = EffectData()
	effectdata:SetStart(target:GetShootPos())
	effectdata:SetOrigin(target:GetShootPos())
	effectdata:SetScale(1)
	effectdata:SetMagnitude(1)
	effectdata:SetScale(3)
	effectdata:SetRadius(1)
	effectdata:SetEntity(target)
	for i = 1, 100 do timer.Simple(1/i, function() util.Effect("TeslaHitBoxes", effectdata, true, true) end) end
	local Zap = math.random(1,9)
	if Zap == 4 then Zap = 3 end
	target:EmitSound("ambient/energy/zap"..Zap..".wav")
end
 
function Lightning.Strike(ori,target)
		local effectdata = EffectData()
		effectdata:SetStart( ori:GetPos()  + Vector(0,0,72)) // not sure if we need a start and origin (endpoint) for this effect, but whatever
		effectdata:SetOrigin( target:GetPos() + Vector(0,0,72))
		effectdata:SetScale( 1 )
		util.Effect( "lightning", effectdata )	
		for I=1,7 do Lightning.Zap(target) end
end
if CLIENT then
EFFECT = {}

EFFECT.Mat = Material( "cable/blue_elec" )

/*---------------------------------------------------------
   Init( data table )
---------------------------------------------------------*/
function EFFECT:Init( data )

	self.StartPos 	= data:GetStart()	
	
	self.EndPos 	= data:GetOrigin()
	self.Dir 		= self.EndPos - self.StartPos
	local vOffset = self.EndPos
	
	self.fDelta = 3
	
	
	self.Entity:SetRenderBoundsWS( self.StartPos, self.EndPos )
	
	self.TracerTime = math.Rand( 0.7, 1.0 )
	self.Length = math.Rand( 0.1, 0.15 )
	
	self.DieTime = CurTime() + self.TracerTime
end

/*---------------------------------------------------------
   THINK
---------------------------------------------------------*/
function EFFECT:Think( )

	if ( CurTime() > self.DieTime ) then
		return false 
	end
	
	return true

end

/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render( )
	self.fDelta = math.Max( self.fDelta - 0.5, 0)
			
	render.SetMaterial( self.Mat )
	
	render.DrawBeam( self.EndPos, 		
					 self.StartPos,
					 8 + self.fDelta * 128,
					 0,					
					 0,				
					 Color( 255, 0, 0, 255 ) )
					 
end

	effects.Register(EFFECT,"lightning")
end