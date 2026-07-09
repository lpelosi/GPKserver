-----------------------------------
-- Trust: Ulmia
-----------------------------------
---@type TSpellTrust
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.PRISHE] = xi.trust.messageOffset.TEAMWORK_1,
        [xi.magic.spell.MILDAURION] = xi.trust.messageOffset.TEAMWORK_2,
    })

    -- TODO: BRD trusts need better logic and major overhaul, for now they compliment each other
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.MADRIGAL }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.MADRIGAL })
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.MINUET }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.VALOR_MINUET })
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.MARCH }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.MARCH })
    -- GPK: maintain up to 4 songs (relies on the C++ MAXIMUM_SONGS_BONUS-for-all-casters fix)
    mob:addMod(xi.mod.MAXIMUM_SONGS_BONUS, 2)
    -- 4th song: Aria of Passion at BRD 99+ (its level requirement), else Army's Paeon (regen) as a beneficial fallback
    if mob:getMainLvl() >= 99 then
        mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.ARIA }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.ARIA_OF_PASSION })
    else
        mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.PAEON }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.ARMYS_PAEON })
    end

    mob:setAutoAttackEnabled(false)

    mob:setMobMod(xi.mobMod.TRUST_DISTANCE, xi.trust.movementType.MID_RANGE)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
