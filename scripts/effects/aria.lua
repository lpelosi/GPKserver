-----------------------------------
-- xi.effect.ARIA (213)
-- Song: Aria of Passion (enabled by the Loughnashade harp).
-- Grants Physical Damage Limit+ to party members in range.
-- getPower() = the DAMAGE_LIMITP value (%x100) from the enhancing-song power formula.
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DAMAGE_LIMITP, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DAMAGE_LIMITP, effect:getPower())
end

return effectObject
