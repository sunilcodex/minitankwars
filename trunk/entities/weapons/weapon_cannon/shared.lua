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
 
function SWEP:PrimaryAttack() //when +attack1 happens
 
	local eyetrace = self.Owner:GetEyeTrace();
	// this gets where you are looking. The SWep is making an explosion where you are LOOKING, right?
 
	self.Weapon:EmitSound ( self.Sound )
	// this makes the sound, which I specified earlier in the code
 
	local explode = ents.Create( "env_explosion" ) //creates the explosion
	explode:SetPos( eyetrace.HitPos ) //this creates the explosion where you were looking
	explode:SetOwner( self.Owner ) // this sets you as the person who made the explosion
	explode:Spawn() //this actually spawns the explosion
	explode:SetKeyValue( "iMagnitude", "500" ) //the magnitude
	explode:Fire( "Explode", 0, 0 )	
	
	if(SERVER) then
		self.Owner.TankEnt:Recoil(100, (eyetrace.HitPos-eyetrace.StartPos):Normalize())
	end
 
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Delay )
	timer.Simple(1, (function() self.Owner.TankEnt.TurretEnt:EmitSound("MiniTankWars/reload.wav", 100, 90) end))
	self:TakePrimaryAmmo(1)
end