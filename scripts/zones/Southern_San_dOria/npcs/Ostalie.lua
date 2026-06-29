-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ostalie
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- GPK custom: convenience-goods shop (replaced useless low-level starter armor/belts with consumables).
    local stock =
    {
        { xi.item.POTION,                 900, 3 },
        { xi.item.HI_POTION,             1500, 3 },
        { xi.item.ETHER,                 5000, 3 },
        { xi.item.ANTIDOTE,               330, 3 },
        { xi.item.FLASK_OF_EYE_DROPS,    2700, 3 },
        { xi.item.FLASK_OF_ECHO_DROPS,    830, 3 },
        { xi.item.REMEDY,                3000, 3 },
        { xi.item.RERAISER,              2000, 3 },
        { xi.item.HI_RERAISER,           8000, 3 },
        { xi.item.POT_OF_SILENT_OIL,      100, 3 },
        { xi.item.PINCH_OF_PRISM_POWDER,  100, 3 },
        { xi.item.SCROLL_OF_INSTANT_WARP, 500, 3 },
        { xi.item.PICKAXE,                208, 3 },
        { xi.item.HATCHET,                520, 3 },
    }

    -- Thief's tools.
    if GetNationRank(player:getNation()) >= 2 then -- Player nation rank 2 or 3.
        table.insert(stock, { xi.item.SET_OF_THIEFS_TOOLS, 4158, 3 })
    end

    -- Living Key.
    local sandyNationRank  = GetNationRank(xi.nation.SANDORIA)
    local bastokNationRank = GetNationRank(xi.nation.BASTOK)
    local windyNationRank  = GetNationRank(xi.nation.WINDURST)
    if
        (sandyNationRank == bastokNationRank and sandyNationRank == windyNationRank) or                       -- All 3 nations tied.
        (sandyNationRank ~= bastokNationRank and sandyNationRank ~= windyNationRank and sandyNationRank == 3) -- Nation not tied and nation last.
    then
        table.insert(stock, { xi.item.LIVING_KEY, 5520, 3 })
    end

    player:showText(npc, ID.text.OSTALIE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
