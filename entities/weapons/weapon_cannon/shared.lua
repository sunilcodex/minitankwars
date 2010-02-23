SWEP.Author = "BMCha"
SWEP.Contact = "PM on FP"
SWEP.Purpose = "KABLOOIE"
SWEP.Instructions = "Click to fire"
SWEP.Category = "Tank Armament"
 
//Not sold separately
SWEP.Spawnable = false;
SWEP.AdminSpawnable = false;
 
SWEP.Primary.ClipSize = 10;
SWEP.Primary.DefaultClip = 30;
SWEP.Primary.Automatic = true;
SWEP.Primary.Ammo = "RPG_Round";
 
util.PrecacheSound("MiniTankWars/reload.wav")
util.PrecacheSound("MiniTankWars/cannon1.wav")
 
SWEP.Sound = Sound ("MiniTankWars/cannon1.wav")
SWEP.Damage = 50
SWEP.Spread = 0.02
SWEP.NumBul = 1
SWEP.Delay = 0.35
SWEP.Force = 6
 
function SWEP:Deploy()
	return true
end
 
function SWEP:Holster()
	return true
end
 
function SWEP:Think()
end
 
function SWEP:PrimaryAttack()
 
	self.Weapon:EmitSound ( self.Sound )
	if(SERVER) then
		local BarrelTip = self.Owner.TankEnt.TurretEnt:LookupAttachment("BarrelTip")
		local AttachData = self.Owner.TankEnt.TurretEnt:GetAttachment(BarrelTip)
		
		local shell = ents.Create( "Cannon_Shell" )
		shell:SetPos( AttachData.Pos+AttachData.Ang:Forward()*100 )
		shell:SetAngles(AttachData.Ang)
		shell:SetOwner( self.Owner )
		shell:Spawn()
		shell:GetPhysicsObject():Wake()
		
		local ed = EffectData()
		ed:SetEntity(self.Owner.TankEnt)
		util.Effect("TankFireRing", ed, true, true)
		ed:SetEntity(self.Owner.TankEnt.TurretEnt)
		ed:SetAttachment(BarrelTip)
		util.Effect("TankFire", ed, true, true)
		
		self.Owner.TankEnt:Recoil(100, AttachData.Ang:Forward())
	end
 
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Delay )
	timer.Simple(1, (function() self.Owner.TankEnt.TurretEnt:EmitSound("MiniTankWars/reload.wav", 100, 90) end))
	self:TakePrimaryAmmo(1)
end