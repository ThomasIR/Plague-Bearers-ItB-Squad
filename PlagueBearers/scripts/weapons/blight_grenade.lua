local wt2 = {
	Blight_Grenade_Upgrade1 = "Any Direction",
	Blight_Grenade_Upgrade2 = "+4 Area",
}
for k,v in pairs(wt2) do Weapon_Texts[k] = v end

----- BLIGHT GRENADE -----
Blight_Grenade = LineArtillery:new{
	Class = "Ranged",
    name = "Blight Grenade",
	Icon = "weapons/ranged_blight_grenade.png",
	TwoClick = true,
	AnyDir = false,
	BigSize = 0,
	PowerCost = 0,
	Damage = 0,
	Upgrades = 2,
	UpgradeCost = {1,3},
	LaunchSound = "/weapons/acid_shot",
	ImpactSound = "/impact/generic/acid_canister",
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2,1),
		Enemy2 = Point(2,0),
		Enemy3 = Point(1,1),
		Second_Click = Point(3,1),
	},
}

function Blight_Grenade:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2,0)
	ret:AddDamage(damage)
	return ret
end

function Blight_Grenade:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	if not self.AnyDir then
		local dir = GetDirection(p2 - p1)
		ret:push_back(p2 + DIR_VECTORS[(dir - 1) % 4])
		ret:push_back(p2 + DIR_VECTORS[(dir + 1) % 4])
		return ret
	end
	
	for dir = DIR_START, DIR_END do
		ret:push_back(p2 + DIR_VECTORS[dir])
	end
	return ret
end

function Blight_Grenade:GetFinalEffect(p1,p2,p3)
	local ret = SkillEffect()
	direction = GetDirection(p2 - p1)
	direction2 = GetDirection(p3 - p2)

	if self.BigSize == 1 then
		local damage = SpaceDamage(p2, 0)
		damage.iAcid = 1
		damage.sAnimation = "ExploAcid1"
		ret:AddArtillery(damage, "advanced/effects/shotup_swapother.png")

		for dir = DIR_START, DIR_END do
		    local p4 = p2 + DIR_VECTORS[dir]
		    if Board:IsValid(p4) then
				damage.loc = p4
				ret:AddDamage(damage)
			end
		end
		
		damage = SpaceDamage(p2 + DIR_VECTORS[direction2], self.Damage, direction2)
		damage.iAcid = 1
	    damage.sAnimation = "airpush_"..direction2
		ret:AddDamage(damage)
		ret:AddDelay(0.2)

		damage.loc = p2
		ret:AddDamage(damage)

		for dir = DIR_START, DIR_END do
		    local p4 = p2 + DIR_VECTORS[dir]
		    if dir ~= direction2 and p4 ~= p2 - DIR_VECTORS[direction2] and Board:IsValid(p4) then
				damage.loc = p4
				ret:AddDamage(damage)
			end
		end
		ret:AddDelay(0.2)

		damage.loc = p2 - DIR_VECTORS[direction2]
		ret:AddDamage(damage)

		return ret
	end

	local damage = SpaceDamage(p2, 0)
	damage.sAnimation = "ExploAcid1"
	ret:AddArtillery(damage, "advanced/effects/shotup_swapother.png")

	damage = SpaceDamage(p2, self.Damage, direction2)
	damage.iAcid = 1
	damage.sAnimation = "airpush_"..direction2
	ret:AddDamage(damage)

	return ret
end

Blight_Grenade_A = Blight_Grenade:new{AnyDir = true, BigSize = 0, UpgradeDescription = "Can now push targets in any direction.",
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2,1),
		Enemy2 = Point(2,0),
		Enemy3 = Point(1,1),
		Second_Click = Point(2,2),
	},
}

Blight_Grenade_B = Blight_Grenade:new{AnyDir = false, BigSize = 1, UpgradeDescription = "Increases area hit by 4 tiles.",}

Blight_Grenade_AB = Blight_Grenade:new{AnyDir = true, BigSize = 1,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2,1),
		Enemy2 = Point(2,0),
		Enemy3 = Point(1,1),
		Second_Click = Point(2,2),
	},
}