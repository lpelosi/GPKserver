-----------------------------------
-- GPK custom: per-job Artifact-quest reforge-gear vendors
--
-- One vendor NPC per job, standing beside that job's Artifact (AF) questline START npc,
-- selling that job's reforged AF/Relic/Empyrean armor (top tier of each set, 15 items).
-- The 7 advanced jobs (no classic AF quest) are placed at their unlock hub (Aht Urhgan /
-- Adoulin). Names continue the German-WWII-leader (first name only) convention. Native
-- xi.shop.general shop. Reversible: drop the init.txt line + restart.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('af_vendors')

local PRICE       = 10000 -- flat gil per piece (adjust freely)
local VENDOR_LOOK = '0x0000C80200000000000000000000000000000000'

local vendors =
{
    ['Aht_Urhgan_Whitegate'] =
    {
        { name = 'Nikolaus', x = 3.4, y = 0.0, z = 94.9, rot = 64,  -- BLU
          stock = { 23435, 23502, 23569, 23636, 23703, 23910, 23933, 23955, 23978, 24000, 24023, 24045, 24068, 24090, 24113 } },
        { name = 'Johannes', x = 6.4, y = 0.0, z = 96.9, rot = 64,  -- COR
          stock = { 23436, 23503, 23570, 23637, 23704, 23911, 23934, 23956, 23979, 24001, 24024, 24046, 24069, 24091, 24114 } },
        { name = 'Robert', x = 9.4, y = 0.0, z = 98.9, rot = 64,  -- PUP
          stock = { 23437, 23504, 23571, 23638, 23705, 23912, 23935, 23957, 23980, 24002, 24025, 24047, 24070, 24092, 24115 } },
        { name = 'Erhard', x = 12.4, y = 0.0, z = 100.9, rot = 64,  -- DNC
          stock = { 23438, 23505, 23572, 23639, 23706, 23913, 23936, 23958, 23981, 24003, 24026, 24048, 24071, 24093, 24116 } },
        { name = 'Theodor', x = 15.4, y = 0.0, z = 100.9, rot = 64,  -- SCH
          stock = { 23439, 23506, 23573, 23640, 23707, 23915, 23937, 23960, 23982, 24005, 24027, 24050, 24072, 24095, 24117 } },
    },
    ['Bastok_Mines'] =
    {
        { name = 'Hermann', x = 77.12, y = 0.0, z = -81.44, rot = 184,  -- WAR
          stock = { 23420, 23487, 23554, 23621, 23688, 23895, 23918, 23940, 23963, 23985, 24008, 24030, 24053, 24075, 24098 } },
    },
    ['Heavens_Tower'] =
    {
        { name = 'Rudolf', x = 2.0, y = 30.749, z = 20.0, rot = 64,  -- BLM
          stock = { 23423, 23490, 23512, 23557, 23624, 23691, 23898, 23921, 23943, 23966, 24011, 24033, 24056, 24078, 24101 } },
    },
    ['Lower_Jeuno'] =
    {
        { name = 'Maximilian', x = -15.201, y = -0.1, z = -60.072, rot = 145,  -- BRD (+ Loughnashade, BRD Prime harp)
          stock = { 23429, 23496, 23563, 23630, 23697, 23904, 23927, 23949, 23972, 23994, 24017, 24039, 24062, 24084, 24107, 22307 } },
    },
    ['Metalworks'] =
    {
        { name = 'Ferdinand', x = -24.263, y = -10.0, z = -3.596, rot = 15,  -- DRK
          stock = { 23427, 23494, 23561, 23628, 23695, 23902, 23925, 23947, 23970, 23992, 24015, 24037, 24060, 24082, 24105 } },
    },
    ['Norg'] =
    {
        { name = 'Hans', x = 92.348, y = -7.086, z = -5.913, rot = 44,  -- SAM
          stock = { 23431, 23498, 23565, 23632, 23699, 23906, 23929, 23951, 23974, 23996, 24019, 24041, 24064, 24086, 24109 } },
        { name = 'Wolfram', x = -24.276, y = 0.53, z = -8.323, rot = 116,  -- NIN
          stock = { 23432, 23499, 23566, 23633, 23700, 23907, 23930, 23952, 23975, 23997, 24020, 24042, 24065, 24087, 24110 } },
    },
    ['Northern_San_dOria'] =
    {
        { name = 'Josef', x = 130.838, y = -10.999, z = 128.338, rot = 240,  -- WHM
          stock = { 23422, 23489, 23556, 23623, 23690, 23897, 23920, 23942, 23965, 23987, 24010, 24032, 24055, 24077, 24100 } },
        { name = 'Otto', x = 7.346, y = 0.499, z = 26.899, rot = 64,  -- PLD (+ Duban, PLD Prime shield)
          stock = { 23426, 23493, 23560, 23627, 23694, 23901, 23924, 23946, 23969, 23991, 24014, 24036, 24059, 24081, 24104, 26495 } },
        { name = 'Werner', x = -167.127, y = 3.999, z = 158.677, rot = 8,  -- DRG
          stock = { 23433, 23500, 23567, 23634, 23701, 23908, 23931, 23953, 23976, 23998, 24021, 24043, 24066, 24088, 24111 } },
    },
    ['Port_Bastok'] =
    {
        { name = 'Heinrich', x = -158.604, y = -7.48, z = 3.141, rot = 55,  -- MNK
          stock = { 23421, 23488, 23555, 23622, 23689, 23896, 23919, 23941, 23964, 23986, 24009, 24031, 24054, 24076, 24099 } },
    },
    ['Southern_San_dOria'] =
    {
        { name = 'Martin', x = 97.381, y = 0.0, z = 113.601, rot = 249,  -- RDM
          stock = { 23424, 23491, 23558, 23625, 23692, 23899, 23922, 23944, 23967, 23989, 24012, 24034, 24057, 24079, 24102 } },
    },
    ['Upper_Jeuno'] =
    {
        { name = 'Georg', x = -55.023, y = 8.199, z = 97.519, rot = 36,  -- BST
          stock = { 23428, 23495, 23562, 23629, 23696, 23903, 23926, 23948, 23971, 23993, 24016, 24038, 24061, 24083, 24106 } },
    },
    ['Western_Adoulin'] =
    {
        { name = 'Paul', x = -27.4, y = -0.676, z = 37.95, rot = 96,  -- GEO
          stock = { 23440, 23507, 23574, 23641, 23708, 23916, 23938, 23961, 23983, 24006, 24028, 24051, 24073, 24096, 24118 } },
        { name = 'Felix', x = -30.4, y = -0.676, z = 37.95, rot = 96,  -- RUN
          stock = { 23441, 23508, 23575, 23642, 23709, 23917, 23939, 23962, 23984, 24007, 24029, 24052, 24074, 24097, 24119 } },
    },
    ['Windurst_Walls'] =
    {
        { name = 'Eduard', x = -24.0, y = -14.498, z = 262.994, rot = 0,  -- SMN
          stock = { 23434, 23501, 23568, 23635, 23702, 23909, 23932, 23954, 23977, 23999, 24022, 24044, 24067, 24089, 24112 } },
    },
    ['Windurst_Woods'] =
    {
        { name = 'Alfred', x = 67.036, y = -4.75, z = 239.561, rot = 59,  -- THF
          stock = { 23425, 23492, 23559, 23626, 23693, 23900, 23923, 23945, 23968, 23990, 24013, 24035, 24058, 24080, 24103 } },
        { name = 'Ernst', x = 119.5, y = -3.7, z = 90.453, rot = 189,  -- RNG
          stock = { 23430, 23497, 23564, 23631, 23698, 23905, 23928, 23950, 23973, 23995, 24018, 24040, 24063, 24085, 24108 } },
    },
}

local function makeShop(stock)
    local s = {}
    for i = 1, #stock do s[i] = { stock[i], PRICE } end
    return s
end

for zoneName, list in pairs(vendors) do
    m:addOverride('xi.zones.' .. zoneName .. '.Zone.onInitialize', function(zone)
        super(zone)
        for _, v in ipairs(list) do
            local shop = makeShop(v.stock)
            zone:insertDynamicEntity({
                objtype = xi.objType.NPC, name = v.name, look = VENDOR_LOOK,
                x = v.x, y = v.y, z = v.z, rotation = v.rot, widescan = 1,
                onTrigger = function(player, npc) xi.shop.general(player, shop) end,
            })
        end
    end)
end

return m
