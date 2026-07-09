-----------------------------------
-- Imperator
-- Sword Prime Weapon Skill -- unlocked while equipped with Caliburnus.
-- Description: Delivers a single powerful attack.
-- Modifiers: DEX:70% / MND:70%
-- fTP (1000/2000/3000 TP): 3.75 / 7.5 / 11.75
-- Skillchain: Detonation / Compression / Distortion
-- Element: None (physical)
-- NOTE: "Prime Aftermath" is not applied -- LSB has no PRIME aftermath type yet
--       (only RELIC/MYTHIC/EMPYREAN). Damage + skillchain are fully functional.
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 3.75, 7.5, 11.75 }
    params.dex_wsc = 0.70
    params.mnd_wsc = 0.70

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.PRIME)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
