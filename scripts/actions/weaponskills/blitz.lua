-----------------------------------
-- Blitz
-- Axe Prime Weapon Skill -- unlocked while equipped with Spalirisos.
-- Description: Delivers a fivefold attack.
-- Modifiers: STR:32% / DEX:32%
-- fTP (1000/2000/3000 TP): 1.5 / 7 / 12.5
-- Skillchain: Liquefaction / Impaction / Fragmentation
-- Element: None (physical)
-- NOTE: "Prime Aftermath" is not applied -- LSB has no PRIME aftermath type yet
--       (only RELIC/MYTHIC/EMPYREAN). Damage + skillchain are fully functional.
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 5
    params.ftpMod  = { 1.5, 7, 12.5 }
    params.str_wsc = 0.32
    params.dex_wsc = 0.32

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.PRIME)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
