-----------------------------------
-- Origin
-- Scythe Prime Weapon Skill -- unlocked while equipped with Foenaria.
-- Description: Absorbs HP and MP. Damage varies with TP. (Single-hit weapon skill.)
-- Modifiers: STR:60% / INT:60%
-- fTP (1000/2000/3000 TP): 3.0 / 6.0 / 9.0
-- Skillchain: Induration / Reverberation / Fusion
-- Element: None (physical)
-- NOTE: "Prime Aftermath" is not applied -- LSB has no PRIME aftermath type yet
--       (only RELIC/MYTHIC/EMPYREAN). Damage + skillchain are fully functional.
-- NOTE: The retail HP/MP absorb rider is NOT implemented here -- damage + skillchain
--       are fully functional, but no HP/MP is drained on hit.
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 3.0, 6.0, 9.0 }
    params.str_wsc = 0.60
    params.int_wsc = 0.60

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.PRIME)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
