-- ------------------------------------------------------------
-- LIBRARY MANAGEMENT SYSTEM DATABASE
-- ------------------------------------------------------------

CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

-- ------------------------------------------------------------
-- 1. LIBRARY
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS LIBRARY (
    license_no VARCHAR(20) PRIMARY KEY,
    library_name VARCHAR(100),
    contact_no VARCHAR(15)
);

INSERT INTO LIBRARY VALUES 
('LIC001', 'Central City Library', '9876543210'),
('LIC002', 'Greenfield Library', '9123456789'),
('LIC003', 'BlueSky Public Library', '9786541230'),
('LIC004', 'Townside Library', '9988776655'),
('LIC005', 'Northview Library', '9012345678'),
('LIC006', 'Silverline Library', '8899776655'),
('LIC007', 'Meadow Library', '9567843210'),
('LIC008', 'City Central Library', '9832145678'),
('LIC009', 'Lakeside Library', '9345678901'),
('LIC010', 'Sunshine Library', '9786547890'),
('LIC011', 'Hilltop Library', '9456123780'),
('LIC012', 'Golden Library', '9871203495'),
('LIC013', 'Riverbend Library', '9012765432'),
('LIC014', 'Downtown Library', '9345012765'),
('LIC015', 'Springwood Library', '9745612034');

-- ------------------------------------------------------------
-- 2. LIBRARIAN
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS LIBRARIAN (
    librarian_id INT PRIMARY KEY,
    librarian_name VARCHAR(100),
    contact_no VARCHAR(15),
    designation VARCHAR(50),
    license_no VARCHAR(20),
    lib_pass VARCHAR(255),
    FOREIGN KEY (license_no) REFERENCES LIBRARY(license_no)
);

INSERT INTO LIBRARIAN (librarian_id, librarian_name, contact_no, designation, license_no, lib_pass) VALUES
(1,'Anita Thomas','9123456789','Chief Librarian','LIC001', '$2y$10$bivyzJy9VgqWrD4oXGUsDeXEYmab6ILBMG8r5AdIPNDADKI4fOHa2'),
(2,'Ramesh Nair','9876501234','Assistant Librarian','LIC002', '$2y$10$NbKjUuoTSlPPLzmQvu/Xae3lCMYXS.OWnN6Apnx0XsFHM.iGB1yIK'),
(3,'Kavya Iyer','9090909090','Junior Librarian','LIC003', '$2y$10$f0UxKpZ1EeWuArltncY.V.CouSo.g7fJ05KSK0f/8yY1axkxNqa3u'),
(4,'Anoop Krishnan','9898123456','Senior Librarian','LIC004', '$2y$10$E6WSJ5oYh4FAEW/hj8CYu.P87NetcSrpfHztrMrj1tD5x0/7uI9TS'),
(5,'Suhas Kumar','9999911111','Assistant Librarian','LIC005', '$2y$10$bLgnd8pXKteo83tJvSnov.5I.JAi40hZm0UGad4RWC2U9JCCb3thS'),
(6,'Sneha Menon','9765432109','Chief Librarian','LIC006', '$2y$10$ple0KHaVGqyDD4jmxuMVRe2JS.DQO1JtUgOzVWhlx9sZxhkJ1YKuq'),
(7,'Ajay Raj','9345123456','Library Clerk','LIC007', '$2y$10$srOOa9zrm4u31ZjNX52QEukTB6wALXT2gTMmrx.ZB5bOPIyhH946C'),
(8,'Rekha Sharma','9456123001','Senior Librarian','LIC008', '$2y$10$MZYhQ6Eg/8igHHyNzX/Vk.FCVS2wa/ebjoEkhq293sq7pAyjfj0rK'),
(9,'Vivek Pillai','9234567890','Junior Librarian','LIC009', '$2y$10$dautYxqBpTza2yw4rLsdgeAgjLZdJd0HlMGOUyiv7VDCZrVT94wv6'),
(10,'Meera Das','9832145566','Library Clerk','LIC010', '$2y$10$fzHlPAv4GUq2lh16eQmCGuq9yl3kXhfcxCwO32T118lDJeA9a8bb.'),
(11,'Alok Varma','9654321789','Assistant Librarian','LIC011', '$2y$10$OLEJVRgeK4C8blCMBwS57eh3AX7FWkvlkn1Nvuq.AYOIaEX6emeJm'),
(12,'Deepa George','9745612789','Chief Librarian','LIC012', '$2y$10$E3JGBGmkT2bMIY2ECwhRe.wdJI1/tmv0kAalx5Hc2Os56aCFRGr66'),
(13,'Anu Prakash','9345678123','Senior Librarian','LIC013', '$2y$10$/SsLJE.h2k9N8./rIX1wpu.I.LOJXzLber53bzxE5JnlCnTYrwtCW'),
(14,'Ravi Mohan','9786543210','Junior Librarian','LIC014', '$2y$10$tM6iRMUM2aSNoYYe7UxgMOZe2Lq0b3sBWGWOmamkTecXwgy3KsJ16'),
(15,'Divya Nair','9876123456','Chief Librarian','LIC015', '$2y$10$eKOO79vFrdO3QzyUkFownOIiaArKWLw6AAWUfZJeN/fV66VZ4Sv.m');
-- ------------------------------------------------------------
-- 3. AUTHOR
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS AUTHOR (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100),
    author_genre VARCHAR(50),
    author_details TEXT,
    awards TEXT
);

INSERT INTO AUTHOR VALUES
(101,'Chetan Bhagat','Fiction','Indian author and columnist','Filmfare Award'),
(102,'J.K. Rowling','Fantasy','British author of Harry Potter','Multiple Awards'),
(103,'George R.R. Martin','Fantasy','Author of A Song of Ice and Fire','Hugo Award'),
(104,'Arundhati Roy','Drama','Indian author','Booker Prize'),
(105,'Ruskin Bond','Children','Indian author','Padma Shri'),
(106,'Dan Brown','Thriller','American author','Best Seller'),
(107,'Agatha Christie','Mystery','English author','Dame Commander'),
(108,'Paulo Coelho','Philosophy','Brazilian author','Golden Book Award'),
(109,'Stephen King','Horror','American author','Bram Stoker Award'),
(110,'Khaled Hosseini','Drama','Afghan-American author','South African Award'),
(111,'R.K. Narayan','Fiction','Indian author','Padma Vibhushan'),
(112,'Sudha Murthy','Motivational','Indian author and philanthropist','Padma Shri'),
(113,'Neil Gaiman','Fantasy','British author','Hugo Award'),
(114,'Robin Sharma','Self-help','Canadian writer and speaker','Global Best Seller'),
(115,'Amish Tripathi','Mythology','Indian author','Dainik Bhaskar Award');

-- ------------------------------------------------------------
-- 4. PUBLISHER
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PUBLISHER (
    publisher_code INT PRIMARY KEY,
    publisher_name VARCHAR(100),
    publisher_details TEXT
);

INSERT INTO PUBLISHER VALUES
(201,'Penguin Books','Leading international publisher'),
(202,'HarperCollins','American multinational publisher'),
(203,'Bloomsbury','British publishing house'),
(204,'Hachette India','Indian branch of French publisher'),
(205,'Rupa Publications','Indian publisher'),
(206,'Scholastic','Global children’s publisher'),
(207,'Macmillan','Educational publisher'),
(208,'Pearson','Academic publisher'),
(209,'Random House','Global publishing group'),
(210,'Westland Books','Indian publisher'),
(211,'Simon & Schuster','American publishing company'),
(212,'Orient BlackSwan','Academic publisher India'),
(213,'Oxford Press','University publisher'),
(214,'Vintage Books','Imprint of Random House'),
(215,'Srishti Publishers','Indian independent publisher');

-- ------------------------------------------------------------
-- 5. BOOKS
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS BOOKS (
    book_id INT PRIMARY KEY,
    book_name VARCHAR(150),
    publish_date DATE,
    author_id INT,
    book_price DECIMAL(10,2),
    book_status VARCHAR(30),
    no_of_stock INT,  -- Added column for stock quantity
    FOREIGN KEY (author_id) REFERENCES AUTHOR(author_id)
);

INSERT INTO BOOKS (book_id, book_name, publish_date, author_id, book_price, book_status, no_of_stock)
VALUES
(301, 'Half Girlfriend', '2014-10-01', 101, 299.00, 'Available', 12),
(302, 'Harry Potter and the Goblet of Fire', '2000-07-08', 102, 499.00, 'Issued', 8),
(303, '2 States', '2009-04-01', 101, 250.00, 'Available', 10),
(304, 'Harry Potter and the Philosopher''s Stone', '1997-06-26', 102, 450.00, 'Available', 15),
(305, 'The 3 Mistakes of My Life', '2008-05-10', 101, 280.00, 'Available', 9),
(306, 'Harry Potter and the Prisoner of Azkaban', '1999-07-08', 102, 470.00, 'Available', 11),
(307, 'Revolution 2020', '2011-10-01', 101, 320.00, 'Available', 7),
(308, 'Harry Potter and the Order of the Phoenix', '2003-06-21', 102, 520.00, 'Issued', 5),
(309, 'One Indian Girl', '2016-10-01', 101, 340.00, 'Available', 6),
(310, 'Harry Potter and the Chamber of Secrets', '1998-07-02', 102, 460.00, 'Available', 13),
(311, 'The Girl in Room 105', '2018-10-09', 101, 310.00, 'Available', 8),
(312, 'Harry Potter and the Half-Blood Prince', '2005-07-16', 102, 540.00, 'Available', 4),
(313, 'The Great Gatsby', '1925-04-10', 103, 380.00, 'Available', 10),
(314, 'To Kill a Mockingbird', '1960-07-11', 104, 400.00, 'Available', 9),
(315, '1984', '1949-06-08', 105, 350.00, 'Available', 12);

-- ------------------------------------------------------------
-- 6. MEMBER
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MEMBER (
    member_id INT PRIMARY KEY,
    name VARCHAR(100),
    member_type VARCHAR(50),
    address VARCHAR(255),
    contact_no VARCHAR(15),
    password VARCHAR(255) NOT NULL  
);

INSERT INTO MEMBER (member_id, name, member_type, address, contact_no, password) VALUES
(401,'Rahul Sharma','Student','New Delhi','9876501234','$2y$10$Ov0nqyH9UrLkiopswCZy.eqYN7hR2/E7JpvP.RsQ6H22Bbd2KhYfq'),
(402,'Priya Menon','Teacher','Kochi','9898123456','$2y$10$yLAFFJi5IQTR9zLjG643XOZByBWCf7nUWJnvv5zGKw98jjvw1GOUO'),
(403,'Arjun Das','Student','Chennai','9988776654','$2y$10$yxLuqXrZEpNOeC0AkqYgqOaz2RbZ23q8F2wa16.KlDsRbpgcLlbHe'),
(404,'Sneha Verma','Student','Mumbai','9123456798','$2y$10$/Z.WM8KCJWg/dLu/kKvNsu5YFxjYaryat1Jwn2uT9qTMDoCX6r5QC'),
(405,'Vikram Patel','Staff','Ahmedabad','9786543210','$2y$10$R75jJSyAZh4IJMPt9719Le.wTcb5Yg2Ubn3nXC1u8Du3.X5esmRnG'),
(406,'Anjali Rao','Student','Bangalore','9654321789','$2y$10$hDN57jLyHWX4YSW/BFHPveqsAQ31LLZdXJg.mZ.5ueZ8YcQW/gk06'),
(407,'Rohit Singh','Teacher','Jaipur','9876543211','$2y$10$LIaOEq4OfzLuXog4E.acOewyus4glxGKdAAIVpeSpKhoN2RucTctu'),
(408,'Pooja Nair','Student','Kollam','9765123489','$2y$10$7T9W4SnYLs8Ou9BNo5gIFeaJbdIGj0RHuHIKzcPCPmOAR58AFpsIW'),
(409,'Varun Menon','Student','Kottayam','9898456123','$2y$10$mLz4nSRu//Pr5Ta0MMqQ0.Kr4FkQxBhB.7SJ12Eb3rruOZ/XM1bSG'),
(410,'Megha Thomas','Student','Ernakulam','9012345671','$2y$10$fg.HChMjgiueZ52lKV/hZOYhU1LwNz3Q9GGXOfRKSbKkd4W1PrkBG'),
(411,'Gopal Pillai','Teacher','Thiruvananthapuram','9745612034','$2y$10$FEE0Uhk6uGCL5f0WTMQQ8uvL53/jj2uhCefEoSyq1VJoo7V1cseXa'),
(412,'Lina Joseph','Student','Coimbatore','9345678123','$2y$10$2rfXpzUMtAntradh.RWMzupzNciJ7QJKTPilcZwSCFyiPJkQV3iuq'),
(413,'Krishna Kumar','Staff','Madurai','9234567812','$2y$10$3OD2J215zN4hf3brG3DKT.77xt9PeWhnse1q170k4zU3YSawLcTdG'),
(414,'Deepthi Nair','Student','Palakkad','9988776655','$2y$10$q5GcY3s71PX1wgbbT6TQDOqPlOPRs.97X3MC.gvGFSaR5P19/76pi'),
(415,'Nikhil George','Student','Trivandrum','9567843210','$2y$10$XwXml.QnMrpnGi8.0uK9eeSquFZp7A8c6MHTyzCytB1LaTlr46V2W');

-- ------------------------------------------------------------
-- 7. BORROWS
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS BORROWS (
    borrow_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    book_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES MEMBER(member_id),
    FOREIGN KEY (book_id) REFERENCES BOOKS(book_id)
);

INSERT INTO BORROWS VALUES
(501,401,302,'2025-10-01','2025-10-15'),
(502,402,301,'2025-09-20','2025-09-30'),
(503,403,308,'2025-10-10',NULL),
(504,404,315,'2025-09-25','2025-10-05'),
(505,405,312,'2025-10-01',NULL),
(506,406,306,'2025-10-02','2025-10-12'),
(507,407,303,'2025-09-28','2025-10-10'),
(508,408,309,'2025-10-05',NULL),
(509,409,307,'2025-10-03','2025-10-13'),
(510,410,314,'2025-10-06','2025-10-16'),
(511,411,311,'2025-10-04','2025-10-14'),
(512,412,310,'2025-10-01','2025-10-15'),
(513,413,313,'2025-10-08','2025-10-18'),
(514,414,305,'2025-10-09',NULL),
(515,415,304,'2025-10-07','2025-10-17');

-- ------------------------------------------------------------
-- 8. FINE
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FINE (
    fine_id INT PRIMARY KEY,
    amount DECIMAL(10,2),
    status VARCHAR(20),
    member_id INT,
    FOREIGN KEY (member_id) REFERENCES MEMBER(member_id)
);

INSERT INTO FINE VALUES
(601,0.00,'Cleared',401),
(602,50.00,'Unpaid',402),
(603,0.00,'Cleared',403),
(604,100.00,'Unpaid',404),
(605,0.00,'Cleared',405),
(606,25.00,'Pending',406),
(607,75.00,'Unpaid',407),
(608,0.00,'Cleared',408),
(609,50.00,'Pending',409),
(610,0.00,'Cleared',410),
(611,20.00,'Cleared',411),
(612,0.00,'Cleared',412),
(613,10.00,'Unpaid',413),
(614,0.00,'Cleared',414),
(615,15.00,'Pending',415);

-- ------------------------------------------------------------
-- 9. ISSUED_BY
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ISSUED_BY (
    librarian_id INT,
    book_id INT,
    issue_date DATE,
    PRIMARY KEY (librarian_id, book_id),
    FOREIGN KEY (librarian_id) REFERENCES LIBRARIAN(librarian_id),
    FOREIGN KEY (book_id) REFERENCES BOOKS(book_id)
);

INSERT INTO ISSUED_BY VALUES
(1,302,'2025-10-01'),
(2,301,'2025-09-20'),
(3,308,'2025-10-10'),
(4,315,'2025-09-25'),
(5,312,'2025-10-01'),
(6,306,'2025-10-02'),
(7,303,'2025-09-28'),
(8,309,'2025-10-05'),
(9,307,'2025-10-03'),
(10,314,'2025-10-06'),
(11,311,'2025-10-04'),
(12,310,'2025-10-01'),
(13,313,'2025-10-08'),
(14,305,'2025-10-09'),
(15,304,'2025-10-07');

-- ------------------------------------------------------------
-- 10. MANAGES
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MANAGES (
    librarian_id INT,
    member_id INT,
    PRIMARY KEY (librarian_id, member_id),
    FOREIGN KEY (librarian_id) REFERENCES LIBRARIAN(librarian_id),
    FOREIGN KEY (member_id) REFERENCES MEMBER(member_id)
);

INSERT INTO MANAGES VALUES
(1,401),(2,402),(3,403),(4,404),(5,405),
(6,406),(7,407),(8,408),(9,409),(10,410),
(11,411),(12,412),(13,413),(14,414),(15,415);

-- ------------------------------------------------------------
-- 11. FINE_LOG
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FINE_LOG (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    fine_id INT,
    member_id INT,
    paid_on DATETIME,
    old_status VARCHAR(20),
    new_status VARCHAR(20) 
);