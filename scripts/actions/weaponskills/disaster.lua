-----------------------------------
-- Disaster
-- Great Axe Prime Weapon Skill -- unlocked while equipped with Laphria.
-- Description: Damage varies with TP. (Single-hit weapon skill.)
-- Modifiers: STR:60% / VIT:60%
-- fTP (1000/2000/3000 TP): 3.05 / 9.15 / 15.25
--   NOTE: BG-wiki lists 3.05 / 9.15 and flags 3000 TP as "info needed";
--         15.25 is a linear extrapolation of the 1000->2000 step.
-- Skillchain: Transfixion / Scission / Gravitation
-- Element: None (physical)
-- NOTE: "Prime Aftermath" is not applied -- LSB has no PRIME aftermath type yet
--       (only RELIC/MYTHIC/EMPYREAN). Damage + skillchain are fully functional.
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 3.05, 9.15, 15.25 }
    params.str_wsc = 0.60
    params.vit_wsc = 0.60

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.PRIME)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
