-- ============================================================================
-- GPK custom: implement stubbed AF/Relic/Empyrean reforge gear (+2/+3)
-- LSB ships these items as "TODO: Not implemented" (no model, no stats).
-- Re-run this after any full item_equipment / item_mods re-import.
--
-- Part 1: MODELS -- reforge tiers share the base tier's 3D model. Copy the base
--         reforged item's MId onto every +2/+3 piece that lacks one (idempotent:
--         only touches MId=0 rows). 218 rows as of 2026-07-07.
-- Part 2: STATS  -- item_mods sourced from BG-wiki, appended below per set.
-- ============================================================================

-- Part 1: models -------------------------------------------------------------
UPDATE item_equipment tgt
JOIN item_basic tb ON tb.itemid = tgt.itemId
JOIN item_basic bb ON bb.name = SUBSTRING_INDEX(tb.name,'_+',1)
JOIN item_equipment be ON be.itemId = bb.itemid AND be.slot = tgt.slot AND be.MId <> 0
SET tgt.MId = be.MId
WHERE (tb.name LIKE '%\_+2' OR tb.name LIKE '%\_+3') AND tgt.MId = 0 AND tgt.ilevel >= 109;

-- Part 2: stats (appended per set) -------------------------------------------

-- Ebers (WHM Empyrean) +3
-- Ebers Attire Set +3 (WHM Empyrean) stat mods
-- Derived from +2 item_mods templates (modId set + unit scale) and BG-wiki +3 stat lines.
-- Idempotent: clears existing rows for the five +3 pieces first.
DELETE FROM item_mods WHERE itemId IN (23422,23489,23690,23556,23623);

-- ============================================================
-- Ebers Cap +3 (23422)  template Ebers Cap +2 (23087)
-- DEF:124 HP+64 MP+108 STR+23 DEX+29 VIT+29 AGI+26 INT+34 MND+34 CHR+31
-- Acc+61 MAcc+61 Eva+86 MEva+125 MDB+10 Haste+6% FastCast+13% "Divine Veil"+26% "Cure" potency+22%
-- ============================================================
INSERT INTO item_mods (itemId, modId, value) VALUES (23422, 1, 124);   -- DEF
INSERT INTO item_mods (itemId, modId, value) VALUES (23422, 2, 64);    -- HP
INSERT INTO item_mods (itemId, modId, value) VALUES (23422, 5, 108);   -- MP
INSERT INTO item_mods (itemId, modId, value) VALUES (23422, 8, 23);    -- STR
INSERT INTO item_mods (itemId, modId, value) VALUES (23422, 9, 29);    -- DEX
INSERT INTO item_mods (itemId, modId, value) VALUES (23422, 10, 29);   -- VIT
INSERT INTO item_mods (itemId, modId, value) VALUES (23422, 11, 26);   -- AGI
INSERT INTO item_mods (itemId, modId, value) VALUES (23422, 12, 34);   -- INT
INSERT INTO item_mods (itemId, modId, value) VALUES (23422, 13, 34);   -- MND
INSERT INTO item_mods (itemId, modId, value) VALUES (23422, 14, 31);   -- CHR
INSERT INTO item_mods (itemId, modId, value) VALUES (23422, 25, 61);   -- ACC (Accuracy)
INSERT INTO item_mods (itemId, modId, value) VALUES (23422, 29, 10);   -- MDEF (Magic Def. Bonus)
INSERT INTO item_mods (itemId, modId, value) VALUES (23422, 30, 61);   -- MACC (Magic Accuracy)
INSERT INTO item_mods (itemId, modId, value) VALUES (23422, 31, 125);  -- MEVA (Magic Evasion)
INSERT INTO item_mods (itemId, modId, value) VALUES (23422, 68, 86);   -- EVA (Evasion)
INSERT INTO item_mods (itemId, modId, value) VALUES (23422, 170, 13);  -- FASTCAST +13%
INSERT INTO item_mods (itemId, modId, value) VALUES (23422, 374, 22);  -- CURE_POTENCY +22%
INSERT INTO item_mods (itemId, modId, value) VALUES (23422, 384, 600); -- HASTE_GEAR +6% (unit = %*100)
INSERT INTO item_mods (itemId, modId, value) VALUES (23422, 524, 26);  -- AOE_NA "Divine Veil" +26%

-- ============================================================
-- Ebers Bliaut +3 (23489)  template Ebers Bliaut +2 (23154)
-- DEF:155 HP+127 MP+139 STR+30 DEX+35 VIT+35 AGI+30 INT+45 MND+48 CHR+39
-- Acc+64 MAcc+64 Eva+91 MEva+130 MDB+11 Healing+34 Haste+3% "Afflatus Solace"+18 Regen+5 Refresh+4
-- ============================================================
INSERT INTO item_mods (itemId, modId, value) VALUES (23489, 1, 155);   -- DEF
INSERT INTO item_mods (itemId, modId, value) VALUES (23489, 2, 127);   -- HP
INSERT INTO item_mods (itemId, modId, value) VALUES (23489, 5, 139);   -- MP
INSERT INTO item_mods (itemId, modId, value) VALUES (23489, 8, 30);    -- STR
INSERT INTO item_mods (itemId, modId, value) VALUES (23489, 9, 35);    -- DEX
INSERT INTO item_mods (itemId, modId, value) VALUES (23489, 10, 35);   -- VIT
INSERT INTO item_mods (itemId, modId, value) VALUES (23489, 11, 30);   -- AGI
INSERT INTO item_mods (itemId, modId, value) VALUES (23489, 12, 45);   -- INT
INSERT INTO item_mods (itemId, modId, value) VALUES (23489, 13, 48);   -- MND
INSERT INTO item_mods (itemId, modId, value) VALUES (23489, 14, 39);   -- CHR
INSERT INTO item_mods (itemId, modId, value) VALUES (23489, 25, 64);   -- ACC
INSERT INTO item_mods (itemId, modId, value) VALUES (23489, 29, 11);   -- MDEF
INSERT INTO item_mods (itemId, modId, value) VALUES (23489, 30, 64);   -- MACC
INSERT INTO item_mods (itemId, modId, value) VALUES (23489, 31, 130);  -- MEVA
INSERT INTO item_mods (itemId, modId, value) VALUES (23489, 68, 91);   -- EVA
INSERT INTO item_mods (itemId, modId, value) VALUES (23489, 112, 34);  -- HEALING (Healing magic skill)
INSERT INTO item_mods (itemId, modId, value) VALUES (23489, 293, 18);  -- AFFLATUS_SOLACE +18
INSERT INTO item_mods (itemId, modId, value) VALUES (23489, 369, 4);   -- REFRESH +4
INSERT INTO item_mods (itemId, modId, value) VALUES (23489, 370, 5);   -- REGEN +5
INSERT INTO item_mods (itemId, modId, value) VALUES (23489, 384, 300); -- HASTE_GEAR +3%

-- ============================================================
-- Ebers Duckbills +3 (23690)  template Ebers Duckbills +2 (23355)
-- DEF:96 HP+71 MP+80 STR+20 DEX+26 VIT+25 AGI+43 INT+32 MND+34 CHR+44
-- Acc+60 MAcc+60 Eva+105 MEva+157 MDB+9 Enhancing+35 Haste+3% "Auspice"+19 Damage taken -11%
-- ============================================================
INSERT INTO item_mods (itemId, modId, value) VALUES (23690, 1, 96);    -- DEF
INSERT INTO item_mods (itemId, modId, value) VALUES (23690, 2, 71);    -- HP
INSERT INTO item_mods (itemId, modId, value) VALUES (23690, 5, 80);    -- MP
INSERT INTO item_mods (itemId, modId, value) VALUES (23690, 8, 20);    -- STR
INSERT INTO item_mods (itemId, modId, value) VALUES (23690, 9, 26);    -- DEX
INSERT INTO item_mods (itemId, modId, value) VALUES (23690, 10, 25);   -- VIT
INSERT INTO item_mods (itemId, modId, value) VALUES (23690, 11, 43);   -- AGI
INSERT INTO item_mods (itemId, modId, value) VALUES (23690, 12, 32);   -- INT
INSERT INTO item_mods (itemId, modId, value) VALUES (23690, 13, 34);   -- MND
INSERT INTO item_mods (itemId, modId, value) VALUES (23690, 14, 44);   -- CHR
INSERT INTO item_mods (itemId, modId, value) VALUES (23690, 25, 60);   -- ACC
INSERT INTO item_mods (itemId, modId, value) VALUES (23690, 29, 9);    -- MDEF
INSERT INTO item_mods (itemId, modId, value) VALUES (23690, 30, 60);   -- MACC
INSERT INTO item_mods (itemId, modId, value) VALUES (23690, 31, 157);  -- MEVA
INSERT INTO item_mods (itemId, modId, value) VALUES (23690, 68, 105);  -- EVA
INSERT INTO item_mods (itemId, modId, value) VALUES (23690, 113, 35);  -- ENHANCE (Enhancing magic skill)
INSERT INTO item_mods (itemId, modId, value) VALUES (23690, 160, -1100); -- DMG Damage taken -11% (unit = %*100)
INSERT INTO item_mods (itemId, modId, value) VALUES (23690, 384, 300); -- HASTE_GEAR +3%
INSERT INTO item_mods (itemId, modId, value) VALUES (23690, 484, 19);  -- AUSPICE_EFFECT +19

-- ============================================================
-- Ebers Mitts +3 (23556)  template Ebers Mitts +2 (23221)
-- DEF:114 HP+65 MP+65 STR+16 DEX+40 VIT+40 AGI+15 INT+34 MND+50 CHR+26
-- Acc+62 MAcc+62 Eva+72 MEva+87 MDB+7 Enmity-12 Haste+3% "Divine Caress"+5 Regen duration+26 Damage taken -11%
-- NOTE: "Divine Caress"+5 has NO item_mods entry (no CARESS mod in mod.lua) -> intentionally omitted.
-- ============================================================
INSERT INTO item_mods (itemId, modId, value) VALUES (23556, 1, 114);   -- DEF
INSERT INTO item_mods (itemId, modId, value) VALUES (23556, 2, 65);    -- HP
INSERT INTO item_mods (itemId, modId, value) VALUES (23556, 5, 65);    -- MP
INSERT INTO item_mods (itemId, modId, value) VALUES (23556, 8, 16);    -- STR
INSERT INTO item_mods (itemId, modId, value) VALUES (23556, 9, 40);    -- DEX
INSERT INTO item_mods (itemId, modId, value) VALUES (23556, 10, 40);   -- VIT
INSERT INTO item_mods (itemId, modId, value) VALUES (23556, 11, 15);   -- AGI
INSERT INTO item_mods (itemId, modId, value) VALUES (23556, 12, 34);   -- INT
INSERT INTO item_mods (itemId, modId, value) VALUES (23556, 13, 50);   -- MND
INSERT INTO item_mods (itemId, modId, value) VALUES (23556, 14, 26);   -- CHR
INSERT INTO item_mods (itemId, modId, value) VALUES (23556, 25, 62);   -- ACC
INSERT INTO item_mods (itemId, modId, value) VALUES (23556, 27, -12);  -- ENMITY -12
INSERT INTO item_mods (itemId, modId, value) VALUES (23556, 29, 7);    -- MDEF
INSERT INTO item_mods (itemId, modId, value) VALUES (23556, 30, 62);   -- MACC
INSERT INTO item_mods (itemId, modId, value) VALUES (23556, 31, 87);   -- MEVA
INSERT INTO item_mods (itemId, modId, value) VALUES (23556, 68, 72);   -- EVA
INSERT INTO item_mods (itemId, modId, value) VALUES (23556, 160, -1100); -- DMG Damage taken -11%
INSERT INTO item_mods (itemId, modId, value) VALUES (23556, 339, 26);  -- REGEN_DURATION +26
INSERT INTO item_mods (itemId, modId, value) VALUES (23556, 384, 300); -- HASTE_GEAR +3%

-- ============================================================
-- Ebers Pantaloons +3 (23623)  template Ebers Pantaloons +2 (23288)
-- DEF:136 HP+71 MP+65 STR+34 VIT+26 AGI+27 INT+47 MND+45 CHR+26
-- Acc+63 MAcc+63 Eva+77 MEva+157 MDB+10 Haste+5% "Divine Benison"+4 Converts 8% "Cure" to MP
-- Healing magic casting time -15% Damage taken -13%
-- ============================================================
INSERT INTO item_mods (itemId, modId, value) VALUES (23623, 1, 136);   -- DEF
INSERT INTO item_mods (itemId, modId, value) VALUES (23623, 2, 71);    -- HP
INSERT INTO item_mods (itemId, modId, value) VALUES (23623, 5, 65);    -- MP
INSERT INTO item_mods (itemId, modId, value) VALUES (23623, 8, 34);    -- STR (wiki +3; note +2 DB row was 26 vs wiki 29)
INSERT INTO item_mods (itemId, modId, value) VALUES (23623, 10, 26);   -- VIT
INSERT INTO item_mods (itemId, modId, value) VALUES (23623, 11, 27);   -- AGI
INSERT INTO item_mods (itemId, modId, value) VALUES (23623, 12, 47);   -- INT
INSERT INTO item_mods (itemId, modId, value) VALUES (23623, 13, 45);   -- MND
INSERT INTO item_mods (itemId, modId, value) VALUES (23623, 14, 26);   -- CHR
INSERT INTO item_mods (itemId, modId, value) VALUES (23623, 25, 63);   -- ACC
INSERT INTO item_mods (itemId, modId, value) VALUES (23623, 29, 10);   -- MDEF
INSERT INTO item_mods (itemId, modId, value) VALUES (23623, 30, 63);   -- MACC
INSERT INTO item_mods (itemId, modId, value) VALUES (23623, 31, 157);  -- MEVA
INSERT INTO item_mods (itemId, modId, value) VALUES (23623, 68, 77);   -- EVA
INSERT INTO item_mods (itemId, modId, value) VALUES (23623, 160, -1300); -- DMG Damage taken -13%
INSERT INTO item_mods (itemId, modId, value) VALUES (23623, 384, 500); -- HASTE_GEAR +5%
INSERT INTO item_mods (itemId, modId, value) VALUES (23623, 860, 8);   -- CURE2MP_PERCENT Converts 8% Cure to MP
INSERT INTO item_mods (itemId, modId, value) VALUES (23623, 910, 4);   -- DIVINE_BENISON +4
-- LOWER CONFIDENCE: template +2 lacked this stat. CURE_CAST_TIME stores positive magnitude of % reduction.
INSERT INTO item_mods (itemId, modId, value) VALUES (23623, 519, 15);  -- CURE_CAST_TIME "Healing magic casting time" -15%

-- Part 2b: +3 stats for 178 stub/near-stub pieces (41 sets) -- BG-wiki sourced,
-- generated via +2-template modId alignment. Implemented pieces left untouched.
-- GPK reforge +3 stats (stubs + near-stubs only; implemented pieces preserved)
DELETE FROM item_mods WHERE itemId IN (23403,23404,23405,23406,23407,23408,23409,23410,23412,23413,23414,23415,23416,23417,23419,23420,23421,23423,23424,23425,23426,23427,23428,23429,23430,23431,23432,23433,23434,23435,23436,23437,23438,23439,23440,23441,23466,23467,23468,23469,23470,23471,23472,23473,23474,23475,23476,23477,23478,23479,23480,23481,23482,23483,23484,23486,23487,23488,23490,23491,23492,23493,23494,23495,23496,23497,23498,23499,23500,23501,23502,23503,23504,23505,23506,23507,23508,23533,23534,23535,23536,23538,23539,23540,23541,23542,23543,23544,23545,23546,23547,23548,23549,23550,23551,23553,23554,23555,23557,23558,23559,23560,23561,23562,23563,23564,23565,23566,23567,23568,23569,23570,23571,23572,23573,23574,23575,23600,23601,23602,23603,23604,23605,23606,23607,23608,23609,23610,23612,23613,23614,23615,23616,23617,23618,23620,23621,23622,23624,23625,23626,23627,23628,23629,23630,23631,23632,23633,23634,23635,23636,23637,23638,23639,23640,23641,23642,23688,23689,23691,23692,23693,23694,23695,23696,23697,23698,23699,23700,23701,23702,23703,23704,23705,23706,23707,23708,23709);
INSERT INTO item_mods (itemId, modId, value) VALUES (23430, 1, 128);
INSERT INTO item_mods (itemId, modId, value) VALUES (23430, 2, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23430, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23430, 9, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23430, 10, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23430, 11, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23430, 12, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23430, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23430, 14, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23430, 24, 71);
INSERT INTO item_mods (itemId, modId, value) VALUES (23430, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23430, 26, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23430, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23430, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23430, 31, 109);
INSERT INTO item_mods (itemId, modId, value) VALUES (23430, 68, 97);
INSERT INTO item_mods (itemId, modId, value) VALUES (23430, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23430, 289, 14);
INSERT INTO item_mods (itemId, modId, value) VALUES (23430, 365, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23430, 384, 800);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 1, 160);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 2, 87);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 5, 89);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 8, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 9, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 10, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 11, 49);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 12, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 13, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 24, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 26, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 27, -13);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 31, 119);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 68, 102);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 423, 11);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 424, 11);
INSERT INTO item_mods (itemId, modId, value) VALUES (23497, 1081, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 1, 118);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 2, 52);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 8, 28);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 9, 49);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 10, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 11, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 12, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 13, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 14, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 24, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 26, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 31, 93);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 68, 77);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 73, 11);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 104, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23564, 826, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 1, 141);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 2, 75);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 5, 68);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 8, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 10, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 11, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 12, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 13, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 14, 18);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 24, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 26, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 29, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 31, 125);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 68, 91);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 73, 12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 160, -1300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 165, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23631, 1053, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23698, 1, 100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23698, 2, 41);
INSERT INTO item_mods (itemId, modId, value) VALUES (23698, 8, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23698, 9, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23698, 10, 19);
INSERT INTO item_mods (itemId, modId, value) VALUES (23698, 11, 56);
INSERT INTO item_mods (itemId, modId, value) VALUES (23698, 13, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23698, 14, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23698, 24, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23698, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23698, 26, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23698, 27, -12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23698, 29, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23698, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23698, 31, 125);
INSERT INTO item_mods (itemId, modId, value) VALUES (23698, 68, 124);
INSERT INTO item_mods (itemId, modId, value) VALUES (23698, 105, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23698, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23698, 841, 12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 1, 123);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 2, 56);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 5, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 8, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 9, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 10, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 11, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 12, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 13, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 14, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 23, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 25, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 29, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 30, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 31, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 68, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 224, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 225, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 226, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 227, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 228, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 229, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 230, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 360, 14);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 384, 800);
INSERT INTO item_mods (itemId, modId, value) VALUES (23406, 841, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23473, 1, 153);
INSERT INTO item_mods (itemId, modId, value) VALUES (23473, 2, 79);
INSERT INTO item_mods (itemId, modId, value) VALUES (23473, 5, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23473, 8, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23473, 9, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23473, 10, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23473, 11, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23473, 12, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23473, 13, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23473, 14, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23473, 23, 65);
INSERT INTO item_mods (itemId, modId, value) VALUES (23473, 25, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23473, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23473, 30, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23473, 31, 84);
INSERT INTO item_mods (itemId, modId, value) VALUES (23473, 68, 69);
INSERT INTO item_mods (itemId, modId, value) VALUES (23473, 360, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23473, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23540, 1, 111);
INSERT INTO item_mods (itemId, modId, value) VALUES (23540, 2, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23540, 8, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23540, 9, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23540, 10, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23540, 11, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23540, 12, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23540, 13, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23540, 14, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23540, 23, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23540, 25, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23540, 29, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23540, 30, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23540, 31, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23540, 68, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23540, 360, 13);
INSERT INTO item_mods (itemId, modId, value) VALUES (23540, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23540, 564, 2);
INSERT INTO item_mods (itemId, modId, value) VALUES (23607, 1, 132);
INSERT INTO item_mods (itemId, modId, value) VALUES (23607, 2, 67);
INSERT INTO item_mods (itemId, modId, value) VALUES (23607, 8, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23607, 9, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23607, 10, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23607, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23607, 12, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23607, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23607, 14, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23607, 23, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23607, 25, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23607, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23607, 30, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23607, 31, 89);
INSERT INTO item_mods (itemId, modId, value) VALUES (23607, 68, 58);
INSERT INTO item_mods (itemId, modId, value) VALUES (23607, 360, 11);
INSERT INTO item_mods (itemId, modId, value) VALUES (23607, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23607, 1152, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23607, 1169, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 1, 123);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 2, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 5, 86);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 8, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 9, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 10, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 11, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 12, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 13, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 14, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 28, 51);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 31, 136);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 68, 83);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 113, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 160, -1000);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 311, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 568, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 569, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23439, 838, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23506, 1, 152);
INSERT INTO item_mods (itemId, modId, value) VALUES (23506, 2, 80);
INSERT INTO item_mods (itemId, modId, value) VALUES (23506, 5, 97);
INSERT INTO item_mods (itemId, modId, value) VALUES (23506, 8, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23506, 9, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23506, 10, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23506, 11, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23506, 12, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23506, 13, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23506, 14, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23506, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23506, 28, 59);
INSERT INTO item_mods (itemId, modId, value) VALUES (23506, 29, 11);
INSERT INTO item_mods (itemId, modId, value) VALUES (23506, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23506, 31, 141);
INSERT INTO item_mods (itemId, modId, value) VALUES (23506, 68, 88);
INSERT INTO item_mods (itemId, modId, value) VALUES (23506, 160, -1300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23506, 311, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23506, 369, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23506, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23573, 1, 112);
INSERT INTO item_mods (itemId, modId, value) VALUES (23573, 2, 48);
INSERT INTO item_mods (itemId, modId, value) VALUES (23573, 5, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23573, 8, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23573, 9, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23573, 10, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23573, 11, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23573, 12, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23573, 13, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23573, 14, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23573, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23573, 27, -12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23573, 28, 52);
INSERT INTO item_mods (itemId, modId, value) VALUES (23573, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23573, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23573, 31, 98);
INSERT INTO item_mods (itemId, modId, value) VALUES (23573, 68, 69);
INSERT INTO item_mods (itemId, modId, value) VALUES (23573, 311, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23573, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23573, 487, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23640, 1, 134);
INSERT INTO item_mods (itemId, modId, value) VALUES (23640, 2, 68);
INSERT INTO item_mods (itemId, modId, value) VALUES (23640, 5, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23640, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23640, 10, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23640, 11, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23640, 12, 53);
INSERT INTO item_mods (itemId, modId, value) VALUES (23640, 13, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23640, 14, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23640, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23640, 28, 54);
INSERT INTO item_mods (itemId, modId, value) VALUES (23640, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23640, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23640, 31, 168);
INSERT INTO item_mods (itemId, modId, value) VALUES (23640, 68, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23640, 114, 28);
INSERT INTO item_mods (itemId, modId, value) VALUES (23640, 160, -1200);
INSERT INTO item_mods (itemId, modId, value) VALUES (23640, 311, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23640, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23707, 1, 95);
INSERT INTO item_mods (itemId, modId, value) VALUES (23707, 2, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23707, 5, 90);
INSERT INTO item_mods (itemId, modId, value) VALUES (23707, 8, 18);
INSERT INTO item_mods (itemId, modId, value) VALUES (23707, 9, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23707, 10, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23707, 11, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23707, 12, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23707, 13, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23707, 14, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23707, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23707, 28, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23707, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23707, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23707, 31, 168);
INSERT INTO item_mods (itemId, modId, value) VALUES (23707, 68, 110);
INSERT INTO item_mods (itemId, modId, value) VALUES (23707, 115, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23707, 311, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23707, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23408, 1, 120);
INSERT INTO item_mods (itemId, modId, value) VALUES (23408, 2, 56);
INSERT INTO item_mods (itemId, modId, value) VALUES (23408, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23408, 9, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23408, 10, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23408, 11, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23408, 12, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23408, 13, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23408, 14, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23408, 24, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23408, 26, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23408, 27, -8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23408, 29, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23408, 30, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23408, 31, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23408, 68, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23408, 305, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23408, 359, 14);
INSERT INTO item_mods (itemId, modId, value) VALUES (23408, 384, 800);
INSERT INTO item_mods (itemId, modId, value) VALUES (23475, 1, 151);
INSERT INTO item_mods (itemId, modId, value) VALUES (23475, 2, 79);
INSERT INTO item_mods (itemId, modId, value) VALUES (23475, 5, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23475, 8, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23475, 9, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23475, 10, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23475, 11, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23475, 12, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23475, 13, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23475, 14, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23475, 24, 65);
INSERT INTO item_mods (itemId, modId, value) VALUES (23475, 26, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23475, 27, -8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23475, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23475, 30, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23475, 31, 84);
INSERT INTO item_mods (itemId, modId, value) VALUES (23475, 68, 69);
INSERT INTO item_mods (itemId, modId, value) VALUES (23475, 359, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23475, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23542, 1, 106);
INSERT INTO item_mods (itemId, modId, value) VALUES (23542, 2, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23542, 8, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23542, 9, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23542, 10, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23542, 11, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23542, 12, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23542, 13, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23542, 14, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23542, 24, 79);
INSERT INTO item_mods (itemId, modId, value) VALUES (23542, 26, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23542, 27, -6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23542, 29, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23542, 30, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23542, 31, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23542, 68, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23542, 365, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23542, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23609, 1, 130);
INSERT INTO item_mods (itemId, modId, value) VALUES (23609, 2, 87);
INSERT INTO item_mods (itemId, modId, value) VALUES (23609, 5, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23609, 8, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23609, 10, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23609, 11, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23609, 12, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23609, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23609, 14, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23609, 24, 81);
INSERT INTO item_mods (itemId, modId, value) VALUES (23609, 26, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23609, 27, -7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23609, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23609, 30, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23609, 31, 89);
INSERT INTO item_mods (itemId, modId, value) VALUES (23609, 68, 58);
INSERT INTO item_mods (itemId, modId, value) VALUES (23609, 365, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23609, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23609, 841, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23468, 1, 145);
INSERT INTO item_mods (itemId, modId, value) VALUES (23468, 2, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23468, 5, 79);
INSERT INTO item_mods (itemId, modId, value) VALUES (23468, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23468, 9, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23468, 10, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23468, 11, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23468, 12, 46);
INSERT INTO item_mods (itemId, modId, value) VALUES (23468, 13, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23468, 14, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23468, 25, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23468, 27, -12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23468, 28, 52);
INSERT INTO item_mods (itemId, modId, value) VALUES (23468, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23468, 30, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23468, 31, 100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23468, 68, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23468, 115, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23468, 369, 3);
INSERT INTO item_mods (itemId, modId, value) VALUES (23468, 394, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 1, 99);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 2, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 5, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 8, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 9, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 10, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 11, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 12, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 13, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 25, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 27, -7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 28, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 29, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 30, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 31, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 68, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 115, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 116, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23535, 487, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23602, 1, 123);
INSERT INTO item_mods (itemId, modId, value) VALUES (23602, 2, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23602, 5, 85);
INSERT INTO item_mods (itemId, modId, value) VALUES (23602, 8, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23602, 10, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23602, 11, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23602, 12, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23602, 13, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23602, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23602, 25, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23602, 27, -7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23602, 28, 58);
INSERT INTO item_mods (itemId, modId, value) VALUES (23602, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23602, 30, 46);
INSERT INTO item_mods (itemId, modId, value) VALUES (23602, 31, 127);
INSERT INTO item_mods (itemId, modId, value) VALUES (23602, 68, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23602, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 1, 128);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 2, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 5, 86);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 8, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 9, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 10, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 11, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 12, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 13, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 14, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 28, 51);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 31, 136);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 68, 83);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 123, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 160, -1200);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 311, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23440, 1025, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 1, 158);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 2, 80);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 5, 97);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 8, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 9, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 10, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 11, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 12, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 13, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 14, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 27, -10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 28, 59);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 29, 11);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 31, 141);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 68, 88);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 115, 28);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 311, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 369, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23507, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 1, 115);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 2, 48);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 5, 80);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 8, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 9, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 10, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 11, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 12, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 13, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 14, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 27, -13);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 28, 52);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 31, 98);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 68, 69);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 114, 28);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 160, -1200);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 311, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23574, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23641, 1, 138);
INSERT INTO item_mods (itemId, modId, value) VALUES (23641, 2, 68);
INSERT INTO item_mods (itemId, modId, value) VALUES (23641, 5, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23641, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23641, 10, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23641, 11, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23641, 12, 55);
INSERT INTO item_mods (itemId, modId, value) VALUES (23641, 13, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23641, 14, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23641, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23641, 28, 58);
INSERT INTO item_mods (itemId, modId, value) VALUES (23641, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23641, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23641, 31, 168);
INSERT INTO item_mods (itemId, modId, value) VALUES (23641, 68, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23641, 116, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23641, 311, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23641, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23641, 487, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23708, 1, 98);
INSERT INTO item_mods (itemId, modId, value) VALUES (23708, 2, 59);
INSERT INTO item_mods (itemId, modId, value) VALUES (23708, 5, 70);
INSERT INTO item_mods (itemId, modId, value) VALUES (23708, 8, 18);
INSERT INTO item_mods (itemId, modId, value) VALUES (23708, 9, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23708, 10, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23708, 11, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23708, 12, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23708, 13, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23708, 14, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23708, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23708, 28, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23708, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23708, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23708, 31, 168);
INSERT INTO item_mods (itemId, modId, value) VALUES (23708, 68, 110);
INSERT INTO item_mods (itemId, modId, value) VALUES (23708, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23708, 311, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23708, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23434, 1, 123);
INSERT INTO item_mods (itemId, modId, value) VALUES (23434, 2, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23434, 5, 154);
INSERT INTO item_mods (itemId, modId, value) VALUES (23434, 8, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23434, 9, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23434, 10, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23434, 11, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23434, 12, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23434, 13, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23434, 14, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23434, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23434, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23434, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23434, 31, 130);
INSERT INTO item_mods (itemId, modId, value) VALUES (23434, 68, 86);
INSERT INTO item_mods (itemId, modId, value) VALUES (23434, 117, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23434, 160, -1000);
INSERT INTO item_mods (itemId, modId, value) VALUES (23434, 369, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23434, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23434, 1154, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23501, 1, 153);
INSERT INTO item_mods (itemId, modId, value) VALUES (23501, 2, 84);
INSERT INTO item_mods (itemId, modId, value) VALUES (23501, 5, 171);
INSERT INTO item_mods (itemId, modId, value) VALUES (23501, 8, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23501, 9, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23501, 10, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23501, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23501, 12, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23501, 13, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23501, 14, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23501, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23501, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23501, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23501, 31, 130);
INSERT INTO item_mods (itemId, modId, value) VALUES (23501, 68, 94);
INSERT INTO item_mods (itemId, modId, value) VALUES (23501, 117, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23501, 160, -1300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23501, 346, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23501, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23568, 1, 112);
INSERT INTO item_mods (itemId, modId, value) VALUES (23568, 2, 48);
INSERT INTO item_mods (itemId, modId, value) VALUES (23568, 5, 114);
INSERT INTO item_mods (itemId, modId, value) VALUES (23568, 8, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23568, 9, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23568, 10, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23568, 11, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23568, 12, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23568, 13, 48);
INSERT INTO item_mods (itemId, modId, value) VALUES (23568, 14, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23568, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23568, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23568, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23568, 31, 93);
INSERT INTO item_mods (itemId, modId, value) VALUES (23568, 68, 72);
INSERT INTO item_mods (itemId, modId, value) VALUES (23568, 74, 140);
INSERT INTO item_mods (itemId, modId, value) VALUES (23568, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23568, 1170, 1);
INSERT INTO item_mods (itemId, modId, value) VALUES (23568, 1171, 1);
INSERT INTO item_mods (itemId, modId, value) VALUES (23635, 1, 132);
INSERT INTO item_mods (itemId, modId, value) VALUES (23635, 2, 71);
INSERT INTO item_mods (itemId, modId, value) VALUES (23635, 5, 136);
INSERT INTO item_mods (itemId, modId, value) VALUES (23635, 8, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23635, 10, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23635, 11, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23635, 12, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23635, 13, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23635, 14, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23635, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23635, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23635, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23635, 31, 157);
INSERT INTO item_mods (itemId, modId, value) VALUES (23635, 68, 83);
INSERT INTO item_mods (itemId, modId, value) VALUES (23635, 117, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23635, 160, -1200);
INSERT INTO item_mods (itemId, modId, value) VALUES (23635, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23635, 913, 14);
INSERT INTO item_mods (itemId, modId, value) VALUES (23635, 995, 700);
INSERT INTO item_mods (itemId, modId, value) VALUES (23702, 1, 91);
INSERT INTO item_mods (itemId, modId, value) VALUES (23702, 2, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23702, 5, 117);
INSERT INTO item_mods (itemId, modId, value) VALUES (23702, 8, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23702, 9, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23702, 10, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23702, 11, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23702, 12, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23702, 13, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23702, 14, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23702, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23702, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23702, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23702, 31, 168);
INSERT INTO item_mods (itemId, modId, value) VALUES (23702, 68, 105);
INSERT INTO item_mods (itemId, modId, value) VALUES (23702, 346, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23702, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23702, 540, 80);
INSERT INTO item_mods (itemId, modId, value) VALUES (23421, 1, 127);
INSERT INTO item_mods (itemId, modId, value) VALUES (23421, 2, 66);
INSERT INTO item_mods (itemId, modId, value) VALUES (23421, 8, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23421, 9, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23421, 10, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23421, 11, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23421, 12, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23421, 13, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23421, 14, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23421, 23, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23421, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23421, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23421, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23421, 31, 98);
INSERT INTO item_mods (itemId, modId, value) VALUES (23421, 68, 91);
INSERT INTO item_mods (itemId, modId, value) VALUES (23421, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23421, 289, 14);
INSERT INTO item_mods (itemId, modId, value) VALUES (23421, 384, 900);
INSERT INTO item_mods (itemId, modId, value) VALUES (23421, 428, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23488, 1, 155);
INSERT INTO item_mods (itemId, modId, value) VALUES (23488, 2, 89);
INSERT INTO item_mods (itemId, modId, value) VALUES (23488, 8, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23488, 9, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23488, 10, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23488, 11, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23488, 12, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23488, 13, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23488, 14, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23488, 23, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23488, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23488, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23488, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23488, 31, 109);
INSERT INTO item_mods (itemId, modId, value) VALUES (23488, 68, 105);
INSERT INTO item_mods (itemId, modId, value) VALUES (23488, 173, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23488, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23488, 841, 12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23488, 1097, 2);
INSERT INTO item_mods (itemId, modId, value) VALUES (23555, 1, 113);
INSERT INTO item_mods (itemId, modId, value) VALUES (23555, 2, 55);
INSERT INTO item_mods (itemId, modId, value) VALUES (23555, 8, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23555, 9, 49);
INSERT INTO item_mods (itemId, modId, value) VALUES (23555, 10, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23555, 11, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23555, 12, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23555, 13, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23555, 14, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23555, 23, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23555, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23555, 29, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23555, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23555, 31, 82);
INSERT INTO item_mods (itemId, modId, value) VALUES (23555, 68, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23555, 80, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23555, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23555, 899, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23622, 1, 140);
INSERT INTO item_mods (itemId, modId, value) VALUES (23622, 2, 77);
INSERT INTO item_mods (itemId, modId, value) VALUES (23622, 8, 49);
INSERT INTO item_mods (itemId, modId, value) VALUES (23622, 10, 28);
INSERT INTO item_mods (itemId, modId, value) VALUES (23622, 11, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23622, 12, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23622, 13, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23622, 14, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23622, 23, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23622, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23622, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23622, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23622, 31, 119);
INSERT INTO item_mods (itemId, modId, value) VALUES (23622, 68, 86);
INSERT INTO item_mods (itemId, modId, value) VALUES (23622, 73, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23622, 160, -1400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23622, 292, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23622, 384, 700);
INSERT INTO item_mods (itemId, modId, value) VALUES (23689, 1, 98);
INSERT INTO item_mods (itemId, modId, value) VALUES (23689, 2, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23689, 8, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23689, 9, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23689, 10, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23689, 11, 49);
INSERT INTO item_mods (itemId, modId, value) VALUES (23689, 13, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23689, 14, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23689, 23, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23689, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23689, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23689, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23689, 31, 119);
INSERT INTO item_mods (itemId, modId, value) VALUES (23689, 68, 122);
INSERT INTO item_mods (itemId, modId, value) VALUES (23689, 160, -1000);
INSERT INTO item_mods (itemId, modId, value) VALUES (23689, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23689, 386, 65);
INSERT INTO item_mods (itemId, modId, value) VALUES (23689, 429, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 1, 115);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 2, 56);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 5, 52);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 8, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 9, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 10, 28);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 11, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 12, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 14, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 23, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 25, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 27, -9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 30, 51);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 31, 95);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 68, 58);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 119, 18);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 161, -600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 164, -600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23407, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23474, 1, 145);
INSERT INTO item_mods (itemId, modId, value) VALUES (23474, 2, 89);
INSERT INTO item_mods (itemId, modId, value) VALUES (23474, 5, 94);
INSERT INTO item_mods (itemId, modId, value) VALUES (23474, 8, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23474, 9, 41);
INSERT INTO item_mods (itemId, modId, value) VALUES (23474, 10, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23474, 11, 41);
INSERT INTO item_mods (itemId, modId, value) VALUES (23474, 12, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23474, 13, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23474, 14, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23474, 23, 92);
INSERT INTO item_mods (itemId, modId, value) VALUES (23474, 25, 53);
INSERT INTO item_mods (itemId, modId, value) VALUES (23474, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23474, 30, 54);
INSERT INTO item_mods (itemId, modId, value) VALUES (23474, 31, 100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23474, 68, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23474, 160, -700);
INSERT INTO item_mods (itemId, modId, value) VALUES (23474, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23474, 841, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 1, 104);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 2, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 5, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 8, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 9, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 10, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 11, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 12, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 13, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 14, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 23, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 25, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 27, -9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 29, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 30, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 31, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 68, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 121, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 161, -500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 164, -500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23541, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23608, 1, 127);
INSERT INTO item_mods (itemId, modId, value) VALUES (23608, 2, 103);
INSERT INTO item_mods (itemId, modId, value) VALUES (23608, 5, 89);
INSERT INTO item_mods (itemId, modId, value) VALUES (23608, 8, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23608, 10, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23608, 11, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23608, 12, 54);
INSERT INTO item_mods (itemId, modId, value) VALUES (23608, 13, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23608, 14, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23608, 23, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23608, 25, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23608, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23608, 30, 52);
INSERT INTO item_mods (itemId, modId, value) VALUES (23608, 31, 127);
INSERT INTO item_mods (itemId, modId, value) VALUES (23608, 68, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23608, 161, -600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23608, 164, -600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23608, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23420, 1, 144);
INSERT INTO item_mods (itemId, modId, value) VALUES (23420, 2, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23420, 8, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23420, 9, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23420, 10, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23420, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23420, 12, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23420, 13, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23420, 14, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23420, 23, 71);
INSERT INTO item_mods (itemId, modId, value) VALUES (23420, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23420, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23420, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23420, 31, 98);
INSERT INTO item_mods (itemId, modId, value) VALUES (23420, 68, 86);
INSERT INTO item_mods (itemId, modId, value) VALUES (23420, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23420, 165, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23420, 288, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23420, 384, 700);
INSERT INTO item_mods (itemId, modId, value) VALUES (23487, 1, 174);
INSERT INTO item_mods (itemId, modId, value) VALUES (23487, 2, 96);
INSERT INTO item_mods (itemId, modId, value) VALUES (23487, 8, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23487, 9, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23487, 10, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23487, 11, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23487, 12, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23487, 13, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23487, 14, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23487, 23, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23487, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23487, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23487, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23487, 31, 109);
INSERT INTO item_mods (itemId, modId, value) VALUES (23487, 68, 94);
INSERT INTO item_mods (itemId, modId, value) VALUES (23487, 73, 11);
INSERT INTO item_mods (itemId, modId, value) VALUES (23487, 85, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23487, 160, -1400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23487, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23487, 1046, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23554, 1, 130);
INSERT INTO item_mods (itemId, modId, value) VALUES (23554, 2, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23554, 8, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23554, 9, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23554, 10, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23554, 11, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23554, 12, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23554, 13, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23554, 14, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23554, 23, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23554, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23554, 29, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23554, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23554, 31, 82);
INSERT INTO item_mods (itemId, modId, value) VALUES (23554, 68, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23554, 84, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23554, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23554, 841, 12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23554, 1045, 130);
INSERT INTO item_mods (itemId, modId, value) VALUES (23621, 1, 155);
INSERT INTO item_mods (itemId, modId, value) VALUES (23621, 2, 80);
INSERT INTO item_mods (itemId, modId, value) VALUES (23621, 8, 53);
INSERT INTO item_mods (itemId, modId, value) VALUES (23621, 10, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23621, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23621, 12, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23621, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23621, 14, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23621, 23, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23621, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23621, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23621, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23621, 31, 130);
INSERT INTO item_mods (itemId, modId, value) VALUES (23621, 68, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23621, 288, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23621, 345, 100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23621, 384, 800);
INSERT INTO item_mods (itemId, modId, value) VALUES (23621, 903, 100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23621, 904, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23688, 1, 112);
INSERT INTO item_mods (itemId, modId, value) VALUES (23688, 2, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23688, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23688, 9, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23688, 10, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23688, 11, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23688, 13, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23688, 14, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23688, 23, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23688, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23688, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23688, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23688, 31, 130);
INSERT INTO item_mods (itemId, modId, value) VALUES (23688, 68, 105);
INSERT INTO item_mods (itemId, modId, value) VALUES (23688, 160, -1000);
INSERT INTO item_mods (itemId, modId, value) VALUES (23688, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23688, 414, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23688, 421, 13);
INSERT INTO item_mods (itemId, modId, value) VALUES (23404, 1, 140);
INSERT INTO item_mods (itemId, modId, value) VALUES (23404, 2, 116);
INSERT INTO item_mods (itemId, modId, value) VALUES (23404, 5, 98);
INSERT INTO item_mods (itemId, modId, value) VALUES (23404, 8, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23404, 9, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23404, 10, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23404, 11, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23404, 12, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23404, 13, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23404, 14, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23404, 23, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23404, 25, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23404, 27, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23404, 29, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23404, 30, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23404, 31, 52);
INSERT INTO item_mods (itemId, modId, value) VALUES (23404, 68, 53);
INSERT INTO item_mods (itemId, modId, value) VALUES (23404, 92, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23404, 384, 700);
INSERT INTO item_mods (itemId, modId, value) VALUES (23471, 1, 171);
INSERT INTO item_mods (itemId, modId, value) VALUES (23471, 2, 138);
INSERT INTO item_mods (itemId, modId, value) VALUES (23471, 5, 110);
INSERT INTO item_mods (itemId, modId, value) VALUES (23471, 8, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23471, 9, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23471, 10, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23471, 11, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23471, 12, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23471, 13, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23471, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23471, 23, 65);
INSERT INTO item_mods (itemId, modId, value) VALUES (23471, 25, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23471, 27, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23471, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23471, 30, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23471, 31, 68);
INSERT INTO item_mods (itemId, modId, value) VALUES (23471, 68, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23471, 160, -1200);
INSERT INTO item_mods (itemId, modId, value) VALUES (23471, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23471, 965, 41);
INSERT INTO item_mods (itemId, modId, value) VALUES (23538, 1, 125);
INSERT INTO item_mods (itemId, modId, value) VALUES (23538, 2, 124);
INSERT INTO item_mods (itemId, modId, value) VALUES (23538, 8, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23538, 9, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23538, 10, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23538, 12, 18);
INSERT INTO item_mods (itemId, modId, value) VALUES (23538, 13, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23538, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23538, 23, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23538, 25, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23538, 27, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23538, 29, 3);
INSERT INTO item_mods (itemId, modId, value) VALUES (23538, 30, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23538, 31, 46);
INSERT INTO item_mods (itemId, modId, value) VALUES (23538, 68, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23538, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23538, 385, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23605, 1, 151);
INSERT INTO item_mods (itemId, modId, value) VALUES (23605, 2, 72);
INSERT INTO item_mods (itemId, modId, value) VALUES (23605, 5, 100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23605, 8, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23605, 10, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23605, 11, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23605, 12, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23605, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23605, 14, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23605, 23, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23605, 25, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23605, 27, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23605, 29, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23605, 30, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23605, 31, 84);
INSERT INTO item_mods (itemId, modId, value) VALUES (23605, 68, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23605, 161, -700);
INSERT INTO item_mods (itemId, modId, value) VALUES (23605, 164, -700);
INSERT INTO item_mods (itemId, modId, value) VALUES (23605, 168, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23605, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23436, 1, 130);
INSERT INTO item_mods (itemId, modId, value) VALUES (23436, 2, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23436, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23436, 9, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23436, 10, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23436, 11, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23436, 12, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23436, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23436, 14, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23436, 24, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23436, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23436, 26, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23436, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23436, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23436, 31, 109);
INSERT INTO item_mods (itemId, modId, value) VALUES (23436, 68, 97);
INSERT INTO item_mods (itemId, modId, value) VALUES (23436, 160, -1000);
INSERT INTO item_mods (itemId, modId, value) VALUES (23436, 359, 18);
INSERT INTO item_mods (itemId, modId, value) VALUES (23436, 384, 800);
INSERT INTO item_mods (itemId, modId, value) VALUES (23436, 893, 100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 1, 161);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 2, 87);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 5, 89);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 8, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 9, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 10, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 11, 49);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 12, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 13, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 24, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 26, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 31, 119);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 68, 102);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 160, -1300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 467, 14);
INSERT INTO item_mods (itemId, modId, value) VALUES (23503, 895, 100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 1, 120);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 2, 52);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 8, 28);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 9, 49);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 10, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 11, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 12, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 13, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 14, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 24, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 26, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 31, 93);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 68, 77);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 165, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 841, 12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 882, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23570, 894, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 1, 143);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 2, 75);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 5, 68);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 8, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 9, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 10, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 11, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 12, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 13, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 14, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 24, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 26, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 29, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 31, 125);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 68, 91);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 73, 12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 160, -1200);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 365, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23637, 892, 100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23704, 1, 99);
INSERT INTO item_mods (itemId, modId, value) VALUES (23704, 2, 41);
INSERT INTO item_mods (itemId, modId, value) VALUES (23704, 8, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23704, 9, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23704, 10, 19);
INSERT INTO item_mods (itemId, modId, value) VALUES (23704, 11, 56);
INSERT INTO item_mods (itemId, modId, value) VALUES (23704, 13, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23704, 14, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23704, 24, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23704, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23704, 26, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23704, 28, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23704, 29, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23704, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23704, 31, 125);
INSERT INTO item_mods (itemId, modId, value) VALUES (23704, 68, 124);
INSERT INTO item_mods (itemId, modId, value) VALUES (23704, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23704, 411, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23704, 891, 100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 1, 148);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 2, 145);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 5, 129);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 8, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 9, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 10, 58);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 12, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 13, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 14, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 23, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 31, 103);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 68, 80);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 109, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 170, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 384, 700);
INSERT INTO item_mods (itemId, modId, value) VALUES (23426, 426, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23493, 1, 180);
INSERT INTO item_mods (itemId, modId, value) VALUES (23493, 2, 151);
INSERT INTO item_mods (itemId, modId, value) VALUES (23493, 5, 144);
INSERT INTO item_mods (itemId, modId, value) VALUES (23493, 8, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23493, 9, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23493, 10, 52);
INSERT INTO item_mods (itemId, modId, value) VALUES (23493, 11, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23493, 12, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23493, 13, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23493, 14, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23493, 23, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23493, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23493, 27, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23493, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23493, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23493, 31, 119);
INSERT INTO item_mods (itemId, modId, value) VALUES (23493, 68, 86);
INSERT INTO item_mods (itemId, modId, value) VALUES (23493, 168, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23493, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23627, 1, 160);
INSERT INTO item_mods (itemId, modId, value) VALUES (23627, 2, 127);
INSERT INTO item_mods (itemId, modId, value) VALUES (23627, 5, 71);
INSERT INTO item_mods (itemId, modId, value) VALUES (23627, 8, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23627, 10, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23627, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23627, 12, 41);
INSERT INTO item_mods (itemId, modId, value) VALUES (23627, 13, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23627, 14, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23627, 23, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23627, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23627, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23627, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23627, 31, 136);
INSERT INTO item_mods (itemId, modId, value) VALUES (23627, 68, 69);
INSERT INTO item_mods (itemId, modId, value) VALUES (23627, 160, -1300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23627, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23627, 427, 14);
INSERT INTO item_mods (itemId, modId, value) VALUES (23560, 1, 136);
INSERT INTO item_mods (itemId, modId, value) VALUES (23560, 2, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23560, 5, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23560, 8, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23560, 9, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23560, 10, 54);
INSERT INTO item_mods (itemId, modId, value) VALUES (23560, 12, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23560, 13, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23560, 14, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23560, 23, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23560, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23560, 29, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23560, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23560, 31, 98);
INSERT INTO item_mods (itemId, modId, value) VALUES (23560, 68, 69);
INSERT INTO item_mods (itemId, modId, value) VALUES (23560, 82, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23560, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23560, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23560, 905, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23694, 1, 121);
INSERT INTO item_mods (itemId, modId, value) VALUES (23694, 2, 52);
INSERT INTO item_mods (itemId, modId, value) VALUES (23694, 5, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23694, 8, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23694, 9, 28);
INSERT INTO item_mods (itemId, modId, value) VALUES (23694, 10, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23694, 11, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23694, 13, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23694, 14, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23694, 23, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23694, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23694, 27, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23694, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23694, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23694, 31, 136);
INSERT INTO item_mods (itemId, modId, value) VALUES (23694, 68, 94);
INSERT INTO item_mods (itemId, modId, value) VALUES (23694, 170, 13);
INSERT INTO item_mods (itemId, modId, value) VALUES (23694, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23694, 1062, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 1, 135);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 2, 111);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 5, 65);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 8, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 9, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 10, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 12, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 13, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 14, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 23, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 29, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 31, 119);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 68, 92);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 168, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 384, 800);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 529, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 890, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23441, 1013, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23575, 1, 124);
INSERT INTO item_mods (itemId, modId, value) VALUES (23575, 2, 59);
INSERT INTO item_mods (itemId, modId, value) VALUES (23575, 5, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23575, 8, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23575, 9, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23575, 10, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23575, 11, 17);
INSERT INTO item_mods (itemId, modId, value) VALUES (23575, 12, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23575, 13, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23575, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23575, 23, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23575, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23575, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23575, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23575, 31, 87);
INSERT INTO item_mods (itemId, modId, value) VALUES (23575, 68, 78);
INSERT INTO item_mods (itemId, modId, value) VALUES (23575, 83, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23575, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23575, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23575, 958, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 1, 105);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 2, 48);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 5, 59);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 9, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 10, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 11, 48);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 13, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 14, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 15, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 16, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 17, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 18, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 19, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 20, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 21, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 22, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 23, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 27, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 29, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 31, 157);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 68, 122);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23709, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23642, 1, 147);
INSERT INTO item_mods (itemId, modId, value) VALUES (23642, 2, 100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23642, 5, 94);
INSERT INTO item_mods (itemId, modId, value) VALUES (23642, 8, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23642, 10, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23642, 11, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23642, 12, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23642, 13, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23642, 14, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23642, 23, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23642, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23642, 27, 13);
INSERT INTO item_mods (itemId, modId, value) VALUES (23642, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23642, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23642, 31, 157);
INSERT INTO item_mods (itemId, modId, value) VALUES (23642, 68, 89);
INSERT INTO item_mods (itemId, modId, value) VALUES (23642, 160, -1300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23642, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23642, 963, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23508, 1, 167);
INSERT INTO item_mods (itemId, modId, value) VALUES (23508, 2, 143);
INSERT INTO item_mods (itemId, modId, value) VALUES (23508, 5, 91);
INSERT INTO item_mods (itemId, modId, value) VALUES (23508, 8, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23508, 9, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23508, 10, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23508, 11, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23508, 12, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23508, 13, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23508, 14, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23508, 23, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23508, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23508, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23508, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23508, 31, 130);
INSERT INTO item_mods (itemId, modId, value) VALUES (23508, 68, 97);
INSERT INTO item_mods (itemId, modId, value) VALUES (23508, 170, 13);
INSERT INTO item_mods (itemId, modId, value) VALUES (23508, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23508, 426, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23508, 427, 14);
INSERT INTO item_mods (itemId, modId, value) VALUES (23405, 1, 134);
INSERT INTO item_mods (itemId, modId, value) VALUES (23405, 2, 96);
INSERT INTO item_mods (itemId, modId, value) VALUES (23405, 5, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23405, 8, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23405, 9, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23405, 10, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23405, 11, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23405, 12, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23405, 13, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23405, 14, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23405, 23, 77);
INSERT INTO item_mods (itemId, modId, value) VALUES (23405, 25, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23405, 29, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23405, 30, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23405, 31, 52);
INSERT INTO item_mods (itemId, modId, value) VALUES (23405, 68, 53);
INSERT INTO item_mods (itemId, modId, value) VALUES (23405, 384, 700);
INSERT INTO item_mods (itemId, modId, value) VALUES (23405, 1071, -12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23472, 1, 166);
INSERT INTO item_mods (itemId, modId, value) VALUES (23472, 2, 103);
INSERT INTO item_mods (itemId, modId, value) VALUES (23472, 5, 75);
INSERT INTO item_mods (itemId, modId, value) VALUES (23472, 8, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23472, 9, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23472, 10, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23472, 11, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23472, 12, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23472, 13, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23472, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23472, 23, 82);
INSERT INTO item_mods (itemId, modId, value) VALUES (23472, 25, 48);
INSERT INTO item_mods (itemId, modId, value) VALUES (23472, 28, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23472, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23472, 30, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23472, 31, 68);
INSERT INTO item_mods (itemId, modId, value) VALUES (23472, 48, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23472, 68, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23472, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23472, 407, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23539, 1, 122);
INSERT INTO item_mods (itemId, modId, value) VALUES (23539, 2, 49);
INSERT INTO item_mods (itemId, modId, value) VALUES (23539, 8, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23539, 9, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23539, 10, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23539, 12, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23539, 13, 41);
INSERT INTO item_mods (itemId, modId, value) VALUES (23539, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23539, 23, 77);
INSERT INTO item_mods (itemId, modId, value) VALUES (23539, 25, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23539, 28, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23539, 29, 3);
INSERT INTO item_mods (itemId, modId, value) VALUES (23539, 30, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23539, 31, 46);
INSERT INTO item_mods (itemId, modId, value) VALUES (23539, 68, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23539, 116, 18);
INSERT INTO item_mods (itemId, modId, value) VALUES (23539, 315, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23539, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23606, 1, 150);
INSERT INTO item_mods (itemId, modId, value) VALUES (23606, 2, 97);
INSERT INTO item_mods (itemId, modId, value) VALUES (23606, 5, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23606, 8, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23606, 10, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23606, 11, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23606, 12, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23606, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23606, 14, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23606, 23, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23606, 25, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23606, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23606, 30, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23606, 31, 84);
INSERT INTO item_mods (itemId, modId, value) VALUES (23606, 68, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23606, 116, 18);
INSERT INTO item_mods (itemId, modId, value) VALUES (23606, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23606, 841, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23429, 1, 125);
INSERT INTO item_mods (itemId, modId, value) VALUES (23429, 2, 66);
INSERT INTO item_mods (itemId, modId, value) VALUES (23429, 5, 65);
INSERT INTO item_mods (itemId, modId, value) VALUES (23429, 8, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23429, 9, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23429, 10, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23429, 11, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23429, 12, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23429, 13, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23429, 14, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23429, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23429, 27, -11);
INSERT INTO item_mods (itemId, modId, value) VALUES (23429, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23429, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23429, 31, 130);
INSERT INTO item_mods (itemId, modId, value) VALUES (23429, 68, 88);
INSERT INTO item_mods (itemId, modId, value) VALUES (23429, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23429, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23429, 438, 1);
INSERT INTO item_mods (itemId, modId, value) VALUES (23429, 455, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 1, 155);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 2, 84);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 5, 100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 8, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 9, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 10, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 11, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 12, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 13, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 14, 48);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 29, 11);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 31, 136);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 68, 94);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 119, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 121, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 370, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 434, 1);
INSERT INTO item_mods (itemId, modId, value) VALUES (23496, 454, 14);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 1, 114);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 2, 52);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 5, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 8, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 9, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 10, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 11, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 12, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 13, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 14, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 31, 93);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 68, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 119, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 120, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 121, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23563, 443, 1);
INSERT INTO item_mods (itemId, modId, value) VALUES (23630, 1, 137);
INSERT INTO item_mods (itemId, modId, value) VALUES (23630, 2, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23630, 5, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23630, 8, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23630, 10, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23630, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23630, 12, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23630, 13, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23630, 14, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23630, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23630, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23630, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23630, 31, 157);
INSERT INTO item_mods (itemId, modId, value) VALUES (23630, 68, 88);
INSERT INTO item_mods (itemId, modId, value) VALUES (23630, 119, 28);
INSERT INTO item_mods (itemId, modId, value) VALUES (23630, 160, -1300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23630, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23630, 442, 1);
INSERT INTO item_mods (itemId, modId, value) VALUES (23630, 833, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23697, 1, 96);
INSERT INTO item_mods (itemId, modId, value) VALUES (23697, 2, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23697, 5, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23697, 8, 17);
INSERT INTO item_mods (itemId, modId, value) VALUES (23697, 9, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23697, 10, 17);
INSERT INTO item_mods (itemId, modId, value) VALUES (23697, 11, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23697, 12, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23697, 13, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23697, 14, 53);
INSERT INTO item_mods (itemId, modId, value) VALUES (23697, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23697, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23697, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23697, 31, 157);
INSERT INTO item_mods (itemId, modId, value) VALUES (23697, 68, 113);
INSERT INTO item_mods (itemId, modId, value) VALUES (23697, 76, 18);
INSERT INTO item_mods (itemId, modId, value) VALUES (23697, 170, 13);
INSERT INTO item_mods (itemId, modId, value) VALUES (23697, 370, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23697, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23697, 451, 1);
INSERT INTO item_mods (itemId, modId, value) VALUES (23419, 1, 124);
INSERT INTO item_mods (itemId, modId, value) VALUES (23419, 2, 56);
INSERT INTO item_mods (itemId, modId, value) VALUES (23419, 5, 88);
INSERT INTO item_mods (itemId, modId, value) VALUES (23419, 8, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23419, 9, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23419, 10, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23419, 11, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23419, 12, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23419, 13, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23419, 14, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23419, 23, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23419, 25, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23419, 29, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23419, 30, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23419, 31, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23419, 68, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23419, 161, -600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23419, 164, -600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23419, 384, 800);
INSERT INTO item_mods (itemId, modId, value) VALUES (23419, 1182, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23486, 1, 156);
INSERT INTO item_mods (itemId, modId, value) VALUES (23486, 2, 119);
INSERT INTO item_mods (itemId, modId, value) VALUES (23486, 5, 104);
INSERT INTO item_mods (itemId, modId, value) VALUES (23486, 8, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23486, 9, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23486, 10, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23486, 11, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23486, 12, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23486, 13, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23486, 14, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23486, 23, 65);
INSERT INTO item_mods (itemId, modId, value) VALUES (23486, 25, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23486, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23486, 30, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23486, 31, 84);
INSERT INTO item_mods (itemId, modId, value) VALUES (23486, 68, 69);
INSERT INTO item_mods (itemId, modId, value) VALUES (23486, 160, -900);
INSERT INTO item_mods (itemId, modId, value) VALUES (23486, 370, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23486, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23486, 1009, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23553, 1, 112);
INSERT INTO item_mods (itemId, modId, value) VALUES (23553, 2, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23553, 8, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23553, 9, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23553, 10, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23553, 11, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23553, 12, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23553, 13, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23553, 14, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23553, 23, 81);
INSERT INTO item_mods (itemId, modId, value) VALUES (23553, 25, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23553, 27, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23553, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23553, 30, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23553, 31, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23553, 68, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23553, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23553, 1008, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23620, 1, 139);
INSERT INTO item_mods (itemId, modId, value) VALUES (23620, 2, 107);
INSERT INTO item_mods (itemId, modId, value) VALUES (23620, 8, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23620, 10, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23620, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23620, 12, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23620, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23620, 14, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23620, 23, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23620, 25, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23620, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23620, 30, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23620, 31, 89);
INSERT INTO item_mods (itemId, modId, value) VALUES (23620, 68, 58);
INSERT INTO item_mods (itemId, modId, value) VALUES (23620, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23620, 890, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23412, 1, 113);
INSERT INTO item_mods (itemId, modId, value) VALUES (23412, 2, 51);
INSERT INTO item_mods (itemId, modId, value) VALUES (23412, 5, 115);
INSERT INTO item_mods (itemId, modId, value) VALUES (23412, 8, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23412, 9, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23412, 10, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23412, 11, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23412, 12, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23412, 13, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23412, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23412, 23, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23412, 25, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23412, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23412, 30, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23412, 31, 95);
INSERT INTO item_mods (itemId, modId, value) VALUES (23412, 68, 56);
INSERT INTO item_mods (itemId, modId, value) VALUES (23412, 346, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23412, 357, -10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23412, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23479, 1, 143);
INSERT INTO item_mods (itemId, modId, value) VALUES (23479, 2, 70);
INSERT INTO item_mods (itemId, modId, value) VALUES (23479, 5, 135);
INSERT INTO item_mods (itemId, modId, value) VALUES (23479, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23479, 9, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23479, 10, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23479, 11, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23479, 12, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23479, 13, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23479, 14, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23479, 23, 65);
INSERT INTO item_mods (itemId, modId, value) VALUES (23479, 25, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23479, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23479, 30, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23479, 31, 100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23479, 68, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23479, 346, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23479, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23479, 541, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23546, 1, 101);
INSERT INTO item_mods (itemId, modId, value) VALUES (23546, 2, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23546, 5, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23546, 8, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23546, 9, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23546, 10, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23546, 11, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23546, 12, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23546, 13, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23546, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23546, 23, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23546, 25, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23546, 29, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23546, 30, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23546, 31, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23546, 68, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23546, 117, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23546, 357, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23546, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23613, 1, 123);
INSERT INTO item_mods (itemId, modId, value) VALUES (23613, 2, 58);
INSERT INTO item_mods (itemId, modId, value) VALUES (23613, 5, 105);
INSERT INTO item_mods (itemId, modId, value) VALUES (23613, 8, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23613, 10, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23613, 11, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23613, 12, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23613, 13, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23613, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23613, 23, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23613, 25, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23613, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23613, 30, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23613, 31, 127);
INSERT INTO item_mods (itemId, modId, value) VALUES (23613, 68, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23613, 357, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23613, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 1, 132);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 2, 66);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 5, 65);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 8, 28);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 9, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 10, 28);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 11, 28);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 12, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 13, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 14, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 23, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 28, 51);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 31, 125);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 68, 88);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 82, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 384, 800);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 841, 12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23435, 1140, 28);
INSERT INTO item_mods (itemId, modId, value) VALUES (23502, 1, 164);
INSERT INTO item_mods (itemId, modId, value) VALUES (23502, 2, 87);
INSERT INTO item_mods (itemId, modId, value) VALUES (23502, 5, 91);
INSERT INTO item_mods (itemId, modId, value) VALUES (23502, 8, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23502, 9, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23502, 10, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23502, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23502, 12, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23502, 13, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23502, 14, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23502, 23, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23502, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23502, 28, 54);
INSERT INTO item_mods (itemId, modId, value) VALUES (23502, 29, 11);
INSERT INTO item_mods (itemId, modId, value) VALUES (23502, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23502, 31, 136);
INSERT INTO item_mods (itemId, modId, value) VALUES (23502, 68, 91);
INSERT INTO item_mods (itemId, modId, value) VALUES (23502, 160, -1300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23502, 369, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23502, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 1, 120);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 2, 55);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 5, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 8, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 9, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 10, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 11, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 12, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 13, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 23, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 27, -6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 28, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 31, 87);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 68, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 160, -1000);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23569, 1147, -16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23636, 1, 143);
INSERT INTO item_mods (itemId, modId, value) VALUES (23636, 2, 75);
INSERT INTO item_mods (itemId, modId, value) VALUES (23636, 5, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23636, 8, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23636, 9, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23636, 10, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23636, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23636, 12, 48);
INSERT INTO item_mods (itemId, modId, value) VALUES (23636, 13, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23636, 14, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23636, 23, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23636, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23636, 28, 53);
INSERT INTO item_mods (itemId, modId, value) VALUES (23636, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23636, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23636, 31, 162);
INSERT INTO item_mods (itemId, modId, value) VALUES (23636, 67, 77);
INSERT INTO item_mods (itemId, modId, value) VALUES (23636, 122, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23636, 160, -1200);
INSERT INTO item_mods (itemId, modId, value) VALUES (23636, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 1, 103);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 2, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 5, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 8, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 9, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 10, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 11, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 12, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 13, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 14, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 23, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 27, -10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 28, 55);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 31, 157);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 68, 110);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 487, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23703, 1139, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23432, 1, 131);
INSERT INTO item_mods (itemId, modId, value) VALUES (23432, 2, 71);
INSERT INTO item_mods (itemId, modId, value) VALUES (23432, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23432, 9, 41);
INSERT INTO item_mods (itemId, modId, value) VALUES (23432, 10, 28);
INSERT INTO item_mods (itemId, modId, value) VALUES (23432, 11, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23432, 12, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23432, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23432, 14, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23432, 23, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23432, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23432, 26, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23432, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23432, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23432, 31, 119);
INSERT INTO item_mods (itemId, modId, value) VALUES (23432, 68, 89);
INSERT INTO item_mods (itemId, modId, value) VALUES (23432, 160, -1000);
INSERT INTO item_mods (itemId, modId, value) VALUES (23432, 259, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23432, 384, 1000);
INSERT INTO item_mods (itemId, modId, value) VALUES (23499, 1, 163);
INSERT INTO item_mods (itemId, modId, value) VALUES (23499, 2, 93);
INSERT INTO item_mods (itemId, modId, value) VALUES (23499, 8, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23499, 9, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23499, 10, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23499, 11, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23499, 12, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23499, 13, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23499, 14, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23499, 23, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23499, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23499, 26, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23499, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23499, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23499, 31, 129);
INSERT INTO item_mods (itemId, modId, value) VALUES (23499, 68, 95);
INSERT INTO item_mods (itemId, modId, value) VALUES (23499, 160, -1300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23499, 165, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23499, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23566, 1, 121);
INSERT INTO item_mods (itemId, modId, value) VALUES (23566, 2, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23566, 8, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23566, 9, 55);
INSERT INTO item_mods (itemId, modId, value) VALUES (23566, 10, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23566, 11, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23566, 12, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23566, 13, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23566, 14, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23566, 23, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23566, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23566, 26, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23566, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23566, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23566, 31, 103);
INSERT INTO item_mods (itemId, modId, value) VALUES (23566, 68, 79);
INSERT INTO item_mods (itemId, modId, value) VALUES (23566, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23566, 487, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23566, 522, 18);
INSERT INTO item_mods (itemId, modId, value) VALUES (23566, 1148, 28);
INSERT INTO item_mods (itemId, modId, value) VALUES (23633, 1, 143);
INSERT INTO item_mods (itemId, modId, value) VALUES (23633, 2, 80);
INSERT INTO item_mods (itemId, modId, value) VALUES (23633, 8, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23633, 10, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23633, 11, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23633, 12, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23633, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23633, 14, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23633, 23, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23633, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23633, 26, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23633, 29, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23633, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23633, 31, 135);
INSERT INTO item_mods (itemId, modId, value) VALUES (23633, 68, 87);
INSERT INTO item_mods (itemId, modId, value) VALUES (23633, 88, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23633, 160, -1200);
INSERT INTO item_mods (itemId, modId, value) VALUES (23633, 384, 800);
INSERT INTO item_mods (itemId, modId, value) VALUES (23700, 1, 103);
INSERT INTO item_mods (itemId, modId, value) VALUES (23700, 2, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23700, 8, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23700, 9, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23700, 10, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23700, 11, 54);
INSERT INTO item_mods (itemId, modId, value) VALUES (23700, 13, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23700, 14, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23700, 23, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23700, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23700, 26, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23700, 29, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23700, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23700, 31, 135);
INSERT INTO item_mods (itemId, modId, value) VALUES (23700, 68, 120);
INSERT INTO item_mods (itemId, modId, value) VALUES (23700, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23700, 486, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23700, 841, 12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23700, 900, 1);
INSERT INTO item_mods (itemId, modId, value) VALUES (23427, 1, 145);
INSERT INTO item_mods (itemId, modId, value) VALUES (23427, 2, 71);
INSERT INTO item_mods (itemId, modId, value) VALUES (23427, 5, 59);
INSERT INTO item_mods (itemId, modId, value) VALUES (23427, 8, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23427, 9, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23427, 10, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23427, 11, 28);
INSERT INTO item_mods (itemId, modId, value) VALUES (23427, 12, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23427, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23427, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23427, 23, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23427, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23427, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23427, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23427, 31, 87);
INSERT INTO item_mods (itemId, modId, value) VALUES (23427, 68, 86);
INSERT INTO item_mods (itemId, modId, value) VALUES (23427, 86, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23427, 288, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23427, 384, 700);
INSERT INTO item_mods (itemId, modId, value) VALUES (23494, 1, 177);
INSERT INTO item_mods (itemId, modId, value) VALUES (23494, 2, 93);
INSERT INTO item_mods (itemId, modId, value) VALUES (23494, 5, 89);
INSERT INTO item_mods (itemId, modId, value) VALUES (23494, 8, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23494, 9, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23494, 10, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23494, 11, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23494, 12, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23494, 13, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23494, 14, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23494, 23, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23494, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23494, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23494, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23494, 31, 103);
INSERT INTO item_mods (itemId, modId, value) VALUES (23494, 68, 94);
INSERT INTO item_mods (itemId, modId, value) VALUES (23494, 160, -1300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23494, 165, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23494, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23494, 998, 55);
INSERT INTO item_mods (itemId, modId, value) VALUES (23561, 1, 133);
INSERT INTO item_mods (itemId, modId, value) VALUES (23561, 2, 59);
INSERT INTO item_mods (itemId, modId, value) VALUES (23561, 5, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23561, 8, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23561, 9, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23561, 10, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23561, 12, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23561, 13, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23561, 14, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23561, 23, 72);
INSERT INTO item_mods (itemId, modId, value) VALUES (23561, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23561, 29, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23561, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23561, 31, 82);
INSERT INTO item_mods (itemId, modId, value) VALUES (23561, 68, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23561, 83, 28);
INSERT INTO item_mods (itemId, modId, value) VALUES (23561, 160, -1000);
INSERT INTO item_mods (itemId, modId, value) VALUES (23561, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23561, 1153, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23628, 1, 159);
INSERT INTO item_mods (itemId, modId, value) VALUES (23628, 2, 82);
INSERT INTO item_mods (itemId, modId, value) VALUES (23628, 5, 71);
INSERT INTO item_mods (itemId, modId, value) VALUES (23628, 8, 53);
INSERT INTO item_mods (itemId, modId, value) VALUES (23628, 10, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23628, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23628, 12, 41);
INSERT INTO item_mods (itemId, modId, value) VALUES (23628, 13, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23628, 14, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23628, 23, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23628, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23628, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23628, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23628, 31, 119);
INSERT INTO item_mods (itemId, modId, value) VALUES (23628, 68, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23628, 116, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23628, 160, -1200);
INSERT INTO item_mods (itemId, modId, value) VALUES (23628, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23695, 1, 117);
INSERT INTO item_mods (itemId, modId, value) VALUES (23695, 2, 48);
INSERT INTO item_mods (itemId, modId, value) VALUES (23695, 5, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23695, 8, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23695, 9, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23695, 10, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23695, 11, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23695, 12, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23695, 13, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23695, 14, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23695, 23, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23695, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23695, 28, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23695, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23695, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23695, 31, 119);
INSERT INTO item_mods (itemId, modId, value) VALUES (23695, 68, 102);
INSERT INTO item_mods (itemId, modId, value) VALUES (23695, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23695, 841, 12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23695, 902, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23466, 1, 142);
INSERT INTO item_mods (itemId, modId, value) VALUES (23466, 2, 122);
INSERT INTO item_mods (itemId, modId, value) VALUES (23466, 8, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23466, 9, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23466, 10, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23466, 11, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23466, 12, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23466, 13, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23466, 14, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23466, 23, 65);
INSERT INTO item_mods (itemId, modId, value) VALUES (23466, 25, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23466, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23466, 30, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23466, 31, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23466, 68, 72);
INSERT INTO item_mods (itemId, modId, value) VALUES (23466, 160, -500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23466, 291, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23466, 370, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23466, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23533, 1, 96);
INSERT INTO item_mods (itemId, modId, value) VALUES (23533, 2, 80);
INSERT INTO item_mods (itemId, modId, value) VALUES (23533, 8, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23533, 9, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23533, 10, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23533, 11, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23533, 12, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23533, 13, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23533, 14, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23533, 23, 86);
INSERT INTO item_mods (itemId, modId, value) VALUES (23533, 25, 49);
INSERT INTO item_mods (itemId, modId, value) VALUES (23533, 29, 3);
INSERT INTO item_mods (itemId, modId, value) VALUES (23533, 30, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23533, 31, 46);
INSERT INTO item_mods (itemId, modId, value) VALUES (23533, 68, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23533, 73, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23533, 289, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23533, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23533, 1026, 51);
INSERT INTO item_mods (itemId, modId, value) VALUES (23533, 1027, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23600, 1, 124);
INSERT INTO item_mods (itemId, modId, value) VALUES (23600, 2, 116);
INSERT INTO item_mods (itemId, modId, value) VALUES (23600, 8, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23600, 9, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23600, 10, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23600, 11, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23600, 12, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23600, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23600, 14, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23600, 23, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23600, 25, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23600, 29, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23600, 30, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23600, 31, 84);
INSERT INTO item_mods (itemId, modId, value) VALUES (23600, 68, 53);
INSERT INTO item_mods (itemId, modId, value) VALUES (23600, 165, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23600, 289, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23600, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23600, 482, 19);
INSERT INTO item_mods (itemId, modId, value) VALUES (23416, 1, 123);
INSERT INTO item_mods (itemId, modId, value) VALUES (23416, 2, 86);
INSERT INTO item_mods (itemId, modId, value) VALUES (23416, 5, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23416, 8, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23416, 9, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23416, 10, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23416, 11, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23416, 12, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23416, 13, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23416, 14, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23416, 23, 77);
INSERT INTO item_mods (itemId, modId, value) VALUES (23416, 25, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23416, 29, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23416, 30, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23416, 31, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23416, 68, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23416, 384, 800);
INSERT INTO item_mods (itemId, modId, value) VALUES (23416, 491, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 1, 153);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 2, 79);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 5, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 8, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 9, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 10, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 11, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 12, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 13, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 14, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 23, 86);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 25, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 30, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 31, 84);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 68, 69);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 161, -600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 164, -600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 253, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 302, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23483, 493, 41);
INSERT INTO item_mods (itemId, modId, value) VALUES (23550, 1, 111);
INSERT INTO item_mods (itemId, modId, value) VALUES (23550, 2, 85);
INSERT INTO item_mods (itemId, modId, value) VALUES (23550, 8, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23550, 9, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23550, 10, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23550, 11, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23550, 12, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23550, 13, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23550, 14, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23550, 23, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23550, 25, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23550, 27, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23550, 29, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23550, 30, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23550, 31, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23550, 68, 55);
INSERT INTO item_mods (itemId, modId, value) VALUES (23550, 291, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23550, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23617, 1, 133);
INSERT INTO item_mods (itemId, modId, value) VALUES (23617, 2, 67);
INSERT INTO item_mods (itemId, modId, value) VALUES (23617, 8, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23617, 10, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23617, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23617, 12, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23617, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23617, 14, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23617, 23, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23617, 25, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23617, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23617, 30, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23617, 31, 89);
INSERT INTO item_mods (itemId, modId, value) VALUES (23617, 68, 58);
INSERT INTO item_mods (itemId, modId, value) VALUES (23617, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23617, 492, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23617, 841, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23437, 1, 131);
INSERT INTO item_mods (itemId, modId, value) VALUES (23437, 2, 66);
INSERT INTO item_mods (itemId, modId, value) VALUES (23437, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23437, 9, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23437, 10, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23437, 11, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23437, 12, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23437, 13, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23437, 14, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23437, 23, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23437, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23437, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23437, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23437, 31, 98);
INSERT INTO item_mods (itemId, modId, value) VALUES (23437, 68, 91);
INSERT INTO item_mods (itemId, modId, value) VALUES (23437, 80, 19);
INSERT INTO item_mods (itemId, modId, value) VALUES (23437, 288, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23437, 384, 800);
INSERT INTO item_mods (itemId, modId, value) VALUES (23504, 1, 164);
INSERT INTO item_mods (itemId, modId, value) VALUES (23504, 2, 89);
INSERT INTO item_mods (itemId, modId, value) VALUES (23504, 8, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23504, 9, 41);
INSERT INTO item_mods (itemId, modId, value) VALUES (23504, 10, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23504, 11, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23504, 12, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23504, 13, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23504, 14, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23504, 23, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23504, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23504, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23504, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23504, 31, 109);
INSERT INTO item_mods (itemId, modId, value) VALUES (23504, 68, 105);
INSERT INTO item_mods (itemId, modId, value) VALUES (23504, 160, -1300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23504, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23504, 505, -40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23571, 1, 119);
INSERT INTO item_mods (itemId, modId, value) VALUES (23571, 2, 55);
INSERT INTO item_mods (itemId, modId, value) VALUES (23571, 8, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23571, 9, 49);
INSERT INTO item_mods (itemId, modId, value) VALUES (23571, 10, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23571, 11, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23571, 12, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23571, 13, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23571, 14, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23571, 23, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23571, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23571, 29, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23571, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23571, 31, 82);
INSERT INTO item_mods (itemId, modId, value) VALUES (23571, 68, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23571, 73, 11);
INSERT INTO item_mods (itemId, modId, value) VALUES (23571, 160, -1000);
INSERT INTO item_mods (itemId, modId, value) VALUES (23571, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23638, 1, 145);
INSERT INTO item_mods (itemId, modId, value) VALUES (23638, 2, 77);
INSERT INTO item_mods (itemId, modId, value) VALUES (23638, 8, 49);
INSERT INTO item_mods (itemId, modId, value) VALUES (23638, 10, 28);
INSERT INTO item_mods (itemId, modId, value) VALUES (23638, 11, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23638, 12, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23638, 13, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23638, 14, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23638, 23, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23638, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23638, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23638, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23638, 31, 119);
INSERT INTO item_mods (itemId, modId, value) VALUES (23638, 68, 86);
INSERT INTO item_mods (itemId, modId, value) VALUES (23638, 101, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23638, 102, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23638, 103, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23638, 160, -1200);
INSERT INTO item_mods (itemId, modId, value) VALUES (23638, 173, 11);
INSERT INTO item_mods (itemId, modId, value) VALUES (23638, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23705, 1, 100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23705, 2, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23705, 8, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23705, 9, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23705, 10, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23705, 11, 49);
INSERT INTO item_mods (itemId, modId, value) VALUES (23705, 12, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23705, 13, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23705, 14, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23705, 23, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23705, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23705, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23705, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23705, 31, 119);
INSERT INTO item_mods (itemId, modId, value) VALUES (23705, 68, 122);
INSERT INTO item_mods (itemId, modId, value) VALUES (23705, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23705, 841, 12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23705, 1199, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23498, 1, 176);
INSERT INTO item_mods (itemId, modId, value) VALUES (23498, 2, 96);
INSERT INTO item_mods (itemId, modId, value) VALUES (23498, 8, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23498, 9, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23498, 10, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23498, 11, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23498, 12, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23498, 13, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23498, 14, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23498, 23, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23498, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23498, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23498, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23498, 31, 109);
INSERT INTO item_mods (itemId, modId, value) VALUES (23498, 68, 94);
INSERT INTO item_mods (itemId, modId, value) VALUES (23498, 73, 14);
INSERT INTO item_mods (itemId, modId, value) VALUES (23498, 89, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23498, 160, -1400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23498, 306, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23498, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23632, 1, 156);
INSERT INTO item_mods (itemId, modId, value) VALUES (23632, 2, 80);
INSERT INTO item_mods (itemId, modId, value) VALUES (23632, 8, 53);
INSERT INTO item_mods (itemId, modId, value) VALUES (23632, 9, 19);
INSERT INTO item_mods (itemId, modId, value) VALUES (23632, 10, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23632, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23632, 12, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23632, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23632, 14, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23632, 23, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23632, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23632, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23632, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23632, 31, 130);
INSERT INTO item_mods (itemId, modId, value) VALUES (23632, 68, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23632, 73, 11);
INSERT INTO item_mods (itemId, modId, value) VALUES (23632, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23632, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23431, 1, 144);
INSERT INTO item_mods (itemId, modId, value) VALUES (23431, 2, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23431, 8, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23431, 9, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23431, 10, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23431, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23431, 12, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23431, 13, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23431, 14, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23431, 23, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23431, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23431, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23431, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23431, 31, 98);
INSERT INTO item_mods (itemId, modId, value) VALUES (23431, 68, 86);
INSERT INTO item_mods (itemId, modId, value) VALUES (23431, 73, 12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23431, 160, -1000);
INSERT INTO item_mods (itemId, modId, value) VALUES (23431, 384, 700);
INSERT INTO item_mods (itemId, modId, value) VALUES (23565, 1, 134);
INSERT INTO item_mods (itemId, modId, value) VALUES (23565, 2, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23565, 8, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23565, 9, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23565, 10, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23565, 11, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23565, 12, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23565, 13, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23565, 14, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23565, 23, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23565, 24, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23565, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23565, 26, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23565, 29, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23565, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23565, 31, 82);
INSERT INTO item_mods (itemId, modId, value) VALUES (23565, 68, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23565, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23565, 841, 12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23699, 1, 116);
INSERT INTO item_mods (itemId, modId, value) VALUES (23699, 2, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23699, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23699, 9, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23699, 10, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23699, 11, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23699, 13, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23699, 14, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23699, 23, 70);
INSERT INTO item_mods (itemId, modId, value) VALUES (23699, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23699, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23699, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23699, 31, 130);
INSERT INTO item_mods (itemId, modId, value) VALUES (23699, 68, 105);
INSERT INTO item_mods (itemId, modId, value) VALUES (23699, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23699, 944, 14);
INSERT INTO item_mods (itemId, modId, value) VALUES (23699, 1081, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23699, 1090, 13);
INSERT INTO item_mods (itemId, modId, value) VALUES (23414, 1, 120);
INSERT INTO item_mods (itemId, modId, value) VALUES (23414, 2, 80);
INSERT INTO item_mods (itemId, modId, value) VALUES (23414, 8, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23414, 9, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23414, 10, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23414, 11, 41);
INSERT INTO item_mods (itemId, modId, value) VALUES (23414, 12, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23414, 13, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23414, 14, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23414, 24, 87);
INSERT INTO item_mods (itemId, modId, value) VALUES (23414, 26, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23414, 29, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23414, 30, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23414, 31, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23414, 68, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23414, 384, 800);
INSERT INTO item_mods (itemId, modId, value) VALUES (23414, 542, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 1, 151);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 2, 79);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 5, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 8, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 9, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 10, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 11, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 12, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 13, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 14, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 24, 83);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 25, 49);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 28, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 30, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 31, 84);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 68, 69);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 161, -600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 164, -600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 220, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23481, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23548, 1, 109);
INSERT INTO item_mods (itemId, modId, value) VALUES (23548, 2, 65);
INSERT INTO item_mods (itemId, modId, value) VALUES (23548, 8, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23548, 9, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23548, 10, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23548, 11, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23548, 12, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23548, 13, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23548, 14, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23548, 24, 76);
INSERT INTO item_mods (itemId, modId, value) VALUES (23548, 26, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23548, 29, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23548, 30, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23548, 31, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23548, 68, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23548, 365, 13);
INSERT INTO item_mods (itemId, modId, value) VALUES (23548, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23615, 1, 132);
INSERT INTO item_mods (itemId, modId, value) VALUES (23615, 2, 90);
INSERT INTO item_mods (itemId, modId, value) VALUES (23615, 5, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23615, 8, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23615, 10, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23615, 11, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23615, 12, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23615, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23615, 14, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23615, 23, 78);
INSERT INTO item_mods (itemId, modId, value) VALUES (23615, 24, 78);
INSERT INTO item_mods (itemId, modId, value) VALUES (23615, 26, 46);
INSERT INTO item_mods (itemId, modId, value) VALUES (23615, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23615, 30, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23615, 31, 89);
INSERT INTO item_mods (itemId, modId, value) VALUES (23615, 68, 72);
INSERT INTO item_mods (itemId, modId, value) VALUES (23615, 365, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23615, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 1, 126);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 2, 66);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 5, 95);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 8, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 9, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 10, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 11, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 12, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 13, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 14, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 23, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 28, 56);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 31, 125);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 68, 88);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 160, -1000);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 311, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23424, 1184, -17);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 1, 157);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 2, 87);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 5, 91);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 8, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 9, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 10, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 12, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 13, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 14, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 23, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 28, 54);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 29, 11);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 31, 136);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 68, 91);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 160, -1400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 290, 18);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 311, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 369, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23491, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 1, 115);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 2, 55);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 5, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 8, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 9, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 10, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 11, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 12, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 13, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 23, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 28, 52);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 31, 87);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 68, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 114, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 297, 14);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 311, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23558, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23625, 1, 137);
INSERT INTO item_mods (itemId, modId, value) VALUES (23625, 2, 75);
INSERT INTO item_mods (itemId, modId, value) VALUES (23625, 5, 117);
INSERT INTO item_mods (itemId, modId, value) VALUES (23625, 8, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23625, 10, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23625, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23625, 12, 48);
INSERT INTO item_mods (itemId, modId, value) VALUES (23625, 13, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23625, 14, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23625, 23, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23625, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23625, 28, 58);
INSERT INTO item_mods (itemId, modId, value) VALUES (23625, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23625, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23625, 31, 162);
INSERT INTO item_mods (itemId, modId, value) VALUES (23625, 68, 77);
INSERT INTO item_mods (itemId, modId, value) VALUES (23625, 311, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23625, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23625, 487, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23625, 529, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 1, 98);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 2, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 5, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 8, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 9, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 10, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 11, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 12, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 13, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 14, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 23, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 27, -11);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 28, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 31, 157);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 68, 110);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 113, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 311, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 841, 12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23692, 890, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23413, 1, 121);
INSERT INTO item_mods (itemId, modId, value) VALUES (23413, 2, 91);
INSERT INTO item_mods (itemId, modId, value) VALUES (23413, 5, 78);
INSERT INTO item_mods (itemId, modId, value) VALUES (23413, 8, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23413, 9, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23413, 10, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23413, 11, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23413, 12, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23413, 13, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23413, 14, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23413, 23, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23413, 25, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23413, 29, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23413, 30, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23413, 31, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23413, 68, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23413, 122, 17);
INSERT INTO item_mods (itemId, modId, value) VALUES (23413, 384, 800);
INSERT INTO item_mods (itemId, modId, value) VALUES (23413, 1075, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23480, 1, 155);
INSERT INTO item_mods (itemId, modId, value) VALUES (23480, 2, 79);
INSERT INTO item_mods (itemId, modId, value) VALUES (23480, 5, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23480, 8, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23480, 9, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23480, 10, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23480, 11, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23480, 12, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23480, 13, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23480, 14, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23480, 23, 86);
INSERT INTO item_mods (itemId, modId, value) VALUES (23480, 25, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23480, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23480, 30, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23480, 31, 84);
INSERT INTO item_mods (itemId, modId, value) VALUES (23480, 68, 69);
INSERT INTO item_mods (itemId, modId, value) VALUES (23480, 170, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23480, 369, 3);
INSERT INTO item_mods (itemId, modId, value) VALUES (23480, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23547, 1, 109);
INSERT INTO item_mods (itemId, modId, value) VALUES (23547, 2, 70);
INSERT INTO item_mods (itemId, modId, value) VALUES (23547, 5, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23547, 8, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23547, 9, 49);
INSERT INTO item_mods (itemId, modId, value) VALUES (23547, 10, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23547, 11, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23547, 12, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23547, 13, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23547, 14, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23547, 23, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23547, 25, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23547, 29, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23547, 30, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23547, 31, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23547, 68, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23547, 289, 11);
INSERT INTO item_mods (itemId, modId, value) VALUES (23547, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23614, 1, 133);
INSERT INTO item_mods (itemId, modId, value) VALUES (23614, 2, 87);
INSERT INTO item_mods (itemId, modId, value) VALUES (23614, 5, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23614, 8, 41);
INSERT INTO item_mods (itemId, modId, value) VALUES (23614, 10, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23614, 11, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23614, 12, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23614, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23614, 14, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23614, 25, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23614, 28, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23614, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23614, 30, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23614, 31, 89);
INSERT INTO item_mods (itemId, modId, value) VALUES (23614, 68, 58);
INSERT INTO item_mods (itemId, modId, value) VALUES (23614, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23614, 841, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23438, 1, 131);
INSERT INTO item_mods (itemId, modId, value) VALUES (23438, 2, 71);
INSERT INTO item_mods (itemId, modId, value) VALUES (23438, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23438, 9, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23438, 10, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23438, 11, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23438, 12, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23438, 13, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23438, 14, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23438, 23, 71);
INSERT INTO item_mods (itemId, modId, value) VALUES (23438, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23438, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23438, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23438, 31, 109);
INSERT INTO item_mods (itemId, modId, value) VALUES (23438, 68, 109);
INSERT INTO item_mods (itemId, modId, value) VALUES (23438, 73, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23438, 384, 800);
INSERT INTO item_mods (itemId, modId, value) VALUES (23438, 841, 12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23505, 1, 164);
INSERT INTO item_mods (itemId, modId, value) VALUES (23505, 2, 93);
INSERT INTO item_mods (itemId, modId, value) VALUES (23505, 8, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23505, 9, 48);
INSERT INTO item_mods (itemId, modId, value) VALUES (23505, 10, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23505, 11, 48);
INSERT INTO item_mods (itemId, modId, value) VALUES (23505, 12, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23505, 13, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23505, 14, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23505, 23, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23505, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23505, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23505, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23505, 31, 109);
INSERT INTO item_mods (itemId, modId, value) VALUES (23505, 68, 115);
INSERT INTO item_mods (itemId, modId, value) VALUES (23505, 160, -1400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23505, 259, 11);
INSERT INTO item_mods (itemId, modId, value) VALUES (23505, 289, 14);
INSERT INTO item_mods (itemId, modId, value) VALUES (23505, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23572, 1, 121);
INSERT INTO item_mods (itemId, modId, value) VALUES (23572, 2, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23572, 8, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23572, 9, 53);
INSERT INTO item_mods (itemId, modId, value) VALUES (23572, 10, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23572, 11, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23572, 12, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23572, 13, 41);
INSERT INTO item_mods (itemId, modId, value) VALUES (23572, 14, 28);
INSERT INTO item_mods (itemId, modId, value) VALUES (23572, 23, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23572, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23572, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23572, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23572, 31, 83);
INSERT INTO item_mods (itemId, modId, value) VALUES (23572, 68, 96);
INSERT INTO item_mods (itemId, modId, value) VALUES (23572, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23572, 175, 1300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23572, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23572, 836, 14);
INSERT INTO item_mods (itemId, modId, value) VALUES (23639, 1, 144);
INSERT INTO item_mods (itemId, modId, value) VALUES (23639, 2, 80);
INSERT INTO item_mods (itemId, modId, value) VALUES (23639, 8, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23639, 10, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23639, 11, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23639, 12, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23639, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23639, 14, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23639, 23, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23639, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23639, 29, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23639, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23639, 31, 115);
INSERT INTO item_mods (itemId, modId, value) VALUES (23639, 68, 107);
INSERT INTO item_mods (itemId, modId, value) VALUES (23639, 81, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23639, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23639, 486, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23639, 1081, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23706, 1, 102);
INSERT INTO item_mods (itemId, modId, value) VALUES (23706, 2, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23706, 8, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23706, 9, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23706, 10, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23706, 11, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23706, 13, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23706, 14, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23706, 23, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23706, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23706, 29, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23706, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23706, 31, 115);
INSERT INTO item_mods (itemId, modId, value) VALUES (23706, 68, 140);
INSERT INTO item_mods (itemId, modId, value) VALUES (23706, 73, 12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23706, 160, -1000);
INSERT INTO item_mods (itemId, modId, value) VALUES (23706, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23410, 1, 120);
INSERT INTO item_mods (itemId, modId, value) VALUES (23410, 2, 56);
INSERT INTO item_mods (itemId, modId, value) VALUES (23410, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23410, 9, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23410, 10, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23410, 11, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23410, 12, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23410, 13, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23410, 14, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23410, 23, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23410, 25, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23410, 28, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23410, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23410, 30, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23410, 31, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23410, 68, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23410, 110, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23410, 384, 800);
INSERT INTO item_mods (itemId, modId, value) VALUES (23410, 522, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23477, 1, 154);
INSERT INTO item_mods (itemId, modId, value) VALUES (23477, 2, 79);
INSERT INTO item_mods (itemId, modId, value) VALUES (23477, 8, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23477, 9, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23477, 10, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23477, 11, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23477, 12, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23477, 13, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23477, 14, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23477, 23, 87);
INSERT INTO item_mods (itemId, modId, value) VALUES (23477, 24, 79);
INSERT INTO item_mods (itemId, modId, value) VALUES (23477, 25, 51);
INSERT INTO item_mods (itemId, modId, value) VALUES (23477, 26, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23477, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23477, 30, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23477, 31, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23477, 68, 72);
INSERT INTO item_mods (itemId, modId, value) VALUES (23477, 259, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23477, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23477, 911, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23544, 1, 109);
INSERT INTO item_mods (itemId, modId, value) VALUES (23544, 2, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23544, 8, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23544, 9, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23544, 10, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23544, 11, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23544, 12, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23544, 13, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23544, 14, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23544, 23, 79);
INSERT INTO item_mods (itemId, modId, value) VALUES (23544, 25, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23544, 29, 3);
INSERT INTO item_mods (itemId, modId, value) VALUES (23544, 30, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23544, 31, 46);
INSERT INTO item_mods (itemId, modId, value) VALUES (23544, 68, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23544, 289, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23544, 308, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23544, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23428, 1, 132);
INSERT INTO item_mods (itemId, modId, value) VALUES (23428, 2, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23428, 8, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23428, 9, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23428, 10, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23428, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23428, 12, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23428, 13, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23428, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23428, 23, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23428, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23428, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23428, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23428, 31, 98);
INSERT INTO item_mods (itemId, modId, value) VALUES (23428, 68, 86);
INSERT INTO item_mods (itemId, modId, value) VALUES (23428, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23428, 384, 800);
INSERT INTO item_mods (itemId, modId, value) VALUES (23495, 1, 163);
INSERT INTO item_mods (itemId, modId, value) VALUES (23495, 2, 96);
INSERT INTO item_mods (itemId, modId, value) VALUES (23495, 8, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23495, 9, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23495, 10, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23495, 11, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23495, 12, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23495, 13, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23495, 14, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23495, 23, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23495, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23495, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23495, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23495, 31, 109);
INSERT INTO item_mods (itemId, modId, value) VALUES (23495, 68, 94);
INSERT INTO item_mods (itemId, modId, value) VALUES (23495, 84, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23495, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23495, 841, 12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23562, 1, 122);
INSERT INTO item_mods (itemId, modId, value) VALUES (23562, 2, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23562, 8, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23562, 9, 48);
INSERT INTO item_mods (itemId, modId, value) VALUES (23562, 10, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23562, 11, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23562, 12, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23562, 13, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23562, 14, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23562, 23, 72);
INSERT INTO item_mods (itemId, modId, value) VALUES (23562, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23562, 29, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23562, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23562, 31, 82);
INSERT INTO item_mods (itemId, modId, value) VALUES (23562, 68, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23562, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23562, 165, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23562, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23629, 1, 143);
INSERT INTO item_mods (itemId, modId, value) VALUES (23629, 2, 80);
INSERT INTO item_mods (itemId, modId, value) VALUES (23629, 8, 53);
INSERT INTO item_mods (itemId, modId, value) VALUES (23629, 10, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23629, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23629, 12, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23629, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23629, 14, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23629, 23, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23629, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23629, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23629, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23629, 31, 130);
INSERT INTO item_mods (itemId, modId, value) VALUES (23629, 68, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23629, 160, -1300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23629, 384, 800);
INSERT INTO item_mods (itemId, modId, value) VALUES (23696, 1, 101);
INSERT INTO item_mods (itemId, modId, value) VALUES (23696, 2, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23696, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23696, 9, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23696, 10, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23696, 11, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23696, 13, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23696, 14, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23696, 23, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23696, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23696, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23696, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23696, 31, 130);
INSERT INTO item_mods (itemId, modId, value) VALUES (23696, 68, 105);
INSERT INTO item_mods (itemId, modId, value) VALUES (23696, 288, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23696, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23696, 1157, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23433, 1, 140);
INSERT INTO item_mods (itemId, modId, value) VALUES (23433, 2, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23433, 8, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23433, 9, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23433, 10, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23433, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23433, 12, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23433, 13, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23433, 14, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23433, 23, 71);
INSERT INTO item_mods (itemId, modId, value) VALUES (23433, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23433, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23433, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23433, 31, 98);
INSERT INTO item_mods (itemId, modId, value) VALUES (23433, 68, 86);
INSERT INTO item_mods (itemId, modId, value) VALUES (23433, 87, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23433, 384, 700);
INSERT INTO item_mods (itemId, modId, value) VALUES (23433, 841, 12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23500, 1, 170);
INSERT INTO item_mods (itemId, modId, value) VALUES (23500, 2, 96);
INSERT INTO item_mods (itemId, modId, value) VALUES (23500, 8, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23500, 9, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23500, 10, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23500, 11, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23500, 12, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23500, 13, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23500, 14, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23500, 23, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23500, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23500, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23500, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23500, 31, 109);
INSERT INTO item_mods (itemId, modId, value) VALUES (23500, 68, 94);
INSERT INTO item_mods (itemId, modId, value) VALUES (23500, 73, 14);
INSERT INTO item_mods (itemId, modId, value) VALUES (23500, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23567, 1, 128);
INSERT INTO item_mods (itemId, modId, value) VALUES (23567, 2, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23567, 8, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23567, 9, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23567, 10, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23567, 11, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23567, 12, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23567, 13, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23567, 14, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23567, 23, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23567, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23567, 29, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23567, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23567, 31, 82);
INSERT INTO item_mods (itemId, modId, value) VALUES (23567, 68, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23567, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23567, 281, 1);
INSERT INTO item_mods (itemId, modId, value) VALUES (23567, 288, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23567, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23634, 1, 151);
INSERT INTO item_mods (itemId, modId, value) VALUES (23634, 2, 80);
INSERT INTO item_mods (itemId, modId, value) VALUES (23634, 8, 53);
INSERT INTO item_mods (itemId, modId, value) VALUES (23634, 10, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23634, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23634, 12, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23634, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23634, 14, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23634, 23, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23634, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23634, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23634, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23634, 31, 130);
INSERT INTO item_mods (itemId, modId, value) VALUES (23634, 68, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23634, 160, -1300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23634, 286, 19);
INSERT INTO item_mods (itemId, modId, value) VALUES (23634, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23634, 421, 13);
INSERT INTO item_mods (itemId, modId, value) VALUES (23701, 1, 108);
INSERT INTO item_mods (itemId, modId, value) VALUES (23701, 2, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23701, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23701, 9, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23701, 10, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23701, 11, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23701, 13, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23701, 14, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23701, 23, 70);
INSERT INTO item_mods (itemId, modId, value) VALUES (23701, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23701, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23701, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23701, 31, 130);
INSERT INTO item_mods (itemId, modId, value) VALUES (23701, 68, 105);
INSERT INTO item_mods (itemId, modId, value) VALUES (23701, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23701, 285, 90);
INSERT INTO item_mods (itemId, modId, value) VALUES (23701, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23467, 1, 144);
INSERT INTO item_mods (itemId, modId, value) VALUES (23467, 2, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23467, 5, 105);
INSERT INTO item_mods (itemId, modId, value) VALUES (23467, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23467, 9, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23467, 10, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23467, 11, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23467, 12, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23467, 13, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23467, 14, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23467, 23, 65);
INSERT INTO item_mods (itemId, modId, value) VALUES (23467, 25, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23467, 27, -8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23467, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23467, 30, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23467, 31, 100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23467, 68, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23467, 369, 3);
INSERT INTO item_mods (itemId, modId, value) VALUES (23467, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23467, 838, 52);
INSERT INTO item_mods (itemId, modId, value) VALUES (23534, 1, 105);
INSERT INTO item_mods (itemId, modId, value) VALUES (23534, 2, 72);
INSERT INTO item_mods (itemId, modId, value) VALUES (23534, 5, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23534, 8, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23534, 9, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23534, 10, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23534, 11, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23534, 12, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23534, 13, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23534, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23534, 23, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23534, 25, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23534, 27, -9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23534, 29, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23534, 30, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23534, 31, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23534, 68, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23534, 111, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23534, 114, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23534, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23601, 1, 127);
INSERT INTO item_mods (itemId, modId, value) VALUES (23601, 2, 93);
INSERT INTO item_mods (itemId, modId, value) VALUES (23601, 5, 79);
INSERT INTO item_mods (itemId, modId, value) VALUES (23601, 8, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23601, 10, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23601, 11, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23601, 12, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23601, 13, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23601, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23601, 23, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23601, 25, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23601, 27, -8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23601, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23601, 30, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23601, 31, 127);
INSERT INTO item_mods (itemId, modId, value) VALUES (23601, 68, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23601, 112, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23601, 113, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23601, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23601, 567, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23415, 1, 123);
INSERT INTO item_mods (itemId, modId, value) VALUES (23415, 2, 56);
INSERT INTO item_mods (itemId, modId, value) VALUES (23415, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23415, 9, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23415, 10, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23415, 11, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23415, 12, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23415, 13, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23415, 14, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23415, 23, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23415, 25, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23415, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23415, 30, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23415, 31, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23415, 68, 58);
INSERT INTO item_mods (itemId, modId, value) VALUES (23415, 370, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23415, 384, 800);
INSERT INTO item_mods (itemId, modId, value) VALUES (23482, 1, 153);
INSERT INTO item_mods (itemId, modId, value) VALUES (23482, 2, 100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23482, 8, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23482, 9, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23482, 10, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23482, 11, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23482, 12, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23482, 13, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23482, 14, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23482, 23, 86);
INSERT INTO item_mods (itemId, modId, value) VALUES (23482, 25, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23482, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23482, 30, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23482, 31, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23482, 68, 72);
INSERT INTO item_mods (itemId, modId, value) VALUES (23482, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23549, 1, 110);
INSERT INTO item_mods (itemId, modId, value) VALUES (23549, 2, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23549, 8, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23549, 9, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23549, 10, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23549, 11, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23549, 12, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23549, 13, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23549, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23549, 23, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23549, 25, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23549, 29, 3);
INSERT INTO item_mods (itemId, modId, value) VALUES (23549, 30, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23549, 31, 46);
INSERT INTO item_mods (itemId, modId, value) VALUES (23549, 68, 55);
INSERT INTO item_mods (itemId, modId, value) VALUES (23549, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23549, 841, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23616, 1, 133);
INSERT INTO item_mods (itemId, modId, value) VALUES (23616, 2, 67);
INSERT INTO item_mods (itemId, modId, value) VALUES (23616, 8, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23616, 10, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23616, 11, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23616, 12, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23616, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23616, 14, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23616, 23, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23616, 25, 46);
INSERT INTO item_mods (itemId, modId, value) VALUES (23616, 29, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23616, 30, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23616, 31, 84);
INSERT INTO item_mods (itemId, modId, value) VALUES (23616, 68, 53);
INSERT INTO item_mods (itemId, modId, value) VALUES (23616, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23403, 1, 122);
INSERT INTO item_mods (itemId, modId, value) VALUES (23403, 2, 56);
INSERT INTO item_mods (itemId, modId, value) VALUES (23403, 5, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23403, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23403, 9, 41);
INSERT INTO item_mods (itemId, modId, value) VALUES (23403, 10, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23403, 11, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23403, 12, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23403, 13, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23403, 14, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23403, 23, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23403, 25, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23403, 29, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23403, 30, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23403, 31, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23403, 68, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23403, 302, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23403, 384, 800);
INSERT INTO item_mods (itemId, modId, value) VALUES (23403, 835, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23470, 1, 152);
INSERT INTO item_mods (itemId, modId, value) VALUES (23470, 2, 79);
INSERT INTO item_mods (itemId, modId, value) VALUES (23470, 5, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23470, 8, 41);
INSERT INTO item_mods (itemId, modId, value) VALUES (23470, 9, 46);
INSERT INTO item_mods (itemId, modId, value) VALUES (23470, 10, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23470, 11, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23470, 12, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23470, 13, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23470, 14, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23470, 23, 65);
INSERT INTO item_mods (itemId, modId, value) VALUES (23470, 25, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23470, 27, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23470, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23470, 30, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23470, 31, 84);
INSERT INTO item_mods (itemId, modId, value) VALUES (23470, 68, 69);
INSERT INTO item_mods (itemId, modId, value) VALUES (23470, 165, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23470, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23470, 421, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23604, 1, 130);
INSERT INTO item_mods (itemId, modId, value) VALUES (23604, 2, 67);
INSERT INTO item_mods (itemId, modId, value) VALUES (23604, 8, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23604, 9, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23604, 10, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23604, 11, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23604, 12, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23604, 13, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23604, 14, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23604, 23, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23604, 25, 46);
INSERT INTO item_mods (itemId, modId, value) VALUES (23604, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23604, 30, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23604, 31, 89);
INSERT INTO item_mods (itemId, modId, value) VALUES (23604, 68, 58);
INSERT INTO item_mods (itemId, modId, value) VALUES (23604, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23604, 841, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23604, 897, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23417, 1, 112);
INSERT INTO item_mods (itemId, modId, value) VALUES (23417, 2, 86);
INSERT INTO item_mods (itemId, modId, value) VALUES (23417, 5, 82);
INSERT INTO item_mods (itemId, modId, value) VALUES (23417, 8, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23417, 9, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23417, 10, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23417, 11, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23417, 12, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23417, 13, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23417, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23417, 25, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23417, 28, 49);
INSERT INTO item_mods (itemId, modId, value) VALUES (23417, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23417, 30, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23417, 31, 95);
INSERT INTO item_mods (itemId, modId, value) VALUES (23417, 68, 56);
INSERT INTO item_mods (itemId, modId, value) VALUES (23417, 115, 19);
INSERT INTO item_mods (itemId, modId, value) VALUES (23417, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23417, 489, -13);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 1, 144);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 2, 99);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 5, 104);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 9, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 10, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 11, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 12, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 13, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 14, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 25, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 28, 52);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 30, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 31, 100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 68, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 112, 19);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 113, 19);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 401, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23484, 890, 12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 1, 100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 2, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 5, 75);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 8, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 9, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 10, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 11, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 12, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 13, 46);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 25, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 27, -7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 28, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 29, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 30, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 31, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 68, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 112, 19);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 114, 19);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 260, 3);
INSERT INTO item_mods (itemId, modId, value) VALUES (23551, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23618, 1, 126);
INSERT INTO item_mods (itemId, modId, value) VALUES (23618, 2, 83);
INSERT INTO item_mods (itemId, modId, value) VALUES (23618, 5, 69);
INSERT INTO item_mods (itemId, modId, value) VALUES (23618, 8, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23618, 10, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23618, 11, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23618, 12, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23618, 13, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23618, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23618, 25, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23618, 27, -7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23618, 28, 51);
INSERT INTO item_mods (itemId, modId, value) VALUES (23618, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23618, 30, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23618, 31, 127);
INSERT INTO item_mods (itemId, modId, value) VALUES (23618, 68, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23618, 115, 19);
INSERT INTO item_mods (itemId, modId, value) VALUES (23618, 116, 19);
INSERT INTO item_mods (itemId, modId, value) VALUES (23618, 315, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23618, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23478, 1, 161);
INSERT INTO item_mods (itemId, modId, value) VALUES (23478, 2, 102);
INSERT INTO item_mods (itemId, modId, value) VALUES (23478, 5, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23478, 8, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23478, 9, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23478, 10, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23478, 11, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23478, 12, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23478, 13, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23478, 14, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23478, 23, 80);
INSERT INTO item_mods (itemId, modId, value) VALUES (23478, 25, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23478, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23478, 30, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23478, 31, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23478, 68, 76);
INSERT INTO item_mods (itemId, modId, value) VALUES (23478, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23478, 974, 1);
INSERT INTO item_mods (itemId, modId, value) VALUES (23545, 1, 116);
INSERT INTO item_mods (itemId, modId, value) VALUES (23545, 2, 77);
INSERT INTO item_mods (itemId, modId, value) VALUES (23545, 5, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23545, 8, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23545, 9, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23545, 10, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23545, 11, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23545, 12, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23545, 13, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23545, 14, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23545, 23, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23545, 25, 46);
INSERT INTO item_mods (itemId, modId, value) VALUES (23545, 29, 3);
INSERT INTO item_mods (itemId, modId, value) VALUES (23545, 30, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23545, 31, 46);
INSERT INTO item_mods (itemId, modId, value) VALUES (23545, 68, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23545, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23545, 841, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23612, 1, 140);
INSERT INTO item_mods (itemId, modId, value) VALUES (23612, 2, 85);
INSERT INTO item_mods (itemId, modId, value) VALUES (23612, 8, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23612, 9, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23612, 10, 41);
INSERT INTO item_mods (itemId, modId, value) VALUES (23612, 11, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23612, 12, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23612, 13, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23612, 14, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23612, 23, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23612, 25, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23612, 29, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23612, 30, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23612, 31, 95);
INSERT INTO item_mods (itemId, modId, value) VALUES (23612, 68, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23612, 73, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23612, 363, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23612, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23409, 1, 135);
INSERT INTO item_mods (itemId, modId, value) VALUES (23409, 2, 78);
INSERT INTO item_mods (itemId, modId, value) VALUES (23409, 5, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23409, 8, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23409, 9, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23409, 10, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23409, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23409, 12, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23409, 13, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23409, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23409, 23, 79);
INSERT INTO item_mods (itemId, modId, value) VALUES (23409, 25, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23409, 29, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23409, 30, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23409, 31, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23409, 68, 53);
INSERT INTO item_mods (itemId, modId, value) VALUES (23409, 73, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23409, 365, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23409, 384, 700);
INSERT INTO item_mods (itemId, modId, value) VALUES (23476, 1, 165);
INSERT INTO item_mods (itemId, modId, value) VALUES (23476, 2, 101);
INSERT INTO item_mods (itemId, modId, value) VALUES (23476, 5, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23476, 8, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23476, 9, 37);
INSERT INTO item_mods (itemId, modId, value) VALUES (23476, 10, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23476, 11, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23476, 12, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23476, 13, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23476, 14, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23476, 23, 80);
INSERT INTO item_mods (itemId, modId, value) VALUES (23476, 25, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23476, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23476, 30, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23476, 31, 73);
INSERT INTO item_mods (itemId, modId, value) VALUES (23476, 68, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23476, 73, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23476, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23476, 841, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23543, 1, 125);
INSERT INTO item_mods (itemId, modId, value) VALUES (23543, 2, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23543, 8, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23543, 9, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23543, 10, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23543, 11, 17);
INSERT INTO item_mods (itemId, modId, value) VALUES (23543, 12, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23543, 13, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23543, 14, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23543, 23, 81);
INSERT INTO item_mods (itemId, modId, value) VALUES (23543, 25, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23543, 29, 3);
INSERT INTO item_mods (itemId, modId, value) VALUES (23543, 30, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23543, 31, 46);
INSERT INTO item_mods (itemId, modId, value) VALUES (23543, 68, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23543, 94, 12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23543, 161, -600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23543, 164, -600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23543, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23610, 1, 145);
INSERT INTO item_mods (itemId, modId, value) VALUES (23610, 2, 70);
INSERT INTO item_mods (itemId, modId, value) VALUES (23610, 8, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23610, 10, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23610, 11, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23610, 12, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23610, 13, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23610, 14, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23610, 23, 82);
INSERT INTO item_mods (itemId, modId, value) VALUES (23610, 25, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23610, 29, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23610, 30, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23610, 31, 95);
INSERT INTO item_mods (itemId, modId, value) VALUES (23610, 68, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23610, 163, -700);
INSERT INTO item_mods (itemId, modId, value) VALUES (23610, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23610, 508, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23610, 1047, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23425, 1, 130);
INSERT INTO item_mods (itemId, modId, value) VALUES (23425, 2, 71);
INSERT INTO item_mods (itemId, modId, value) VALUES (23425, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23425, 9, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23425, 10, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23425, 11, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23425, 12, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23425, 13, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23425, 14, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23425, 23, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23425, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23425, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23425, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23425, 31, 109);
INSERT INTO item_mods (itemId, modId, value) VALUES (23425, 68, 99);
INSERT INTO item_mods (itemId, modId, value) VALUES (23425, 302, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23425, 384, 800);
INSERT INTO item_mods (itemId, modId, value) VALUES (23425, 884, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23492, 1, 161);
INSERT INTO item_mods (itemId, modId, value) VALUES (23492, 2, 93);
INSERT INTO item_mods (itemId, modId, value) VALUES (23492, 8, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23492, 9, 51);
INSERT INTO item_mods (itemId, modId, value) VALUES (23492, 10, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23492, 11, 48);
INSERT INTO item_mods (itemId, modId, value) VALUES (23492, 12, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23492, 13, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23492, 14, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23492, 23, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23492, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23492, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23492, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23492, 31, 119);
INSERT INTO item_mods (itemId, modId, value) VALUES (23492, 68, 105);
INSERT INTO item_mods (itemId, modId, value) VALUES (23492, 81, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23492, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23492, 841, 12);
INSERT INTO item_mods (itemId, modId, value) VALUES (23492, 912, 1);
INSERT INTO item_mods (itemId, modId, value) VALUES (23559, 1, 121);
INSERT INTO item_mods (itemId, modId, value) VALUES (23559, 2, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23559, 8, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23559, 9, 53);
INSERT INTO item_mods (itemId, modId, value) VALUES (23559, 10, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23559, 11, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23559, 12, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23559, 13, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23559, 14, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23559, 23, 72);
INSERT INTO item_mods (itemId, modId, value) VALUES (23559, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23559, 29, 6);
INSERT INTO item_mods (itemId, modId, value) VALUES (23559, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23559, 31, 93);
INSERT INTO item_mods (itemId, modId, value) VALUES (23559, 68, 86);
INSERT INTO item_mods (itemId, modId, value) VALUES (23559, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23559, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23559, 830, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23626, 1, 142);
INSERT INTO item_mods (itemId, modId, value) VALUES (23626, 2, 80);
INSERT INTO item_mods (itemId, modId, value) VALUES (23626, 8, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23626, 9, 18);
INSERT INTO item_mods (itemId, modId, value) VALUES (23626, 10, 26);
INSERT INTO item_mods (itemId, modId, value) VALUES (23626, 11, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23626, 12, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23626, 13, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23626, 14, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23626, 23, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23626, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23626, 29, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23626, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23626, 31, 125);
INSERT INTO item_mods (itemId, modId, value) VALUES (23626, 68, 97);
INSERT INTO item_mods (itemId, modId, value) VALUES (23626, 160, -1300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23626, 165, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23626, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23626, 896, 13);
INSERT INTO item_mods (itemId, modId, value) VALUES (23693, 1, 103);
INSERT INTO item_mods (itemId, modId, value) VALUES (23693, 2, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23693, 8, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23693, 9, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23693, 10, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23693, 11, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23693, 13, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23693, 14, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23693, 23, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23693, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23693, 29, 9);
INSERT INTO item_mods (itemId, modId, value) VALUES (23693, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23693, 31, 125);
INSERT INTO item_mods (itemId, modId, value) VALUES (23693, 68, 130);
INSERT INTO item_mods (itemId, modId, value) VALUES (23693, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23693, 303, 5);
INSERT INTO item_mods (itemId, modId, value) VALUES (23693, 384, 400);
INSERT INTO item_mods (itemId, modId, value) VALUES (23693, 896, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 1, 146);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 2, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 5, 99);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 9, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 10, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 11, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 12, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 13, 45);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 14, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 23, 65);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 25, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 30, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 31, 100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 68, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 112, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 113, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 170, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23469, 890, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23536, 1, 103);
INSERT INTO item_mods (itemId, modId, value) VALUES (23536, 2, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23536, 5, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23536, 8, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23536, 9, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23536, 10, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23536, 11, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23536, 12, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23536, 13, 46);
INSERT INTO item_mods (itemId, modId, value) VALUES (23536, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23536, 23, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23536, 25, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23536, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23536, 30, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23536, 31, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23536, 68, 42);
INSERT INTO item_mods (itemId, modId, value) VALUES (23536, 113, 24);
INSERT INTO item_mods (itemId, modId, value) VALUES (23536, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 1, 129);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 2, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 5, 49);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 8, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 9, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 10, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 11, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 12, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 13, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 14, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 23, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 25, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 29, 8);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 30, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 31, 127);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 68, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 115, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 161, -500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 164, -500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 344, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23603, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 1, 125);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 2, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 5, 86);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 8, 22);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 9, 25);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 10, 27);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 11, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 12, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 13, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 14, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 25, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 27, -10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 28, 51);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 30, 61);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 31, 136);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 68, 83);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 115, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 311, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 384, 600);
INSERT INTO item_mods (itemId, modId, value) VALUES (23423, 901, 18);
INSERT INTO item_mods (itemId, modId, value) VALUES (23490, 1, 154);
INSERT INTO item_mods (itemId, modId, value) VALUES (23490, 2, 80);
INSERT INTO item_mods (itemId, modId, value) VALUES (23490, 5, 132);
INSERT INTO item_mods (itemId, modId, value) VALUES (23490, 8, 29);
INSERT INTO item_mods (itemId, modId, value) VALUES (23490, 9, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23490, 10, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23490, 11, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23490, 12, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23490, 13, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23490, 14, 43);
INSERT INTO item_mods (itemId, modId, value) VALUES (23490, 25, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23490, 28, 59);
INSERT INTO item_mods (itemId, modId, value) VALUES (23490, 29, 11);
INSERT INTO item_mods (itemId, modId, value) VALUES (23490, 30, 64);
INSERT INTO item_mods (itemId, modId, value) VALUES (23490, 31, 141);
INSERT INTO item_mods (itemId, modId, value) VALUES (23490, 68, 88);
INSERT INTO item_mods (itemId, modId, value) VALUES (23490, 311, 34);
INSERT INTO item_mods (itemId, modId, value) VALUES (23490, 369, 4);
INSERT INTO item_mods (itemId, modId, value) VALUES (23490, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23490, 1146, -16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 1, 110);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 2, 48);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 5, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 8, 16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 9, 40);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 10, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 11, 20);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 12, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 13, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 14, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 25, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 28, 57);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 29, 7);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 30, 62);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 31, 98);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 68, 69);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 160, -1300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 311, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 384, 300);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 562, 13);
INSERT INTO item_mods (itemId, modId, value) VALUES (23557, 563, 13);
INSERT INTO item_mods (itemId, modId, value) VALUES (23624, 1, 134);
INSERT INTO item_mods (itemId, modId, value) VALUES (23624, 2, 68);
INSERT INTO item_mods (itemId, modId, value) VALUES (23624, 5, 119);
INSERT INTO item_mods (itemId, modId, value) VALUES (23624, 8, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23624, 10, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23624, 11, 31);
INSERT INTO item_mods (itemId, modId, value) VALUES (23624, 12, 53);
INSERT INTO item_mods (itemId, modId, value) VALUES (23624, 13, 38);
INSERT INTO item_mods (itemId, modId, value) VALUES (23624, 14, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23624, 25, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23624, 28, 58);
INSERT INTO item_mods (itemId, modId, value) VALUES (23624, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23624, 30, 63);
INSERT INTO item_mods (itemId, modId, value) VALUES (23624, 31, 168);
INSERT INTO item_mods (itemId, modId, value) VALUES (23624, 68, 74);
INSERT INTO item_mods (itemId, modId, value) VALUES (23624, 311, 33);
INSERT INTO item_mods (itemId, modId, value) VALUES (23624, 384, 500);
INSERT INTO item_mods (itemId, modId, value) VALUES (23624, 487, 15);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 1, 95);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 2, 39);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 5, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 8, 18);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 9, 21);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 10, 23);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 11, 44);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 12, 36);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 13, 32);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 14, 47);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 25, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 27, -16);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 28, 50);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 29, 10);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 30, 60);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 31, 168);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 68, 110);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 116, 35);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 160, -1100);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 311, 30);
INSERT INTO item_mods (itemId, modId, value) VALUES (23691, 384, 300);

-- heathens_flanchards_+3 model (name-mismatch on the bulk copy: base is "flanchard")
UPDATE item_equipment tgt JOIN (SELECT e.MId FROM item_basic b JOIN item_equipment e ON e.itemId=b.itemid WHERE b.name LIKE 'heathens_flanchard%' AND e.MId<>0 LIMIT 1) src SET tgt.MId=src.MId WHERE tgt.itemId=23628 AND tgt.MId=0;

-- Part 1b: +4 models (AF/Relic have a +4 tier; copy base tier MId)
UPDATE item_equipment tgt JOIN item_basic tb ON tb.itemid=tgt.itemId JOIN item_basic bb ON bb.name=SUBSTRING_INDEX(tb.name,'_+',1) JOIN item_equipment be ON be.itemId=bb.itemid AND be.slot=tgt.slot AND be.MId<>0 SET tgt.MId=be.MId WHERE tb.name LIKE '%\\_+4' AND tgt.MId=0 AND tgt.ilevel>=109;

-- ============================================================
-- +4 tier (Artifact/Relic only; Empyrean has no +4). BG-wiki sourced via +3-template alignment.
-- ============================================================
-- +4 batch 1
-- Reforged +4 armor stats, batch 1: academics, agoge, anchorites, ankusa, arcadian, archmages
-- Method: modIds locked from each piece's +3 template (item_mods) + BG-wiki +4 stat lines.
-- Haste = %*100 (mod 384). WSD (841), Arts skills, etc. per +3 template scale. Verified vs mod.lua.

DELETE FROM item_mods WHERE itemId IN (
  23915,23960,24005,24050,24095,   -- academics +4
  23918,23963,24008,24053,24098,   -- agoge +4
  23896,23941,23986,24031,24076,   -- anchorites +4
  23926,23971,24016,24061,24106,   -- ankusa +4
  23928,23973,24018,24063,24108,   -- arcadian +4
  23921,23966,24011,24056,24101    -- archmages +4
);

-- ============ ACADEMICS (SCH AF) ============
-- academics_mortarboard_+4 (23915) <- tmpl 23395; +4 adds Accuracy (mod 25)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23915,1,118),(23915,2,74),(23915,5,68),(23915,8,29),(23915,9,32),(23915,10,29),(23915,11,34),(23915,12,37),(23915,13,42),(23915,14,34),
(23915,25,62),(23915,27,-7),(23915,28,22),(23915,29,7),(23915,30,62),(23915,31,120),(23915,68,96),(23915,170,8),(23915,384,600),(23915,401,4);

-- academics_gown_+4 (23960) <- tmpl 23462; +4 adds Accuracy (mod 25)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23960,1,148),(23960,2,101),(23960,5,183),(23960,8,31),(23960,9,34),(23960,10,31),(23960,11,36),(23960,12,44),(23960,13,44),(23960,14,39),
(23960,25,60),(23960,29,8),(23960,30,60),(23960,31,125),(23960,68,101),(23960,337,25),(23960,369,3),(23960,384,300),(23960,487,10);

-- academics_bracers_+4 (24005) <- tmpl 23529; +4 adds Accuracy (mod 25)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24005,1,106),(24005,2,53),(24005,5,71),(24005,8,16),(24005,9,41),(24005,10,35),(24005,11,20),(24005,12,29),(24005,13,48),(24005,14,29),
(24005,25,58),(24005,27,-6),(24005,29,5),(24005,30,58),(24005,31,82),(24005,68,82),(24005,170,9),(24005,296,8),(24005,384,300);

-- academics_pants_+4 (24050) <- tmpl 23596; +4 adds Accuracy (mod 25)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24050,1,130),(24050,2,99),(24050,5,78),(24050,8,35),(24050,10,22),(24050,11,32),(24050,12,44),(24050,13,44),(24050,14,29),
(24050,25,59),(24050,27,-6),(24050,29,8),(24050,30,59),(24050,31,152),(24050,68,87),(24050,336,25),(24050,374,15),(24050,384,500);

-- academics_loafers_+4 (24095) <- tmpl 23663; +4 adds Accuracy (mod 25). Omitted: Arts: Magic Accuracy+20 (not stored in +3 tmpl)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24095,1,88),(24095,2,39),(24095,5,41),(24095,8,20),(24095,9,24),(24095,10,20),(24095,11,48),(24095,12,32),(24095,13,34),(24095,14,44),
(24095,25,56),(24095,27,-8),(24095,29,7),(24095,30,56),(24095,31,152),(24095,68,115),(24095,384,300),(24095,489,-12);

-- ============ AGOGE (WAR Relic) ============
-- agoge_mask_+4 (23918) <- tmpl 23398
INSERT INTO item_mods (itemId, modId, value) VALUES
(23918,1,140),(23918,2,68),(23918,8,40),(23918,9,28),(23918,10,40),(23918,11,28),(23918,12,31),(23918,13,28),(23918,14,28),
(23918,23,93),(23918,25,42),(23918,29,5),(23918,30,42),(23918,31,113),(23918,68,81),(23918,110,22),(23918,384,800),(23918,483,30),(23918,841,12);

-- agoge_lorica_+4 (23963) <- tmpl 23465 (SPARSE: only mod 955 in +3). Base stats reconstructed from sibling agoge pieces + mod.lua.
INSERT INTO item_mods (itemId, modId, value) VALUES
(23963,1,170),(23963,2,91),(23963,8,41),(23963,9,35),(23963,10,41),(23963,11,30),(23963,12,33),(23963,13,30),(23963,14,30),
(23963,23,95),(23963,25,55),(23963,29,8),(23963,30,45),(23963,31,124),(23963,68,89),(23963,288,7),(23963,384,400),(23963,955,30);

-- agoge_mufflers_+4 (24008) <- tmpl 23532 (SPARSE: only 903/904/956 in +3). Base stats reconstructed. Omitted: Phys dmg taken-6%, Defender block+15% (not stored in +3 tmpl)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24008,1,124),(24008,2,80),(24008,8,30),(24008,9,39),(24008,10,52),(24008,11,13),(24008,12,24),(24008,13,36),(24008,14,26),
(24008,23,96),(24008,25,43),(24008,29,5),(24008,30,43),(24008,31,103),(24008,68,67),(24008,384,500),(24008,903,50),(24008,904,1),(24008,956,15);

-- agoge_cuisses_+4 (24053) <- tmpl 23599
INSERT INTO item_mods (itemId, modId, value) VALUES
(24053,1,151),(24053,2,80),(24053,8,48),(24053,10,35),(24053,11,24),(24053,12,39),(24053,13,23),(24053,14,23),
(24053,23,74),(24053,25,44),(24053,29,7),(24053,30,44),(24053,31,140),(24053,68,72),(24053,288,6),(24053,384,600),(24053,1038,11);

-- agoge_calligae_+4 (24098) <- tmpl 23666
INSERT INTO item_mods (itemId, modId, value) VALUES
(24098,1,106),(24098,2,45),(24098,8,32),(24098,9,29),(24098,10,33),(24098,11,43),(24098,13,21),(24098,14,38),
(24098,23,71),(24098,25,48),(24098,29,6),(24098,30,41),(24098,31,140),(24098,68,97),(24098,384,400),(24098,954,30);

-- ============ ANCHORITES (MNK AF) ============
-- anchorites_crown_+4 (23896) <- tmpl 23376; +4 adds Magic Accuracy (mod 30)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23896,1,125),(23896,2,92),(23896,8,33),(23896,9,35),(23896,10,32),(23896,11,37),(23896,12,31),(23896,13,37),(23896,14,31),
(23896,25,57),(23896,29,6),(23896,30,57),(23896,31,88),(23896,68,98),(23896,165,8),(23896,384,800),(23896,561,21);

-- anchorites_cyclas_+4 (23941) <- tmpl 23443; +4 adds Magic Accuracy (mod 30)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23941,1,155),(23941,2,138),(23941,8,39),(23941,9,40),(23941,10,36),(23941,11,40),(23941,12,34),(23941,13,37),(23941,14,34),
(23941,25,65),(23941,29,6),(23941,30,65),(23941,31,98),(23941,68,112),(23941,384,400),(23941,421,8),(23941,1026,66),(23941,1027,1);

-- anchorites_gloves_+4 (23986) <- tmpl 23510; +4 adds Magic Accuracy (mod 30)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23986,1,113),(23986,2,100),(23986,8,28),(23986,9,49),(23986,10,38),(23986,11,21),(23986,12,20),(23986,13,41),(23986,14,26),
(23986,25,58),(23986,29,3),(23986,30,58),(23986,31,71),(23986,68,82),(23986,97,72),(23986,289,11),(23986,384,500),(23986,841,12);

-- anchorites_hose_+4 (24031) <- tmpl 23577; +4 adds Magic Accuracy (mod 30). Omitted: Counter attack+20 (not stored in +3 tmpl)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24031,1,137),(24031,2,114),(24031,8,42),(24031,10,29),(24031,11,36),(24031,12,42),(24031,13,35),(24031,14,20),
(24031,25,59),(24031,29,5),(24031,30,59),(24031,31,109),(24031,68,93),(24031,107,27),(24031,291,6),(24031,384,600);

-- anchorites_gaiters_+4 (24076) <- tmpl 23644; +4 adds Magic Accuracy (mod 30). Omitted: Kick Attacks attack+120 (not stored in +3 tmpl)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24076,1,95),(24076,2,46),(24076,8,24),(24076,9,35),(24076,10,21),(24076,11,49),(24076,13,30),(24076,14,39),
(24076,25,56),(24076,29,5),(24076,30,56),(24076,31,109),(24076,68,134),(24076,292,10),(24076,384,400),(24076,552,19);

-- ============ ANKUSA (BST Relic) ============
-- ankusa_helm_+4 (23926) <- tmpl 23406. Omitted: Pet:Haste+6% (not stored in +3 tmpl)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23926,1,128),(23926,2,66),(23926,5,53),(23926,8,37),(23926,9,36),(23926,10,30),(23926,11,29),(23926,12,28),(23926,13,25),(23926,14,33),
(23926,23,72),(23926,25,42),(23926,29,5),(23926,30,42),(23926,31,113),(23926,68,89),
(23926,224,5),(23926,225,5),(23926,226,5),(23926,227,5),(23926,228,5),(23926,229,5),(23926,230,5),(23926,360,14),(23926,384,800),(23926,841,12);

-- ankusa_jackcoat_+4 (23971) <- tmpl 23473. Omitted: Reward Effect III, Pet:DA+5%, Pet:Haste+7% (not stored in +3 tmpl)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23971,1,158),(23971,2,89),(23971,5,74),(23971,8,43),(23971,9,43),(23971,10,39),(23971,11,38),(23971,12,40),(23971,13,33),(23971,14,33),
(23971,23,75),(23971,25,45),(23971,29,9),(23971,30,45),(23971,31,124),(23971,68,94),(23971,360,16),(23971,384,400);

-- ankusa_gloves_+4 (24016) <- tmpl 23540. Omitted: Pet:Phys dmg taken-6% (not stored in +3 tmpl)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24016,1,116),(24016,2,55),(24016,8,26),(24016,9,45),(24016,10,47),(24016,11,22),(24016,12,25),(24016,13,40),(24016,14,27),
(24016,23,73),(24016,25,43),(24016,29,5),(24016,30,43),(24016,31,97),(24016,68,69),(24016,360,13),(24016,384,500),(24016,564,2);

-- ankusa_trousers_+4 (24061) <- tmpl 23607. Omitted: Pet:Haste+6%, Store TP+7 (not stored in +3 tmpl)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24061,1,137),(24061,2,77),(24061,8,44),(24061,9,20),(24061,10,31),(24061,11,30),(24061,12,43),(24061,13,27),(24061,14,21),
(24061,23,74),(24061,25,44),(24061,29,8),(24061,30,44),(24061,31,129),(24061,68,83),(24061,360,11),(24061,384,600),(24061,1152,21),(24061,1169,10);

-- ankusa_gaiters_+4 (24106) <- tmpl 23674. Omitted: Pet:Evasion+38, Phys dmg taken-5% (not stored in +3 tmpl)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24106,1,96),(24106,2,43),(24106,8,27),(24106,9,34),(24106,10,27),(24106,11,47),(24106,13,22),(24106,14,40),
(24106,23,71),(24106,25,41),(24106,29,8),(24106,30,41),(24106,31,129),(24106,68,117),(24106,360,12),(24106,364,41),(24106,384,400);

-- ============ ARCADIAN (RNG AF) ============ (uses RATT=24, RACC=26)
-- arcadian_beret_+4 (23928) <- tmpl 23408
INSERT INTO item_mods (itemId, modId, value) VALUES
(23928,1,125),(23928,2,66),(23928,8,36),(23928,9,29),(23928,10,27),(23928,11,37),(23928,12,28),(23928,13,31),(23928,14,26),
(23928,24,72),(23928,26,42),(23928,27,-8),(23928,29,5),(23928,30,42),(23928,31,113),(23928,68,89),(23928,305,38),(23928,359,14),(23928,384,800);

-- arcadian_jerkin_+4 (23973) <- tmpl 23475. Omitted: Double Shot damage+11, Occ.Triple Shot (not stored in +3 tmpl)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23973,1,156),(23973,2,89),(23973,5,74),(23973,8,42),(23973,9,39),(23973,10,36),(23973,11,43),(23973,12,36),(23973,13,33),(23973,14,33),
(23973,24,75),(23973,26,45),(23973,27,-8),(23973,29,9),(23973,30,45),(23973,31,124),(23973,68,94),(23973,359,16),(23973,384,400);

-- arcadian_bracers_+4 (24018) <- tmpl 23542
INSERT INTO item_mods (itemId, modId, value) VALUES
(24018,1,111),(24018,2,55),(24018,8,30),(24018,9,45),(24018,10,44),(24018,11,21),(24018,12,25),(24018,13,40),(24018,14,27),
(24018,24,89),(24018,26,43),(24018,27,-6),(24018,29,5),(24018,30,43),(24018,31,97),(24018,68,85),(24018,365,6),(24018,384,500);

-- arcadian_braccae_+4 (24063) <- tmpl 23609
INSERT INTO item_mods (itemId, modId, value) VALUES
(24063,1,135),(24063,2,97),(24063,5,53),(24063,8,44),(24063,10,29),(24063,11,33),(24063,12,43),(24063,13,27),(24063,14,21),
(24063,24,91),(24063,26,52),(24063,27,-7),(24063,29,8),(24063,30,44),(24063,31,129),(24063,68,83),(24063,365,7),(24063,384,600),(24063,841,12);

-- arcadian_socks_+4 (24108) <- tmpl 23676
INSERT INTO item_mods (itemId, modId, value) VALUES
(24108,1,93),(24108,2,43),(24108,8,29),(24108,9,34),(24108,10,25),(24108,11,51),(24108,13,22),(24108,14,40),
(24108,24,91),(24108,26,41),(24108,27,-8),(24108,29,8),(24108,30,41),(24108,31,129),(24108,68,117),(24108,165,8),(24108,359,10),(24108,384,400);

-- ============ ARCHMAGES (BLM Relic) ============
-- archmages_petasos_+4 (23921) <- tmpl 23401
INSERT INTO item_mods (itemId, modId, value) VALUES
(23921,1,120),(23921,2,66),(23921,5,62),(23921,8,27),(23921,9,24),(23921,10,29),(23921,11,24),(23921,12,39),(23921,13,29),(23921,14,29),
(23921,25,42),(23921,27,-7),(23921,28,58),(23921,29,8),(23921,30,48),(23921,31,135),(23921,68,81),(23921,115,22),(23921,384,600);

-- archmages_coat_+4 (23966) <- tmpl 23468. NOTE: +3 tmpl stored Haste as mod 394 (WHITE_MAGIC_COST) - a bug; corrected to 384 (HASTE) here.
INSERT INTO item_mods (itemId, modId, value) VALUES
(23966,1,150),(23966,2,84),(23966,5,89),(23966,8,34),(23966,9,31),(23966,10,36),(23966,11,31),(23966,12,51),(23966,13,39),(23966,14,39),
(23966,25,45),(23966,27,-12),(23966,28,55),(23966,29,9),(23966,30,45),(23966,31,140),(23966,68,86),(23966,115,25),(23966,369,3),(23966,384,300);

-- archmages_gloves_+4 (24011) <- tmpl 23535
INSERT INTO item_mods (itemId, modId, value) VALUES
(24011,1,104),(24011,2,52),(24011,5,44),(24011,8,19),(24011,9,38),(24011,10,40),(24011,11,15),(24011,12,41),(24011,13,43),(24011,14,29),
(24011,25,43),(24011,27,-7),(24011,28,53),(24011,29,6),(24011,30,43),(24011,31,97),(24011,68,67),(24011,115,24),(24011,116,24),(24011,384,300),(24011,487,20);

-- archmages_tonban_+4 (24056) <- tmpl 23602. +4-only "Magic Burst Damage II+3" resolved to mod 274 (MAGIC_BURST_BONUS_UNCAPPED)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24056,1,128),(24056,2,73),(24056,5,95),(24056,8,38),(24056,10,27),(24056,11,27),(24056,12,55),(24056,13,34),(24056,14,29),
(24056,25,44),(24056,27,-7),(24056,28,61),(24056,29,9),(24056,30,51),(24056,31,167),(24056,68,72),(24056,274,3),(24056,384,500);

-- archmages_sabots_+4 (24101) <- tmpl 23669
INSERT INTO item_mods (itemId, modId, value) VALUES
(24101,1,88),(24101,2,43),(24101,5,44),(24101,8,23),(24101,9,21),(24101,10,25),(24101,11,43),(24101,12,35),(24101,13,29),(24101,14,44),
(24101,25,41),(24101,27,-6),(24101,28,57),(24101,29,8),(24101,30,47),(24101,31,167),(24101,68,100),(24101,115,18),(24101,384,300),(24101,1150,30);

-- +4 batch 2
-- Reforged Artifact/Relic +4 stats, batch 2
-- Sets: assimilators, atrophy, bagua, bihu, brioso, caballarius
-- Method: +3 item_mods = modId template; values from BG-wiki +4 stat lines.
-- Scale: Haste(384) %x100; Damage-taken(160/161/163/164) %x100 negative; Skillchain(175) x100; else 1:1.
-- ADD notes: reforged +4 grants BOTH Accuracy(25) and Magic Accuracy(30); where a +3 piece
--   had only one, the other modId is added (equal value per wiki). Marked /*ADD*/.
-- OMITs: bagua galero "Luopan: HP+600" and bagua sandals "Luopan: Regen+5" have no modId in mod.lua; omitted.
-- Fixes on bagua mitaines (+3 template had two prior-run errors):
--   * +3 stored Evasion+42 under wrong modId 41 (ICE_MACC) and lacked EVA modId 68. Wiki +3 shows Evasion+42,
--     so +4 Evasion+67 is written to the CORRECT modId 68=67 (a +25 jump matching the other bagua pieces);
--     bogus modId 41 is dropped.
--   * Enmity(27) uses wiki -8 (the +3 DB row's +8 is a sign error; wiki shows Enmity-8 at both tiers).

DELETE FROM item_mods WHERE itemId IN (
  23910,23955,24000,24045,24090,
  23899,23944,23989,24034,24079,
  23938,23983,24028,24073,24118,
  23927,23972,24017,24062,24107,
  23904,23949,23994,24039,24084,
  23924,23969,24014,24059,24104
);

-- ===================== ASSIMILATORS (BLU AF) =====================
-- Assimilator's Keffiyeh +4 (23910)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23910,1,127),(23910,2,89),(23910,5,69),(23910,8,30),(23910,9,39),(23910,10,30),(23910,11,39),(23910,12,33),(23910,13,36),(23910,14,31),(23910,25,66)/*ADD*/,(23910,28,30),(23910,29,4),(23910,30,66),(23910,31,98),(23910,68,104),(23910,384,800);
-- Assimilator's Jubbah +4 (23955)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23955,1,157),(23955,2,123),(23955,5,101),(23955,8,39),(23955,9,49),(23955,10,34),(23955,11,43),(23955,12,33),(23955,13,36),(23955,14,33),(23955,25,60),(23955,29,8),(23955,30,60)/*ADD*/,(23955,31,109),(23955,68,109),(23955,122,25),(23955,369,3),(23955,384,400),(23955,841,12);
-- Assimilator's Bazubands +4 (24000)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24000,1,115),(24000,2,57),(24000,5,65),(24000,8,21),(24000,9,50),(24000,10,42),(24000,11,20),(24000,12,32),(24000,13,43),(24000,14,27),(24000,25,58),(24000,29,4),(24000,30,58)/*ADD*/,(24000,31,82),(24000,68,84),(24000,110,20),(24000,160,-600),(24000,384,500),(24000,945,16);
-- Assimilator's Shalwar +4 (24045)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24045,1,139),(24045,2,113),(24045,5,42),(24045,8,42),(24045,10,26),(24045,11,35),(24045,12,43),(24045,13,30),(24045,14,21),(24045,25,59)/*ADD*/,(24045,29,7),(24045,30,59),(24045,31,114),(24045,68,98),(24045,168,24),(24045,384,600),(24045,487,10),(24045,1139,16);
-- Assimilator's Charuqs +4 (24090)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24090,1,97),(24090,2,69),(24090,5,50),(24090,8,22),(24090,9,39),(24090,10,22),(24090,11,52),(24090,13,25),(24090,14,40),(24090,23,43),(24090,25,65),(24090,29,7),(24090,30,65)/*ADD*/,(24090,31,114),(24090,68,132),(24090,175,1000),(24090,384,400),(24090,1140,24);

-- ===================== ATROPHY (RDM AF) =====================
-- Atrophy Chapeau +4 (23899)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23899,1,121),(23899,2,74),(23899,5,68),(23899,8,29),(23899,9,32),(23899,10,29),(23899,11,34),(23899,12,37),(23899,13,42),(23899,14,34),(23899,25,64)/*ADD*/,(23899,29,8),(23899,30,64),(23899,31,120),(23899,68,96),(23899,115,18),(23899,170,16),(23899,384,600),(23899,487,10);
-- Atrophy Tabard +4 (23944)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23944,1,151),(23944,2,101),(23944,5,108),(23944,8,31),(23944,9,34),(23944,10,31),(23944,11,36),(23944,12,43),(23944,13,48),(23944,14,39),(23944,25,65)/*ADD*/,(23944,28,22),(23944,29,9),(23944,30,65),(23944,31,125),(23944,68,101),(23944,114,22),(23944,369,3),(23944,384,300),(23944,529,2);
-- Atrophy Gloves +4 (23989)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23989,1,109),(23989,2,53),(23989,5,41),(23989,8,21),(23989,9,46),(23989,10,35),(23989,11,20),(23989,12,29),(23989,13,48),(23989,14,29),(23989,23,35),(23989,25,63),(23989,29,6),(23989,30,63)/*ADD*/,(23989,31,82),(23989,68,82),(23989,110,22),(23989,384,300),(23989,841,9),(23989,890,20);
-- Atrophy Tights +4 (24034)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24034,1,133),(24034,2,84),(24034,5,63),(24034,8,35),(24034,10,22),(24034,11,32),(24034,12,44),(24034,13,44),(24034,14,29),(24034,25,59),(24034,29,9),(24034,30,59)/*ADD*/,(24034,31,152),(24034,68,87),(24034,112,18),(24034,113,22),(24034,374,12),(24034,384,500);
-- Atrophy Boots +4 (24079)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24079,1,91),(24079,2,92),(24079,5,93),(24079,8,20),(24079,9,24),(24079,10,20),(24079,11,48),(24079,12,27),(24079,13,34),(24079,14,44),(24079,25,66),(24079,29,8),(24079,30,66)/*ADD*/,(24079,31,152),(24079,68,115),(24079,109,18),(24079,384,400),(24079,518,10);

-- ===================== BAGUA (GEO Relic) =====================
-- Bagua Galero +4 (23938)  [OMIT: Luopan: HP+600 - no modId]
INSERT INTO item_mods (itemId, modId, value) VALUES
(23938,1,123),(23938,2,101),(23938,5,62),(23938,8,27),(23938,9,24),(23938,10,29),(23938,11,24),(23938,12,34),(23938,13,29),(23938,14,29),(23938,25,42),(23938,28,52),(23938,29,8),(23938,30,51),(23938,31,135),(23938,68,81),(23938,315,35),(23938,384,600);
-- Bagua Tunic +4 (23983)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23983,1,154),(23983,2,124),(23983,5,129),(23983,8,34),(23983,9,31),(23983,10,36),(23983,11,31),(23983,12,44),(23983,13,39),(23983,14,39),(23983,25,45),(23983,28,66),(23983,29,9),(23983,30,45),(23983,31,140),(23983,68,86),(23983,123,17),(23983,384,300);
-- Bagua Mitaines +4 (24028)  [OMIT: modId 41 spurious; Enmity(27) sign-corrected to -8]
INSERT INTO item_mods (itemId, modId, value) VALUES
(24028,1,109),(24028,2,52),(24028,5,44),(24028,8,19),(24028,9,38),(24028,10,40),(24028,11,15),(24028,12,34),(24028,13,43),(24028,14,29),(24028,25,43),(24028,27,-8),(24028,28,53),(24028,29,6),(24028,30,43),(24028,31,97),(24028,68,67),(24028,369,2),(24028,384,300),(24028,399,14),(24028,487,12);
-- Bagua Pants +4 (24073)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24073,1,133),(24073,2,128),(24073,5,59),(24073,8,38),(24073,10,27),(24073,11,30),(24073,12,52),(24073,13,37),(24073,14,29),(24073,25,44),(24073,28,54),(24073,29,9),(24073,30,44),(24073,31,167),(24073,68,85),(24073,384,500),(24073,960,21);
-- Bagua Sandals +4 (24118)  [OMIT: Luopan: Regen+5 - no modId]
INSERT INTO item_mods (itemId, modId, value) VALUES
(24118,1,92),(24118,2,73),(24118,5,44),(24118,8,23),(24118,9,21),(24118,10,28),(24118,11,43),(24118,12,35),(24118,13,32),(24118,14,44),(24118,25,41),(24118,28,51),(24118,29,8),(24118,30,41),(24118,31,167),(24118,68,100),(24118,114,22),(24118,384,300);

-- ===================== BIHU (BRD Relic) =====================
-- Bihu Roundlet +4 (23927)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23927,1,120),(23927,2,66),(23927,5,62),(23927,8,24),(23927,9,24),(23927,10,33),(23927,11,24),(23927,12,32),(23927,13,27),(23927,14,42),(23927,23,72),(23927,25,42),(23927,27,-9),(23927,29,8),(23927,30,56),(23927,31,135),(23927,68,83),(23927,119,19),(23927,161,-600),(23927,164,-600),(23927,384,600);
-- Bihu Justaucorps +4 (23972)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23972,1,150),(23972,2,99),(23972,5,104),(23972,8,42),(23972,9,41),(23972,10,44),(23972,11,41),(23972,12,42),(23972,13,38),(23972,14,45),(23972,23,102),(23972,25,58),(23972,29,9),(23972,30,59),(23972,31,140),(23972,68,89),(23972,160,-700),(23972,384,300),(23972,841,12);
-- Bihu Cuffs +4 (24017)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24017,1,109),(24017,2,52),(24017,5,44),(24017,8,19),(24017,9,38),(24017,10,40),(24017,11,15),(24017,12,32),(24017,13,42),(24017,14,35),(24017,23,73),(24017,25,43),(24017,27,-9),(24017,29,6),(24017,30,49),(24017,31,97),(24017,68,69),(24017,121,16),(24017,161,-500),(24017,164,-500),(24017,384,300);
-- Bihu Cannions +4 (24062)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24062,1,132),(24062,2,113),(24062,5,99),(24062,8,36),(24062,10,25),(24062,11,27),(24062,12,57),(24062,13,43),(24062,14,45),(24062,23,74),(24062,25,44),(24062,29,9),(24062,30,57),(24062,31,167),(24062,68,75),(24062,161,-600),(24062,164,-600),(24062,384,500);
-- Bihu Slippers +4 (24107)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24107,1,91),(24107,2,43),(24107,5,44),(24107,8,20),(24107,9,21),(24107,10,22),(24107,11,43),(24107,12,30),(24107,13,27),(24107,14,50),(24107,23,71),(24107,25,41),(24107,27,-8),(24107,29,8),(24107,30,41),(24107,31,167),(24107,68,103),(24107,120,16),(24107,161,-500),(24107,164,-500),(24107,384,300),(24107,455,10);

-- ===================== BRIOSO (BRD AF) =====================
-- Brioso Roundlet +4 (23904)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23904,1,120),(23904,2,74),(23904,5,52),(23904,8,26),(23904,9,32),(23904,10,26),(23904,11,34),(23904,12,34),(23904,13,38),(23904,14,43),(23904,25,71)/*ADD*/,(23904,29,7),(23904,30,71),(23904,31,120),(23904,68,98),(23904,110,13),(23904,120,14),(23904,384,600),(23904,435,2);
-- Brioso Justaucorps +4 (23949)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23949,1,150),(23949,2,101),(23949,5,79),(23949,8,29),(23949,9,34),(23949,10,29),(23949,11,36),(23949,12,39),(23949,13,41),(23949,14,45),(23949,25,74)/*ADD*/,(23949,27,-6),(23949,29,8),(23949,30,74),(23949,31,125),(23949,68,104),(23949,119,18),(23949,120,15),(23949,384,300),(23949,455,15);
-- Brioso Cuffs +4 (23994)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23994,1,108),(23994,2,53),(23994,5,34),(23994,8,16),(23994,9,41),(23994,10,35),(23994,11,20),(23994,12,29),(23994,13,45),(23994,14,41),(23994,25,58)/*ADD*/,(23994,27,-8),(23994,29,5),(23994,30,58),(23994,31,82),(23994,68,84),(23994,119,18),(23994,384,300),(23994,440,2);
-- Brioso Cannions +4 (24039)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24039,1,132),(24039,2,84),(24039,5,79),(24039,8,33),(24039,10,20),(24039,11,32),(24039,12,44),(24039,13,36),(24039,14,35),(24039,25,66)/*ADD*/,(24039,27,-5),(24039,29,8),(24039,30,66),(24039,31,152),(24039,68,90),(24039,121,20),(24039,160,-800),(24039,384,500);
-- Brioso Slippers +4 (24084)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24084,1,90),(24084,2,84),(24084,5,64),(24084,8,17),(24084,9,24),(24084,10,17),(24084,11,48),(24084,12,27),(24084,13,30),(24084,14,50),(24084,25,56)/*ADD*/,(24084,29,7),(24084,30,56),(24084,31,152),(24084,68,118),(24084,121,15),(24084,384,300),(24084,454,15);

-- ===================== CABALLARIUS (PLD Relic) =====================
-- Caballarius Coronet +4 (23924)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23924,1,145),(23924,2,126),(23924,5,108),(23924,8,37),(23924,9,26),(23924,10,48),(23924,11,26),(23924,12,27),(23924,13,24),(23924,14,24),(23924,23,72),(23924,25,42),(23924,27,9),(23924,29,5),(23924,30,42),(23924,31,92),(23924,68,78),(23924,92,30),(23924,384,700);
-- Caballarius Surcoat +4 (23969)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23969,1,176),(23969,2,148),(23969,5,120),(23969,8,44),(23969,9,29),(23969,10,44),(23969,11,29),(23969,12,32),(23969,13,29),(23969,14,29),(23969,23,75),(23969,25,45),(23969,27,10),(23969,29,7),(23969,30,45),(23969,31,108),(23969,68,86),(23969,160,-1200),(23969,384,300),(23969,965,41);
-- Caballarius Gauntlets +4 (24014)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24014,1,130),(24014,2,134),(24014,8,25),(24014,9,39),(24014,10,52),(24014,12,21),(24014,13,39),(24014,14,29),(24014,23,73),(24014,25,43),(24014,27,9),(24014,29,4),(24014,30,43),(24014,31,86),(24014,68,67),(24014,384,400),(24014,385,35);
-- Caballarius Breeches +4 (24059)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24059,1,156),(24059,2,82),(24059,5,110),(24059,8,55),(24059,10,41),(24059,11,26),(24059,12,38),(24059,13,27),(24059,14,20),(24059,23,74),(24059,25,44),(24059,27,9),(24059,29,6),(24059,30,44),(24059,31,124),(24059,68,67),(24059,161,-700),(24059,164,-700),(24059,168,10),(24059,384,500);
-- Caballarius Leggings +4 (24104)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24104,1,114),(24104,2,73),(24104,5,55),(24104,8,31),(24104,9,22),(24104,10,32),(24104,11,39),(24104,13,20),(24104,14,36),(24104,23,71),(24104,25,41),(24104,27,8),(24104,29,5),(24104,30,41),(24104,31,124),(24104,68,94),(24104,163,-700),(24104,384,300),(24104,837,25);

-- +4 batch 3
-- Reforged +4 armor stats, batch 3: convokers, fallens, foire, futhark, geomancy, glyphic
-- Method: +3 item_mods = modId/scale template; values from BG-wiki +4 stat lines.
-- Notes: convokers & foire gain MACC(30) at +4; geomancy gains ACC(25) at +4.
--        Haste(384) = %x100; DMG-taken(160/161/164) = %x100 negative; all else 1:1.

DELETE FROM item_mods WHERE itemId IN (
  23909,23954,23999,24044,24089,
  23925,23970,24015,24060,24105,
  23912,23957,24002,24047,24092,
  23939,23984,24029,24074,24119,
  23916,23961,24006,24051,24096,
  23932,23977,24022,24067,24112
);

-- ===== CONVOKERS (SMN AF) =====
-- Horn +4 (23909)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23909,1,117),(23909,2,66),(23909,5,108),(23909,8,22),(23909,9,29),(23909,10,24),(23909,11,29),(23909,12,29),(23909,13,32),(23909,14,29),(23909,25,57),(23909,29,7),(23909,30,57),(23909,31,120),(23909,68,96),(23909,117,20),(23909,369,3),(23909,384,600);
-- Doublet +4 (23954)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23954,1,147),(23954,2,95),(23954,5,221),(23954,8,31),(23954,9,35),(23954,10,31),(23954,11,36),(23954,12,39),(23954,13,42),(23954,14,39),(23954,25,60),(23954,29,8),(23954,30,60),(23954,31,125),(23954,68,101),(23954,357,15),(23954,384,300);
-- Bracers +4 (23999)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23999,1,105),(23999,2,47),(23999,5,96),(23999,8,16),(23999,9,43),(23999,10,34),(23999,11,20),(23999,12,29),(23999,13,46),(23999,14,29),(23999,25,58),(23999,29,5),(23999,30,58),(23999,31,82),(23999,68,82),(23999,384,300);
-- Spats +4 (24044)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24044,1,129),(24044,2,77),(24044,5,119),(24044,8,35),(24044,10,21),(24044,11,32),(24044,12,44),(24044,13,37),(24044,14,29),(24044,25,59),(24044,27,-8),(24044,29,8),(24044,30,59),(24044,31,152),(24044,68,87),(24044,384,500);
-- Pigaches +4 (24089)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24089,1,87),(24089,2,33),(24089,5,81),(24089,8,20),(24089,9,26),(24089,10,20),(24089,11,47),(24089,12,27),(24089,13,32),(24089,14,44),(24089,25,56),(24089,29,7),(24089,30,56),(24089,31,152),(24089,68,115),(24089,346,6),(24089,384,300);

-- ===== FALLENS (DRK Relic) =====
-- Burgeonet +4 (23925)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23925,1,139),(23925,2,106),(23925,5,53),(23925,8,45),(23925,9,24),(23925,10,45),(23925,11,24),(23925,12,25),(23925,13,22),(23925,14,22),(23925,23,87),(23925,25,49),(23925,29,5),(23925,30,42),(23925,31,92),(23925,68,78),(23925,384,700),(23925,1071,-12);
-- Cuirass +4 (23970)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23970,1,171),(23970,2,113),(23970,5,85),(23970,8,47),(23970,9,32),(23970,10,44),(23970,11,29),(23970,12,35),(23970,13,32),(23970,14,29),(23970,23,92),(23970,25,53),(23970,28,63),(23970,29,7),(23970,30,45),(23970,31,108),(23970,48,27),(23970,68,86),(23970,384,300),(23970,407,10);
-- Finger Gauntlets +4 (24015)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24015,1,127),(24015,2,59),(24015,8,31),(24015,9,39),(24015,10,48),(24015,12,27),(24015,13,41),(24015,14,29),(24015,23,87),(24015,25,43),(24015,28,65),(24015,29,4),(24015,30,43),(24015,31,86),(24015,68,67),(24015,116,19),(24015,315,16),(24015,384,400);
-- Flanchard +4 (24060)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24060,1,155),(24060,2,107),(24060,5,55),(24060,8,50),(24060,10,36),(24060,11,26),(24060,12,43),(24060,13,27),(24060,14,20),(24060,23,74),(24060,25,44),(24060,29,11),(24060,30,44),(24060,31,124),(24060,68,67),(24060,116,19),(24060,384,500),(24060,841,12);
-- Sollerets +4 (24105)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24105,1,113),(24105,2,48),(24105,8,36),(24105,9,27),(24105,10,32),(24105,11,39),(24105,13,20),(24105,14,36),(24105,23,86),(24105,25,41),(24105,29,5),(24105,30,41),(24105,31,124),(24105,68,94),(24105,384,300);

-- ===== FOIRE (PUP Relic) =====
-- Taj +4 (23912)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23912,1,127),(23912,2,74),(23912,8,30),(23912,9,38),(23912,10,35),(23912,11,37),(23912,12,31),(23912,13,37),(23912,14,31),(23912,25,57),(23912,29,6),(23912,30,57),(23912,31,88),(23912,68,108),(23912,384,800);
-- Tobe +4 (23957)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23957,1,157),(23957,2,109),(23957,8,34),(23957,9,40),(23957,10,31),(23957,11,40),(23957,12,34),(23957,13,37),(23957,14,34),(23957,23,40),(23957,25,67),(23957,29,6),(23957,30,67),(23957,31,98),(23957,68,122),(23957,384,400),(23957,841,12);
-- Dastanas +4 (24002)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24002,1,115),(24002,2,80),(24002,8,20),(24002,9,49),(24002,10,38),(24002,11,21),(24002,12,20),(24002,13,41),(24002,14,26),(24002,25,58),(24002,29,3),(24002,30,58),(24002,31,71),(24002,68,92),(24002,384,500),(24002,504,5),(24002,505,5);
-- Churidars +4 (24047)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24047,1,139),(24047,2,143),(24047,8,42),(24047,10,24),(24047,11,36),(24047,12,42),(24047,13,30),(24047,14,20),(24047,25,59),(24047,29,5),(24047,30,59),(24047,31,109),(24047,68,103),(24047,384,600);
-- Babouches +4 (24092)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24092,1,97),(24092,2,84),(24092,8,24),(24092,9,30),(24092,10,21),(24092,11,49),(24092,13,25),(24092,14,39),(24092,25,61),(24092,29,5),(24092,30,61),(24092,31,109),(24092,68,139),(24092,384,400),(24092,853,3);

-- ===== FUTHARK (RUN Relic) =====
-- Bandeau +4 (23939)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23939,1,129),(23939,2,66),(23939,5,98),(23939,8,26),(23939,9,27),(23939,10,35),(23939,11,34),(23939,12,28),(23939,13,23),(23939,14,24),(23939,23,72),(23939,25,42),(23939,29,5),(23939,30,42),(23939,31,113),(23939,68,89),(23939,161,-600),(23939,164,-600),(23939,384,800),(23939,1182,7);
-- Coat +4 (23984)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23984,1,161),(23984,2,129),(23984,5,114),(23984,8,37),(23984,9,39),(23984,10,39),(23984,11,38),(23984,12,38),(23984,13,33),(23984,14,33),(23984,23,75),(23984,25,45),(23984,29,9),(23984,30,45),(23984,31,124),(23984,68,94),(23984,160,-900),(23984,370,5),(23984,384,400),(23984,1009,5);
-- Mitons +4 (24029)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24029,1,117),(24029,2,55),(24029,8,24),(24029,9,45),(24029,10,47),(24029,11,15),(24029,12,27),(24029,13,40),(24029,14,27),(24029,23,91),(24029,25,43),(24029,27,6),(24029,29,9),(24029,30,43),(24029,31,97),(24029,68,69),(24029,384,500),(24029,1008,9);
-- Trousers +4 (24074)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24074,1,144),(24074,2,117),(24074,8,42),(24074,10,31),(24074,11,30),(24074,12,45),(24074,13,27),(24074,14,21),(24074,23,74),(24074,25,44),(24074,29,8),(24074,30,44),(24074,31,129),(24074,68,83),(24074,384,600),(24074,890,30);
-- Boots +4 (24119)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24119,1,100),(24119,2,43),(24119,5,60),(24119,8,25),(24119,9,34),(24119,10,27),(24119,11,47),(24119,13,22),(24119,14,40),(24119,23,71),(24119,25,50),(24119,29,8),(24119,30,41),(24119,31,129),(24119,68,117),(24119,110,20),(24119,384,400),(24119,486,40);

-- ===== GEOMANCY (GEO AF) =====
-- Galero +4 (23916)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23916,1,122),(23916,2,74),(23916,5,89),(23916,8,26),(23916,9,29),(23916,10,26),(23916,11,31),(23916,12,36),(23916,13,41),(23916,14,31),(23916,25,57),(23916,29,7),(23916,30,57),(23916,31,120),(23916,68,96),(23916,115,20),(23916,384,600),(23916,1132,100);
-- Tunic +4 (23961)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23961,1,152),(23961,2,101),(23961,5,147),(23961,8,31),(23961,9,34),(23961,10,31),(23961,11,36),(23961,12,39),(23961,13,44),(23961,14,39),(23961,25,60),(23961,29,8),(23961,30,60),(23961,31,125),(23961,68,101),(23961,116,22),(23961,369,3),(23961,384,300),(23961,1029,14);
-- Mitaines +4 (24006)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24006,1,110),(24006,2,90),(24006,5,78),(24006,8,16),(24006,9,41),(24006,10,35),(24006,11,20),(24006,12,29),(24006,13,48),(24006,14,29),(24006,25,58),(24006,29,5),(24006,30,58),(24006,31,82),(24006,68,82),(24006,123,20),(24006,161,-300),(24006,164,-300),(24006,384,300);
-- Pants +4 (24051)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24051,1,134),(24051,2,137),(24051,5,116),(24051,8,35),(24051,10,22),(24051,11,32),(24051,12,44),(24051,13,39),(24051,14,29),(24051,25,59),(24051,29,8),(24051,30,59),(24051,31,152),(24051,68,87),(24051,168,24),(24051,170,15),(24051,384,500);
-- Sandals +4 (24096)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24096,1,92),(24096,2,39),(24096,5,93),(24096,8,20),(24096,9,24),(24096,10,20),(24096,11,48),(24096,12,27),(24096,13,34),(24096,14,44),(24096,25,56),(24096,29,7),(24096,30,56),(24096,31,152),(24096,68,115),(24096,76,18),(24096,384,300);

-- ===== GLYPHIC (SMN Relic) =====
-- Horn +4 (23932)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23932,1,118),(23932,2,61),(23932,5,125),(23932,8,27),(23932,9,24),(23932,10,29),(23932,11,24),(23932,12,32),(23932,13,29),(23932,14,29),(23932,23,72),(23932,25,42),(23932,29,8),(23932,30,42),(23932,31,135),(23932,68,81),(23932,346,5),(23932,357,-10),(23932,384,600);
-- Doublet +4 (23977)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23977,1,148),(23977,2,80),(23977,5,145),(23977,8,36),(23977,9,30),(23977,10,36),(23977,11,31),(23977,12,42),(23977,13,39),(23977,14,39),(23977,23,75),(23977,25,45),(23977,29,9),(23977,30,45),(23977,31,140),(23977,68,86),(23977,346,6),(23977,384,300),(23977,541,4);
-- Bracers +4 (24022)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24022,1,106),(24022,2,48),(24022,5,71),(24022,8,21),(24022,9,38),(24022,10,39),(24022,11,15),(24022,12,32),(24022,13,43),(24022,14,29),(24022,23,73),(24022,25,43),(24022,29,6),(24022,30,43),(24022,31,97),(24022,68,67),(24022,117,24),(24022,357,8),(24022,384,300);
-- Spats +4 (24067)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24067,1,128),(24067,2,68),(24067,5,115),(24067,8,40),(24067,10,26),(24067,11,27),(24067,12,47),(24067,13,34),(24067,14,29),(24067,23,74),(24067,25,44),(24067,29,9),(24067,30,44),(24067,31,167),(24067,68,72),(24067,357,8),(24067,384,500);
-- Pigaches +4 (24112)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24112,1,85),(24112,2,39),(24112,5,105),(24112,8,25),(24112,9,21),(24112,10,25),(24112,11,42),(24112,12,30),(24112,13,29),(24112,14,44),(24112,23,71),(24112,25,41),(24112,29,8),(24112,30,41),(24112,31,167),(24112,68,100),(24112,384,300),(24112,541,-3);

-- +4 batch 4
-- Reforge +4 armor stats, batch 4
-- Sets: hachiya (NIN Relic), hesychasts (MNK Relic), horos (DNC AF),
--       ignominy (DRK Relic), laksamana (COR AF), lanun (COR Relic)
-- Method: +3 sibling piece (same slot) = template for modId set + unit scale;
--         values taken from BG-wiki +4 stat lines. ACC(25)/MACC(30)/RACC(26)
--         present only at +4 are added (mod.lua-confirmed). See report for omissions.

DELETE FROM item_mods WHERE itemId IN (
  23907,23952,23997,24042,24087,
  23919,23964,24009,24054,24099,
  23936,23981,24026,24071,24116,
  23902,23947,23992,24037,24082,
  23911,23956,24001,24046,24091,
  23934,23979,24024,24069,24114
);

-- ============ HACHIYA (Ninja Relic) ============
-- Hatsuburi +4 (head) 23907  [+ACC(25) added]
INSERT INTO item_mods (itemId, modId, value) VALUES
(23907,1,127),(23907,2,74),(23907,8,33),(23907,9,38),(23907,10,32),(23907,11,37),(23907,12,31),(23907,13,34),(23907,14,31),(23907,25,64),(23907,29,6),(23907,30,64),(23907,31,88),(23907,68,108),(23907,118,18),(23907,289,9),(23907,384,800),(23907,841,12);
-- Chainmail +4 (body) 23952  [+MACC(30) added]
INSERT INTO item_mods (itemId, modId, value) VALUES
(23952,1,157),(23952,2,108),(23952,8,39),(23952,9,40),(23952,10,36),(23952,11,40),(23952,12,34),(23952,13,37),(23952,14,34),(23952,25,60),(23952,29,6),(23952,30,60),(23952,31,98),(23952,68,122),(23952,165,8),(23952,259,10),(23952,289,9),(23952,384,400),(23952,499,5),(23952,500,20),(23952,501,35);
-- Tekko +4 (hands) 23997  [+MACC(30) added; Daken omitted]
INSERT INTO item_mods (itemId, modId, value) VALUES
(23997,1,115),(23997,2,57),(23997,8,20),(23997,9,49),(23997,10,38),(23997,11,31),(23997,12,20),(23997,13,41),(23997,14,26),(23997,24,53),(23997,25,58),(23997,26,58),(23997,29,3),(23997,30,58),(23997,31,71),(23997,68,92),(23997,106,15),(23997,289,9),(23997,384,500);
-- Hakama +4 (legs) 24042  [+MACC(30) added]
INSERT INTO item_mods (itemId, modId, value) VALUES
(24042,1,139),(24042,2,90),(24042,8,42),(24042,10,24),(24042,11,36),(24042,12,42),(24042,13,30),(24042,14,20),(24042,25,66),(24042,26,45),(24042,29,5),(24042,30,66),(24042,31,109),(24042,68,118),(24042,73,6),(24042,259,5),(24042,289,9),(24042,384,600);
-- Kyahan +4 (feet) 24087  [+ACC(25) added]
INSERT INTO item_mods (itemId, modId, value) VALUES
(24087,1,97),(24087,2,39),(24087,8,24),(24087,9,30),(24087,10,21),(24087,11,49),(24087,12,20),(24087,13,25),(24087,14,39),(24087,25,62),(24087,28,25),(24087,29,5),(24087,30,62),(24087,31,109),(24087,68,139),(24087,384,400),(24087,487,10);

-- ============ HESYCHASTS (Monk Relic) ============
-- Crown +4 (head) 23919
INSERT INTO item_mods (itemId, modId, value) VALUES
(23919,1,113),(23919,2,112),(23919,8,35),(23919,9,30),(23919,10,37),(23919,11,26),(23919,12,28),(23919,13,25),(23919,14,25),(23919,23,72),(23919,25,42),(23919,27,-8),(23919,29,7),(23919,30,42),(23919,31,103),(23919,68,83),(23919,289,12),(23919,384,800),(23919,841,12);
-- Cyclas +4 (body) 23964
INSERT INTO item_mods (itemId, modId, value) VALUES
(23964,1,147),(23964,2,132),(23964,8,39),(23964,9,35),(23964,10,40),(23964,11,39),(23964,12,37),(23964,13,34),(23964,14,34),(23964,23,75),(23964,25,45),(23964,29,7),(23964,30,45),(23964,31,113),(23964,68,97),(23964,160,-500),(23964,291,5),(23964,370,5),(23964,384,400);
-- Gloves +4 (hands) 24009
INSERT INTO item_mods (itemId, modId, value) VALUES
(24009,1,101),(24009,2,90),(24009,8,25),(24009,9,44),(24009,10,43),(24009,11,16),(24009,12,23),(24009,13,38),(24009,14,26),(24009,23,96),(24009,25,54),(24009,29,4),(24009,30,43),(24009,31,86),(24009,68,67),(24009,73,8),(24009,289,10),(24009,384,400),(24009,1026,51),(24009,1027,6);
-- Hose +4 (legs) 24054
INSERT INTO item_mods (itemId, modId, value) VALUES
(24054,1,129),(24054,2,126),(24054,8,47),(24054,9,21),(24054,10,29),(24054,11,31),(24054,12,45),(24054,13,27),(24054,14,20),(24054,23,74),(24054,25,44),(24054,29,6),(24054,30,44),(24054,31,124),(24054,68,78),(24054,165,8),(24054,289,10),(24054,384,600),(24054,482,19);
-- Gaiters +4 (feet) 24099
INSERT INTO item_mods (itemId, modId, value) VALUES
(24099,1,86),(24099,2,94),(24099,8,33),(24099,9,29),(24099,10,26),(24099,11,44),(24099,13,22),(24099,14,39),(24099,23,71),(24099,25,41),(24099,29,6),(24099,30,41),(24099,31,124),(24099,68,114),(24099,384,400),(24099,543,21);

-- ============ HOROS (Dancer AF) ============
-- Tiara +4 (head) 23936
INSERT INTO item_mods (itemId, modId, value) VALUES
(23936,1,128),(23936,2,96),(23936,5,53),(23936,8,36),(23936,9,37),(23936,10,30),(23936,11,29),(23936,12,28),(23936,13,25),(23936,14,28),(23936,23,87),(23936,25,49),(23936,29,5),(23936,30,42),(23936,31,113),(23936,68,89),(23936,384,800),(23936,491,15);
-- Casaque +4 (body) 23981
INSERT INTO item_mods (itemId, modId, value) VALUES
(23981,1,158),(23981,2,89),(23981,5,74),(23981,8,37),(23981,9,39),(23981,10,39),(23981,11,38),(23981,12,36),(23981,13,33),(23981,14,35),(23981,23,96),(23981,25,55),(23981,29,9),(23981,30,45),(23981,31,124),(23981,68,94),(23981,161,-600),(23981,164,-600),(23981,253,35),(23981,302,4),(23981,384,400),(23981,493,41);
-- Bangles +4 (hands) 24026
INSERT INTO item_mods (itemId, modId, value) VALUES
(24026,1,116),(24026,2,95),(24026,8,24),(24026,9,45),(24026,10,47),(24026,11,24),(24026,12,25),(24026,13,40),(24026,14,38),(24026,23,84),(24026,25,48),(24026,27,9),(24026,29,5),(24026,30,43),(24026,31,97),(24026,68,80),(24026,291,6),(24026,384,500);
-- Tights +4 (legs) 24071
INSERT INTO item_mods (itemId, modId, value) VALUES
(24071,1,138),(24071,2,77),(24071,8,45),(24071,10,31),(24071,11,30),(24071,12,43),(24071,13,27),(24071,14,26),(24071,23,74),(24071,25,50),(24071,29,11),(24071,30,50),(24071,31,129),(24071,68,83),(24071,384,600),(24071,492,50),(24071,841,12);
-- Toe Shoes +4 (feet) 24116
INSERT INTO item_mods (itemId, modId, value) VALUES
(24116,1,96),(24116,2,83),(24116,8,25),(24116,9,34),(24116,10,27),(24116,11,47),(24116,13,22),(24116,14,42),(24116,23,71),(24116,25,47),(24116,29,8),(24116,30,41),(24116,31,129),(24116,68,130),(24116,73,7),(24116,384,400),(24116,403,24);

-- ============ IGNOMINY (Dark Knight Relic) ============
-- Burgeonet +4 (head) 23902  [+MACC(30) added]
INSERT INTO item_mods (itemId, modId, value) VALUES
(23902,1,141),(23902,2,81),(23902,5,54),(23902,8,38),(23902,9,34),(23902,10,35),(23902,11,34),(23902,12,30),(23902,13,30),(23902,14,27),(23902,23,43),(23902,25,57),(23902,29,4),(23902,30,57),(23902,31,77),(23902,68,93),(23902,96,6),(23902,116,22),(23902,384,700);
-- Cuirass +4 (body) 23947  [+MACC(30) added]
INSERT INTO item_mods (itemId, modId, value) VALUES
(23947,1,171),(23947,2,174),(23947,5,132),(23947,8,46),(23947,9,34),(23947,10,39),(23947,11,34),(23947,12,29),(23947,13,32),(23947,14,29),(23947,23,53),(23947,25,60),(23947,29,6),(23947,30,60),(23947,31,93),(23947,68,101),(23947,114,23),(23947,384,300),(23947,841,12);
-- Finger Gauntlets +4 (hands) 23992  [template = gauntlets_+3; +MACC(30) added]
INSERT INTO item_mods (itemId, modId, value) VALUES
(23992,1,129),(23992,2,86),(23992,5,42),(23992,8,25),(23992,9,49),(23992,10,43),(23992,12,18),(23992,13,38),(23992,14,29),(23992,23,38),(23992,25,64),(23992,29,3),(23992,30,64),(23992,31,71),(23992,68,82),(23992,175,1000),(23992,384,400),(23992,392,16);
-- Flanchard +4 (legs) 24037  [+MACC(30) added]
INSERT INTO item_mods (itemId, modId, value) VALUES
(24037,1,153),(24037,2,98),(24037,8,50),(24037,9,20),(24037,10,31),(24037,11,31),(24037,12,40),(24037,13,25),(24037,14,20),(24037,23,50),(24037,25,59),(24037,29,5),(24037,30,59),(24037,31,109),(24037,68,87),(24037,110,22),(24037,288,10),(24037,384,500);
-- Sollerets +4 (feet) 24082  [+ACC(25) added]
INSERT INTO item_mods (itemId, modId, value) VALUES
(24082,1,111),(24082,2,77),(24082,5,50),(24082,8,26),(24082,9,27),(24082,10,27),(24082,11,44),(24082,13,23),(24082,14,36),(24082,23,45),(24082,25,64),(24082,28,29),(24082,29,4),(24082,30,64),(24082,31,109),(24082,68,109),(24082,384,300),(24082,858,90);

-- ============ LAKSAMANA (Corsair AF) ============
-- Tricorne +4 (head) 23911
INSERT INTO item_mods (itemId, modId, value) VALUES
(23911,1,125),(23911,2,74),(23911,8,33),(23911,9,39),(23911,10,27),(23911,11,44),(23911,12,30),(23911,13,33),(23911,14,31),(23911,26,66),(23911,29,4),(23911,30,66),(23911,31,98),(23911,68,104),(23911,384,800),(23911,411,20);
-- Frac +4 (body) 23956  [+MACC(30) added]
INSERT INTO item_mods (itemId, modId, value) VALUES
(23956,1,155),(23956,2,108),(23956,5,64),(23956,8,39),(23956,9,44),(23956,10,31),(23956,11,50),(23956,12,33),(23956,13,36),(23956,14,33),(23956,24,40),(23956,26,67),(23956,29,8),(23956,30,67),(23956,31,109),(23956,68,109),(23956,305,19),(23956,359,20),(23956,384,400),(23956,841,12);
-- Gants +4 (hands) 24001  [+RACC(26) added]
INSERT INTO item_mods (itemId, modId, value) VALUES
(24001,1,113),(24001,2,57),(24001,5,45),(24001,8,21),(24001,9,50),(24001,10,39),(24001,11,22),(24001,12,22),(24001,13,43),(24001,14,27),(24001,25,40),(24001,26,63),(24001,27,-8),(24001,29,4),(24001,30,63),(24001,31,82),(24001,68,84),(24001,110,15),(24001,289,10),(24001,384,500);
-- Trews +4 (legs) 24046  [+MACC(30) added]
INSERT INTO item_mods (itemId, modId, value) VALUES
(24046,1,137),(24046,2,150),(24046,5,83),(24046,8,39),(24046,10,24),(24046,11,38),(24046,12,40),(24046,13,30),(24046,14,21),(24046,23,40),(24046,26,59),(24046,27,-8),(24046,28,27),(24046,29,7),(24046,30,59),(24046,31,114),(24046,68,98),(24046,365,15),(24046,384,600);
-- Bottes +4 (feet) 24091
INSERT INTO item_mods (itemId, modId, value) VALUES
(24091,1,95),(24091,2,84),(24091,8,22),(24091,9,39),(24091,10,20),(24091,11,54),(24091,13,25),(24091,14,40),(24091,26,62),(24091,29,7),(24091,30,62),(24091,31,114),(24091,68,132),(24091,384,400),(24091,411,20);

-- ============ LANUN (Corsair Relic) ============
-- Tricorne +4 (head) 23934
INSERT INTO item_mods (itemId, modId, value) VALUES
(23934,1,125),(23934,2,90),(23934,8,40),(23934,9,29),(23934,10,27),(23934,11,41),(23934,12,28),(23934,13,25),(23934,14,26),(23934,24,97),(23934,26,42),(23934,29,5),(23934,30,42),(23934,31,113),(23934,68,89),(23934,384,800),(23934,542,50);
-- Frac +4 (body) 23979
INSERT INTO item_mods (itemId, modId, value) VALUES
(23979,1,156),(23979,2,89),(23979,5,74),(23979,8,42),(23979,9,39),(23979,10,36),(23979,11,43),(23979,12,39),(23979,13,33),(23979,14,33),(23979,24,93),(23979,25,54),(23979,28,64),(23979,29,9),(23979,30,45),(23979,31,124),(23979,68,94),(23979,161,-600),(23979,164,-600),(23979,220,50),(23979,384,400);
-- Gants +4 (hands) 24024
INSERT INTO item_mods (itemId, modId, value) VALUES
(24024,1,114),(24024,2,75),(24024,8,31),(24024,9,45),(24024,10,44),(24024,11,22),(24024,12,25),(24024,13,40),(24024,14,27),(24024,24,86),(24024,26,49),(24024,29,5),(24024,30,43),(24024,31,97),(24024,68,69),(24024,365,13),(24024,384,500);
-- Trews +4 (legs) 24069
INSERT INTO item_mods (itemId, modId, value) VALUES
(24069,1,137),(24069,2,100),(24069,5,53),(24069,8,47),(24069,10,29),(24069,11,36),(24069,12,43),(24069,13,27),(24069,14,21),(24069,23,88),(24069,24,88),(24069,26,51),(24069,29,8),(24069,30,44),(24069,31,129),(24069,68,97),(24069,365,10),(24069,384,600);
-- Bottes +4 (feet) 24114
INSERT INTO item_mods (itemId, modId, value) VALUES
(24114,1,93),(24114,2,68),(24114,8,27),(24114,9,34),(24114,10,25),(24114,11,49),(24114,12,22),(24114,13,22),(24114,14,40),(24114,24,71),(24114,25,48),(24114,28,58),(24114,29,8),(24114,30,41),(24114,31,129),(24114,68,117),(24114,161,-600),(24114,164,-600),(24114,384,400),(24114,840,12);

-- +4 batch 5
-- Reforge +4 stat backfill: batch 5
-- Sets: Luhlaza (BLU AF), Mochizuki (NIN Relic), Orion (RNG Relic),
--       Pedagogy (SCH Relic), Piety (WHM Relic), Pillager's (THF Relic)
-- Method: modIds locked from each piece's +3 template (item_mods); values from
--   BG-wiki +4 per-piece pages. mod 29 (MDEF) = DB(+3) value + 1 (uniform delta;
--   BG-wiki MDEF runs low vs LSB baseline). Hakama/Bonnet/Armlets: a few stats
--   corrected to DB+3 baseline where BG-wiki +4 was stale (see notes at bottom).

DELETE FROM item_mods WHERE itemId IN (
  24023,24113,23978,23933,24068,
  23930,23975,24020,24065,24110,
  23905,23950,23995,24040,24085,
  23937,23982,24027,24072,24117,
  23920,23965,24010,24055,24100,
  23900,23945,23990,24035,24080
);

-- ===== LUHLAZA (BLU AF) =====
-- luhlaza_bazubands_+4 (24023)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24023,1,114),(24023,2,80),(24023,5,55),(24023,8,26),(24023,9,49),(24023,10,47),(24023,11,15),(24023,12,25),(24023,13,44),(24023,14,27),(24023,23,73),(24023,25,49),(24023,29,5),(24023,30,43),(24023,31,97),(24023,68,82),(24023,289,11),(24023,384,500);
-- luhlaza_charuqs_+4 (24113)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24113,1,98),(24113,2,43),(24113,5,66),(24113,8,27),(24113,9,34),(24113,10,27),(24113,11,47),(24113,12,25),(24113,13,22),(24113,14,40),(24113,23,96),(24113,25,41),(24113,29,8),(24113,30,41),(24113,31,129),(24113,68,117),(24113,122,13),(24113,384,400);
-- luhlaza_jubbah_+4 (23978)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23978,1,160),(23978,2,89),(23978,5,74),(23978,8,42),(23978,9,42),(23978,10,39),(23978,11,38),(23978,12,36),(23978,13,33),(23978,14,33),(23978,23,96),(23978,25,55),(23978,29,9),(23978,30,45),(23978,31,124),(23978,68,94),(23978,170,9),(23978,369,3),(23978,384,400);
-- luhlaza_keffiyeh_+4 (23933)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23933,1,126),(23933,2,101),(23933,5,88),(23933,8,35),(23933,9,29),(23933,10,35),(23933,11,29),(23933,12,33),(23933,13,30),(23933,14,26),(23933,23,72),(23933,25,42),(23933,29,5),(23933,30,42),(23933,31,113),(23933,68,89),(23933,122,18),(23933,384,800),(23933,1075,24);
-- luhlaza_shalwar_+4 (24068)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24068,1,138),(24068,2,97),(24068,5,50),(24068,8,46),(24068,10,31),(24068,11,32),(24068,12,43),(24068,13,27),(24068,14,21),(24068,25,50),(24068,28,60),(24068,29,8),(24068,30,50),(24068,31,129),(24068,68,83),(24068,384,600),(24068,841,12);

-- ===== MOCHIZUKI (NIN Relic) =====
-- mochizuki_hatsuburi_+4 (23930)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23930,1,125),(23930,2,66),(23930,8,36),(23930,9,31),(23930,10,38),(23930,11,33),(23930,12,35),(23930,13,32),(23930,14,32),(23930,23,72),(23930,25,49),(23930,28,64),(23930,29,7),(23930,30,42),(23930,31,103),(23930,68,98),(23930,110,21),(23930,384,800),(23930,522,21);
-- mochizuki_chainmail_+4 (23975)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23975,1,159),(23975,2,89),(23975,8,39),(23975,9,35),(23975,10,36),(23975,11,35),(23975,12,37),(23975,13,34),(23975,14,34),(23975,23,97),(23975,24,89),(23975,25,56),(23975,26,52),(23975,29,7),(23975,30,45),(23975,31,113),(23975,68,97),(23975,259,9),(23975,384,400),(23975,911,10);
-- mochizuki_tekko_+4 (24020)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24020,1,114),(24020,2,55),(24020,8,35),(24020,9,44),(24020,10,42),(24020,11,16),(24020,12,23),(24020,13,38),(24020,14,26),(24020,23,89),(24020,25,43),(24020,29,4),(24020,30,43),(24020,31,86),(24020,68,67),(24020,289,9),(24020,308,38),(24020,384,500);
-- mochizuki_hakama_+4 (24065)  [see NOTE: BG-wiki page stale; DEX/crit/TA carried from +3, AGI/CHR from DB baseline]
INSERT INTO item_mods (itemId, modId, value) VALUES
(24065,1,139),(24065,2,92),(24065,8,47),(24065,9,10),(24065,10,29),(24065,11,37),(24065,12,45),(24065,13,27),(24065,14,21),(24065,23,74),(24065,25,44),(24065,29,10),(24065,30,44),(24065,31,124),(24065,68,88),(24065,165,6),(24065,259,10),(24065,302,6),(24065,384,600),(24065,841,12);
-- mochizuki_kyahan_+4 (24110)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24110,1,98),(24110,2,43),(24110,8,33),(24110,9,29),(24110,10,30),(24110,11,48),(24110,13,22),(24110,14,39),(24110,23,86),(24110,25,48),(24110,27,8),(24110,29,6),(24110,30,41),(24110,31,124),(24110,68,114),(24110,118,24),(24110,384,400);

-- ===== ORION (RNG Relic) =====
-- orion_beret_+4 (23905)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23905,1,124),(23905,2,74),(23905,8,33),(23905,9,39),(23905,10,27),(23905,11,44),(23905,12,30),(23905,13,33),(23905,14,31),(23905,24,39),(23905,26,57),(23905,27,-7),(23905,29,4),(23905,31,98),(23905,68,104),(23905,359,18),(23905,384,800),(23905,841,12);
-- orion_jerkin_+4 (23950)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23950,1,154),(23950,2,108),(23950,5,64),(23950,8,34),(23950,9,44),(23950,10,31),(23950,11,45),(23950,12,33),(23950,13,36),(23950,14,33),(23950,24,46),(23950,26,70),(23950,27,-7),(23950,28,22),(23950,29,8),(23950,30,70),(23950,31,109),(23950,68,109),(23950,73,8),(23950,98,100),(23950,384,400);
-- orion_bracers_+4 (23995)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23995,1,112),(23995,2,57),(23995,8,21),(23995,9,50),(23995,10,39),(23995,11,32),(23995,12,22),(23995,13,43),(23995,14,27),(23995,26,58),(23995,27,-6),(23995,29,4),(23995,31,82),(23995,68,84),(23995,138,3),(23995,384,500),(23995,420,32),(23995,425,16);
-- orion_braccae_+4 (24040)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24040,1,136),(24040,2,90),(24040,5,43),(24040,8,39),(24040,10,24),(24040,11,42),(24040,12,40),(24040,13,34),(24040,14,21),(24040,26,66),(24040,27,-7),(24040,29,7),(24040,31,114),(24040,68,98),(24040,314,16),(24040,365,15),(24040,384,600);
-- orion_socks_+4 (24085)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24085,1,94),(24085,2,39),(24085,8,22),(24085,9,39),(24085,10,20),(24085,11,54),(24085,13,25),(24085,14,40),(24085,24,41),(24085,26,64),(24085,27,-6),(24085,29,7),(24085,31,114),(24085,68,132),(24085,76,18),(24085,312,11),(24085,384,400);

-- ===== PEDAGOGY (SCH Relic) =====
-- pedagogy_mortarboard_+4 (23937)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23937,1,117),(23937,2,96),(23937,5,92),(23937,8,27),(23937,9,24),(23937,10,29),(23937,11,24),(23937,12,44),(23937,13,39),(23937,14,29),(23937,25,42),(23937,28,52),(23937,29,8),(23937,30,42),(23937,31,135),(23937,68,81),(23937,115,20),(23937,384,600),(23937,489,-13);
-- pedagogy_gown_+4 (23982)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23982,1,149),(23982,2,109),(23982,5,114),(23982,8,34),(23982,9,31),(23982,10,36),(23982,11,31),(23982,12,44),(23982,13,39),(23982,14,39),(23982,25,45),(23982,28,55),(23982,29,11),(23982,30,45),(23982,31,140),(23982,68,86),(23982,112,20),(23982,113,20),(23982,384,300),(23982,401,5),(23982,890,12);
-- pedagogy_bracers_+4 (24027)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24027,1,105),(24027,2,52),(24027,5,85),(24027,8,19),(24027,9,38),(24027,10,40),(24027,11,15),(24027,12,37),(24027,13,46),(24027,14,29),(24027,25,43),(24027,27,-7),(24027,28,53),(24027,29,6),(24027,30,43),(24027,31,97),(24027,68,67),(24027,112,20),(24027,114,20),(24027,260,3),(24027,384,300);
-- pedagogy_pants_+4 (24072)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24072,1,131),(24072,2,93),(24072,5,79),(24072,8,38),(24072,10,27),(24072,11,27),(24072,12,52),(24072,13,34),(24072,14,29),(24072,25,44),(24072,27,-7),(24072,28,54),(24072,29,9),(24072,30,44),(24072,31,167),(24072,68,72),(24072,115,20),(24072,116,20),(24072,315,15),(24072,384,500);
-- pedagogy_loafers_+4 (24117)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24117,1,89),(24117,2,43),(24117,5,69),(24117,8,23),(24117,9,21),(24117,10,25),(24117,11,43),(24117,12,32),(24117,13,29),(24117,14,44),(24117,25,41),(24117,28,51),(24117,29,8),(24117,30,41),(24117,31,167),(24117,68,100),(24117,112,21),(24117,170,8),(24117,384,300);

-- ===== PIETY (WHM Relic) =====
-- piety_cap_+4 (23920)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23920,1,119),(23920,2,66),(23920,5,95),(23920,8,29),(23920,9,26),(23920,10,36),(23920,11,26),(23920,12,36),(23920,13,36),(23920,14,31),(23920,23,72),(23920,25,42),(23920,27,-10),(23920,29,8),(23920,30,42),(23920,31,135),(23920,68,81),(23920,384,600),(23920,519,15);
-- piety_bliaut_+4 (23965)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23965,1,149),(23965,2,84),(23965,5,115),(23965,8,34),(23965,9,31),(23965,10,36),(23965,11,31),(23965,12,44),(23965,13,39),(23965,14,39),(23965,23,75),(23965,25,45),(23965,27,-8),(23965,29,9),(23965,30,45),(23965,31,140),(23965,68,86),(23965,369,3),(23965,384,300),(23965,838,52);
-- piety_mitts_+4 (24010)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24010,1,110),(24010,2,82),(24010,5,74),(24010,8,19),(24010,9,38),(24010,10,40),(24010,11,15),(24010,12,34),(24010,13,43),(24010,14,29),(24010,23,73),(24010,25,43),(24010,27,-9),(24010,29,6),(24010,30,43),(24010,31,97),(24010,68,67),(24010,111,27),(24010,114,27),(24010,384,300);
-- piety_pantaloons_+4 (24055)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24055,1,132),(24055,2,103),(24055,5,89),(24055,8,38),(24055,10,27),(24055,11,27),(24055,12,49),(24055,13,34),(24055,14,29),(24055,23,74),(24055,25,44),(24055,27,-8),(24055,29,9),(24055,30,44),(24055,31,167),(24055,68,72),(24055,112,27),(24055,113,27),(24055,384,500),(24055,567,36);
-- piety_duckbills_+4 (24100)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24100,1,91),(24100,2,68),(24100,5,69),(24100,8,23),(24100,9,21),(24100,10,25),(24100,11,43),(24100,12,32),(24100,13,29),(24100,14,44),(24100,23,71),(24100,25,41),(24100,27,-7),(24100,29,8),(24100,30,41),(24100,31,167),(24100,68,100),(24100,113,22),(24100,114,22),(24100,374,14),(24100,384,300);

-- ===== PILLAGER'S (THF Relic) =====
-- pillagers_bonnet_+4 (23900)  [NOTE: mod29 from DB+3 baseline +1 (=6); BG-wiki listed 4 (stale)]
INSERT INTO item_mods (itemId, modId, value) VALUES
(23900,1,126),(23900,2,74),(23900,5,43),(23900,8,30),(23900,9,42),(23900,10,30),(23900,11,42),(23900,12,30),(23900,13,33),(23900,14,31),(23900,25,63),(23900,26,43),(23900,29,6),(23900,31,108),(23900,68,124),(23900,384,800),(23900,421,5),(23900,841,9);
-- pillagers_vest_+4 (23945)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23945,1,156),(23945,2,108),(23945,5,64),(23945,8,34),(23945,9,49),(23945,10,34),(23945,11,43),(23945,12,33),(23945,13,36),(23945,14,33),(23945,25,70),(23945,29,8),(23945,31,119),(23945,68,119),(23945,302,7),(23945,384,400),(23945,421,6),(23945,885,100);
-- pillagers_armlets_+4 (23990)  [NOTE: VIT(mod10)=43 from DB+3 baseline; BG-wiki listed 42 (stale)]
INSERT INTO item_mods (itemId, modId, value) VALUES
(23990,1,114),(23990,2,57),(23990,8,21),(23990,9,50),(23990,10,43),(23990,11,30),(23990,12,22),(23990,13,43),(23990,14,27),(23990,25,58),(23990,29,4),(23990,31,92),(23990,68,94),(23990,259,5),(23990,384,500),(23990,421,4),(23990,520,20);
-- pillagers_culottes_+4 (24035)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24035,1,138),(24035,2,90),(24035,8,39),(24035,9,20),(24035,10,26),(24035,11,35),(24035,12,40),(24035,13,30),(24035,14,21),(24035,23,35),(24035,25,64),(24035,29,7),(24035,31,124),(24035,68,108),(24035,302,5),(24035,384,600),(24035,421,5);
-- pillagers_poulaines_+4 (24080)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24080,1,96),(24080,2,39),(24080,8,22),(24080,9,39),(24080,10,22),(24080,11,52),(24080,13,25),(24080,14,40),(24080,25,62),(24080,26,43),(24080,29,7),(24080,31,124),(24080,68,142),(24080,76,18),(24080,93,18),(24080,249,20),(24080,298,15),(24080,384,400);

-- ============================================================
-- OMITTED / LOW-CONFIDENCE NOTES
-- Omitted (no matching modId in the +3 template; consistent with the +3 tier):
--   * Magic Accuracy on RNG/THF pieces whose +3 template carries only RACC (mod26),
--     not MACC (mod30): orion_beret (+57), orion_bracers (+58), orion_braccae (+66),
--     orion_socks (+64), pillagers_bonnet (+63), pillagers_vest (+70),
--     pillagers_armlets (+58), pillagers_culottes (+64), pillagers_poulaines (+62).
--   * pedagogy_mortarboard: "Magic Burst Accuracy +15", "Magic Burst damage II +4".
--   * mochizuki_chainmail: "Utsusemi cast time -14%".
--   * piety_mitts: "Banish potency vs undead +30".
--   * All set-bonus lines ("Set: Accuracy+ Ranged Accuracy+ Magic Accuracy+") and
--     merit-augment lines are latent effects, not item_mods; omitted as in +3.
-- Low-confidence (BG-wiki +4 page stale vs LSB DB +3 baseline):
--   * mochizuki_hakama_+4: BG-wiki omits DEX/Crit-rate/Triple-Atk and lists AGI/CHR
--     one lower than DB. DEX(9)=10, Crit(165)=6, TA(302)=6 carried from +3 unchanged;
--     AGI(11)=37, CHR(14)=21 kept at DB baseline; MDEF(29)=10 via +1 delta.
--   * pillagers_bonnet_+4: MDEF set to 6 (DB+3 5 +1); wiki showed 4.
--   * pillagers_armlets_+4: VIT set to 43 (DB+3 baseline); wiki showed 42.
-- General: mod 29 (MDEF) computed as DB(+3) + 1 for every piece (BG-wiki MDEF runs
--   low vs LSB baseline; +3->+4 delta is uniformly +1). Haste (mod384) = %*100.

-- +4 batch 6
-- Reforge +4 stats batch 6: pitre, plunderers, pteroslaver, pummelers, reverence, runeist
-- Method: +3 item_mods = template (locks modId set + scale); values from BG-wiki +4 lines (1:1),
--   Haste(384) %x100, damage-taken(160/161/163/164) %x100 negative -- all unchanged +3->+4.
-- Uniform rule: modId 30 (Magic Accuracy, confirmed 1:1) set/added on every +4 piece to its
--   wiki +4 value. Reverence Surcoat also gains modId 25 (Accuracy), new at +4.

DELETE FROM item_mods WHERE itemId IN (
  23935,23980,24025,24070,24115,   -- pitre
  23923,23968,24013,24058,24103,   -- plunderers
  23931,23976,24021,24066,24111,   -- pteroslaver
  23895,23940,23985,24030,24075,   -- pummelers
  23901,23946,23991,24036,24081,   -- reverence
  23917,23962,24007,24052,24097    -- runeist
);

-- ===== PITRE (PUP Artifact) =====
-- pitre_taj_+4 (23935)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23935,1,128),(23935,2,66),(23935,8,36),(23935,9,31),(23935,10,32),(23935,11,33),(23935,12,29),(23935,13,26),(23935,14,26),(23935,23,72),(23935,25,42),(23935,29,7),(23935,30,42),(23935,31,103),(23935,68,83),(23935,370,5),(23935,384,800);
-- pitre_tobe_+4 (23980)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23980,1,158),(23980,2,110),(23980,8,39),(23980,9,35),(23980,10,36),(23980,11,35),(23980,12,37),(23980,13,34),(23980,14,34),(23980,23,96),(23980,25,55),(23980,29,7),(23980,30,45),(23980,31,113),(23980,68,97),(23980,384,400);
-- pitre_dastanas_+4 (24025)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24025,1,115),(24025,2,55),(24025,8,25),(24025,9,47),(24025,10,43),(24025,11,16),(24025,12,23),(24025,13,38),(24025,14,29),(24025,23,73),(24025,25,43),(24025,29,4),(24025,30,43),(24025,31,86),(24025,68,80),(24025,384,500),(24025,841,12);
-- pitre_churidars_+4 (24070)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24070,1,138),(24070,2,77),(24070,8,50),(24070,10,32),(24070,11,31),(24070,12,45),(24070,13,27),(24070,14,20),(24070,23,74),(24070,25,51),(24070,29,6),(24070,30,44),(24070,31,124),(24070,68,78),(24070,384,600);
-- pitre_babouches_+4 (24115)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24115,1,96),(24115,2,93),(24115,8,29),(24115,9,25),(24115,10,26),(24115,11,44),(24115,12,22),(24115,13,22),(24115,14,39),(24115,23,71),(24115,25,41),(24115,29,6),(24115,30,41),(24115,31,124),(24115,68,114),(24115,384,400);

-- ===== PLUNDERERS (THF Relic) =====
-- plunderers_bonnet_+4 (23923)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23923,1,127),(23923,2,66),(23923,5,53),(23923,8,36),(23923,9,41),(23923,10,36),(23923,11,35),(23923,12,34),(23923,13,31),(23923,14,32),(23923,23,72),(23923,25,49),(23923,29,5),(23923,30,42),(23923,31,113),(23923,68,89),(23923,302,4),(23923,384,800),(23923,835,5);
-- plunderers_vest_+4 (23968)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23968,1,157),(23968,2,89),(23968,5,74),(23968,8,46),(23968,9,46),(23968,10,39),(23968,11,45),(23968,12,36),(23968,13,33),(23968,14,33),(23968,23,75),(23968,25,45),(23968,27,30),(23968,29,9),(23968,30,45),(23968,31,124),(23968,68,94),(23968,165,6),(23968,384,400),(23968,421,5);
-- plunderers_armlets_+4 (24013)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24013,1,115),(24013,2,55),(24013,8,24),(24013,9,43),(24013,10,45),(24013,11,13),(24013,12,23),(24013,13,38),(24013,14,34),(24013,23,73),(24013,25,50),(24013,29,5),(24013,30,43),(24013,31,97),(24013,68,84),(24013,303,4),(24013,384,500);
-- plunderers_culottes_+4 (24058)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24058,1,135),(24058,2,77),(24058,8,47),(24058,9,21),(24058,10,34),(24058,11,33),(24058,12,46),(24058,13,30),(24058,14,24),(24058,23,74),(24058,25,51),(24058,29,8),(24058,30,44),(24058,31,129),(24058,68,83),(24058,384,600),(24058,841,9),(24058,897,4);
-- plunderers_poulaines_+4 (24103)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24103,1,97),(24103,2,43),(24103,8,27),(24103,9,37),(24103,10,27),(24103,11,47),(24103,13,22),(24103,14,43),(24103,23,71),(24103,25,41),(24103,29,8),(24103,30,41),(24103,31,129),(24103,68,117),(24103,302,5),(24103,384,400),(24103,1039,11);

-- ===== PTEROSLAVER (DRG Relic) =====
-- pteroslaver_armet_+4 (23931)  [30 added: +3 template lacked it]
INSERT INTO item_mods (itemId, modId, value) VALUES
(23931,1,136),(23931,2,90),(23931,5,53),(23931,8,42),(23931,9,25),(23931,10,40),(23931,11,25),(23931,12,27),(23931,13,24),(23931,14,24),(23931,23,87),(23931,25,49),(23931,29,5),(23931,30,42),(23931,31,103),(23931,68,78),(23931,384,700),(23931,402,72);
-- pteroslaver_mail_+4 (23976)  [30 = wiki +4 45; +3 template value 36 differed from wiki]
INSERT INTO item_mods (itemId, modId, value) VALUES
(23976,1,166),(23976,2,112),(23976,5,74),(23976,8,49),(23976,9,39),(23976,10,41),(23976,11,31),(23976,12,34),(23976,13,31),(23976,14,31),(23976,23,90),(23976,25,45),(23976,29,7),(23976,30,45),(23976,31,113),(23976,68,101),(23976,384,300),(23976,974,1);
-- pteroslaver_finger_gauntlets_+4 (24021)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24021,1,121),(24021,2,87),(24021,5,60),(24021,8,21),(24021,9,43),(24021,10,45),(24021,11,20),(24021,12,23),(24021,13,36),(24021,14,30),(24021,23,73),(24021,25,51),(24021,29,4),(24021,30,43),(24021,31,86),(24021,68,67),(24021,384,400),(24021,841,12);
-- pteroslaver_brais_+4 (24066)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24066,1,145),(24066,2,95),(24066,8,48),(24066,9,22),(24066,10,46),(24066,11,25),(24066,12,39),(24066,13,26),(24066,14,22),(24066,23,74),(24066,25,44),(24066,29,6),(24066,30,44),(24066,31,135),(24066,68,67),(24066,73,10),(24066,363,29),(24066,384,500);
-- pteroslaver_greaves_+4 (24111)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24111,1,103),(24111,2,65),(24111,5,50),(24111,8,33),(24111,9,27),(24111,10,30),(24111,11,42),(24111,13,20),(24111,14,36),(24111,23,83),(24111,25,47),(24111,29,5),(24111,30,41),(24111,31,135),(24111,68,97),(24111,384,300);

-- ===== PUMMELERS (MNK Relic) =====  [30 added on all: genuine +4 Magic Accuracy gain]
-- pummelers_mask_+4 (23895)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23895,1,138),(23895,2,77),(23895,8,31),(23895,9,39),(23895,10,34),(23895,11,36),(23895,12,31),(23895,13,34),(23895,14,31),(23895,25,57),(23895,27,12),(23895,29,4),(23895,30,57),(23895,31,98),(23895,68,96),(23895,161,-500),(23895,164,-500),(23895,384,800),(23895,955,18);
-- pummelers_lorica_+4 (23940)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23940,1,168),(23940,2,111),(23940,8,40),(23940,9,39),(23940,10,40),(23940,11,38),(23940,12,33),(23940,13,36),(23940,14,33),(23940,23,37),(23940,25,60),(23940,29,7),(23940,30,60),(23940,31,109),(23940,68,104),(23940,384,400),(23940,841,12),(23940,954,18);
-- pummelers_mufflers_+4 (23985)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23985,1,126),(23985,2,75),(23985,8,28),(23985,9,47),(23985,10,42),(23985,11,21),(23985,12,24),(23985,13,42),(23985,14,29),(23985,25,58),(23985,27,15),(23985,29,4),(23985,30,58),(23985,31,88),(23985,68,82),(23985,161,-700),(23985,164,-700),(23985,384,500),(23985,414,19);
-- pummelers_cuisses_+4 (24030)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24030,1,150),(24030,2,95),(24030,8,40),(24030,10,27),(24030,11,32),(24030,12,39),(24030,13,29),(24030,14,26),(24030,25,66),(24030,29,6),(24030,30,66),(24030,31,125),(24030,68,92),(24030,161,-500),(24030,164,-500),(24030,288,11),(24030,384,600);
-- pummelers_calligae_+4 (24075)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24075,1,108),(24075,2,65),(24075,8,24),(24075,9,31),(24075,10,31),(24075,11,48),(24075,13,24),(24075,14,38),(24075,23,45),(24075,25,56),(24075,29,5),(24075,30,56),(24075,31,125),(24075,68,112),(24075,73,4),(24075,288,9),(24075,384,400);

-- ===== REVERENCE (PLD Artifact) =====  [30 added except surcoat; surcoat gains 25]
-- reverence_coronet_+4 (23901)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23901,1,144),(23901,2,81),(23901,5,54),(23901,8,35),(23901,9,34),(23901,10,38),(23901,11,34),(23901,12,27),(23901,13,33),(23901,14,27),(23901,25,57),(23901,27,7),(23901,29,4),(23901,30,57),(23901,31,77),(23901,68,93),(23901,161,-700),(23901,164,-700),(23901,384,700),(23901,966,1),(23901,967,10);
-- reverence_surcoat_+4 (23946)  [25 added: Accuracy new at +4; 30 = MACC updated 50->60]
INSERT INTO item_mods (itemId, modId, value) VALUES
(23946,1,174),(23946,2,264),(23946,5,72),(23946,8,39),(23946,9,34),(23946,10,39),(23946,11,34),(23946,12,29),(23946,13,32),(23946,14,29),(23946,25,60),(23946,27,10),(23946,29,6),(23946,30,60),(23946,31,93),(23946,68,101),(23946,111,18),(23946,160,-1100),(23946,170,10),(23946,384,300);
-- reverence_gauntlets_+4 (23991)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23991,1,132),(23991,2,123),(23991,8,20),(23991,9,44),(23991,10,43),(23991,12,18),(23991,13,38),(23991,14,29),(23991,25,58),(23991,27,6),(23991,29,3),(23991,30,58),(23991,31,71),(23991,68,82),(23991,163,-700),(23991,384,400),(23991,485,20);
-- reverence_breeches_+4 (24036)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24036,1,156),(24036,2,173),(24036,5,95),(24036,8,45),(24036,10,31),(24036,11,31),(24036,12,35),(24036,13,25),(24036,14,20),(24036,25,59),(24036,27,7),(24036,29,5),(24036,30,59),(24036,31,109),(24036,68,82),(24036,113,20),(24036,161,-600),(24036,164,-600),(24036,384,500);
-- reverence_leggings_+4 (24081)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24081,1,114),(24081,2,92),(24081,5,65),(24081,8,26),(24081,9,27),(24081,10,27),(24081,11,44),(24081,13,23),(24081,14,36),(24081,25,61),(24081,29,4),(24081,30,61),(24081,31,109),(24081,68,109),(24081,109,22),(24081,384,300),(24081,516,10),(24081,857,90),(24081,1141,2);

-- ===== RUNEIST (RUN Artifact) =====  [30 added on all: genuine +4 Magic Accuracy gain]
-- runeist_bandeau_+4 (23917)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23917,1,130),(23917,2,119),(23917,5,99),(23917,8,31),(23917,9,38),(23917,10,31),(23917,11,40),(23917,12,31),(23917,13,36),(23917,14,32),(23917,25,57),(23917,29,4),(23917,30,57),(23917,31,108),(23917,68,104),(23917,170,14),(23917,384,800);
-- runeist_coat_+4 (23962)
INSERT INTO item_mods (itemId, modId, value) VALUES
(23962,1,160),(23962,2,228),(23962,5,86),(23962,8,34),(23962,9,42),(23962,10,34),(23962,11,43),(23962,12,33),(23962,13,38),(23962,14,33),(23962,15,39),(23962,16,39),(23962,17,39),(23962,18,39),(23962,19,39),(23962,20,39),(23962,21,39),(23962,22,39),(23962,25,60),(23962,29,8),(23962,30,60),(23962,31,119),(23962,68,109),(23962,369,3),(23962,384,400),(23962,1010,19);
-- runeist_mitons_+4 (24007)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24007,1,118),(24007,2,95),(24007,5,57),(24007,8,21),(24007,9,48),(24007,10,42),(24007,11,20),(24007,12,22),(24007,13,45),(24007,14,27),(24007,25,58),(24007,29,4),(24007,30,58),(24007,31,92),(24007,68,84),(24007,113,20),(24007,161,-300),(24007,164,-300),(24007,384,500);
-- runeist_trousers_+4 (24052)
INSERT INTO item_mods (itemId, modId, value) VALUES
(24052,1,142),(24052,2,90),(24052,5,72),(24052,8,39),(24052,10,26),(24052,11,35),(24052,12,40),(24052,13,33),(24052,14,21),(24052,25,59),(24052,29,7),(24052,30,59),(24052,31,124),(24052,68,98),(24052,111,20),(24052,161,-500),(24052,164,-500),(24052,384,600);
-- runeist_boots_+4 (24097)  [template = runeist_bottes_+3]
INSERT INTO item_mods (itemId, modId, value) VALUES
(24097,1,100),(24097,2,84),(24097,8,22),(24097,9,37),(24097,10,22),(24097,11,52),(24097,13,27),(24097,14,40),(24097,25,56),(24097,29,7),(24097,30,56),(24097,31,124),(24097,68,152),(24097,384,400),(24097,1011,4);

-- +4 batch 7
-- Reforge +4 armor stats, batch 7
-- Sets: sakonji, spaekonas, theophany, totemic, vishap, vitiation, wakido
-- Method: modIds+scale from each piece's +3 template; values from BG-wiki +4 line.
-- All 7 sets confirmed to have a +4 tier.
-- NOTE: spaekonas_gloves has NO +4 tier (only +3) -> not included.

DELETE FROM item_mods WHERE itemId IN (
  23974,24064,23929,24019,24109,
  23943,23898,24078,24033,
  23942,23897,24077,23987,24032,
  24083,23993,23903,23948,24038,
  23908,24043,23998,24088,23953,
  24102,23922,24012,23967,24057,
  23951,24041,23906,23996,24086
);

-- ================= SAKONJI (SAM AF) =================
-- sakonji_kabuto_+4 (23929) <- 23409
INSERT INTO item_mods (itemId, modId, value) VALUES
(23929,1,140),(23929,2,88),(23929,5,53),(23929,8,39),(23929,9,30),(23929,10,37),(23929,11,30),(23929,12,32),(23929,13,29),(23929,14,29),(23929,23,89),(23929,25,50),(23929,29,5),(23929,30,42),(23929,31,103),(23929,68,78),(23929,73,8),(23929,365,5),(23929,384,700);
-- sakonji_domaru_+4 (23974) <- 23476
INSERT INTO item_mods (itemId, modId, value) VALUES
(23974,1,170),(23974,2,111),(23974,5,74),(23974,8,47),(23974,9,37),(23974,10,41),(23974,11,31),(23974,12,34),(23974,13,31),(23974,14,31),(23974,23,90),(23974,25,52),(23974,29,7),(23974,30,45),(23974,31,113),(23974,68,86),(23974,73,10),(23974,841,12),(23974,384,300);
-- sakonji_kote_+4 (24019) <- 23543
INSERT INTO item_mods (itemId, modId, value) VALUES
(24019,1,130),(24019,2,57),(24019,8,21),(24019,9,40),(24019,10,45),(24019,11,17),(24019,12,23),(24019,13,36),(24019,14,30),(24019,23,91),(24019,25,52),(24019,29,4),(24019,30,43),(24019,31,86),(24019,68,67),(24019,94,12),(24019,161,-600),(24019,164,-600),(24019,384,400);
-- sakonji_haidate_+4 (24064) <- 23610
INSERT INTO item_mods (itemId, modId, value) VALUES
(24064,1,150),(24064,2,80),(24064,8,48),(24064,10,34),(24064,11,25),(24064,12,39),(24064,13,26),(24064,14,22),(24064,23,92),(24064,25,44),(24064,29,6),(24064,30,44),(24064,31,135),(24064,68,85),(24064,163,-700),(24064,384,500),(24064,508,35),(24064,1047,25);
-- sakonji_sune-ate_+4 (24109) <- 23677
INSERT INTO item_mods (itemId, modId, value) VALUES
(24109,1,111),(24109,2,75),(24109,8,36),(24109,9,27),(24109,10,30),(24109,11,42),(24109,13,20),(24109,14,36),(24109,23,94),(24109,25,41),(24109,29,5),(24109,30,41),(24109,31,135),(24109,68,97),(24109,73,10),(24109,384,300);

-- ================= SPAEKONAS (BLM Relic) =================
-- NOTE: added modId 25 (ACC) -- new player Accuracy on +4 tier (absent from +3, resolvable=ACC).
-- spaekonas_petasos_+4 (23898) <- 23378
INSERT INTO item_mods (itemId, modId, value) VALUES
(23898,1,118),(23898,2,74),(23898,5,68),(23898,8,29),(23898,9,32),(23898,10,29),(23898,11,34),(23898,12,37),(23898,13,39),(23898,14,34),(23898,25,57),(23898,27,-6),(23898,28,25),(23898,29,7),(23898,30,57),(23898,31,120),(23898,68,96),(23898,296,6),(23898,311,44),(23898,384,600);
-- spaekonas_coat_+4 (23943) <- 23445
INSERT INTO item_mods (itemId, modId, value) VALUES
(23943,1,148),(23943,2,101),(23943,5,108),(23943,8,31),(23943,9,34),(23943,10,31),(23943,11,36),(23943,12,39),(23943,13,44),(23943,14,39),(23943,25,65),(23943,27,-9),(23943,29,8),(23943,30,65),(23943,31,125),(23943,68,101),(23943,114,22),(23943,311,50),(23943,384,300);
-- spaekonas_tonban_+4 (24033) <- 23579
INSERT INTO item_mods (itemId, modId, value) VALUES
(24033,1,130),(24033,2,84),(24033,5,168),(24033,8,35),(24033,10,22),(24033,11,32),(24033,12,44),(24033,13,39),(24033,14,29),(24033,25,59),(24033,27,-6),(24033,28,32),(24033,29,8),(24033,30,59),(24033,31,152),(24033,68,87),(24033,116,22),(24033,311,48),(24033,315,20),(24033,384,500);
-- spaekonas_sabots_+4 (24078) <- 23646
INSERT INTO item_mods (itemId, modId, value) VALUES
(24078,1,88),(24078,2,51),(24078,5,53),(24078,8,20),(24078,9,24),(24078,10,20),(24078,11,48),(24078,12,32),(24078,13,34),(24078,14,44),(24078,25,64),(24078,28,28),(24078,29,7),(24078,30,64),(24078,31,152),(24078,68,115),(24078,311,42),(24078,384,300),(24078,487,10);

-- ================= THEOPHANY (WHM AF) =================
-- NOTE: added modId 25 (ACC) -- new player Accuracy on +4 tier.
-- theophany_cap_+4 (23897) <- 23377
INSERT INTO item_mods (itemId, modId, value) VALUES
(23897,1,120),(23897,2,74),(23897,5,68),(23897,8,29),(23897,9,32),(23897,10,29),(23897,11,34),(23897,12,34),(23897,13,42),(23897,14,34),(23897,25,57),(23897,27,-6),(23897,29,8),(23897,30,57),(23897,31,120),(23897,68,96),(23897,374,12),(23897,384,600),(23897,519,7);
-- theophany_bliaut_+4 (23942) <- 23444
INSERT INTO item_mods (itemId, modId, value) VALUES
(23942,1,150),(23942,2,101),(23942,5,108),(23942,8,31),(23942,9,34),(23942,10,31),(23942,11,36),(23942,12,39),(23942,13,44),(23942,14,39),(23942,25,60),(23942,27,-6),(23942,29,9),(23942,30,60),(23942,31,125),(23942,68,101),(23942,114,22),(23942,260,6),(23942,369,3),(23942,384,300);
-- theophany_mitts_+4 (23987) <- 23511
INSERT INTO item_mods (itemId, modId, value) VALUES
(23987,1,108),(23987,2,53),(23987,5,93),(23987,8,21),(23987,9,41),(23987,10,35),(23987,11,20),(23987,12,29),(23987,13,53),(23987,14,29),(23987,25,58),(23987,27,-7),(23987,29,6),(23987,30,58),(23987,31,82),(23987,68,82),(23987,112,22),(23987,260,4),(23987,384,300);
-- theophany_pantaloons_+4 (24032) <- 23578
INSERT INTO item_mods (itemId, modId, value) VALUES
(24032,1,132),(24032,2,84),(24032,5,63),(24032,8,35),(24032,10,22),(24032,11,32),(24032,12,44),(24032,13,39),(24032,14,29),(24032,25,59),(24032,27,-6),(24032,29,9),(24032,30,59),(24032,31,152),(24032,68,87),(24032,111,22),(24032,310,21),(24032,339,24),(24032,384,500);
-- theophany_duckbills_+4 (24077) <- 23645
INSERT INTO item_mods (itemId, modId, value) VALUES
(24077,1,90),(24077,2,84),(24077,5,86),(24077,8,20),(24077,9,24),(24077,10,20),(24077,11,53),(24077,12,32),(24077,13,39),(24077,14,44),(24077,25,56),(24077,29,8),(24077,30,56),(24077,31,152),(24077,68,115),(24077,113,22),(24077,114,22),(24077,168,29),(24077,384,300),(24077,890,10);

-- ================= TOTEMIC (BST AF) =================
-- NOTE: added modId 30 (MACC) -- new player Magic Accuracy on +4 tier. Pet stats omitted (mirrors +3 template).
-- totemic_helm_+4 (23903) <- 23383
INSERT INTO item_mods (itemId, modId, value) VALUES
(23903,1,127),(23903,2,74),(23903,5,33),(23903,8,33),(23903,9,39),(23903,10,30),(23903,11,39),(23903,12,30),(23903,13,33),(23903,14,34),(23903,25,57),(23903,29,4),(23903,30,57),(23903,31,98),(23903,68,104),(23903,304,31),(23903,360,35),(23903,384,800);
-- totemic_jackcoat_+4 (23948) <- 23450
INSERT INTO item_mods (itemId, modId, value) VALUES
(23948,1,157),(23948,2,108),(23948,5,54),(23948,8,39),(23948,9,44),(23948,10,34),(23948,11,43),(23948,12,33),(23948,13,36),(23948,14,38),(23948,25,60),(23948,29,8),(23948,30,60),(23948,31,109),(23948,68,109),(23948,364,26),(23948,384,400);
-- totemic_gloves_+4 (23993) <- 23517
INSERT INTO item_mods (itemId, modId, value) VALUES
(23993,1,115),(23993,2,57),(23993,8,21),(23993,9,50),(23993,10,42),(23993,11,20),(23993,12,22),(23993,13,43),(23993,14,30),(23993,25,58),(23993,29,4),(23993,30,58),(23993,31,82),(23993,68,84),(23993,110,20),(23993,384,500),(23993,841,12);
-- totemic_trousers_+4 (24038) <- 23584
INSERT INTO item_mods (itemId, modId, value) VALUES
(24038,1,139),(24038,2,90),(24038,8,39),(24038,10,26),(24038,11,35),(24038,12,40),(24038,13,30),(24038,14,21),(24038,25,59),(24038,29,7),(24038,30,59),(24038,31,114),(24038,68,98),(24038,224,2),(24038,225,2),(24038,226,2),(24038,227,2),(24038,228,2),(24038,229,2),(24038,230,2),(24038,384,600),(24038,1152,19);
-- totemic_gaiters_+4 (24083) <- 23651
INSERT INTO item_mods (itemId, modId, value) VALUES
(24083,1,97),(24083,2,39),(24083,8,22),(24083,9,39),(24083,10,22),(24083,11,52),(24083,13,25),(24083,14,40),(24083,25,56),(24083,29,7),(24083,30,56),(24083,31,114),(24083,68,132),(24083,364,36),(24083,384,400);

-- ================= VISHAP (DRG Relic) =================
-- NOTE: added modId 30 (MACC) -- new player Magic Accuracy on +4 tier. Wyvern/jump-accuracy effects omitted (mirror +3 template).
-- vishap_armet_+4 (23908) <- 23388
INSERT INTO item_mods (itemId, modId, value) VALUES
(23908,1,134),(23908,2,77),(23908,5,43),(23908,8,37),(23908,9,35),(23908,10,35),(23908,11,35),(23908,12,29),(23908,13,35),(23908,14,29),(23908,23,47),(23908,25,57),(23908,29,4),(23908,30,57),(23908,31,88),(23908,68,93),(23908,384,700);
-- vishap_mail_+4 (23953) <- 23455
INSERT INTO item_mods (itemId, modId, value) VALUES
(23953,1,164),(23953,2,111),(23953,5,64),(23953,8,41),(23953,9,36),(23953,10,41),(23953,11,36),(23953,12,31),(23953,13,34),(23953,14,31),(23953,23,40),(23953,25,67),(23953,29,6),(23953,30,67),(23953,31,98),(23953,68,101),(23953,73,8),(23953,361,39),(23953,384,300);
-- vishap_finger_gauntlets_+4 (23998) <- 23522
INSERT INTO item_mods (itemId, modId, value) VALUES
(23998,1,122),(23998,2,60),(23998,8,16),(23998,9,45),(23998,10,40),(23998,11,22),(23998,12,20),(23998,13,39),(23998,14,30),(23998,23,40),(23998,25,58),(23998,29,3),(23998,30,58),(23998,31,71),(23998,68,82),(23998,110,20),(23998,361,34),(23998,384,400);
-- vishap_brais_+4 (24043) <- 23589
INSERT INTO item_mods (itemId, modId, value) VALUES
(24043,1,146),(24043,2,95),(24043,8,43),(24043,9,25),(24043,10,29),(24043,11,30),(24043,12,36),(24043,13,29),(24043,14,22),(24043,25,59),(24043,29,5),(24043,30,59),(24043,31,120),(24043,68,82),(24043,384,500),(24043,859,90),(24043,1142,2);
-- vishap_greaves_+4 (24088) <- 23656
INSERT INTO item_mods (itemId, modId, value) VALUES
(24088,1,104),(24088,2,57),(24088,8,30),(24088,9,32),(24088,10,25),(24088,11,47),(24088,13,23),(24088,14,36),(24088,23,35),(24088,25,56),(24088,29,4),(24088,30,56),(24088,31,120),(24088,68,122),(24088,362,26),(24088,384,300);

-- ================= VITIATION (RDM AF) =================
-- +3 chapeau template anomalies vs wiki: MP stored 7 (wiki 77) -> used correct scaled +4 value 87; Refresh 369=4 kept (flat, matches existing +3 sibling).
-- vitiation_chapeau_+4 (23922) <- 23402
INSERT INTO item_mods (itemId, modId, value) VALUES
(23922,1,123),(23922,2,91),(23922,5,87),(23922,8,24),(23922,9,24),(23922,10,29),(23922,11,24),(23922,12,34),(23922,13,42),(23922,14,29),(23922,23,72),(23922,25,42),(23922,29,8),(23922,30,42),(23922,31,135),(23922,68,81),(23922,114,27),(23922,369,4),(23922,384,600),(23922,841,9);
-- vitiation_tabard_+4 (23967) <- 23469
INSERT INTO item_mods (itemId, modId, value) VALUES
(23967,1,151),(23967,2,84),(23967,5,109),(23967,8,34),(23967,9,31),(23967,10,36),(23967,11,31),(23967,12,44),(23967,13,45),(23967,14,39),(23967,23,75),(23967,25,45),(23967,29,9),(23967,30,45),(23967,31,140),(23967,68,86),(23967,112,24),(23967,113,24),(23967,170,15),(23967,384,300),(23967,890,15);
-- vitiation_gloves_+4 (24012) <- 23536
INSERT INTO item_mods (itemId, modId, value) VALUES
(24012,1,108),(24012,2,52),(24012,5,74),(24012,8,19),(24012,9,38),(24012,10,40),(24012,11,15),(24012,12,37),(24012,13,46),(24012,14,29),(24012,23,73),(24012,25,43),(24012,29,9),(24012,30,43),(24012,31,97),(24012,68,67),(24012,113,25),(24012,384,300);
-- vitiation_tights_+4 (24057) <- 23603
INSERT INTO item_mods (itemId, modId, value) VALUES
(24057,1,134),(24057,2,73),(24057,5,59),(24057,8,38),(24057,9,22),(24057,10,27),(24057,11,27),(24057,12,49),(24057,13,34),(24057,14,29),(24057,23,74),(24057,25,44),(24057,29,9),(24057,30,44),(24057,31,167),(24057,68,72),(24057,115,24),(24057,161,-500),(24057,164,-500),(24057,344,30),(24057,384,500);
-- vitiation_boots_+4 (24102) <- 23670
INSERT INTO item_mods (itemId, modId, value) VALUES
(24102,1,92),(24102,2,43),(24102,5,75),(24102,8,21),(24102,9,19),(24102,10,23),(24102,11,41),(24102,12,35),(24102,13,32),(24102,14,42),(24102,25,41),(24102,28,58),(24102,29,7),(24102,30,48),(24102,31,167),(24102,68,100),(24102,114,17),(24102,290,10),(24102,384,300);

-- ================= WAKIDO (SAM Relic) =================
-- NOTE: added modId 30 (MACC) -- new player Magic Accuracy on +4 tier.
-- domaru "Damage Taken -8%" omitted (mirrors +3 template, which lacks modId 160). Zanshin/Hasso omitted where +3 template omits them.
-- domaru StoreTP: +3 template stored 7 (sibling pieces confirm 1:1); used wiki-correct +4 value 9.
-- wakido_kabuto_+4 (23906) <- 23386
INSERT INTO item_mods (itemId, modId, value) VALUES
(23906,1,140),(23906,2,77),(23906,5,43),(23906,8,37),(23906,9,38),(23906,10,32),(23906,11,35),(23906,12,29),(23906,13,32),(23906,14,29),(23906,23,46),(23906,25,57),(23906,29,4),(23906,30,57),(23906,31,88),(23906,68,93),(23906,94,8),(23906,95,90),(23906,368,4),(23906,384,700),(23906,1143,2);
-- wakido_domaru_+4 (23951) <- 23453
INSERT INTO item_mods (itemId, modId, value) VALUES
(23951,1,170),(23951,2,111),(23951,5,64),(23951,8,41),(23951,9,36),(23951,10,41),(23951,11,36),(23951,12,31),(23951,13,34),(23951,14,31),(23951,25,67),(23951,29,6),(23951,30,67),(23951,31,98),(23951,68,101),(23951,73,9),(23951,384,300);
-- wakido_haidate_+4 (24041) <- 23587
INSERT INTO item_mods (itemId, modId, value) VALUES
(24041,1,152),(24041,2,95),(24041,8,44),(24041,10,29),(24041,11,30),(24041,12,37),(24041,13,29),(24041,14,22),(24041,23,45),(24041,24,45),(24041,25,59),(24041,29,5),(24041,30,59),(24041,31,120),(24041,68,82),(24041,73,9),(24041,110,20),(24041,384,500),(24041,841,12);
-- wakido_kote_+4 (23996) <- 23520
INSERT INTO item_mods (itemId, modId, value) VALUES
(23996,1,128),(23996,2,60),(23996,8,24),(23996,9,45),(23996,10,40),(23996,11,22),(23996,12,20),(23996,13,40),(23996,14,30),(23996,25,58),(23996,29,3),(23996,30,58),(23996,31,71),(23996,68,82),(23996,73,7),(23996,384,400);
-- wakido_sune-ate_+4 (24086) <- 23654
INSERT INTO item_mods (itemId, modId, value) VALUES
(24086,1,110),(24086,2,42),(24086,8,25),(24086,9,33),(24086,10,25),(24086,11,47),(24086,13,23),(24086,14,37),(24086,23,43),(24086,24,43),(24086,25,66),(24086,26,50),(24086,29,4),(24086,30,66),(24086,31,120),(24086,68,112),(24086,306,5),(24086,384,300);

-- +4 model gap fixes (renamed/split pieces: ignominy finger_gauntlets, runeist boots)
UPDATE item_equipment tgt JOIN item_basic tb ON tb.itemid=tgt.itemId JOIN item_basic sb ON SUBSTRING_INDEX(sb.name,'_',1)=SUBSTRING_INDEX(tb.name,'_',1) JOIN item_equipment src ON src.itemId=sb.itemid AND src.slot=tgt.slot AND src.MId<>0 SET tgt.MId=src.MId WHERE tb.name LIKE '%\_+4' AND tgt.MId=0 AND tgt.ilevel>=109;

-- +4 laksamana model (DB names +4 head/body/feet without the 's' of lower tiers)
UPDATE item_equipment tgt JOIN item_equipment src ON src.slot=tgt.slot AND src.MId<>0 JOIN item_basic sb ON sb.itemid=src.itemId AND sb.name LIKE 'laksamanas%' SET tgt.MId=src.MId WHERE tgt.itemId IN (23911,23956,24091) AND tgt.MId=0;
-- +3 fixes: archmages_coat haste modId 394->384; vitiation_chapeau MP 7->77
DELETE FROM item_mods WHERE itemId=23468 AND modId=384;
UPDATE item_mods SET modId=384 WHERE itemId=23468 AND modId=394;
UPDATE item_mods SET value=77 WHERE itemId=23402 AND modId=2 AND value=7;

-- +3 data-quality cleanup (issues surfaced during the +4 pass)
UPDATE item_mods SET value=9 WHERE itemId=23453 AND modId=73 AND value=7;   -- wakido_domaru StoreTP
UPDATE item_mods SET value=-8 WHERE itemId=23552 AND modId=27 AND value=8;  -- bagua_mitaines Enmity sign
DELETE FROM item_mods WHERE itemId=23552 AND modId=68;
UPDATE item_mods SET modId=68 WHERE itemId=23552 AND modId=41;              -- bagua_mitaines Evasion 41->68
UPDATE item_mods SET value=4 WHERE itemId=23588 AND modId=29 AND value=8;   -- hachiya_hakama MDEF
DELETE FROM item_mods WHERE itemId=23465;
INSERT INTO item_mods (itemId,modId,value) VALUES
(23465,1,165),(23465,2,81),(23465,8,36),(23465,9,35),(23465,10,36),(23465,11,30),(23465,12,30),(23465,13,30),(23465,14,30),
(23465,23,85),(23465,25,50),(23465,29,7),(23465,30,40),(23465,31,84),(23465,68,64),(23465,288,7),(23465,384,400),(23465,955,30);
DELETE FROM item_mods WHERE itemId=23532;
INSERT INTO item_mods (itemId,modId,value) VALUES
(23532,1,119),(23532,2,70),(23532,8,25),(23532,9,39),(23532,10,47),(23532,11,13),(23532,12,21),(23532,13,36),(23532,14,26),
(23532,23,86),(23532,25,38),(23532,29,4),(23532,30,38),(23532,31,63),(23532,68,42),(23532,161,-600),(23532,384,500),
(23532,903,50),(23532,904,1),(23532,956,15);

-- agoge_mufflers_+4: +4 reconstruction missed Physical damage taken -6% (sparse +3 lacked it)
INSERT INTO item_mods (itemId,modId,value) VALUES (24008,161,-600) ON DUPLICATE KEY UPDATE value=VALUES(value);
