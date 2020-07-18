// U WOT? Serverside code?
// Ah shut up :|

GM.PowerUps = {

	voidball = {
		name = "Void dodgeball",
		desc = "Show them who's spacial plain it is!",
		icon = "materials/dodgeball/items/voidball.png",
		bad = false,
		func = function(P)
			P:Give("dodge_hole")
			P:SelectWeapon("dodge_hole")
		end,

		

	},
	bombball = {
		name = "Bomb Dodgeball",
		desc = "Fire a timed dodgeball explosive!",
		icon = "materials/dodgeball/items/bombball.png",
		bad = false,
		func = function(P)
			P:Give("dodge_bomb")
			P:SelectWeapon("dodge_bomb")
		end,
	 
		

	},

	autoball = {
		name = "Auto Dodgeball",
		desc = "Fire 20 balls at a rapid rate!",
		icon = "materials/dodgeball/items/autoball.png",
		bad = false,
		func = function(P)

			P:Give("dodge_auto")
			P:SelectWeapon("dodge_auto")
		end,
	
	

	},

	speedy = {
		name = "Speed boost!",
		desc = "10 second speed boost!",

		icon = nil,
		bad = false,
		func = function(P)
			P:SetWalkSpeed(500)
			P:SetRunSpeed(500)
			timer.Simple(10,function()
				P:SetWalkSpeed(350)
				P:SetRunSpeed(350)

			end)

		end,
		},

		pain = {
			name = "Stepped on a nail",
			desc = "How unfortunate...",

			icon = nil,
			bad = true,
			func = function(P)
				P:TakeDamage(50,P,P)
			end,
	
	

		},

		health = {
			name = "200 Health",
			desc = "Survive two hits before being killed!",
			icon = "materials/dodgeball/items/health.png",
			bad = false,
			func = function(P)
				P:SetHealth(200)
			end,
	
	

		},
		up = {
			name = "What.",
			desc = "Going up?",
			icon = nil,
			bad = true,
			func = function(P)
				P:SetVelocity(Vector(0,0,5000))
			end,
	
	

		},
		slow = {
			name = "Snailmail",
			desc = "Used AOL ( 5 seconds )",
			icon = nil,
			bad = true,
			func = function(P)
				P:SetWalkSpeed(200)
				P:SetRunSpeed(200)
				timer.Simple(5,function()
					P:SetWalkSpeed(350)
					P:SetRunSpeed(350)

				end)
			end,
	
	

		},

		invis = {
			name = "Invisibility",
			desc = "Can't see you! (Lasts 15 seconds)",
			icon = nil,
			bad = false,
			func = function(P)
				local ply = P
				local visibility = 0
					ply:DrawShadow( false )
					ply:SetMaterial( "models/effects/vol_light001" )
					ply:SetRenderMode( RENDERMODE_TRANSALPHA )
					ply:Fire( "alpha", visibility, 0 )
				

					if IsValid( ply:GetActiveWeapon() ) then
						ply:GetActiveWeapon():SetRenderMode( RENDERMODE_TRANSALPHA )
						ply:GetActiveWeapon():Fire( "alpha", visibility, 0 )
						ply:GetActiveWeapon():SetMaterial( "models/effects/vol_light001" )
						if ply:GetActiveWeapon():GetClass() == "gmod_tool" then
							ply:DrawWorldModel( false ) -- tool gun has problems
						else
							ply:DrawWorldModel( true )
						end
					end
					timer.Simple(15,function()
						ply:DrawShadow( true )
						ply:SetMaterial( "" )
						ply:SetRenderMode( RENDERMODE_NORMAL )
						ply:Fire( "alpha", 255, 0 )
						local activeWeapon = ply:GetActiveWeapon()
						if IsValid( activeWeapon ) then
							activeWeapon:SetRenderMode( RENDERMODE_NORMAL )
							activeWeapon:Fire( "alpha", 255, 0 )
							activeWeapon:SetMaterial( "" )
						end
					end)
			end,
	
	

		},
}