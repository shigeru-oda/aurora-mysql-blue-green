USE db1;
-- db1のtable1に1000件のデータを挿入
DELIMITER $$
CREATE PROCEDURE insert_data_table1()
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= 1000 DO
    INSERT INTO table1 (name, age) VALUES (CONCAT('User', i), FLOOR(RAND() * 50 + 20));
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;
CALL insert_data_table1();

-- db1のtable2に1000件のデータを挿入
DELIMITER $$
CREATE PROCEDURE insert_data_table2()
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= 1000 DO
    INSERT INTO table2 (product_name, price, stock) VALUES (CONCAT('Product', i), FLOOR(RAND() * 100 + 1), FLOOR(RAND() * 500));
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;
CALL insert_data_table2();

-- db1のtable3に1000件のデータを挿入
DELIMITER $$
CREATE PROCEDURE insert_data_table3()
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= 1000 DO
    INSERT INTO table3 (customer_id, customer_name, email, signup_date) 
    VALUES (UUID(), CONCAT('Customer', i), CONCAT('customer', i, '@example.com'), DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 365) DAY));
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;
CALL insert_data_table3();

-- db1のtable4に1000件のデータを挿入
DELIMITER $$
CREATE PROCEDURE insert_data_table4()
BEGIN
  DECLARE i INT DEFAULT 1;
  DECLARE customer_id CHAR(36);
  WHILE i <= 1000 DO
    SET customer_id = (SELECT customer_id FROM table3 ORDER BY RAND() LIMIT 1);
    INSERT INTO table4 (customer_id, order_date, total, status) 
    VALUES (customer_id, DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 365) DAY), RAND() * 1000, ELT(FLOOR(RAND() * 4) + 1, 'pending', 'shipped', 'delivered', 'cancelled'));
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;
CALL insert_data_table4();

-- db1のtable5に1000件のデータを挿入
DELIMITER $$
CREATE PROCEDURE insert_data_table5()
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= 1000 DO
    INSERT INTO table5 (event_name, event_date, location, attendees) 
    VALUES (CONCAT('Event', i), DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 365) DAY), CONCAT('Location', i), FLOOR(RAND() * 1000));
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;
CALL insert_data_table5();

-- db1のtable6に1000件のデータを挿入
DELIMITER $$
CREATE PROCEDURE insert_data_table6()
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= 1000 DO
    INSERT INTO table6 (title, content, published_at, author) 
    VALUES (CONCAT('Title', i), 'This is a sample content.', DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 365) DAY), CONCAT('Author', i));
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;
CALL insert_data_table6();

-- db1のtable7に1000件のデータを挿入
DELIMITER $$
CREATE PROCEDURE insert_data_table7()
BEGIN
  DECLARE i INT DEFAULT 1;
  DECLARE post_id BIGINT;
  WHILE i <= 1000 DO
    SET post_id = (SELECT post_id FROM table6 ORDER BY RAND() LIMIT 1);
    INSERT INTO table7 (post_id, content, commenter_name, comment_date) 
    VALUES (post_id, 'This is a sample comment.', CONCAT('Commenter', i), DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 365) DAY));
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;
CALL insert_data_table7();

-- db1のtable8に1000件のデータを挿入
DELIMITER $$
CREATE PROCEDURE insert_data_table8()
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= 1000 DO
    INSERT INTO table8 (first_name, last_name, department, hire_date) 
    VALUES (CONCAT('First', i), CONCAT('Last', i), CONCAT('Dept', FLOOR(RAND() * 10 + 1)), DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 3650) DAY));
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;
CALL insert_data_table8();

-- db1のtable9に1000件のデータを挿入
DELIMITER $$
CREATE PROCEDURE insert_data_table9()
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= 1000 DO
    INSERT INTO table9 (issue, opened_by, opened_at, resolved_at) 
    VALUES (CONCAT('Issue', i), CONCAT('User', FLOOR(RAND() * 100 + 1)), DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 30) DAY), NOW());
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;
CALL insert_data_table9();

-- db1のtable10に1000件のデータを挿入
DELIMITER $$
CREATE PROCEDURE insert_data_table10()
BEGIN
  DECLARE i INT DEFAULT 1;
  DECLARE user_id CHAR(36);
  WHILE i <= 1000 DO
    SET user_id = (SELECT customer_id FROM table3 ORDER BY RAND() LIMIT 1);
    INSERT INTO table10 (transaction_id, user_id, transaction_date, amount) 
    VALUES (UUID(), user_id, DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 30) DAY), RAND() * 1000);
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;
CALL insert_data_table10();

USE cube;
-- 予約語を使用したテーブルにもデータを挿入
DELIMITER $$
CREATE PROCEDURE insert_data_empty()
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= 1000 DO
    INSERT INTO empty (lead, of, rank) 
    VALUES (CONCAT('lead', i), CONCAT('of', i), CONCAT('rank', i));
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;
CALL insert_data_empty();
