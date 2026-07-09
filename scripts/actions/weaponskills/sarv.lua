-----------------------------------
-- Sarv
-- Archery Prime Weapon Skill -- unlocked while equipped with Pinaka.
-- Description: Ranged attack whose damage varies with TP.
-- Modifiers: STR:65% / AGI:65%
-- fTP (1000/2000/3000 TP): 2.75 / 5.5 / 8.25
-- Skillchain: Transfixion / Scission / Gravitation
-- Element: None (ranged, physical)
-- NOTE: "Prime Aftermath" is not applied -- LSB has no PRIME aftermath type yet
--       (only RELIC/MYTHIC/EMPYREAN). Damage + skillchain are fully functional.
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 2.75, 5.5, 8.25 }
    params.str_wsc = 0.65
    params.agi_wsc = 0.65

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)

    xi.aftermath.addStatusEffect(player, tp, xi.slot.RANGED, xi.aftermath.type.PRIME)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
