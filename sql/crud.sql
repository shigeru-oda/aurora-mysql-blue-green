-- 1. 最初の10件のデータをSELECT
SELECT * FROM table1 WHERE id BETWEEN 1 AND 10;

-- 2. 最初の10件の年齢を+1するUPDATE
UPDATE table1 SET age = age + 1 WHERE id BETWEEN 1 AND 10;

-- 3. UPDATE後のデータをSELECT
SELECT * FROM table1 WHERE id BETWEEN 1 AND 10;

-- 4. 最初の10件をDELETE
DELETE FROM table1 WHERE id BETWEEN 1 AND 10;

-- 5. DELETE後のデータをSELECT（データが削除されているか確認）
SELECT * FROM table1 WHERE id BETWEEN 1 AND 10;
-- 1. 最初の10件のデータをSELECT
USE `select`;
SELECT * FROM `from` WHERE `key` BETWEEN 1 AND 10;

-- 2. 最初の10件のvalueを"Updated Value"に変更するUPDATE
UPDATE `from` SET `value` = CONCAT('Updated ', `value`) WHERE `key` BETWEEN 1 AND 10;

-- 3. UPDATE後のデータをSELECT
SELECT * FROM `from` WHERE `key` BETWEEN 1 AND 10;

-- 4. 最初の10件をDELETE
DELETE FROM `from` WHERE `key` BETWEEN 1 AND 10;

-- 5. DELETE後のデータをSELECT（データが削除されているか確認）
SELECT * FROM `from` WHERE `key` BETWEEN 1 AND 10;
