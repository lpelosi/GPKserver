-- scripts/globals/new_char_grant.lua
-- Run on login and give a starter kit once per character.

local SATCHEL_LOC = xi.inv.MOGSATCHEL

local STARTER_FLAG = "NEWCHAR_BONUS_GIVEN"

local ITEMS = {
    xi.item.DESTRIER_BERET,
    xi.item.CHOCOBO_SHIRT,
    xi.item.TRACK_PANTS_P1,
    xi.item.ECHAD_RING,
    xi.item.SPROUT_BERET,
    xi.item.PERFECT_LUCKY_EGG,
    xi.item.TRIZEK_RING,
    xi.item.ADOULIN_RING_P1,
    xi.item.GORNEY_RING_P1,
    xi.item.HAVERTON_RING_P1,
    xi.item.JANNISTON_RING_P1,
    xi.item.KARIEYEH_RING_P1,
    xi.item.ORVAIL_RING_P1,
    xi.item.RENAYE_RING_P1,
    xi.item.SHNEDDICK_RING_P1,
    xi.item.THURANDAUT_RING_P1,
    xi.item.VOCANE_RING_P1,
    xi.item.WEATHERSPOON_RING_P1,
    xi.item.WOLTARIS_RING_P1,
}

-- Hook point: called by the server when a player finishes zoning in.
-- If your branch uses a different hook name/file, register this function there.
xi.player.onGameIn:new('new_char_grant', function(player)
    if player:getCharVar(STARTER_FLAG) == 1 then
        return
    end

    -- Try to put everything into Mog Satchel
    local granted = 0
    for _, itemId in ipairs(ITEMS) do
        -- quantity = 1; add to satchel; ignore augments
        local ok = player:addItem(itemId, 1, nil, nil, nil, nil, nil, nil, nil, nil, nil, { location = SATCHEL_LOC })
        if ok then
            granted = granted + 1
        end
    end

    if granted > 0 then
        player:setCharVar(STARTER_FLAG, 1)
        player:printToPlayer('Welcome to GPK! Please check your Mog Satchel for a surprise welcome kit.', xi.msg.channel.SYSTEM_2)
    end

    if granted == 0 then
        player:printToPlayer("Items didn't get added big dog. =(")
    end

end)
