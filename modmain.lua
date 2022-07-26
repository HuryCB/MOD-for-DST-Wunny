PrefabFiles = {
    "wunny",
    "wunny_none",
    "rabbithole_placer",
    "rabbithouse",
    "carrot",
    "birchnuthat",
    "bunnyback",
    "coolerpack",
}

Assets = {
    Asset("IMAGE", "images/saveslot_portraits/wunny.tex"),
    Asset("ATLAS", "images/saveslot_portraits/wunny.xml"),

    Asset("IMAGE", "images/selectscreen_portraits/wunny.tex"),
    Asset("ATLAS", "images/selectscreen_portraits/wunny.xml"),

    Asset("IMAGE", "images/selectscreen_portraits/wunny_silho.tex"),
    Asset("ATLAS", "images/selectscreen_portraits/wunny_silho.xml"),

    Asset("IMAGE", "bigportraits/wunny.tex"),
    Asset("ATLAS", "bigportraits/wunny.xml"),

    Asset("IMAGE", "images/map_icons/wunny.tex"),
    Asset("ATLAS", "images/map_icons/wunny.xml"),

    Asset("IMAGE", "images/avatars/avatar_wunny.tex"),
    Asset("ATLAS", "images/avatars/avatar_wunny.xml"),

    Asset("IMAGE", "images/avatars/avatar_ghost_wunny.tex"),
    Asset("ATLAS", "images/avatars/avatar_ghost_wunny.xml"),

    Asset("IMAGE", "images/avatars/self_inspect_wunny.tex"),
    Asset("ATLAS", "images/avatars/self_inspect_wunny.xml"),

    Asset("IMAGE", "images/names_wunny.tex"),
    Asset("ATLAS", "images/names_wunny.xml"),

    Asset("IMAGE", "images/names_gold_wunny.tex"),
    Asset("ATLAS", "images/names_gold_wunny.xml"),

    Asset("ATLAS", "images/inventoryimages/rabbithole.xml"),
    Asset("IMAGE", "images/inventoryimages/rabbithole.tex"),

    Asset("IMAGE", "images/inventoryimages/rabbithole.tex"),

    Asset("ATLAS", "images/inventoryimages/birchnuthat.xml"),

    Asset("ATLAS", "images/inventoryimages/coolerpack.xml"),
    Asset("IMAGE", "images/inventoryimages/coolerpack.tex"),
    Asset("ANIM", "anim/swap_coolerpack.zip"),
}

AddMinimapAtlas("images/map_icons/wunny.xml")

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local RECIPETABS = GLOBAL.RECIPETABS
local Ingredient = GLOBAL.Ingredient
local TECH = GLOBAL.TECH


local containers = require "containers"

local params = {}

local OVERRIDE_WIDGETSETUP = false
local containers_widgetsetup_base = containers.widgetsetup

function containers.widgetsetup(container, prefab)
    local t = params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
        container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
        if OVERRIDE_WIDGETSETUP then
            container.type = "coolerpack"
        end
    else
        containers_widgetsetup_base(container, prefab)
    end
end

params.coolerpack = {
    widget =
    {
        slotpos = {},
        animbank = "ui_piggyback_2x6",
        animbuild = "ui_piggyback_2x6",
        pos = GLOBAL.Vector3(-5, -50, 0),
    },
    issidewidget = true,
    type = "pack",
}

for y = 0, 5 do
    table.insert(params.coolerpack.widget.slotpos, GLOBAL.Vector3(-162, -75 * y + 170, 0))
    table.insert(params.coolerpack.widget.slotpos, GLOBAL.Vector3(-162 + 75, -75 * y + 170, 0))
end

function params.coolerpack.itemtestfn(container, item, slot)
    -- if item.prefab == "spoiled_food" then
    --     return true
    -- end

    -- --Perishable
    -- if not (item:HasTag("fresh") or item:HasTag("stale") or item:HasTag("spoiled")) then
    --     return false
    -- end

    -- --Edible
    -- for k, v in pairs(GLOBAL.FOODTYPE) do
    --     if item:HasTag("edible_" .. v) then
    --         return true
    --     end
    -- end

    return true
end

-- local function update_recipe(self, ingredients, tab, level, min_spacing, nounlock, numtogive)
--     self.ingredients   = ingredients
--     self.tab           = tab
--     self.level         = level or 0
--     self.level.ANCIENT = self.level.ANCIENT or 0
--     self.level.MAGIC   = self.level.MAGIC or 0
--     self.level.SCIENCE = self.level.SCIENCE or 0
--     self.min_spacing   = min_spacing or 3.2
--     self.nounlock      = nounlock or false
--     self.numtogive     = numtogive or 1
-- end

AddRecipe("coolerpack", { Ingredient("manrabbit_tail", 4), Ingredient("silk", 6), Ingredient("rope", 2) },
    RECIPETABS.SURVIVAL
    , TECH.NONE, nil,
    nil,
    nil,
    nil,
    "wunny", "images/inventoryimages/coolerpack.xml")
-- AddRecipe("coolerpack", { Ingredient("rabbit", 1) },
--     RECIPETABS.SURVIVAL
--     , TECH.NONE, nil,
--     nil,
--     nil,
--     nil,
--     "wunny", "images/inventoryimages/coolerpack.xml")

local containers_widgetsetup_custom = containers.widgetsetup
local MAXITEMSLOTS = containers.MAXITEMSLOTS

AddPrefabPostInit("world_network", function(inst)
    if containers.widgetsetup ~= containers_widgetsetup_custom then
        OVERRIDE_WIDGETSETUP = true
        local containers_widgetsetup_base2 = containers.widgetsetup
        function containers.widgetsetup(container, prefab)
            containers_widgetsetup_base2(container, prefab)
            if container.type == "coolerpack" then
                container.type = "pack"
            end
        end
    end
    if containers.MAXITEMSLOTS < MAXITEMSLOTS then
        containers.MAXITEMSLOTS = MAXITEMSLOTS
    end
end)

-- The character select screen lines
STRINGS.CHARACTER_TITLES.wunny = "The Bunny man"
STRINGS.CHARACTER_NAMES.wunny = "Wunny"
STRINGS.CHARACTER_DESCRIPTIONS.wunny = "*Perk 1\n*Perk 2\n*Perk 3"
STRINGS.CHARACTER_QUOTES.wunny = "\"Quote\""
STRINGS.CHARACTER_SURVIVABILITY.wunny = "Slim"

--variables
TUNING.WUNNY_SPEED = 6
TUNING.WUNNY_RUNNING_HUNGER_RATE = 1
-- TUNNIN.WUNNY_IDLE_HUNGER_RATE = 1


-- Custom speech strings
STRINGS.CHARACTERS.WUNNY = require "speech_wunny"

-- The character's name as appears in-game
STRINGS.NAMES.WUNNY = "Wunny"
STRINGS.SKIN_NAMES.wunny_none = "Wunny"

-- The skins shown in the cycle view window on the character select screen.
-- A good place to see what you can put in here is in skinutils.lua, in the function GetSkinModes
local skin_modes = {
    {
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle",
        scale = 0.75,
        offset = { 0, -25 }
    },
}

--idk
local spacing = 2

--function of rabbithole recipe
local function rabbithole_recipe(ingredients, level)
    AddRecipe("rabbithole", ingredients, RECIPETABS.SURVIVAL, level,
        "rabbithole_placer", spacing, nil, nil, "wunny", "images/inventoryimages/rabbithole.xml")
end

local function rabbithouse_recipe(ingredientes, level)
    AddRecipe("rabbithouse", ingredientes, RECIPETABS.SURVIVAL, level,
        "rabbithouse_placer", nil, nil, nil, "wunny")
end

rabbithouse_recipe({ Ingredient("carrot", 5), Ingredient("manrabbit_tail", 2), Ingredient("boards", 2) }, TECH.NONE)

rabbithole_recipe({ Ingredient("carrot", 2), Ingredient("rabbit", 2), Ingredient("shovel", 1) }, TECH.NONE)
STRINGS.RECIPE_DESC.RABBITHOLE = "A new home for the rabbits."

AddRecipe("birchnuthat",
    { Ingredient("manrabbit_tail", 1), Ingredient("rope", 1) },
    RECIPETABS.WAR,
    TECH.NONE,
    nil,
    nil,
    nil,
    nil,
    "wunny",
    "images/inventoryimages/birchnuthat.xml",
    "birchnuthat.tex")

-- AddRecipe("bunnyback", { Ingredient("pigskin", 4), Ingredient("silk", 6), Ingredient("rope", 2) }, TECH.NONE)


-- AddRecipe("bunnyback", { Ingredient("manrabbit_tail", 4), Ingredient("silk", 6), Ingredient("rope", 2) },
--     RECIPETABS.SURVIVAL, TECH.NONE)

-- AddRecipe("bunnyback", { Ingredient("rabbit", 1) },
--     RECIPETABS.SURVIVAL, TECH.NONE, nil,
--     nil,
--     nil,
--     nil,
--     "wunny","images/inventoryimages/coolerpack.xml")
-- local containers_widgetsetup_custom = containers.widgetsetup

-- AddRecipe("bunnyback", { Ingredient("manrabbit_tail", 4), Ingredient("silk", 6), Ingredient("rope", 2) },
-- RECIPETABS.SURVIVAL, TECH.NONE, nil,
-- nil,
-- nil,
-- nil,
-- "wunny", "images/inventoryimages/birchnuthat.xml",
-- "birchnuthat.tex")

--add carrot to rabbithole drop
AddPrefabPostInit("rabbithole", function(inst)
    GLOBAL.MakeInventoryPhysics(inst)

    if not GLOBAL.TheWorld.ismastersim then
        return
    end

    local dig_up_old = inst.components.workable.onfinish
    local function dig_up(inst, chopper)
        inst.components.lootdropper:SpawnLootPrefab("carrot")
        if dig_up_old ~= nil then
            dig_up_old(inst, chopper)
        end
    end

    inst.components.workable:SetOnFinishCallback(dig_up)
end)

-- local containers_widgetsetup_custom = containers.widgetsetup

-- AddPrefabPostInit("world_network", function(inst)
--     if containers.widgetsetup ~= containers_widgetsetup_custom then
--         OVERRIDE_WIDGETSETUP = true
--         local containers_widgetsetup_base2 = containers.widgetsetup
--         function containers.widgetsetup(container, prefab)
--             containers_widgetsetup_base2(container, prefab)
--             if container.type == "bunnypack" then
--                 container.type = "pack"
--             end
--         end
--     end

-- end)
-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("wunny", "MALE", skin_modes)
