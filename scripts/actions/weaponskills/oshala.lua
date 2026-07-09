-----------------------------------
-- Oshala
-- Staff Prime Weapon Skill -- unlocked while equipped with Opashoro.
-- Description: Deals physical damage that varies with TP.
-- Modifiers: MND:45% / INT:45%
-- fTP (1000/2000/3000 TP): 3.95 / 7.89 / 11.84
-- Skillchain: Induration / Reverberation / Fusion
-- Element: None (physical)
-- NOTE: "Prime Aftermath" is not applied -- LSB has no PRIME aftermath type yet
--       (only RELIC/MYTHIC/EMPYREAN). Damage + skillchain are fully functional.
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 3.95, 7.89, 11.84 }
    params.mnd_wsc = 0.45
    params.int_wsc = 0.45

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.PRIME)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
