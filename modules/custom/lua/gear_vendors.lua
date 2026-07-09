-----------------------------------
-- GPK custom: Gear Vendor NPCs  (auto-generated -- edit gen_vendors_lua.py, not this file)
--
-- A 6-NPC vendor cluster placed in every home city (beside the local convenience vendor / AH):
--   Heinz  accessories | Gerd staves | Erich Blades | Karl Heavy Arms
--   Albert Fists&Staves | Walter Ranged
-- Weapons are Rare/Ex only. Each weapon NPC opens ONE single-level customMenu of its types,
-- and each option opens a native <=16-item xi.shop.general (nested menus are broken; shops
-- handle Ex fine). Names are short WWII-leader first names (NPC name field caps ~15 chars).
-----------------------------------
require('modules/module_utils')
require('scripts/zones/Southern_San_dOria/Zone')
require('scripts/zones/Bastok_Mines/Zone')
require('scripts/zones/Windurst_Woods/Zone')
require('scripts/zones/Lower_Jeuno/Zone')
-----------------------------------
local m = Module:new('gear_vendors')

local VENDOR_LOOK = '0x0000C80200000000000000000000000000000000'

local accessoriesStock =
{
    { 13014,  1500 }, { 14595,  1500 }, { 14593,  1500 }, { 13240,  2000 },
    { 13061,  2500 }, { 13326,  2500 }, { 12486,  4000 }, { 15543,  8000 },
    { 13056,  8000 }, { 13281,  8000 }, { 13231, 10000 }, { 13593, 10000 },
    { 15457, 12000 }, { 13369, 12000 }, { 13646, 15000 }, { 14739, 20000 },
}

local stavesStock =
{
    { 17545, 10000 }, { 17547, 10000 }, { 17549, 10000 }, { 17551, 10000 },
    { 17553, 10000 }, { 17555, 10000 }, { 17557, 10000 }, { 17559, 10000 },
}

local weaponStocks =
{
    ['Archery'] =
    {
        { 19222, 6300 },
        { 17208, 9000 },
        { 17203, 12000 },
        { 17190, 17700 },
        { 17212, 18000 },
        { 19216, 20700 },
        { 18728, 21300 },
        { 17185, 23700 },
        { 18349, 24000 },
        { 18650, 25500 },
        { 18664, 27000 },
        { 22169, 29700 },
    },
    ['Axe'] =
    {
        { 16656, 1500 },
        { 17967, 3900 },
        { 17947, 9000 },
        { 17936, 11700 },
        { 16680, 12000 },
        { 17959, 15900 },
        { 16679, 16800 },
        { 17925, 18900 },
        { 17927, 20700 },
        { 17938, 21600 },
        { 16654, 23100 },
        { 18289, 24000 },
        { 18641, 25500 },
        { 19620, 27000 },
        { 21732, 29700 },
    },
    ['Club'] =
    {
        { 17058, 300 },
        { 17418, 4500 },
        { 17419, 7500 },
        { 17463, 11700 },
        { 17422, 12300 },
        { 17421, 13500 },
        { 17136, 15600 },
        { 17429, 17700 },
        { 18867, 18600 },
        { 18396, 20400 },
        { 17464, 21000 },
        { 18324, 22500 },
        { 18325, 24000 },
        { 18647, 25500 },
        { 18661, 27000 },
        { 21998, 29700 },
    },
    ['Dagger'] =
    {
        { 16486, 2100 },
        { 16509, 3600 },
        { 16511, 5700 },
        { 16487, 11400 },
        { 16764, 12000 },
        { 17980, 14400 },
        { 16765, 15300 },
        { 19120, 17100 },
        { 17981, 18300 },
        { 18001, 20400 },
        { 18002, 21900 },
        { 18270, 22500 },
        { 18271, 24000 },
        { 18638, 25500 },
        { 18652, 27000 },
        { 20594, 29700 },
    },
    ['GKatana'] =
    {
        { 17809, 300 },
        { 17811, 3000 },
        { 18451, 9000 },
        { 17812, 12600 },
        { 16965, 15000 },
        { 18445, 17100 },
        { 17822, 18000 },
        { 18449, 20700 },
        { 17804, 21900 },
        { 18318, 22500 },
        { 18454, 24900 },
        { 17801, 26700 },
        { 18660, 27000 },
        { 21952, 29700 },
    },
    ['GreatAxe'] =
    {
        { 18503, 6300 },
        { 16708, 11100 },
        { 18210, 12600 },
        { 16727, 13800 },
        { 16728, 16800 },
        { 16734, 20100 },
        { 18508, 21900 },
        { 18294, 22500 },
        { 18295, 24000 },
        { 18519, 26400 },
        { 18656, 27000 },
        { 21789, 29700 },
    },
    ['GreatSword'] =
    {
        { 20781, 300 },
        { 16637, 1500 },
        { 19160, 4500 },
        { 19150, 15000 },
        { 16945, 18600 },
        { 19155, 20700 },
        { 19153, 22200 },
        { 18282, 22500 },
        { 18283, 24000 },
        { 19172, 26100 },
        { 19173, 27600 },
        { 21677, 29700 },
    },
    ['H2H'] =
    {
        { 16434, 6600 },
        { 18762, 7500 },
        { 18359, 9000 },
        { 17510, 11700 },
        { 18350, 12000 },
        { 17503, 13800 },
        { 18752, 15000 },
        { 17491, 17400 },
        { 17504, 18000 },
        { 18761, 20700 },
        { 18759, 21300 },
        { 18264, 22500 },
        { 18265, 24000 },
        { 18637, 25500 },
        { 18651, 27000 },
        { 21540, 29700 },
    },
    ['Katana'] =
    {
        { 18412, 4500 },
        { 17792, 9000 },
        { 17787, 11700 },
        { 17772, 12000 },
        { 18411, 15000 },
        { 16924, 17100 },
        { 18428, 18600 },
        { 19271, 20700 },
        { 19278, 21300 },
        { 18312, 22500 },
        { 18313, 24000 },
        { 18645, 25500 },
        { 18659, 27000 },
        { 21936, 29700 },
    },
    ['Marksman'] =
    {
        { 19221, 1500 },
        { 17211, 6000 },
        { 19230, 9300 },
        { 18702, 12000 },
        { 17235, 17400 },
        { 18703, 18000 },
        { 17244, 20100 },
        { 17245, 21000 },
        { 19001, 22500 },
        { 18337, 24000 },
        { 19090, 25500 },
        { 19739, 28200 },
        { 21266, 29700 },
    },
    ['Polearm'] =
    {
        { 19305, 3300 },
        { 16863, 6000 },
        { 16887, 12600 },
        { 16857, 14700 },
        { 16870, 17700 },
        { 18087, 18000 },
        { 18128, 20700 },
        { 19306, 21900 },
        { 18300, 22500 },
        { 18301, 24000 },
        { 18643, 25500 },
        { 18657, 27000 },
        { 21891, 29700 },
    },
    ['Scythe'] =
    {
        { 18040, 7200 },
        { 16798, 12900 },
        { 16788, 17400 },
        { 18041, 18600 },
        { 18951, 20700 },
        { 18958, 21900 },
        { 18961, 22800 },
        { 18307, 24000 },
        { 18553, 26700 },
        { 18658, 27000 },
        { 21842, 29700 },
    },
    ['Staff'] =
    {
        { 17594, 3000 },
        { 18599, 4500 },
        { 18605, 8700 },
        { 17532, 12300 },
        { 17522, 15900 },
        { 18587, 16500 },
        { 17574, 18000 },
        { 18597, 20700 },
        { 18595, 21900 },
        { 18330, 22500 },
        { 18331, 24000 },
        { 18648, 25500 },
        { 18662, 27000 },
        { 22168, 29700 },
    },
    ['Sword'] =
    {
        { 17708, 5700 },
        { 17650, 7200 },
        { 17750, 7500 },
        { 17760, 9300 },
        { 17693, 11700 },
        { 17643, 12600 },
        { 17726, 15000 },
        { 16580, 16500 },
        { 16831, 18000 },
        { 17651, 20100 },
        { 17653, 21000 },
        { 18276, 22500 },
        { 18894, 24300 },
        { 18639, 25500 },
        { 18653, 27000 },
        { 20663, 29700 },
    },
    ['Throwing'] =
    {
        { 18246, 4500 },
        { 19203, 12000 },
        { 18172, 18000 },
        { 18141, 21000 },
        { 18245, 22500 },
        { 19260, 25200 },
        { 22267, 29700 },
    },
}

-- GPK: Prime weapons (top tier) prepended to their weapon-type stock so they show first
-- within the 16-item shop cap. WS granted by the weapon (see gpk_prime_ws.sql / weaponskills).
local PRIME_PRICE = 100000
local primeByStock =
{
    H2H = 21535, Dagger = 21590, Sword = 21646, GreatSword = 21649,
    Axe = 21730, GreatAxe = 21785, Scythe = 21837, Polearm = 21891,
    Katana = 21932, GKatana = 21986, Club = 21998, Staff = 22106,
    Archery = 22163, Marksman = 22164,
}
for key, id in pairs(primeByStock) do
    weaponStocks[key] = weaponStocks[key] or {}
    table.insert(weaponStocks[key], 1, { id, PRIME_PRICE })
end

local weaponGroups =
{
    ['Blades'] = { { 'Sword', 'Sword' }, { 'Dagger', 'Dagger' }, { 'Katana', 'Katana' }, { 'Great Sword', 'GreatSword' }, { 'Great Katana', 'GKatana' } },
    ['Heavy Arms'] = { { 'Axe', 'Axe' }, { 'Great Axe', 'GreatAxe' }, { 'Club', 'Club' }, { 'Scythe', 'Scythe' }, { 'Polearm', 'Polearm' } },
    ['Fists & Staves'] = { { 'Hand-to-Hand', 'H2H' }, { 'Staff', 'Staff' } },
    ['Ranged'] = { { 'Archery', 'Archery' }, { 'Marksmanship', 'Marksman' }, { 'Throwing', 'Throwing' } },
}

local function openTypeShopMenu(player, title, types)
    local menu = { title = title, options = {} }
    for _, t in ipairs(types) do
        local key = t[2]
        table.insert(menu.options, { t[1], function(p) xi.shop.general(p, weaponStocks[key]) end })
    end
    player:customMenu(menu)
end

-- one shared cluster definition, placed at every city anchor
local cluster =
{
    { name = 'Heinz', dx = 1.900, dz = 0.000, onUse = function(p) xi.shop.general(p, accessoriesStock) end },
    { name = 'Gerd', dx = -2.100, dz = 0.000, onUse = function(p) xi.shop.general(p, stavesStock) end },
    { name = 'Erich', dx = 2.900, dz = 2.300, onUse = function(p) openTypeShopMenu(p, 'Blades', weaponGroups['Blades']) end },
    { name = 'Karl', dx = 0.900, dz = 2.300, onUse = function(p) openTypeShopMenu(p, 'Heavy Arms', weaponGroups['Heavy Arms']) end },
    { name = 'Albert', dx = -1.100, dz = 2.300, onUse = function(p) openTypeShopMenu(p, 'Fists & Staves', weaponGroups['Fists & Staves']) end },
    { name = 'Walter', dx = -3.100, dz = 2.300, onUse = function(p) openTypeShopMenu(p, 'Ranged', weaponGroups['Ranged']) end },
}

local function spawnCluster(zone, ax, ay, az)
    for _, v in ipairs(cluster) do
        local use = v.onUse
        zone:insertDynamicEntity({
            objtype = xi.objType.NPC, name = v.name, look = VENDOR_LOOK,
            x = ax + v.dx, y = ay, z = az + v.dz, rotation = 190, widescan = 1,
            onTrigger = function(player, npc) use(player) end,
        })
    end
end

m:addOverride('xi.zones.Southern_San_dOria.Zone.onInitialize', function(zone)
    super(zone)
    spawnCluster(zone, -143.400, -6.000, -11.800)
end)
m:addOverride('xi.zones.Bastok_Mines.Zone.onInitialize', function(zone)
    super(zone)
    spawnCluster(zone, -28.170, -0.044, -7.190)
end)
m:addOverride('xi.zones.Windurst_Woods.Zone.onInitialize', function(zone)
    super(zone)
    spawnCluster(zone, 51.850, -3.750, 52.260)
end)
m:addOverride('xi.zones.Lower_Jeuno.Zone.onInitialize', function(zone)
    super(zone)
    spawnCluster(zone, -13.000, -0.101, -24.000)
end)

return m
