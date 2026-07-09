-----------------------------------
-- Maru Kala
-- Hand-to-Hand Prime Weapon Skill -- unlocked while equipped with Varga Purnikawa.
-- Description: Delivers a twofold attack.
-- Modifiers: STR:41.75% / DEX:41.75%
-- fTP (1000/2000/3000 TP): 3.128 / 7.273 / 11.414
-- Skillchain: Detonation / Compression / Distortion
-- Element: None (physical)
-- NOTE: "Prime Aftermath" is not applied -- LSB has no PRIME aftermath type yet
--       (only RELIC/MYTHIC/EMPYREAN). Damage + skillchain are fully functional.
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 2
    params.ftpMod  = { 3.128, 7.273, 11.414 }
    params.str_wsc = 0.4175
    params.dex_wsc = 0.4175

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.PRIME)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
