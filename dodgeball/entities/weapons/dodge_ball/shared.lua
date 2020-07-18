


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
SWEP.PrintName = "Dodge Ball"                      
SWEP.Author = ""                         
SWEP.Spawnable = true                              
SWEP.AutoSwitchFrom = false                       
SWEP.FiresUnderwater = true                    
SWEP.Weight = 5                                   
SWEP.DrawCrosshair = false                       
SWEP.Category = "GMod Dodgeball"                     
SWEP.SlotPos = 1                                  
SWEP.DrawAmmo = true                               
SWEP.Instructions = "Click to throw!"          
SWEP.Delay = 1 




 
SWEP.Primary.ClipSize		= 900
SWEP.Primary.DefaultClip	= 900
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "thumper"
SWEP.Primary.Delay          = .8

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Timer = CurTime()
SWEP.BallType = "default"
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
		BallMGR.BallTypes[self.BallType]:WeaponThink(self)
	end
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
	local Db = ents.Create( "sent_DodgeBall" )
	BallMGR.BallTypes[self.BallType]:WeaponThrow(self,Db)
	Db.type = self.BallType
	if ( !Db:IsValid() ) then return end
	Db:SetPos( self.Owner:GetShootPos() + self.Owner:GetAimVector() * 7 )
	Db:SetAngles(self.Owner:GetAngles())
	
	Db:SetOwner(self.Owner)
	Db:SetPhysicsAttacker(self.Owner)
	Db:Spawn()
	Db:Activate()
	
	local phys = Db:GetPhysicsObject()
	if !phys:IsValid() or (phys == nil) then return end
	
	phys:SetVelocity( self.Owner:GetAimVector() * 5000 )
	phys:AddAngleVelocity(Vector(0, 500, 0))

end
   end

function SWEP:SecondaryAttack()

end