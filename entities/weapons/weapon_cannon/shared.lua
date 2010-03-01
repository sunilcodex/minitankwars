SWEP.Author = "BMCha"
SWEP.Contact = "PM on FP"
SWEP.Purpose = "KABLOOIE"
SWEP.Instructions = "Click to fire"
SWEP.Category = "Tank Armament"
 
//Not sold separately
SWEP.Spawnable = false;
SWEP.AdminSpawnable = false;

SWEP.Primary.ClipSize = 1337;
SWEP.Primary.DefaultClip = 35;
SWEP.Primary.Automatic = false;
SWEP.Primary.Ammo = "RPG_Round";
 
SWEP.Secondary.ClipSize = -1;
SWEP.Secondary.DefaultClip = -1;
SWEP.Secondary.Automatic = false;
SWEP.Secondary.Ammo = "none";
 
util.PrecacheSound("MiniTankWars/reload.wav")
 
SWEP.Sound = Sound ("MiniTankWars/cannon1.wav")
 
function SWEP:Deploy()
	self.Owner:SetNWFloat("Delay", 2)
	self.Owner:SetNWBool("AP", false)
	return true
end 
 
function SWEP:Holster()
return true
end
 
function SWEP:Think()
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	self.Weapon:EmitSound ( self.Sound )
	if(SERVER) then
		local BarrelTip = self.Owner.TankEnt.TurretEnt:LookupAttachment("BarrelTip")
		self.Owner.TankEnt.TurretEnt:SetPoseParameter("Turret_Elevate", self.Owner.TankEnt.TurretEnt:GetNWFloat("Turret_Elevate"))
		local AttachData = self.Owner.TankEnt.TurretEnt:GetAttachment(BarrelTip)
		
		local shell
		if (self.Owner:GetNWBool("AP", false)==true) then
			shell = ents.Create( "AP_Shell" )
		else
			shell = ents.Create( "Cannon_Shell" )
		end
		shell:SetPos( AttachData.Pos+AttachData.Ang:Forward()*100 )
		shell:SetAngles(AttachData.Ang)
		shell:SetOwner( self.Owner )
		shell:Spawn()
		
		local ed = EffectData()
		ed:SetEntity(self.Owner.TankEnt)
		ed:SetOrigin(self.Owner.TankEnt:GetPos())
		util.Effect("TankFireRing", ed, true, true)
		ed:SetEntity(self.Owner.TankEnt.TurretEnt)
		ed:SetAttachment(BarrelTip)
		ed:SetOrigin(self.Owner.TankEnt.TurretEnt:GetPos())
		util.Effect("TankFire", ed, true, true)
		
		self.Owner.TankEnt:Recoil(100, AttachData.Ang:Forward())
	end
	
	self.Owner:SetNWBool("Reloading", true)
	timer.Simple(self.Owner:GetNWFloat("Delay", 2), function() self.Owner:SetNWBool("Reloading", false) end)
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Owner:GetNWFloat("Delay", 2) )
	if (SERVER) then
	timer.Simple((self.Owner:GetNWFloat("Delay", 2)/2), (function() self.Owner.TankEnt:EmitSound("MiniTankWars/reload.wav", 100, 90/(self.Owner:GetNWFloat("Delay", 2)/2)) end))
	end
	self:TakePrimaryAmmo(1)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	self.Weapon:DefaultReload( ACT_VM_RELOAD ) //animation for reloading
end
 