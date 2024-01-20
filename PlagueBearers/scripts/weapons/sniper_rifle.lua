local wt2 = {
	Sniper_Rifle_Upgrade1 = "",
	Sniper_Rifle_Upgrade2 = "+1 Damage",
}
for k,v in pairs(wt2) do Weapon_Texts[k] = v end

----- SNIPER RIFLE -----
Sniper_Rifle = TankDefault:new{
	Class = "Brute",
	name = "Sniper Rifle",
	Damage = 1,
    Push = 1,
	PowerCost = 0,
	Icon = "weapons/brute_sniper_rifle.png",
	Scope = 0,
	Upgrades = 2,
	UpgradeCost = { 1,3 },
	LaunchSound = "/weapons/modified_cannons",
	ImpactSound = "/impact/generic/explosion",
	TipImage = StandardTips.Ranged,
	ZoneTargeting = ZONE_DIR,
}

function Sniper_Rifle:GetTargetArea(point)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		local curr = point
		for i = 1, 8 do
			curr = point + DIR_VECTORS[dir]*i
			
			if i ~= 1 then
				ret:push_back(curr)
			end
			
			if Board:IsBlocked(curr, PATH_PROJECTILE) then
				if self.Scope == 0 then
					break
				elseif not (Board:IsBuilding(curr) or Board:GetPawnTeam(curr) == TEAM_PLAYER) then
					break
				end
			end
			
		end
	end
	
	return ret
end

function Sniper_Rifle:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
			
	local target = GetProjectileEnd(p1,p2)
	
	if self.Scope == 1 then
		for i = 1,6 do
			if Board:IsBuilding(target) or Board:GetPawnTeam(target) == TEAM_PLAYER then
				target = GetProjectileEnd(target,target + DIR_VECTORS[direction])
			else
				break
			end
		end
	end
	
	local damage = SpaceDamage(target, self.Damage, direction)
	damage.sAnimation = "explopush1_"..direction
	if Board:IsPawnSpace(target)and not Board:GetPawn(target):IsDamaged() then
		damage.iDamage = damage.iDamage * 2
	end
	ret:AddProjectile(damage,"effects/shot_sniper", NO_DELAY)
	return ret
end

Sniper_Rifle_A = Sniper_Rifle:new{Damage = 1, Scope = 1, UpgradeDescription = "Shoot through buildings and friendly units.",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Building = Point(2,2),
		Target = Point(2,1)
	},
}
Sniper_Rifle_B = Sniper_Rifle:new{Damage = 2, Scope = 0, UpgradeDescription = "Increases damage by 1.",}
Sniper_Rifle_AB = Sniper_Rifle:new{Damage = 2, Scope = 1, 
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Building = Point(2,2),
		Target = Point(2,1)
	},
}
