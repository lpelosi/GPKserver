-----------------------------------
-- Tachi: Mumei
-- Great Katana Prime Weapon Skill -- unlocked while equipped with Kusanagi.
-- Description: Damage varies with TP. (Single-hit weapon skill.)
-- Modifiers: STR:50% / DEX:50%
-- fTP (1000/2000/3000 TP): 3.66 / 7.33 / 11
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
    params.ftpMod  = { 3.66, 7.33, 11 }
    params.str_wsc = 0.5
    params.dex_wsc = 0.5

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.PRIME)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
