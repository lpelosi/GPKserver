-- GPK custom: implement the 2 Prime weapon skills LSB left unimplemented.
-- Varga Purnikawa (H2H) grants WS 231 Maru Kala; Mpu Gandring (Dagger) grants WS 232 Ruthless Stroke.
-- Scripts: scripts/actions/weaponskills/{maru_kala,ruthless_stroke}.lua. Re-run after a weapon_skills re-import.
DELETE FROM weapon_skills WHERE weaponskillid IN (231,232);
INSERT INTO weapon_skills (weaponskillid,name,jobs,type,skilllevel,element,animation,animationTime,`range`,aoe,radius,primary_sc,secondary_sc,tertiary_sc,main_only,unlock_id)
SELECT 231,'maru_kala',jobs,type,0,element,animation,animationTime,`range`,aoe,radius,6,2,10,main_only,0 FROM weapon_skills WHERE weaponskillid=14;
INSERT INTO weapon_skills (weaponskillid,name,jobs,type,skilllevel,element,animation,animationTime,`range`,aoe,radius,primary_sc,secondary_sc,tertiary_sc,main_only,unlock_id)
SELECT 232,'ruthless_stroke',jobs,type,0,element,animation,animationTime,`range`,aoe,radius,3,8,12,main_only,0 FROM weapon_skills WHERE weaponskillid=31;

-- ============================================================
-- 12 more Prime weapons (WS 241-252) + their item stats/WS-link. BG-wiki sourced.
-- ============================================================
-- prime batch 1
-- =====================================================================
-- FFXI Prime weapons batch 1: Caliburnus, Helheim, Spalirisos
-- WS + weapon stat mods for LandSandBoat
-- =====================================================================

-- ---------------------------------------------------------------------
-- WEAPON_SKILLS  (copy animation/type/jobs from same-weapon-type WS)
-- SC scheme: Detonation=6 Compression=2 Distortion=10
--            Liquefaction=3 Impaction=8 Fragmentation=12
-- ---------------------------------------------------------------------

-- Imperator (Sword, skill 3) -> copy savage_blade ; SC Detonation/Compression/Distortion
INSERT INTO weapon_skills (weaponskillid,name,jobs,type,skilllevel,element,animation,animationTime,`range`,aoe,radius,primary_sc,secondary_sc,tertiary_sc,main_only,unlock_id)
SELECT 241,'imperator',jobs,type,0,element,animation,animationTime,`range`,aoe,radius,6,2,10,main_only,0
FROM weapon_skills WHERE name='savage_blade';

-- Fimbulvetr (Great Sword, skill 4) -> copy resolution ; SC Detonation/Compression/Distortion
INSERT INTO weapon_skills (weaponskillid,name,jobs,type,skilllevel,element,animation,animationTime,`range`,aoe,radius,primary_sc,secondary_sc,tertiary_sc,main_only,unlock_id)
SELECT 242,'fimbulvetr',jobs,type,0,element,animation,animationTime,`range`,aoe,radius,6,2,10,main_only,0
FROM weapon_skills WHERE name='resolution';

-- Blitz (Axe, skill 5) -> copy decimation ; SC Liquefaction/Impaction/Fragmentation
INSERT INTO weapon_skills (weaponskillid,name,jobs,type,skilllevel,element,animation,animationTime,`range`,aoe,radius,primary_sc,secondary_sc,tertiary_sc,main_only,unlock_id)
SELECT 243,'blitz',jobs,type,0,element,animation,animationTime,`range`,aoe,radius,3,8,12,main_only,0
FROM weapon_skills WHERE name='decimation';

-- ---------------------------------------------------------------------
-- ITEM_MODS
-- modIds: STR8 DEX9 VIT10 CHR14 MND13 ACC25 MACC30 STORETP73 CRITHITRATE165
--         REFRESH369  REGEN_DOWN404 REFRESH_DOWN405 (soul-devour)  ADDS_WEAPONSKILL355
-- Incomplete tier: soul-devour only (no attributes, per wiki) + WS link.
-- Combat-skill bonuses (Sword/Parry/Magic-Acc skill +252/260/269/277) belong in
-- item_weapon (ilvl_skill/ilvl_parry/ilvl_macc), NOT item_mods -- left untouched,
-- matching the Varga Purnikawa / Mpu Gandring reference weapons.
-- ---------------------------------------------------------------------
DELETE FROM item_mods WHERE itemId IN (21643,21644,21645,21646,21649,21651,21652,21653,21727,21728,21729,21730);

-- ---- Caliburnus (Sword)  WS Imperator = 241 ----
-- 21643 Incomplete (DMG156)
INSERT INTO item_mods (itemId,modId,value) VALUES
(21643,404,1),(21643,405,1),(21643,355,241);
-- 21644 Level 119 (DMG165): DEX+25 MND+25 Acc+25 MagicAcc+25 Refresh+2
INSERT INTO item_mods (itemId,modId,value) VALUES
(21644,9,25),(21644,13,25),(21644,25,25),(21644,30,25),(21644,369,2),(21644,355,241);
-- 21645 Level 119 II (DMG172): DEX+30 MND+30 Acc+30 MagicAcc+30 Refresh+3
INSERT INTO item_mods (itemId,modId,value) VALUES
(21645,9,30),(21645,13,30),(21645,25,30),(21645,30,30),(21645,369,3),(21645,355,241);
-- 21646 Level 119 III (DMG181): DEX+35 MND+35 Acc+35 MagicAcc+35 Refresh+4
INSERT INTO item_mods (itemId,modId,value) VALUES
(21646,9,35),(21646,13,35),(21646,25,35),(21646,30,35),(21646,369,4),(21646,355,241);

-- ---- Helheim (Great Sword)  WS Fimbulvetr = 242 ----
-- 21651 Incomplete (DMG288)
INSERT INTO item_mods (itemId,modId,value) VALUES
(21651,404,1),(21651,405,1),(21651,355,242);
-- 21652 Level 119 (DMG306): STR+25 VIT+25 Acc+25 MagicAcc+25 StoreTP+5
INSERT INTO item_mods (itemId,modId,value) VALUES
(21652,8,25),(21652,10,25),(21652,25,25),(21652,30,25),(21652,73,5),(21652,355,242);
-- 21653 Level 119 II (DMG318): STR+30 VIT+30 Acc+30 MagicAcc+30 StoreTP+7
INSERT INTO item_mods (itemId,modId,value) VALUES
(21653,8,30),(21653,10,30),(21653,25,30),(21653,30,30),(21653,73,7),(21653,355,242);
-- 21649 Level 119 III (DMG336): STR+35 VIT+35 Acc+35 MagicAcc+35 StoreTP+10
INSERT INTO item_mods (itemId,modId,value) VALUES
(21649,8,35),(21649,10,35),(21649,25,35),(21649,30,35),(21649,73,10),(21649,355,242);

-- ---- Spalirisos (Axe)  WS Blitz = 243 ----
-- 21727 Incomplete (DMG187)
INSERT INTO item_mods (itemId,modId,value) VALUES
(21727,404,1),(21727,405,1),(21727,355,243);
-- 21728 Level 119 (DMG198): STR+25 DEX+25 CHR+25 Acc+25 MagicAcc+25 Crit+10%
INSERT INTO item_mods (itemId,modId,value) VALUES
(21728,8,25),(21728,9,25),(21728,14,25),(21728,25,25),(21728,30,25),(21728,165,10),(21728,355,243);
-- 21729 Level 119 II (DMG207): STR+30 DEX+30 CHR+30 Acc+30 MagicAcc+30 Crit+12%
INSERT INTO item_mods (itemId,modId,value) VALUES
(21729,8,30),(21729,9,30),(21729,14,30),(21729,25,30),(21729,30,30),(21729,165,12),(21729,355,243);
-- 21730 Level 119 III (DMG218): STR+35 DEX+35 CHR+35 Acc+35 MagicAcc+35 Crit+15%
INSERT INTO item_mods (itemId,modId,value) VALUES
(21730,8,35),(21730,9,35),(21730,14,35),(21730,25,35),(21730,30,35),(21730,165,15),(21730,355,243);

-- prime batch 2
-- =====================================================================
-- Prime Weapons batch #2 : Laphria / Foenaria / Gae Buide
-- Great Axe / Scythe / Polearm  + their Prime weapon skills
-- Pattern copied from working examples: maru_kala (WS 231, Varga Purnikawa)
-- and ruthless_stroke (WS 232, Mpu Gandring).
--
-- Prime WS are single-target, main_only=1 (matching WS 231/232), so each
-- row is SELECT-copied from a single-target same-weapon-type WS
-- (ukkos_fury / entropy / stardiver) rather than the AoE fell_cleave the
-- brief used as a syntax example.
--
-- SC id scheme (retail): Transfixion1 Compression2 Liquefaction3 Scission4
--   Reverberation5 Detonation6 Induration7 Impaction8 Gravitation9
--   Distortion10 Fusion11 Fragmentation12 Light13 Darkness14
-- =====================================================================

-- ---------------------------------------------------------------------
-- WEAPON SKILLS
-- ---------------------------------------------------------------------

-- Disaster (Great Axe, WS 244) : Transfixion(1)/Scission(4)/Gravitation(9)
INSERT INTO weapon_skills (weaponskillid,name,jobs,type,skilllevel,element,animation,animationTime,`range`,aoe,radius,primary_sc,secondary_sc,tertiary_sc,main_only,unlock_id)
SELECT 244,'disaster',jobs,type,0,element,animation,animationTime,`range`,aoe,radius,1,4,9,main_only,0
FROM weapon_skills WHERE name='ukkos_fury';

-- Origin (Scythe, WS 245) : Induration(7)/Reverberation(5)/Fusion(11)
INSERT INTO weapon_skills (weaponskillid,name,jobs,type,skilllevel,element,animation,animationTime,`range`,aoe,radius,primary_sc,secondary_sc,tertiary_sc,main_only,unlock_id)
SELECT 245,'origin',jobs,type,0,element,animation,animationTime,`range`,aoe,radius,7,5,11,main_only,0
FROM weapon_skills WHERE name='entropy';

-- Diarmuid (Polearm, WS 246) : Transfixion(1)/Scission(4)/Gravitation(9)
INSERT INTO weapon_skills (weaponskillid,name,jobs,type,skilllevel,element,animation,animationTime,`range`,aoe,radius,primary_sc,secondary_sc,tertiary_sc,main_only,unlock_id)
SELECT 246,'diarmuid',jobs,type,0,element,animation,animationTime,`range`,aoe,radius,1,4,9,main_only,0
FROM weapon_skills WHERE name='stardiver';

-- ---------------------------------------------------------------------
-- WEAPON STATS (item_mods)
--   mod ids: STR 8, VIT 10, INT 12, ACC 25, MACC 30,
--            DOUBLE_ATTACK 288, TRIPLE_ATTACK 302,
--            REGEN_DOWN 404, REFRESH_DOWN 405, ADDS_WEAPONSKILL 355
--   Incomplete tier "Slowly devours your soul" (-1 HP/-1 MP per tick)
--            = REGEN_DOWN(404)=1 + REFRESH_DOWN(405)=1 (as WS 231/232 incomplete).
--   ilvl skill/parry/macc "skill +252/260/269/277" live in item_weapon
--            (ilvl_skill/ilvl_parry/ilvl_macc) -- NOT item_mods -- so skipped here.
--   Gae Buide "Wyvern: Acc/MAcc" and "Lv.+N" are pet/DRG mods, out of scope.
--   WS link (355) added to EVERY tier per brief.
-- ---------------------------------------------------------------------

DELETE FROM item_mods WHERE itemId IN
  (21782,21783,21784,21785,21834,21835,21836,21837,21888,21889,21890,21891);

-- --- Laphria (Great Axe) : STR/VIT/ACC/MACC + Double Attack, WS 244 ---
-- 21782 Laphria (Incomplete)
INSERT INTO item_mods (itemId,modId,value) VALUES
  (21782,404,1),(21782,405,1),(21782,355,244);
-- 21783 Laphria (Level 119)
INSERT INTO item_mods (itemId,modId,value) VALUES
  (21783,8,25),(21783,10,25),(21783,25,25),(21783,30,25),(21783,288,5),(21783,355,244);
-- 21784 Laphria (Level 119 II)
INSERT INTO item_mods (itemId,modId,value) VALUES
  (21784,8,30),(21784,10,30),(21784,25,30),(21784,30,30),(21784,288,7),(21784,355,244);
-- 21785 Laphria (Level 119 III)
INSERT INTO item_mods (itemId,modId,value) VALUES
  (21785,8,35),(21785,10,35),(21785,25,35),(21785,30,35),(21785,288,10),(21785,355,244);

-- --- Foenaria (Scythe) : STR/INT/ACC/MACC + Triple Attack, WS 245 ---
-- 21834 Foenaria (Incomplete)
INSERT INTO item_mods (itemId,modId,value) VALUES
  (21834,404,1),(21834,405,1),(21834,355,245);
-- 21835 Foenaria (Level 119)
INSERT INTO item_mods (itemId,modId,value) VALUES
  (21835,8,25),(21835,12,25),(21835,25,25),(21835,30,25),(21835,302,3),(21835,355,245);
-- 21836 Foenaria (Level 119 II)
INSERT INTO item_mods (itemId,modId,value) VALUES
  (21836,8,30),(21836,12,30),(21836,25,30),(21836,30,30),(21836,302,4),(21836,355,245);
-- 21837 Foenaria (Level 119 III)
INSERT INTO item_mods (itemId,modId,value) VALUES
  (21837,8,35),(21837,12,35),(21837,25,35),(21837,30,35),(21837,302,6),(21837,355,245);

-- --- Gae Buide (Polearm) : STR/VIT/ACC/MACC + Double Attack, WS 246 ---
-- 21888 Gae Buide (Incomplete)
INSERT INTO item_mods (itemId,modId,value) VALUES
  (21888,404,1),(21888,405,1),(21888,355,246);
-- 21889 Gae Buide (Level 119)
INSERT INTO item_mods (itemId,modId,value) VALUES
  (21889,8,25),(21889,10,25),(21889,25,25),(21889,30,25),(21889,288,5),(21889,355,246);
-- 21890 Gae Buide (Level 119 II)
INSERT INTO item_mods (itemId,modId,value) VALUES
  (21890,8,30),(21890,10,30),(21890,25,30),(21890,30,30),(21890,288,7),(21890,355,246);
-- 21891 Gae Buide (Level 119 III)
INSERT INTO item_mods (itemId,modId,value) VALUES
  (21891,8,35),(21891,10,35),(21891,25,35),(21891,30,35),(21891,288,10),(21891,355,246);

-- prime batch 3
-- ============================================================================
-- Prime Weapons batch 3: Dokoku / Kusanagi / Lorg Mor
-- Weapon skills: Zesho Meppo (247), Tachi: Mumei (248), Dagda (249)
-- Scripts: scripts/actions/weaponskills/{zesho_meppo,tachi_mumei,dagda}.lua
--
-- Skillchain id ref (retail): Transfixion1 Compression2 Liquefaction3 Scission4
--   Reverberation5 Detonation6 Induration7 Impaction8 Gravitation9 Distortion10
--   Fusion11 Fragmentation12 Light13 Darkness14
-- NOTE: "Magic Accuracy skill +N" is NOT an item_mod (per scripts/enum/mod.lua it
--   lives in item_weapon.sql), so it is intentionally omitted from item_mods below.
--   "Physical damage limit+" (Prime aftermath, no numeric value) is also omitted.
-- ============================================================================

-- ------------------------------------------------------------------
-- C) WEAPON_SKILLS rows (SELECT-copy jobs/type/animation from same-type WS)
-- ------------------------------------------------------------------
DELETE FROM weapon_skills WHERE weaponskillid IN (247, 248, 249);

-- Zesho Meppo (Katana, skill 9) copied from blade_metsu
-- SC: Induration(7) / Reverberation(5) / Fusion(11)
INSERT INTO weapon_skills (weaponskillid,name,jobs,type,skilllevel,element,animation,animationTime,`range`,aoe,radius,primary_sc,secondary_sc,tertiary_sc,main_only,unlock_id)
SELECT 247,'zesho_meppo',jobs,type,0,element,animation,animationTime,`range`,aoe,radius,7,5,11,main_only,0
FROM weapon_skills WHERE name='blade_metsu';

-- Tachi: Mumei (Great Katana, skill 10) copied from tachi_shoha
-- SC: Detonation(6) / Compression(2) / Distortion(10)
INSERT INTO weapon_skills (weaponskillid,name,jobs,type,skilllevel,element,animation,animationTime,`range`,aoe,radius,primary_sc,secondary_sc,tertiary_sc,main_only,unlock_id)
SELECT 248,'tachi_mumei',jobs,type,0,element,animation,animationTime,`range`,aoe,radius,6,2,10,main_only,0
FROM weapon_skills WHERE name='tachi_shoha';

-- Dagda (Club, skill 11) copied from black_halo
-- SC: Transfixion(1) / Scission(4) / Gravitation(9)
INSERT INTO weapon_skills (weaponskillid,name,jobs,type,skilllevel,element,animation,animationTime,`range`,aoe,radius,primary_sc,secondary_sc,tertiary_sc,main_only,unlock_id)
SELECT 249,'dagda',jobs,type,0,element,animation,animationTime,`range`,aoe,radius,1,4,9,main_only,0
FROM weapon_skills WHERE name='black_halo';

-- ------------------------------------------------------------------
-- D) ITEM_MODS for all 4 tiers of each weapon
--    modIds: STR=8 DEX=9 AGI=11 MND=13 ACC=25 MATT=28 MACC=30 STORETP=73
--            KATANA=88 GKATANA=89 CLUB=90 PARRY=110 DMG=160 (dmg-taken, -100 = -1%)
--            DOUBLE_ATTACK=288 MAGIC_DAMAGE=311 ADDS_WEAPONSKILL=355 REGEN=370
--    Tier order per weapon: Incomplete / Level 119 / Level 119 II / Level 119 III
-- ------------------------------------------------------------------
DELETE FROM item_mods WHERE itemId IN
    (21929,21930,21931,21932,   -- Dokoku
     21983,21984,21985,21986,   -- Kusanagi
     21998,22000,22001,22002);  -- Lorg Mor

INSERT INTO item_mods (itemId, modId, value) VALUES
-- === Dokoku (Katana) -> Zesho Meppo (247) ===
-- Incomplete (21929): weapon+parry skill only
(21929, 88, 252), (21929, 110, 252), (21929, 355, 247),
-- Level 119 (21930)
(21930,  9, 25), (21930, 11, 25), (21930, 25, 25), (21930, 30, 25),
(21930, 311, 232), (21930, 73, 5), (21930, 88, 260), (21930, 110, 260), (21930, 355, 247),
-- Level 119 II (21931)
(21931,  9, 30), (21931, 11, 30), (21931, 25, 30), (21931, 30, 30),
(21931, 311, 248), (21931, 73, 7), (21931, 88, 269), (21931, 110, 269), (21931, 355, 247),
-- Level 119 III (21932)
(21932,  9, 35), (21932, 11, 35), (21932, 25, 35), (21932, 30, 35),
(21932, 311, 263), (21932, 73, 10), (21932, 88, 277), (21932, 110, 277), (21932, 355, 247),

-- === Kusanagi (Great Katana) -> Tachi: Mumei (248) ===
-- Incomplete (21983): weapon+parry skill only
(21983, 89, 252), (21983, 110, 252), (21983, 355, 248),
-- Level 119 (21984)
(21984,  8, 25), (21984,  9, 25), (21984, 25, 25), (21984, 30, 25),
(21984, 288, 5), (21984, 89, 260), (21984, 110, 260), (21984, 355, 248),
-- Level 119 II (21985)
(21985,  8, 30), (21985,  9, 30), (21985, 25, 30), (21985, 30, 30),
(21985, 288, 7), (21985, 89, 269), (21985, 110, 269), (21985, 355, 248),
-- Level 119 III (21986)
(21986,  8, 35), (21986,  9, 35), (21986, 25, 35), (21986, 30, 35),
(21986, 288, 10), (21986, 89, 277), (21986, 110, 277), (21986, 355, 248),

-- === Lorg Mor (Club) -> Dagda (249) ===
-- Incomplete (21998): weapon+parry skill only
(21998, 90, 252), (21998, 110, 252), (21998, 355, 249),
-- Level 119 (22000)
(22000,  8, 25), (22000, 13, 25), (22000, 25, 25), (22000, 30, 25), (22000, 28, 40),
(22000, 311, 232), (22000, 90, 260), (22000, 110, 260), (22000, 370, 5), (22000, 160, -500), (22000, 355, 249),
-- Level 119 II (22001)
(22001,  8, 30), (22001, 13, 30), (22001, 25, 30), (22001, 30, 30), (22001, 28, 50),
(22001, 311, 248), (22001, 90, 269), (22001, 110, 269), (22001, 370, 6), (22001, 160, -700), (22001, 355, 249),
-- Level 119 III (22002)
(22002,  8, 35), (22002, 13, 35), (22002, 25, 35), (22002, 30, 35), (22002, 28, 60),
(22002, 311, 263), (22002, 90, 277), (22002, 110, 277), (22002, 370, 7), (22002, 160, -1000), (22002, 355, 249);

-- prime batch 4
-- =====================================================================
-- Prime Weapons batch 4: Opashoro/Oshala, Pinaka/Sarv, Earp/Terminus
-- Weapon skills 250/251/252 + item_mods for the 12 tier item ids.
-- NOTE: no PRIME aftermath type in LSB yet; damage + skillchain functional.
-- Skill-rating bonuses (Staff/Archery/Marksmanship/Parrying/Magic Acc.)
-- live in item_weapon, NOT item_mods -- so they are intentionally omitted.
-- =====================================================================

-- ---------------------------------------------------------------------
-- weapon_skills (copy jobs/type/element/animation/etc from same-type WS)
-- ---------------------------------------------------------------------
-- Oshala  (Staff, type 12)  physical  SC: Induration(7)/Reverberation(5)/Fusion(11)
INSERT INTO weapon_skills (weaponskillid,name,jobs,type,skilllevel,element,animation,animationTime,`range`,aoe,radius,primary_sc,secondary_sc,tertiary_sc,main_only,unlock_id)
SELECT 250,'oshala',jobs,type,0,element,animation,animationTime,`range`,aoe,radius,7,5,11,main_only,0 FROM weapon_skills WHERE name='shattersoul';

-- Sarv  (Archery, type 25)  ranged  SC: Transfixion(1)/Scission(4)/Gravitation(9)
INSERT INTO weapon_skills (weaponskillid,name,jobs,type,skilllevel,element,animation,animationTime,`range`,aoe,radius,primary_sc,secondary_sc,tertiary_sc,main_only,unlock_id)
SELECT 251,'sarv',jobs,type,0,element,animation,animationTime,`range`,aoe,radius,1,4,9,main_only,0 FROM weapon_skills WHERE name='namas_arrow';

-- Terminus  (Marksmanship, type 26)  ranged  SC: Induration(7)/Reverberation(5)/Fusion(11)
INSERT INTO weapon_skills (weaponskillid,name,jobs,type,skilllevel,element,animation,animationTime,`range`,aoe,radius,primary_sc,secondary_sc,tertiary_sc,main_only,unlock_id)
SELECT 252,'terminus',jobs,type,0,element,animation,animationTime,`range`,aoe,radius,7,5,11,main_only,0 FROM weapon_skills WHERE name='last_stand';

-- ---------------------------------------------------------------------
-- item_mods
-- mod ids: STR8 DEX9 VIT10 AGI11 INT12 MND13 CHR14 ATT23 RATT24 ACC25
--          RACC26 MATT28 MACC30 STORETP73 BP_DAMAGE126 CRITHITRATE165
--          MAGIC_DAMAGE311 ADDS_WEAPONSKILL355 REGEN_DOWN404 REFRESH_DOWN405
--          PET_ACC_EVA991 PET_MACC_MEVA993 AVATAR_LVL_BONUS1040
-- WS link (mod 355) is added on EVERY tier per spec.
-- Incomplete tiers carry the Prime "devours soul" -1HP/-1MP-per-tic penalty
-- (REGEN_DOWN 404 / REFRESH_DOWN 405), matching Varga Purnikawa / Mpu Gandring.
-- ---------------------------------------------------------------------
DELETE FROM item_mods WHERE itemId IN (22103,22104,22105,22106,22156,22157,22158,22163,22160,22161,22162,22164);

-- ===== Opashoro (Staff) -> Oshala (WS 250) =====
-- 22103 Opashoro (Incomplete)
INSERT INTO item_mods (itemId,modId,value) VALUES
(22103,404,1),(22103,405,1),(22103,355,250);
-- 22104 Opashoro (Level 119): INT+25 MND+25 ACC+25 MACC+25 MAtkB+60 MDmg+294 Avatar Acc/RAcc/MAcc+25 Avatar Lv.+1 BPdmg+30
INSERT INTO item_mods (itemId,modId,value) VALUES
(22104,12,25),(22104,13,25),(22104,25,25),(22104,30,25),(22104,28,60),(22104,311,294),
(22104,991,25),(22104,993,25),(22104,1040,1),(22104,126,30),(22104,355,250);
-- 22105 Opashoro (Level 119 II): INT+30 MND+30 ACC+30 MACC+30 MAtkB+70 MDmg+310 Avatar+30 Lv.+2 BPdmg+40
INSERT INTO item_mods (itemId,modId,value) VALUES
(22105,12,30),(22105,13,30),(22105,25,30),(22105,30,30),(22105,28,70),(22105,311,310),
(22105,991,30),(22105,993,30),(22105,1040,2),(22105,126,40),(22105,355,250);
-- 22106 Opashoro (Level 119 III): INT+35 MND+35 ACC+35 MACC+35 MAtkB+80 MDmg+325 Avatar+35 Lv.+3 BPdmg+50
INSERT INTO item_mods (itemId,modId,value) VALUES
(22106,12,35),(22106,13,35),(22106,25,35),(22106,30,35),(22106,28,80),(22106,311,325),
(22106,991,35),(22106,993,35),(22106,1040,3),(22106,126,50),(22106,355,250);

-- ===== Pinaka (Archery) -> Sarv (WS 251) =====
-- 22156 Pinaka (Incomplete)
INSERT INTO item_mods (itemId,modId,value) VALUES
(22156,404,1),(22156,405,1),(22156,355,251);
-- 22157 Pinaka (Level 119): STR+25 AGI+25 ACC+25 MACC+25 StoreTP+5
INSERT INTO item_mods (itemId,modId,value) VALUES
(22157,8,25),(22157,11,25),(22157,25,25),(22157,30,25),(22157,73,5),(22157,355,251);
-- 22158 Pinaka (Level 119 II): STR+30 AGI+30 ACC+30 MACC+30 StoreTP+7
INSERT INTO item_mods (itemId,modId,value) VALUES
(22158,8,30),(22158,11,30),(22158,25,30),(22158,30,30),(22158,73,7),(22158,355,251);
-- 22163 Pinaka (Level 119 III): STR+35 AGI+35 ACC+35 MACC+35 StoreTP+10
INSERT INTO item_mods (itemId,modId,value) VALUES
(22163,8,35),(22163,11,35),(22163,25,35),(22163,30,35),(22163,73,10),(22163,355,251);

-- ===== Earp (Marksmanship) -> Terminus (WS 252) =====
-- 22160 Earp (Incomplete)
INSERT INTO item_mods (itemId,modId,value) VALUES
(22160,404,1),(22160,405,1),(22160,355,252);
-- 22161 Earp (Level 119): DEX+25 AGI+25 ACC+25 MACC+25 CritHitRate+10
INSERT INTO item_mods (itemId,modId,value) VALUES
(22161,9,25),(22161,11,25),(22161,25,25),(22161,30,25),(22161,165,10),(22161,355,252);
-- 22162 Earp (Level 119 II): DEX+30 AGI+30 ACC+30 MACC+30 CritHitRate+12
INSERT INTO item_mods (itemId,modId,value) VALUES
(22162,9,30),(22162,11,30),(22162,25,30),(22162,30,30),(22162,165,12),(22162,355,252);
-- 22164 Earp (Level 119 III): DEX+35 AGI+35 ACC+35 MACC+35 CritHitRate+15
INSERT INTO item_mods (itemId,modId,value) VALUES
(22164,9,35),(22164,11,35),(22164,25,35),(22164,30,35),(22164,165,15),(22164,355,252);

-- reconcile: drop double-counted combat-skill mods + populate item_weapon skill columns
-- 1) remove double-counting combat-skill mods (belong in item_weapon.ilvl_*, not item_mods)
DELETE FROM item_mods WHERE modId IN (88,89,90,110)
AND itemId IN (SELECT itemid FROM item_basic
  WHERE name REGEXP '^(caliburnus|helheim|spalirisos|laphria|foenaria|gae_buide|dokoku|kusanagi|lorg_mor|opashoro|pinaka|earp)');

-- 2) populate item-level skill/parry/macc per tier (rank by dmg -> 252/260/269/277), matching Varga/Mpu
UPDATE item_weapon w
JOIN (
  SELECT w2.itemId,
    ELT(ROW_NUMBER() OVER (PARTITION BY SUBSTRING_INDEX(b.name,'-',1) ORDER BY w2.dmg), 252,260,269,277) sk
  FROM item_weapon w2 JOIN item_basic b ON b.itemid=w2.itemId
  WHERE b.name REGEXP '^(caliburnus|helheim|spalirisos|laphria|foenaria|gae_buide|dokoku|kusanagi|lorg_mor|opashoro|pinaka|earp)'
) r ON r.itemId=w.itemId
SET w.ilvl_skill=r.sk, w.ilvl_parry=r.sk, w.ilvl_macc=r.sk;

-- Duban (PLD shield, no WS) + Loughnashade (BRD harp; 'Aria of Passion' is a SONG, not a WS - not implemented) stats
DELETE FROM item_mods WHERE itemId IN (26492,26493,26494,26495,22304,22305,22306,22307);
INSERT INTO item_mods (itemId,modId,value) VALUES (26492,1,155),(26492,10,35),(26492,13,35),(26492,31,35),(26492,68,35),(26492,109,134),(26492,958,20),(26492,831,-2500);
INSERT INTO item_mods (itemId,modId,value) VALUES (26493,1,155),(26493,10,35),(26493,13,35),(26493,31,35),(26493,68,35),(26493,109,134),(26493,958,20),(26493,831,-2500);
INSERT INTO item_mods (itemId,modId,value) VALUES (26494,1,155),(26494,10,35),(26494,13,35),(26494,31,35),(26494,68,35),(26494,109,134),(26494,958,20),(26494,831,-2500);
INSERT INTO item_mods (itemId,modId,value) VALUES (26495,1,155),(26495,10,35),(26495,13,35),(26495,31,35),(26495,68,35),(26495,109,134),(26495,958,20),(26495,831,-2500);
INSERT INTO item_mods (itemId,modId,value) VALUES (22304,14,20),(22304,452,4),(22304,453,2);
INSERT INTO item_mods (itemId,modId,value) VALUES (22305,14,20),(22305,452,4),(22305,453,2);
INSERT INTO item_mods (itemId,modId,value) VALUES (22306,14,20),(22306,452,4),(22306,453,2);
INSERT INTO item_mods (itemId,modId,value) VALUES (22307,14,20),(22307,452,4),(22307,453,2);

-- Prime Aftermath: weapons carry AFTERMATH mod(256)=100 (effect id 100 = Physical Damage Limit+)
DELETE FROM item_mods WHERE modId=256 AND itemId IN (SELECT itemid FROM item_basic WHERE name REGEXP '^(varga|mpu_gandring|caliburnus|helheim|spalirisos|laphria|foenaria|gae_buide|dokoku|kusanagi|lorg_mor|opashoro|pinaka|earp)');
INSERT INTO item_mods (itemId,modId,value)
SELECT b.itemid, 256, 100 FROM item_basic b
WHERE b.name REGEXP '^(varga|mpu_gandring|caliburnus|helheim|spalirisos|laphria|foenaria|gae_buide|dokoku|kusanagi|lorg_mor|opashoro|pinaka|earp)'
  AND EXISTS(SELECT 1 FROM item_weapon w WHERE w.itemId=b.itemid);

-- Aria of Passion song (Loughnashade) - spell 1020
DELETE FROM spell_list WHERE spellid=1020;
INSERT INTO spell_list (spellid,name,jobs,`group`,family,element,zonemisc,validTargets,skill,mpCost,castTime,recastTime,message,magicBurstMessage,animation,animationTime,AOE,base,multiplier,CE,VE,requirements,spell_range,radius,content_tag)
SELECT 1020,'aria_of_passion',jobs,`group`,family,element,zonemisc,validTargets,skill,mpCost,castTime,recastTime,message,magicBurstMessage,animation,animationTime,AOE,base,multiplier,CE,VE,requirements,spell_range,radius,content_tag
FROM spell_list WHERE name='advancing_march';

UPDATE spell_list SET family=157 WHERE spellid=1020; -- Aria of Passion own family

-- Aria of Passion: require BRD 99 (jobs blob byte 10 -> 0x63)
UPDATE spell_list SET jobs=CONCAT(SUBSTRING(jobs,1,9), 0x63, SUBSTRING(jobs,11)) WHERE spellid=1020 AND SUBSTRING(jobs,10,1)<>0x63;
