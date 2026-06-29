-----------------------------------
-- Area: Bastok Mines
--  NPC: Boytz
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- GPK custom: convenience-goods shop (replaced flowerpot/ammo with consumables).
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
        { xi.item.PICKAXE,                210, 3 },
        { xi.item.REPUBLIC_WAYSTONE,   10500, 3 },
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
        (bastokNationRank == sandyNationRank and bastokNationRank == windyNationRank) or                        -- All 3 nations tied.
        (bastokNationRank ~= sandyNationRank and bastokNationRank ~= windyNationRank and bastokNationRank == 3) -- Nation not tied and nation last.
    then
        table.insert(stock, { xi.item.LIVING_KEY, 5520, 3 })
    end

    player:showText(npc, zones[xi.zone.BASTOK_MINES].text.BOYTZ_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
