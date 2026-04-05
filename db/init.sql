use railway

CREATE TABLE IF NOT EXISTS users (
  id VARCHAR(36) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  role ENUM('viewer','analyst','admin') DEFAULT 'viewer',
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS records (
  id VARCHAR(36) PRIMARY KEY,
  user_id VARCHAR(36),
  amount DECIMAL(10,2) NOT NULL,
  type ENUM('income','expense') NOT NULL,
  category VARCHAR(100),
  date DATE,
  note TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS transaction_type (
  id INT AUTO_INCREMENT PRIMARY KEY,
  trans_type ENUM("INCOME","EXPENSE")
)

CREATE TABLE IF NOT EXISTS category(
  cat_id INT AUTO_INCREMENT PRIMARY KEY,
  category TEXT,
  trans_id INT,
  FOREIGN KEY (trans_id) REFERENCES transaction_type(id) ON DELETE CASCADE
)

INSERT INTO transaction_type (trans_type) VALUES ("INCOME"),
                                                 ("EXPENSE")

INSERT INTO category (category,trans_id) VALUES ("FOOD",2),
                                                ("ENTERTAINMENT",2),
                                                ("HEALTH",2),
                                                ("TRAVEL",2),
                                                ("CLOTHING",2),
                                                ("SALARY",1),
                                                ("RENTAL_INCOME",1),
                                                ("BUSINESS",1),
                                                ("INVESTMENTS",1);


INSERT INTO category (category,trans_id) VALUES ("OTHER",1),
                                                ("OTHER",2);

ALTER TABLE transactions DROP COLUMN date;
                                

                                ALTER TABLE users ADD COLUMN refresh_token TEXT;

ALTER TABLE users 
CHANGE COLUMN role role_id INT;

ALTER TABLE users 
ADD CONSTRAINT fk_user_role 
FOREIGN KEY (role_id) REFERENCES access_roles(id) 
ON DELETE CASCADE;

ALTER TABLE users MODIFY COLUMN role FOREIGN KEY (role_id) REFERENCES access_roles(id) ON DELETE CASCADE;

CREATE TABLE access_roles (
   id INT AUTO_INCREMENT PRIMARY KEY,
   role TEXT NOT NULL
);

INSERT INTO access_roles (role) VALUES ("ADMIN");
INSERT INTO access_roles (role) VALUES ("ANALYST");
INSERT INTO access_roles (role) VALUES ("CUSTOMER");


RENAME TABLE records TO transactions

ALTER TABLE transactions CHANGE COLUMN type type_id INT;
ALTER TABLE transactions 
ADD CONSTRAINT fk_transaction_type 
FOREIGN KEY (type_id) REFERENCES transaction_type(id) 
ON DELETE CASCADE;


ALTER TABLE transactions CHANGE COLUMN category category_id INT;
ALTER TABLE transactions 
ADD CONSTRAINT fk_category_type 
FOREIGN KEY (category_id) REFERENCES category(cat_id) 
ON DELETE CASCADE;



                                