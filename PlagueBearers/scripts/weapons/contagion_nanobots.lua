local wt2 = {
	Passive_Contagion_Nanobots_Upgrade1 = "+1 Damage",
}
for k,v in pairs(wt2) do Weapon_Texts[k] = v end

----- CONTAGION NANOBOTS -----
--[[  Description: Passive that makes enemies spread fire and acid to adjacent enemies on death.
      Function: TBA
]]--
Passive_Contagion_Nanobots = PassiveSkill:new{
	Name = "Contagion Nanobots",
	Description = "Vek spread Fire and A.C.I.D. to adjacent Vek on death.",
	PowerCost = 0,
	Icon = "weapons/passive_contagion_nanobots.png",
	Upgrades = 0,
	UpgradeCost = {},
	Passive = "Passive_Contagion_Nanobots",
	TipImage = {
		Unit = Point (5,3),
        Target = Point(2,2),
        Enemy = Point(2,2),
        Fire = Point(2,2),
        Acid = Point(2,2),
		Enemy2 = Point(2,1),
        Enemy3 = Point(3,2),
	}
}

function Passive_Contagion_Nanobots:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
    local d = SpaceDamage(Point(2,2), 5)
    ret:AddDamage(d)
    local status_damage = SpaceDamage(Point(2,1), 0, FULL_DELAY)
    status_damage.iAcid = 1
    status_damage.iFire = 1
    ret:AddDamage(status_damage)
    status_damage.loc = Point(3,2)
    ret:AddDamage(status_damage)
	return ret
end

local canExplode = true
Contagion_Nanobots_SkillEffect = function(mission, pawn)
    --Check if ability needs to trigger
    if not mission then return end
    if not pawn then return end
    if IsTestMechScenario() then return end
    --if IsTipImage() then return end
    if not IsPassiveSkill("Passive_Contagion_Nanobots") or pawn:GetTeam() ~= TEAM_ENEMY then return end

    local spreadAcid = pawn:IsAcid()
    local spreadFire = pawn:IsFire()
    --LOG("Nanobot Trigger: Acid", spreadAcid, ", Fire", spreadFire)
    
    modApi:conditionalHook(
		function()
			-- return Board and Board:GetBusyState() == 0
            --LOG("Ready to Trigger:", canExplode)
			return canExplode
		end,
		function()
            canExplode = false
            local makeBusy = SkillEffect()
            makeBusy:AddDelay(1.0)
            --LOG("Delaying Trigger")
	        Board:AddEffect(makeBusy)
            modApi:scheduleHook(1000, function()
                --LOG("Triggering Now")
                if spreadAcid or spreadFire then
                    local pawn_loc = pawn:GetSpace()
                    --LOG("Pawn Location:", pawn_loc)
                    for dir = DIR_START, DIR_END do
	            	    local p2 = pawn_loc + DIR_VECTORS[dir]
	            	    if Board:IsValid(p2) and Board:IsPawnSpace(p2) and Board:IsPawnTeam(p2, TEAM_ENEMY) then
                            --LOG("p2 Location: ", p2)
                            local damage = SpaceDamage(p2, 0)
                            if spreadAcid then damage.iAcid = 1 end
                            if spreadFire then damage.iFire = 1 end
                            local ret = SkillEffect()
                            ret:AddDamage(damage)
                            Board:AddEffect(ret)
                        end
                    end
                end
                canExplode = true
            end)
        end)
end

local function EVENT_onModsLoaded()
	modapiext:addPawnKilledHook(Contagion_Nanobots_SkillEffect)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)
