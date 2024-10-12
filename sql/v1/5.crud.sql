USE db1;
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


USE cube;
-- 1. 最初の10件のデータをSELECT
SELECT * FROM empty WHERE lag BETWEEN 1 AND 10;

-- 2. 最初の10件のvalueを"Updated Value"に変更するUPDATE
UPDATE empty SET lead = CONCAT('lead', 'value') WHERE lag BETWEEN 1 AND 10;

-- 3. UPDATE後のデータをSELECT
SELECT * FROM empty WHERE lag BETWEEN 1 AND 10;

-- 4. 最初の10件をDELETE
DELETE FROM empty WHERE lag BETWEEN 1 AND 10;

-- 5. DELETE後のデータをSELECT（データが削除されているか確認）
SELECT * FROM empty WHERE lag BETWEEN 1 AND 10;
