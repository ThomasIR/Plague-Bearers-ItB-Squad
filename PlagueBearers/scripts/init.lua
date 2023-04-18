local function init(self)
    require(self.scriptPath.."FURL")(self, {
    {
        Type = "mech",
        Name = "MechIncubator",
        Filename = "mech_incubator",
        Path = "img/units/player",
        ResourcePath = "units/player",

        Default =           { PosX = -21, PosY = -11 },
        Animated =          { PosX = -21, PosY = -11, NumFrames = 8 },
        Submerged =         { PosX = -21, PosY = 2 },
        Broken =            { PosX = -21, PosY = -11 },
        SubmergedBroken =   { PosX = -21, PosY = 2 },
        Icon =              {},
    },
    {
        Type = "mech",
        Name = "MechAssassin",
        Filename = "mech_assassin",
        Path = "img/units/player",
        ResourcePath = "units/player",

        Default =           { PosX = -23, PosY = -8 },
        Animated =          { PosX = -23, PosY = -6, NumFrames = 8 },
        Submerged =         { PosX = -23, PosY = 3 },
        Broken =            { PosX = -23, PosY = -6 },
        SubmergedBroken =   { PosX = -23, PosY = 3 },
        Icon =              {},
    },
    {
        Type = "mech",
        Name = "MechPlague",
        Filename = "mech_plague",
        Path = "img/units/player",
        ResourcePath = "units/player",

        Default =           { PosX = -19, PosY = -12 },
        Animated =          { PosX = -19, PosY = -12, NumFrames = 4 },
        Submerged =         { PosX = -19, PosY = 1 },
        Broken =            { PosX = -19, PosY = -12 },
        SubmergedBroken =   { PosX = -19, PosY = 1 },
        Icon =              {},
    },
    {
    		Type = "color",
    		Name = "PlagueBearers",
    		PawnLocation = self.scriptPath.."pawns",

    		PlateHighlight = {255,94,0},
    		PlateLight = {143,149,101},
    		PlateMid = {72,116,42},
    		PlateDark = {40,47,29},
    		PlateOutline = {15,22,16},
    		PlateShadow = {34,36,34},
    		BodyColor = {83,86,71},
    		BodyHighlight = {165,168,150},
    },
    {
        Type = "base",
        Filename = "prime_heat_blaster",
        Path = "img/weapons",
        ResourcePath = "weapons",
    },
    {
        Type = "base",
        Filename = "brute_sniper_rifle",
        Path = "img/weapons",
        ResourcePath = "weapons",
    },
    {
        Type = "base",
        Filename = "ranged_blight_grenade",
        Path = "img/weapons",
        ResourcePath = "weapons",
    },
    {
        Type = "base",
        Filename = "passive_contagion_nanobots",
        Path = "img/weapons",
        ResourcePath = "weapons",
    },
});

require(self.scriptPath.."pawns")
require(self.scriptPath.."weapons/heat_blaster")
require(self.scriptPath.."weapons/sniper_rifle")
require(self.scriptPath.."weapons/blight_grenade")
require(self.scriptPath.."weapons/contagion_nanobots")
modApi:addWeapon_Texts(require(self.scriptPath.."weapon_texts"))

end

local function load(self,options,version)
  modApi:addSquadTrue({"Plague Bearers","IncubatorMech","AssassinMech","PlagueMech"},"Plague Bearers","Careful study of Vek immune systems has equipped these Mechs to exterminate them with the aid of biological warfare.",self.resourcePath.."/squad.png")
end

return {
    id = "Plague Bearers",
    name = "Plague Bearers",
	icon = "/squad.png",
    version = "1.0",
    init = init,
    load = load
}
