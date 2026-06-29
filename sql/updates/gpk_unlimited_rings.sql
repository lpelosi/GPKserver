-- GPK custom: make convenience/EXP rings unlimited and cooldown-free.
-- Mechanism: the map server only decrements charges when maxCharges > 1, and an item is
-- usable whenever its remaining reuse (getReuseTime) is 0. So maxCharges = 1 + reuseDelay = 0
-- => unlimited uses, zero cooldown. Pure data change (item_usable); takes effect on map restart.
-- Re-apply this file after any full DB re-import (a fresh import resets these rows to retail values).
--
-- Affected: Warp Ring, Homing Ring, Return Ring, Dimensional Rings (Holla/Dem/Mea),
--           Chariot/Empress/Emperor Bands (EXP).
UPDATE `item_usable`
SET `maxCharges` = 1, `reuseDelay` = 0
WHERE `itemid` IN (28540, 15541, 15542, 26176, 26177, 26178, 15761, 15762, 15763);
