-----------------------------------
-- Fimbulvetr
-- Great Sword Prime Weapon Skill -- unlocked while equipped with Helheim.
-- Description: Delivers a single powerful attack. Damage varies with TP.
-- Modifiers: STR:60% / VIT:60%
-- fTP (1000/2000/3000 TP): 3.3 / 6.6 / 9.9
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
    params.ftpMod  = { 3.3, 6.6, 9.9 }
    params.str_wsc = 0.60
    params.vit_wsc = 0.60

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.PRIME)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
