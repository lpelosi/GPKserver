-----------------------------------
-- GPK custom: Crafting Guild material vendors  (auto-generated -- edit gen_guild_vendors.py)
--
-- One vendor NPC beside each of the 8 crafting guilds, selling that craft's rarer materials
-- via a native xi.shop.general shop (<=16 items). Short WWII-leader first names (all countries):
--   Erwin Smithing | Friedrich Goldsmithing | Wilhelm Alchemy | Ludwig Leathercraft
--   Fedor Woodworking | Ewald Clothcraft | Gunther Bonecraft | Hasso Cooking | Kurt Fishing
-- (Replaces the old "Metal Dealer" smithing prototype.) Fishing is not a synthesis craft
-- (needs bait/tackle) -- to be added separately.
-----------------------------------
require('modules/module_utils')
require('scripts/zones/Metalworks/Zone')
require('scripts/zones/Bastok_Markets/Zone')
require('scripts/zones/Bastok_Mines/Zone')
require('scripts/zones/Southern_San_dOria/Zone')
require('scripts/zones/Northern_San_dOria/Zone')
require('scripts/zones/Windurst_Woods/Zone')
require('scripts/zones/Windurst_Waters/Zone')
require('scripts/zones/Port_Windurst/Zone')
-----------------------------------
local m = Module:new('crafting_dealers')

-- Goblin_Craftsman look (distinct; the crafting theme).
local VENDOR_LOOK = '0x0000C80200000000000000000000000000000000'

-- per-craft material shop stock ({ itemId, price })
local craftMats =
{
    ['smith'] =
    {
        { 644, 3000 },
        { 653, 3000 },
        { 645, 3000 },
        { 654, 3000 },
        { 646, 3000 },
        { 655, 3000 },
        { 738, 3000 },
        { 746, 3000 },
        { 739, 3000 },
        { 747, 3000 },
        { 745, 3000 },
        { 678, 3000 },
        { 685, 3000 },
        { 2228, 3000 },
        { 652, 3000 },
        { 2000, 3000 },
    },
    ['gold'] =
    {
        { 653, 3000 },
        { 743, 3000 },
        { 744, 3000 },
        { 745, 3000 },
        { 746, 3000 },
        { 785, 3000 },
        { 786, 3000 },
        { 787, 3000 },
        { 789, 3000 },
        { 790, 3000 },
        { 792, 3000 },
        { 793, 3000 },
        { 794, 3000 },
        { 797, 3000 },
        { 800, 3000 },
        { 887, 3000 },
    },
    ['cloth'] =
    {
        { 816, 3000 },
        { 818, 3000 },
        { 819, 3000 },
        { 820, 3000 },
        { 821, 3000 },
        { 823, 3000 },
        { 826, 3000 },
        { 827, 3000 },
        { 828, 3000 },
        { 829, 3000 },
        { 830, 3000 },
        { 878, 3000 },
        { 879, 3000 },
        { 1132, 3000 },
        { 1699, 3000 },
        { 1702, 3000 },
    },
    ['leather'] =
    {
        { 505, 3000 },
        { 506, 3000 },
        { 848, 3000 },
        { 851, 3000 },
        { 852, 3000 },
        { 854, 3000 },
        { 855, 3000 },
        { 857, 3000 },
        { 859, 3000 },
        { 861, 3000 },
        { 863, 3000 },
        { 1516, 3000 },
        { 1591, 3000 },
        { 2139, 3000 },
        { 872, 3000 },
        { 873, 3000 },
    },
    ['wood'] =
    {
        { 690, 3000 },
        { 691, 3000 },
        { 692, 3000 },
        { 693, 3000 },
        { 694, 3000 },
        { 695, 3000 },
        { 696, 3000 },
        { 697, 3000 },
        { 698, 3000 },
        { 699, 3000 },
        { 700, 3000 },
        { 701, 3000 },
        { 702, 3000 },
        { 688, 3000 },
        { 689, 3000 },
        { 703, 3000 },
    },
    ['bone'] =
    {
        { 672, 3000 },
        { 673, 3000 },
        { 674, 3000 },
        { 675, 3000 },
        { 676, 3000 },
        { 854, 3000 },
        { 864, 3000 },
        { 865, 3000 },
        { 866, 3000 },
        { 867, 3000 },
        { 868, 3000 },
        { 880, 3000 },
        { 881, 3000 },
        { 884, 3000 },
        { 885, 3000 },
        { 889, 3000 },
    },
    ['alchemy'] =
    {
        { 635, 3000 },
        { 637, 3000 },
        { 638, 3000 },
        { 912, 3000 },
        { 920, 3000 },
        { 922, 3000 },
        { 928, 3000 },
        { 937, 3000 },
        { 942, 3000 },
        { 943, 3000 },
        { 944, 3000 },
        { 951, 3000 },
        { 953, 3000 },
        { 1108, 3000 },
    },
    ['cook'] =
    {
        { 610, 3000 },
        { 611, 3000 },
        { 620, 3000 },
        { 627, 3000 },
        { 631, 3000 },
        { 1471, 3000 },
        { 2175, 3000 },
        { 2214, 3000 },
        { 2702, 3000 },
        { 4272, 3000 },
        { 4358, 3000 },
        { 4359, 3000 },
        { 4372, 3000 },
        { 4377, 3000 },
        { 4378, 3000 },
        { 4361, 3000 },
    },
    ['fishing_rods'] =
    {
        { 17382, 500 },
        { 17389, 1000 },
        { 17391, 1000 },
        { 17390, 1500 },
        { 17387, 2000 },
        { 17388, 3000 },
        { 17380, 4000 },
        { 17381, 5000 },
        { 17384, 8000 },
        { 17385, 12000 },
        { 17014, 15000 },
        { 17015, 20000 },
        { 17386, 30000 },
        { 17011, 60000 },
        { 19320, 100000 },
        { 19321, 150000 },
    },
    ['fishing_bait'] =
    {
        { 17395, 500 },
        { 17396, 500 },
        { 17000, 500 },
        { 17002, 500 },
        { 17398, 500 },
        { 17399, 500 },
        { 16992, 500 },
        { 17005, 500 },
        { 4507, 500 },
        { 1830, 500 },
        { 1831, 500 },
        { 2770, 500 },
        { 2772, 500 },
        { 4580, 500 },
    },
}

local function openFishingMenu(player)
    local menu = { title = 'Fishing Supplies', options = {
        { 'Rods', function(p) xi.shop.general(p, craftMats['fishing_rods']) end },
        { 'Bait & Tackle', function(p) xi.shop.general(p, craftMats['fishing_bait']) end },
    } }
    player:customMenu(menu)
end

m:addOverride('xi.zones.Metalworks.Zone.onInitialize', function(zone)
    super(zone)
    zone:insertDynamicEntity({
        objtype = xi.objType.NPC, name = 'Erwin', look = VENDOR_LOOK,
        x = -104.500, y = 2.000, z = -26.500, rotation = 190, widescan = 1,
        onTrigger = function(player, npc) xi.shop.general(player, craftMats['smith']) end,
    })
end)

m:addOverride('xi.zones.Bastok_Markets.Zone.onInitialize', function(zone)
    super(zone)
    zone:insertDynamicEntity({
        objtype = xi.objType.NPC, name = 'Friedrich', look = VENDOR_LOOK,
        x = -188.600, y = -6.814, z = -59.400, rotation = 190, widescan = 1,
        onTrigger = function(player, npc) xi.shop.general(player, craftMats['gold']) end,
    })
end)

m:addOverride('xi.zones.Bastok_Mines.Zone.onInitialize', function(zone)
    super(zone)
    zone:insertDynamicEntity({
        objtype = xi.objType.NPC, name = 'Wilhelm', look = VENDOR_LOOK,
        x = 124.800, y = 2.017, z = -0.234, rotation = 190, widescan = 1,
        onTrigger = function(player, npc) xi.shop.general(player, craftMats['alchemy']) end,
    })
end)

m:addOverride('xi.zones.Southern_San_dOria.Zone.onInitialize', function(zone)
    super(zone)
    zone:insertDynamicEntity({
        objtype = xi.objType.NPC, name = 'Ludwig', look = VENDOR_LOOK,
        x = -176.900, y = -1.000, z = 9.891, rotation = 190, widescan = 1,
        onTrigger = function(player, npc) xi.shop.general(player, craftMats['leather']) end,
    })
end)

m:addOverride('xi.zones.Northern_San_dOria.Zone.onInitialize', function(zone)
    super(zone)
    zone:insertDynamicEntity({
        objtype = xi.objType.NPC, name = 'Fedor', look = VENDOR_LOOK,
        x = -173.900, y = 3.999, z = 280.301, rotation = 190, widescan = 1,
        onTrigger = function(player, npc) xi.shop.general(player, craftMats['wood']) end,
    })
end)

m:addOverride('xi.zones.Windurst_Woods.Zone.onInitialize', function(zone)
    super(zone)
    zone:insertDynamicEntity({
        objtype = xi.objType.NPC, name = 'Ewald', look = VENDOR_LOOK,
        x = -36.200, y = -1.250, z = -120.954, rotation = 190, widescan = 1,
        onTrigger = function(player, npc) xi.shop.general(player, craftMats['cloth']) end,
    })
    zone:insertDynamicEntity({
        objtype = xi.objType.NPC, name = 'Gunther', look = VENDOR_LOOK,
        x = -4.200, y = -5.249, z = -144.667, rotation = 190, widescan = 1,
        onTrigger = function(player, npc) xi.shop.general(player, craftMats['bone']) end,
    })
end)

m:addOverride('xi.zones.Windurst_Waters.Zone.onInitialize', function(zone)
    super(zone)
    zone:insertDynamicEntity({
        objtype = xi.objType.NPC, name = 'Hasso', look = VENDOR_LOOK,
        x = -122.000, y = -1.999, z = 59.998, rotation = 190, widescan = 1,
        onTrigger = function(player, npc) xi.shop.general(player, craftMats['cook']) end,
    })
end)

-- Fishing Guild (Port Windurst), by Thubu Parohren -- Rods / Bait menu (Kurt = Student)
m:addOverride('xi.zones.Port_Windurst.Zone.onInitialize', function(zone)
    super(zone)
    zone:insertDynamicEntity({
        objtype = xi.objType.NPC, name = 'Kurt', look = VENDOR_LOOK,
        x = -180.230, y = -2.835, z = 61.373, rotation = 190, widescan = 1,
        onTrigger = function(player, npc) openFishingMenu(player) end,
    })
end)

return m
