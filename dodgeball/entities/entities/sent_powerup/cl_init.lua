include('shared.lua')
ENT.Sprite = Material( "effects/blueflare1" )

function ENT:Draw()
 	self:DrawModel()

 	local typ = self:GetNWString("TYPE")
 	local tab = GAMEMODE.PowerUps[typ]
 	local tabexist = false
 	local tex = Material("materials/dodgeball/items/default.png")

 	if tab then 
 		tabexist = true 
 	end

 	if tabexist==true then 
 		local ic = tab.icon 
 		if ic then 
 			tex = Material(tab.icon)
 		end 
 	end

	surface.SetDrawColor(Color(255,255,255,math.sin(CurTime()^1.3)*100 + 155))
	surface.SetMaterial(tex)

	cam.Start3D2D( self:LocalToWorld(Vector(20.2,-15,15)), self:LocalToWorldAngles( Angle(0,90,90) )  , 1 )
		surface.DrawTexturedRect(0 ,0, 31, 31 )
	cam.End3D2D()
	cam.Start3D2D( self:LocalToWorld(Vector(-15,-20.2,15)), self:LocalToWorldAngles( Angle(0,0,90) )  , 1 )
		surface.DrawTexturedRect(0 ,0, 31, 31 )
	cam.End3D2D()
	cam.Start3D2D( self:LocalToWorld(Vector(15,20.21,15)), self:LocalToWorldAngles( Angle(0,180,90) )  , 1 )
		surface.DrawTexturedRect(0 ,0, 31, 31 )
	cam.End3D2D()
	cam.Start3D2D( self:LocalToWorld(Vector(-20.2,15,15)), self:LocalToWorldAngles( Angle(0,-90,90) )  , 1 )
		surface.DrawTexturedRect(0 ,0, 31, 31 )
	cam.End3D2D()
end