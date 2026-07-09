-----------------------------------
-- Dagda
-- Club Prime Weapon Skill -- unlocked while equipped with Lorg Mor.
-- Description: Delivers a twofold attack. Damage varies with TP.
-- Modifiers: STR:50% / MND:50%  (post-March-2024 modifier set; BG-wiki lists the
--       exact percentages as "Information Needed" -- 50/50 used as an approximation)
-- fTP (1000/2000/3000 TP): 3.128 / 7.273 / 11.414
--       (BG-wiki fTP is "Information Needed"; mirrors a 2-hit Prime WS as approximation)
-- Skillchain: Transfixion / Scission / Gravitation
-- Element: None (physical -- BG-wiki classifies Dagda as physical despite the MND mod)
-- NOTE: "Prime Aftermath" is not applied -- LSB has no PRIME aftermath type yet
--       (only RELIC/MYTHIC/EMPYREAN). Damage + skillchain are fully functional.
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 2
    params.ftpMod  = { 3.128, 7.273, 11.414 }
    params.str_wsc = 0.5
    params.mnd_wsc = 0.5

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.PRIME)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
