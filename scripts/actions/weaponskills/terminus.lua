-----------------------------------
-- Terminus
-- Marksmanship Prime Weapon Skill -- unlocked while equipped with Earp.
-- Description: Ranged attack whose damage varies with TP.
-- Modifiers: DEX:70% / AGI:70%
-- fTP (1000/2000/3000 TP): 2.5 / 5.0 / 7.5
-- Skillchain: Induration / Reverberation / Fusion
-- Element: None (ranged, physical)
-- NOTE: "Prime Aftermath" is not applied -- LSB has no PRIME aftermath type yet
--       (only RELIC/MYTHIC/EMPYREAN). Damage + skillchain are fully functional.
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 2.5, 5.0, 7.5 }
    params.dex_wsc = 0.70
    params.agi_wsc = 0.70

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)

    xi.aftermath.addStatusEffect(player, tp, xi.slot.RANGED, xi.aftermath.type.PRIME)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
