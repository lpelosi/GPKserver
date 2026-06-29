-----------------------------------
-- Area: Windurst Woods
--  NPC: Wije Tiren
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- GPK custom: convenience-goods shop (added consumables alongside Windurst staples).
    local stock =
    {
        { xi.item.POTION,                     900 },
        { xi.item.HI_POTION,                 1500 },
        { xi.item.ETHER,                     5000 },
        { xi.item.ANTIDOTE,                   330 },
        { xi.item.FLASK_OF_EYE_DROPS,        2700 },
        { xi.item.FLASK_OF_ECHO_DROPS,        830 },
        { xi.item.REMEDY,                    3000 },
        { xi.item.RERAISER,                  2000 },
        { xi.item.HI_RERAISER,               8000 },
        { xi.item.POT_OF_SILENT_OIL,          100 },
        { xi.item.PINCH_OF_PRISM_POWDER,      100 },
        { xi.item.SCROLL_OF_INSTANT_WARP,     500 },
        { xi.item.FLASK_OF_DISTILLED_WATER,    12 },
        { xi.item.FEDERATION_WAYSTONE,      10400 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.WIJETIREN_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end

return entity
