-- scripts/globals/new_char_grant.lua
-- Run on login and give a starter kit once per character.
local STARTER_FLAG = 'NEWCHAR_BONUS_GIVEN'

local ITEMS =
{
    10293, -- chocobo_shirt
    11811, -- destrier_beret
    15198, -- sprout_beret
    22299, -- perfect_lucky_egg
    26192, -- adoulin_ring_+1
    26193, -- woltaris_ring_+1
    26194, -- weatherspoon_ring_+1
    26195, -- janniston_ring_+1
    26196, -- renaye_ring_+1
    26197, -- gorney_ring_+1
    26198, -- haverton_ring_+1
    26200, -- vocane_ring_+1
    26201, -- thurandaut_ring_+1
    26202, -- shneddick_ring_+1
    26203, -- orvail_ring_+1
    27326, -- track_pants_+1
    27556, -- echad_ring
    27557, -- trizek_ring
    15199, -- guide_beret
    154,   -- miniature airship
    13216, -- gold mog belt
    3706,  -- vanaclock
    3707,  -- murrey grisaille
}

local function grant(player)
    if player:getCharVar(FLAG) == 1 then return end
    for _, id in ipairs(ITEMS) do
        player:addItem(id, 1)
    end
    player:setCharVar(FLAG, 1)
    player:printToPlayer("As a surprise bonus please enjoy these items for your first login. =)", xi.msg.channel.SYSTEM_2)
end

xi.player.onGameIn:new("new_char_grant", function(player)
    pcall(grant, player)
end)
