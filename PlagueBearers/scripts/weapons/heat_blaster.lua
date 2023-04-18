local wt2 = {
  Heat_Blaster_Upgrade1 = "+1 Range",
  Heat_Blaster_Upgrade2 = "+1 Range",
}
for k,v in pairs(wt2) do Weapon_Texts[k] = v end

----- HEAT BLASTER -----
Heat_Blaster = Skill:new{  
	Class = "Prime",
	Icon = "weapons/prime_heat_blaster.png",
	Rarity = 3,
	Explosion = "",
--	LaunchSound = "/weapons/titan_fist",
	Range = 1, -- Tooltip?
	PathSize = 1,
	Damage = 1,
	FireDamage = 1,
	Push = 1, --Mostly for tooltip, but you could turn it off for some unknown reason
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1 Range",  "+1 Range"  },
	UpgradeCost = { 2 , 2 },
	TipImage = StandardTips.Melee,
	LaunchSound = "/weapons/flamethrower"
}

function Heat_Blaster:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for k = 1, self.PathSize do
			local curr = DIR_VECTORS[i]*k + point
			ret:push_back(curr)
			if not Board:IsValid(curr) then  -- AE change or Board:GetTerrain(curr) == TERRAIN_MOUNTAIN 
				break
			end
		end
	end
	
	return ret
end
				
function Heat_Blaster:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local distance = p1:Manhattan(p2)
	local exploding = {}

	for i = 1, distance do
		local curr = p1 + DIR_VECTORS[direction]*(1+distance-i)
		exploding[i] = Board:IsPawnSpace(curr) and (Board:GetPawn(curr):IsFire() or Board:GetPawn(curr):IsAcid())
		local damage = SpaceDamage(curr,0)
		damage.iFire = EFFECT_CREATE
		if i == 1 then 	
			damage.sAnimation = "flamethrower"..distance.."_"..direction 
		end
		ret:AddDamage(damage)
	end

	for i = 1, distance do
		local curr = p1 + DIR_VECTORS[direction]*(1+distance-i)
		local push = direction*self.Push
		local damage = SpaceDamage(curr,0,push)
		if exploding[i] then
			damage.iDamage = damage.iDamage + self.FireDamage
			damage.sAnimation = "ExploAir1"
		end
		damage.iFire = EFFECT_CREATE
		ret:AddDamage(damage)
		ret:AddDelay(0.2)
	end

	return ret
end	

Heat_Blaster_A = Heat_Blaster:new{
	PathSize = 2, 
	Range = 2,
	TipImage = StandardTips.Ranged,
}

Heat_Blaster_B = Heat_Blaster:new{
	PathSize = 2, 
	Range = 2,
	TipImage = StandardTips.Ranged,
}

Heat_Blaster_AB = Heat_Blaster:new{
	PathSize = 3, 
	Range = 3,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,1),
		Target = Point(2,1)
	}
}