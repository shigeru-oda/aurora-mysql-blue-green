-- データベースを削除
DROP DATABASE db1;
-- 予約語を含むデータベース名を削除
DROP DATABASE cube;
-- データベースを作成
CREATE DATABASE IF NOT EXISTS db1;
-- 予約語を含むデータベース名を作成
CREATE DATABASE IF NOT EXISTS cube;