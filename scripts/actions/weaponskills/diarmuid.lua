-----------------------------------
-- Diarmuid
-- Polearm Prime Weapon Skill -- unlocked while equipped with Gae Buide.
-- Description: Delivers a twofold attack. Damage varies with TP.
-- Modifiers: STR:55% / VIT:55%
-- fTP (1000/2000/3000 TP): 2.17 / 5.36 / 8.55
--   NOTE: BG-wiki flags these modifiers and fTP values as "needs verification".
-- Skillchain: Transfixion / Scission / Gravitation
-- Element: None (physical)
-- NOTE: "Prime Aftermath" is not applied -- LSB has no PRIME aftermath type yet
--       (only RELIC/MYTHIC/EMPYREAN). Damage + skillchain are fully functional.
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 2
    params.ftpMod  = { 2.17, 5.36, 8.55 }
    params.str_wsc = 0.55
    params.vit_wsc = 0.55

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.PRIME)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
