-----------------------------------
-- Zesho Meppo
-- Katana Prime Weapon Skill -- unlocked while equipped with Dokoku.
-- Description: Delivers a fourfold attack. Damage varies with TP.
-- Modifiers: DEX:25% / AGI:25%
-- fTP (1000/2000/3000 TP): 4.0 / 11.358 / 18.715
--       (2000 TP value interpolated -- BG-wiki lists only 1000 & 3000 TP)
-- Skillchain: Induration / Reverberation / Fusion
-- Element: None (physical)
-- NOTE: "Prime Aftermath" is not applied -- LSB has no PRIME aftermath type yet
--       (only RELIC/MYTHIC/EMPYREAN). Damage + skillchain are fully functional.
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 4
    params.ftpMod  = { 4.0, 11.358, 18.715 }
    params.dex_wsc = 0.25
    params.agi_wsc = 0.25

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.PRIME)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
