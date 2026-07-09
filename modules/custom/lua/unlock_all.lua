-----------------------------------
-- GPK custom: Unlock-all on login (maps + trusts + teleport networks)
--
-- Hooks xi.player.onGameIn. Runs the ORIGINAL login logic first (super), then, once per
-- character (gated by a charvar so it is NOT re-run on every login), grants:
--   * every area map (same key-item ranges ALL_MAPS/charCreate uses)
--   * every Trust (spell group 8 = ids 896-1019; gaps at 1000/1001)
--   * every teleport point -- Waypoints, Homepoints, Survival Guides, Abyssea Confluxes,
--     Eschan Portals -- via the game's own addTeleport() API.
--
-- Reliability: every grant call is wrapped in pcall, so nothing here can ever break login.
-- Bump UNLOCK_VER to force a re-grant (e.g. after new content is added).
-----------------------------------
require('modules/module_utils')
require('scripts/globals/player')
-----------------------------------
local m = Module:new('unlock_all')

-- VER 2 (2026-07-06): re-grant on next login to restore Unity-leader trusts that the old
-- accolade gate had stripped when joining/switching a Unity (fixed in C++ UpdateUnityTrust).
local UNLOCK_VER = 3

m:addOverride('xi.player.onGameIn', function(player, firstLogin, zoning)
    -- Always run the real login logic first.
    super(player, firstLogin, zoning)

    -- Only on an actual login (not a zone change), and only once per character.
    if zoning then
        return
    end
    if player:getCharVar('GPK_UNLOCK_VER') >= UNLOCK_VER then
        return
    end

    -- Maps (identical ranges to charCreate's ALL_MAPS grant).
    pcall(function()
        for i = xi.ki.MAP_OF_THE_SAN_DORIA_AREA, xi.ki.MAP_OF_DIO_ABDHALJS_GHELSBA do player:addKeyItem(i) end
        for i = xi.ki.MAP_OF_AL_ZAHBI,           xi.ki.MAP_OF_RAKAZNAR             do player:addKeyItem(i) end
        for i = xi.ki.MAP_OF_RALA_WATERWAYS_U,   xi.ki.MAP_OF_RAKAZNAR_U           do player:addKeyItem(i) end
        for i = xi.ki.MAP_OF_ESCHA_ZITAH,        xi.ki.MAP_OF_REISENJIMA           do player:addKeyItem(i) end
    end)

    -- Trusts (spell group 8; 896-1019 is exclusively trusts, gaps at 1000/1001).
    for id = 896, 999 do
        pcall(player.addSpell, player, id, { silentLog = true })
    end
    for id = 1002, 1019 do
        pcall(player.addSpell, player, id, { silentLog = true })
    end

    -- GPK: Aria of Passion (Prime harp Loughnashade song, spell 1020) -- BRD-only, harmless for others.
    pcall(player.addSpell, player, 1020, { silentLog = true })

    -- Teleport networks (game's own API; each call protected; generous bounds cover every
    -- real destination -- phantom bits have no menu entry, so they are harmless).
    local T = xi.teleport.type
    for bit = 0, 63 do
        pcall(player.addTeleport, player, T.WAYPOINT, bit)       -- bit only
        pcall(player.addTeleport, player, T.ESCHAN_PORTAL, bit)  -- bit only
    end
    for set = 0, 15 do
        for bit = 0, 63 do
            pcall(player.addTeleport, player, T.HOMEPOINT, bit, set)
            pcall(player.addTeleport, player, T.SURVIVAL, bit, set)
            pcall(player.addTeleport, player, T.ABYSSEA_CONFLUX, bit, set)
        end
    end

    player:setCharVar('GPK_UNLOCK_VER', UNLOCK_VER)
end)

return m
