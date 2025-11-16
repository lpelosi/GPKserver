-----------------------------------
-- Spell: Erase
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local extra = caster:getMod(xi.mod.ERASE_ADDITIONAL_EFFECTS) or 0
    if extra < 0 then
        extra = 0
    end
    local count = 1 + extra -- base 1 + extra from modifier
    if count <= 0 then
        count = 1
    end

    local removed = 0
    local lastEffect = xi.effect.NONE

    for i = 1, count do
        local eff = target:eraseStatusEffect()
        if eff == xi.effect.NONE then
            break
        end
        lastEffect = eff
        removed = removed + 1
    end

    if removed == 0 then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_ERASE)
    end

    return lastEffect
end

return spellObject
