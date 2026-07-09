-----------------------------------
-- GPK custom: RoE / level-cap quest fix
--
-- Our server changes broke a set of Records of Eminence "tutorial" objectives that
-- gate on completing a specific quest (roe.lua questComplete req = getQuestStatus == COMPLETED):
--
--   * "Level Cap Increase: 55..99" -> the Jeuno genkai/limit-break quests
--   * "Inventory Expansion 35..80" -> The Gobbiebag Part I..X  (we already max all
--                                     containers to 80 at creation, so these quests can
--                                     no longer be done normally -> the RoE is stuck)
--   * "Mog Safe Expansion 60..80"  -> the Give-a-Moogle-a-Break line
--
-- These RoE records carry the 'retro' flag, so once their prerequisite quest is marked
-- COMPLETED the objective can be claimed. completeQuest() also fires ROE_QUEST_COMPLETE
-- (lua_base_entity.cpp:8306), so an already-active record completes immediately.
--
-- We ALSO raise the real per-char level cap (chars/char_jobs.genkai) to 99 via
-- setLevelCap(), because completeQuest() only marks the quest log -- it does NOT run the
-- genkai quest's reward script, so it would not lift the cap on its own. Raising genkai
-- to 99 removes the level-cap-quest gate entirely (per the full-soloability directive).
--
-- Runs once per character (charvar GPK_ROE_QUESTFIX_VER gate; bump VER to re-apply) on a
-- real login (not a zone change). Everything is pcall-wrapped so it can never break login.
-- Reversible: remove the 'custom/lua/roe_quest_fix.lua' line from modules/init.txt + restart.
-----------------------------------
require('modules/module_utils')
require('scripts/globals/player')
require('scripts/globals/quests')
require('scripts/globals/roe')
-----------------------------------
local m = Module:new('roe_quest_fix')

-- VER 2 (2026-07-07): completeQuest() only flips the quest-log bit -- it does NOT run each
-- quest's reward script. So beyond genkai (handled below) we must also hand-grant the rewards
-- those 23 quests would have given, or downstream systems break:
--   * LB06 New Worlds Await grants the LIMIT_BREAKER key item (npcUtil.giveKeyItem) -- REQUIRED
--     for Merit Mode (0x100_myroom_job.cpp / 0x063_miscdata_merits.cpp gate canUseMeritMode on
--     mainJob>=75 && hasKeyItem(LIMIT_BREAKER)). Missing it = merits don't work.
--   * Gobbiebag I-X + Mog Safe quests expand containers -- skipped, so existing chars keep small
--     safe/locker/sack while the RoE reads "expanded". We max all containers (as charCreate does).
-- (Harmless skips: LB01-04 delKeyItem of quest crests the player never held; LB05 title/fame.)
local VER = 2
local LEVEL_CAP = 99
local MAX_BAG   = 80 -- client-safe container max (matches charCreate)

-- Jeuno-log quests: level-cap increases (55->99) + Gobbiebag inventory expansions (35->80)
local JEUNO_QUESTS =
{
    -- Level Cap Increase
    xi.quest.id.jeuno.IN_DEFIANT_CHALLENGE,       -- 55
    xi.quest.id.jeuno.ATOP_THE_HIGHEST_MOUNTAINS, -- 60
    xi.quest.id.jeuno.WHENCE_BLOWS_THE_WIND,      -- 65
    xi.quest.id.jeuno.RIDING_ON_THE_CLOUDS,       -- 70
    xi.quest.id.jeuno.SHATTERING_STARS,           -- 75
    xi.quest.id.jeuno.NEW_WORLDS_AWAIT,           -- 80
    xi.quest.id.jeuno.EXPANDING_HORIZONS,         -- 85
    xi.quest.id.jeuno.BEYOND_THE_STARS,           -- 90
    xi.quest.id.jeuno.DORMANT_POWERS_DISLODGED,   -- 95
    xi.quest.id.jeuno.BEYOND_INFINITY,            -- 99
    -- Inventory Expansion (The Gobbiebag)
    xi.quest.id.jeuno.THE_GOBBIEBAG_PART_I,       -- 35
    xi.quest.id.jeuno.THE_GOBBIEBAG_PART_II,      -- 40
    xi.quest.id.jeuno.THE_GOBBIEBAG_PART_III,     -- 45
    xi.quest.id.jeuno.THE_GOBBIEBAG_PART_IV,      -- 50
    xi.quest.id.jeuno.THE_GOBBIEBAG_PART_V,       -- 55
    xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VI,      -- 60
    xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VII,     -- 65
    xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VIII,    -- 70
    xi.quest.id.jeuno.THE_GOBBIEBAG_PART_IX,      -- 75
    xi.quest.id.jeuno.THE_GOBBIEBAG_PART_X,       -- 80
}

-- Other-Areas-log quests: Mog Safe expansions (60->80)
local OTHER_QUESTS =
{
    xi.quest.id.otherAreas.GIVE_A_MOOGLE_A_BREAK, -- 60
    xi.quest.id.otherAreas.THE_MOOGLE_PICNIC,     -- 70
    xi.quest.id.otherAreas.MOOGLES_IN_THE_WILD,   -- 80
}

-- Key items these quests grant that completeQuest() skipped. Only FINAL rewards -- the
-- mid-quest collectibles (crests / frigicite / stones / LB01 mold-coal-papyrus) are
-- delKeyItem'd on completion, so a finished quest would NOT leave you holding them.
local REWARD_KEYITEMS =
{
    xi.ki.LIMIT_BREAKER,   -- LB06 New Worlds Await -> gates Merit Mode
    xi.ki.JOB_BREAKER,     -- LB10 Beyond Infinity  -> gates Job Points (needs KI + lvl 99)
    xi.ki.SOUL_GEM,        -- LB09 Dormant Powers Dislodged (reward)
    xi.ki.SOUL_GEM_CLASP,  -- LB10 Beyond Infinity (reward)
}

-- Titles each completed quest awards (owned-title list; addTitle is idempotent).
local REWARD_TITLES =
{
    xi.title.HORIZON_BREAKER,    -- LB01 In Defiant Challenge
    xi.title.SUMMIT_BREAKER,     -- LB02 Atop the Highest Mountains
    xi.title.SKY_BREAKER,        -- LB03 Whence Blows the Wind
    xi.title.CLOUD_BREAKER,      -- LB04 Riding on the Clouds
    xi.title.STAR_BREAKER,       -- LB05 Shattering Stars
    xi.title.MAAT_MASHER,        -- LB05 Shattering Stars (beat Maat)
    xi.title.BUSHIN_ASPIRANT,    -- LB10 Beyond Infinity
    xi.title.GREEDALOX,          -- The Gobbiebag Part V
    xi.title.GRAND_GREEDALOX,    -- The Gobbiebag Part X
    xi.title.MOGS_KIND_MASTER,   -- Give a Moogle a Break
    xi.title.MOGS_LOVING_MASTER, -- Moogles in the Wild
}

m:addOverride('xi.player.onGameIn', function(player, firstLogin, zoning)
    super(player, firstLogin, zoning)

    -- Only once per character, on an actual login (not a zone change).
    if zoning then
        return
    end
    if player:getCharVar('GPK_ROE_QUESTFIX_VER') >= VER then
        return
    end
    player:setCharVar('GPK_ROE_QUESTFIX_VER', VER)

    -- 1) Remove the level-cap gate: raise genkai to 99 (persists to char_jobs).
    pcall(function()
        if player:getLevelCap() < LEVEL_CAP then
            player:setLevelCap(LEVEL_CAP)
        end
    end)

    -- 2) Mark the prerequisite quests complete so their retro RoE objectives can complete.
    for i = 1, #JEUNO_QUESTS do
        pcall(player.completeQuest, player, xi.questLog.JEUNO, JEUNO_QUESTS[i])
    end
    for i = 1, #OTHER_QUESTS do
        pcall(player.completeQuest, player, xi.questLog.OTHER_AREAS, OTHER_QUESTS[i])
    end

    -- 3) Grant the reward key items completeQuest() skipped (LIMIT_BREAKER -> merits,
    --    JOB_BREAKER -> job points, plus the LB09/LB10 reward gems).
    for i = 1, #REWARD_KEYITEMS do
        pcall(function()
            if not player:hasKeyItem(REWARD_KEYITEMS[i]) then
                player:addKeyItem(REWARD_KEYITEMS[i])
            end
        end)
    end

    -- 3b) Grant the titles those quests award (idempotent).
    for i = 1, #REWARD_TITLES do
        pcall(player.addTitle, player, REWARD_TITLES[i])
    end

    -- 4) Max all containers -- the Gobbiebag/Mog Safe quests' expansions were skipped by
    --    completeQuest. Idempotent (adds only the difference); mirrors charCreate.
    for _, loc in ipairs({
        xi.inv.INVENTORY, xi.inv.MOGSAFE, xi.inv.MOGSAFE2, xi.inv.STORAGE, xi.inv.MOGLOCKER,
        xi.inv.MOGSATCHEL, xi.inv.MOGSACK, xi.inv.MOGCASE,
        xi.inv.WARDROBE, xi.inv.WARDROBE2, xi.inv.WARDROBE3, xi.inv.WARDROBE4,
        xi.inv.WARDROBE5, xi.inv.WARDROBE6, xi.inv.WARDROBE7, xi.inv.WARDROBE8,
    }) do
        pcall(function()
            local cur = player:getContainerSize(loc)
            if cur < MAX_BAG then
                player:changeContainerSize(loc, MAX_BAG - cur)
            end
        end)
    end
end)

return m
