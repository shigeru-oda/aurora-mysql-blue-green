-- db1に10個のテーブルを作成
USE db1;

CREATE TABLE table1 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255),
  age INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX idx_name ON table1(name);

CREATE TABLE table2 (
  product_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  product_name VARCHAR(255),
  price DECIMAL(10, 2),
  stock INT
);
CREATE INDEX idx_product_name ON table2(product_name);

CREATE TABLE table3 (
  customer_id CHAR(36) PRIMARY KEY,
  customer_name VARCHAR(255),
  email VARCHAR(255),
  signup_date DATE
);
CREATE INDEX idx_customer_email ON table3(email);

CREATE TABLE table4 (
  order_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  customer_id CHAR(36),
  order_date DATE,
  total DECIMAL(12, 2),
  status ENUM('pending', 'shipped', 'delivered', 'cancelled')
);
CREATE INDEX idx_order_status ON table4(status);

CREATE TABLE table5 (
  event_id INT AUTO_INCREMENT PRIMARY KEY,
  event_name VARCHAR(255),
  event_date DATETIME,
  location VARCHAR(255),
  attendees INT
);
CREATE INDEX idx_event_date ON table5(event_date);

CREATE TABLE table6 (
  post_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255),
  content TEXT,
  published_at DATETIME,
  author VARCHAR(255)
);
CREATE INDEX idx_post_author ON table6(author);

CREATE TABLE table7 (
  comment_id INT AUTO_INCREMENT PRIMARY KEY,
  post_id BIGINT,
  content TEXT,
  commenter_name VARCHAR(255),
  comment_date DATETIME
);
CREATE INDEX idx_comment_post_id ON table7(post_id);

CREATE TABLE table8 (
  employee_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  department VARCHAR(255),
  hire_date DATE
);
CREATE INDEX idx_employee_name ON table8(first_name, last_name);

CREATE TABLE table9 (
  ticket_id INT AUTO_INCREMENT PRIMARY KEY,
  issue VARCHAR(255),
  opened_by VARCHAR(255),
  opened_at DATETIME,
  resolved_at DATETIME
);
CREATE INDEX idx_ticket_issue ON table9(issue);

CREATE TABLE table10 (
  transaction_id CHAR(36) PRIMARY KEY,
  user_id CHAR(36),
  transaction_date DATETIME,
  amount DECIMAL(10, 2)
);
CREATE INDEX idx_transaction_user_id ON table10(user_id);

-- 予約語を含むテーブル名を作成
USE cube;
CREATE TABLE empty (
  lag INT AUTO_INCREMENT PRIMARY KEY,
  lead VARCHAR(255),
  of VARCHAR(255),
  rank VARCHAR(255)
);
CREATE INDEX idx_reserved_select ON empty(lag);