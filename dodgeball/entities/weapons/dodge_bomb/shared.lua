if (SERVER) then
	function SWEP:Deploy()
		self.Owner:DrawViewModel( false )
	end
	SWEP.HoldType			= "melee"
end

SWEP.AdminSpawnable = true                       
SWEP.ViewModelFOV = 90                   
SWEP.ViewModel = ""     
SWEP.WorldModel = "models/weapons/w_dodgeball.mdl"   
SWEP.AutoSwitchTo = true                           
SWEP.Slot = 1                                    
SWEP.HoldType = "melee"                         
SWEP.PrintName = "Bomb Dodgeball"                      
SWEP.Author = ""                         
SWEP.Spawnable = true                              
SWEP.AutoSwitchFrom = true                     
SWEP.FiresUnderwater = true                    
SWEP.Weight = 5                                   
SWEP.DrawCrosshair = false                       
SWEP.Category = "GMod Dodgeball"                     
SWEP.SlotPos = 1                                  
SWEP.DrawAmmo = true                               
SWEP.Instructions = "Click to throw!"          
SWEP.Delay = 0.2
SWEP.Throws = 1

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 900
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "adb"
SWEP.Primary.Delay          = .05

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Timer = CurTime()

local ShootSound = Sound( "weapons/slam/throw.wav" )

function SWEP:Initialize()
	self:SetWeaponHoldType( self.HoldType )
	self.LastFire =  CurTime()
end


function SWEP:Holster()
	for k,v in pairs(player.GetAll()) do
		v:SetNWFloat("DodgeBall",0)
	end
	return true
end

function SWEP:Think()
	if SERVER then 

	end
	if self.Owner:Team() == TEAM_BLUE then self:SetColor(Color(0,50,255)) end
end

/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
	if CurTime() > self.LastFire then else return false end
	self.LastFire = CurTime() + self.Delay
    self.Owner:SetAnimation(PLAYER_ATTACK1)		
 
    self:SetWeaponHoldType( self.HoldType )
	self.Owner:EmitSound( ShootSound, 100, math.random(100,110) )

	if SERVER then 
		local Db = ents.Create( "sent_bombball" )
		if ( !Db:IsValid() ) then return end
		Db:SetPos( self.Owner:GetShootPos() + self.Owner:GetAimVector() * 7 )
		Db:SetAngles(self.Owner:GetAngles())
		
		Db:SetOwner(self.Owner)
		Db:SetPhysicsAttacker(self.Owner)
		Db.BounceCount = 3 // bounce twice, prevent spam
		
		local player = self.Owner
		timer.Simple(0.05, function()
			Db:Spawn()
			Db:Activate()
			
			local phys = Db:GetPhysicsObject()
			if !phys:IsValid() or (phys == nil) then return end
			
			phys:SetVelocity(player:GetAimVector() * 2000)
			phys:AddAngleVelocity(Vector(0, 50, 0))

			self.Throws = self.Throws - 1
			if self.Throws == 0 then player:SelectWeapon("dodge_ball") self:Remove() end 
		end, player)
	end
end

function SWEP:SecondaryAttack()

end