-----------------------------------
-- Ruthless Stroke
-- Dagger Prime Weapon Skill -- unlocked while equipped with Mpu Gandring.
-- Description: Delivers a fourfold attack.
-- Modifiers: DEX:25% / AGI:25%
-- fTP (1000/2000/3000 TP): 5.375 / 14 / 23
-- Skillchain: Liquefaction / Impaction / Fragmentation
-- Element: None (physical)
-- NOTE: "Prime Aftermath" is not applied -- LSB has no PRIME aftermath type yet
--       (only RELIC/MYTHIC/EMPYREAN). Damage + skillchain are fully functional.
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 4
    params.ftpMod  = { 5.375, 14, 23 }
    params.dex_wsc = 0.25
    params.agi_wsc = 0.25

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.PRIME)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
