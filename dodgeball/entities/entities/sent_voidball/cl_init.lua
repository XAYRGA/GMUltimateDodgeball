include('shared.lua')

function ENT:Initialize()
end

function ENT:Think()

end
ENT.Sprite = Material( "effects/blueflare1" )
function ENT:Draw()


        render.SetMaterial( self.Sprite )
        render.DrawSprite( self:GetPos(), 25, 25, Color( 25, 255, 255, 255 ) )

        		local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then
		local r, g, b, a = self:GetColor()
		dlight.Pos = self:GetPos()
		dlight.r = 25
		dlight.g = 255
		dlight.b = 255
		dlight.Brightness = 1
		dlight.Size = 2048
		dlight.Decay = 2560
		dlight.DieTime = CurTime() + 1
        dlight.Style = 1
	end
	cam.Start2D()
	local spos = self:GetPos():ToScreen()

	local dist_mult = - math.Clamp(self:GetPos():Distance(LocalPlayer():GetPos()) / 1000, 0, 1) + 1
	//	print()
		DrawSunbeams(
			0,
			0.1,
			0.5,
			spos.x / ScrW(),
			spos.y / ScrH()
		)
	cam.End2D()

	self.Entity:DrawModel()
	
end


