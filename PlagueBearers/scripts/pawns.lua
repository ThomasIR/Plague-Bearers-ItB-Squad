IncubatorMech = {
	Name = "Incubator Mech",
	Class = "Prime",
	Health = 3,
	MoveSpeed = 3,
	Image = "MechIncubator",
	ImageOffset = FURL_COLORS.PlagueBearers,
	SkillList = { "Heat_Blaster" },
	SoundLocation = "/mech/prime/punch_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true
}
AddPawn("IncubatorMech")

AssassinMech = {
	Name = "Assassin Mech",
	Class = "Brute",
	Health = 3,
	MoveSpeed = 4,
	Image = "MechAssassin",
	ImageOffset = FURL_COLORS.PlagueBearers,
	SkillList = { "Sniper_Rifle" },
	SoundLocation = "/mech/brute/pierce_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true
}
AddPawn("AssassinMech")

PlagueMech = {
	Name = "Plague Mech",
	Class = "Ranged",
	Health = 2,
	MoveSpeed = 3,
	Image = "MechPlague",
	ImageOffset = FURL_COLORS.PlagueBearers,
	SkillList = { "Blight_Grenade", "Passive_Contagion_Nanobots" },
	SoundLocation = "/mech/distance/artillery/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true
}
AddPawn("PlagueMech")
