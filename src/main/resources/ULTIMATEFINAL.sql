-- man skal lige tænke sig om med de første to, ellers skal man køre det hele
/*drop database tv3;
create database tv3;
use tv3; */
/*kig på datatyper ret for små fejl, kigge på not null og skemaer*/



/*implimentation*/
DROP PROCEDURE if exists add_new_journalist;
DROP TABLE IF EXISTS Item;
DROP TABLE IF EXISTS Edition;
DROP TABLE IF EXISTS Footage;
drop table if exists Journalistrole;
DROP TABLE IF EXISTS Topic;
DROP TABLE IF EXISTS telephone;
DROP TABLE IF EXISTS email;

DROP TABLE IF EXISTS Journalist;

CREATE TABLE Journalist 
	(
	CPR_num 			varchar(10) primary key,
	First_Name			text not null,
    Last_Name			text not null,
    Street_name			varchar(100),
    Civic_number		varchar(10),
    country 			varchar(30),
    zipcode				INT(4),
    CONSTRAINT valid_cpr CHECK (CPR_num REGEXP '^[0-9]{8,10}$')
	);
    

    create table telephone(
   CPR_num 			varchar(10),
    phone_number varchar(11) not null,
    
    FOREIGN KEY(CPR_num) REFERENCES Journalist(CPR_num) on delete cascade
    );
    
    
    create table email(
    CPR_num 			varchar(10),
    email text not null,
    
    FOREIGN KEY(CPR_num ) REFERENCES Journalist(CPR_num ) on delete cascade
    );
    

CREATE TABLE Edition (
    EditionID    	    VARCHAR(5) primary key,
    EditionDate  		date not null,
    EditionTime  	 	time(5) not null,
    CPR_num 			varchar(10) not null,
    ItemId       	 	VARCHAR(8) not null,
    Duration      		INT not null CHECK (Duration >= 0 AND Duration <= 1800),
    
    FOREIGN KEY(CPR_num) REFERENCES Journalist(CPR_num) on delete cascade
);
    
    
    CREATE TABLE Topic (
  TopicTitle 		  	varchar(255) primary key,
  TopicDesc 	  		TEXT NOT NULL
  
  );
  
  
  CREATE TABLE JournalistRole (
    CPR_num 			varchar(10),
    TopicTitle			varchar(255),
	JournalistRole  	enum("leader", "adviser", "correspondent", "journalist", "tech", "helper", "intern") NOT NULL,
    
    PRIMARY KEY (CPR_num, TopicTitle),
    FOREIGN KEY(CPR_num) REFERENCES Journalist(CPR_num) ON DELETE cascade,
    FOREIGN KEY(TopicTitle) REFERENCES Topic(TopicTitle) ON DELETE CASCADE

);


  CREATE TABLE Footage
	(
	 FootageTitle		varchar(50) primary key,
     FootageDate		varchar(30) not null,
	 Duration			INT not null CHECK (Duration >= 0 AND Duration <= 180) ,
     CPR_num 			varchar(10) not null,

	 FOREIGN KEY(CPR_num) REFERENCES Journalist(CPR_num) ON DELETE cascade
     );
     
     
     CREATE TABLE Item (
    ItemID 				varchar(8) primary key,
    EditionID    	    VARCHAR(5) not null,			
    ItemTime 			TIME NOT NULL,
    ItemDesc		 	text,
    TopicTitle 			TEXT NOT NULL,
    ItemViewers 		int,
    CPR_num				varchar(10) not null,
    
    FOREIGN KEY(EditionID) REFERENCES Edition(EditionID) ON DELETE cascade,
    FOREIGN KEY(CPR_num) REFERENCES Journalist(CPR_num) ON DELETE cascade
    
);
/*populatiion of the databse*/
     
INSERT INTO Journalist (CPR_num, First_Name, Last_Name, Street_name, Civic_number, country, zipcode) VALUES 
('0101901234', 'Maria', 'Andersen', 'Bredgade', '12', 'Denmark', '1200'),
('0202902345', 'Mikkel', 'Jensen', 'Nørrebrogade', '42', 'Denmark', '2200'),
('0303903456', 'Sofie', 'Pedersen', 'Vesterbrogade', '78', 'Denmark', '1620'),
('0404904567', 'Peter', 'Hansen', 'Amagerbrogade', '34', 'Denmark', '2300'),
('0505905678', 'Emilie', 'Rasmussen', 'Frederiksberg Allé', '56', 'Denmark', '1820'),
('0606906789', 'Anders', 'Madsen', 'Viborggade', '23', 'Denmark', '2200'),
('0707907890', 'Anne', 'Christensen', 'Østerbrogade', '98', 'Denmark', '2100'),
('0808908901', 'Mads', 'Sørensen', 'Hans Knudsens Plads', '4', 'Denmark', '2100'),
('0909909012', 'Lise', 'Nielsen', 'Værnedamsvej', '16', 'Denmark', '1819');

INSERT INTO telephone (cpr_num, phone_number) VALUES
	('0101901234', '+4545454545'),
	('0101901234', '+4512345678'),
    ('0202902345', '+4544345678'),
	('0303903456', '+4556781234'),
	('0303903456', '+4567891234'),
	('0303903456', '+4512345678'),
	('0404904567', '+4532109876'),
	('0505905678', '+4567890123'),
	('0606906789', '+4578901234'),
	('0707907890', '+4590123456'),
	('0808908901', '+4543210987'),
	('0909909012', '+4587654321');

INSERT INTO email (cpr_num, email) VALUES
	  ('0101901234', 'maria.andersen@tv3.dk'),
       ('0101901234', 'gingerlord.and.co@gmail.com'),
       ('0202902345', 'mikkel.jensen@tv3.dk'),
       ('0303903456', 'sofie.pedersen@tv3.dk'),
       ('0404904567', 'peter.hansen@tv3.dk'),
       ('0505905678', 'emilie.rasmussen@tv3.dk'),
       ('0505905678', 'thearchitect@master.com'),
       ('0606906789', 'anders.madsen@tv3.dk'),
       ('0606906789', 'anders.aggresiv@tv3.dk'),
       ('0707907890', 'anne.christensen@tv3.dk'),
       ('0808908901', 'mads.sørenseb@tv3.dk'),
       ('0909909012', 'lise.nielsen@tv3.dk');

 

INSERT INTO Topic (TopicTitle, TopicDesc) VALUES 
('Politics', 'News related to political events and activities'), 
('Entertainment', 'News related to celebrity gossip, movies, music, and TV shows'), 
('Sports', 'News related to sporting events and athletes'), 
('Business', 'News related to finance and the economy'), 
('Technology', 'News related to technological advancements and gadgets'), 
('Health', 'News related to health and wellness'), 
('Education', 'News related to schools, universities, and education policies'), 
('Environment', 'News related to the natural world and conservation efforts'), 
('Science', 'News related to scientific discoveries and advancements');

INSERT INTO JournalistRole (cpr_num, TopicTitle, JournalistRole) VALUES 
    ('0101901234', 'Politics', 'leader'),
    ('0101901234', 'Sports', 'adviser'),
    ('0101901234', 'Environment', 'correspondent'),
    ('0202902345', 'Politics', 'journalist'),
    ('0202902345', 'Sports', 'tech'),
    ('0202902345', 'Education', 'helper'),
    ('0303903456', 'Education', 'intern'),
    ('0303903456', 'Sports', 'leader'),
    ('0303903456', 'Business', 'adviser'),
    ('0404904567', 'Politics', 'correspondent'),
    ('0404904567', 'Sports', 'journalist'),
    ('0404904567', 'Science', 'tech'),
    ('0505905678', 'Health', 'helper'),
    ('0505905678', 'Sports', 'intern'),
    ('0505905678', 'Technology', 'leader'),
    ('0606906789', 'Education', 'adviser'),
    ('0606906789', 'Sports', 'correspondent'),
    ('0606906789', 'Business', 'journalist'),
    ('0707907890', 'Politics', 'tech'),
    ('0707907890', 'Sports', 'helper'),
    ('0707907890', 'Business', 'intern'),
    ('0808908901', 'Politics', 'leader'),
    ('0808908901', 'Health', 'adviser'),
    ('0808908901', 'Science', 'correspondent'),
    ('0909909012', 'Politics', 'journalist'),
    ('0909909012', 'Sports', 'tech'),
    ('0909909012', 'Technology', 'helper');

INSERT INTO Footage (FootageTitle, FootageDate, Duration, cpr_num) VALUES
('Breaking News: Fire in Downtown', '2022-01-01', 120, '0101901234'),
('Interview with Local Business Owner', '2022-01-02', 60, '0202902345'),
('Sports: Basketball Game Highlights', '2022-01-03', 180, '0303903456'),
('Politics: Press Conference with Mayor', '2022-01-04', 90, '0404904567'),
('Culture: Music Festival Recap', '2022-01-05', 120, '0505905678'),
('Business: Stock Market Report', '2022-01-06', 60, '0606906789'),
('Weather: Hurricane Coverage', '2022-01-07', 180, '0707907890'),
('Technology: New Smartphone Review', '2022-01-08', 90, '0808908901'),
('Science: Discoveries in Space Exploration', '2022-01-09', 120, '0808908901'),
('Breaking News: Robbery at Local Bank', '2022-01-10', 60, '0101901234'),
('Interview with Celebrity Chef', '2022-01-11', 180, '0101901234'),
('Sports: Football Game Highlights', '2022-01-12', 90, '0202902345'),
('Politics: Debate between Candidates', '2022-01-13', 120, '0303903456'),
('Culture: Art Exhibition Opening', '2022-01-14', 60, '0404904567'),
('Business: Economic Outlook for the Year', '2022-01-15', 180, '0505905678'),
('Weather: Snowstorm Coverage', '2022-01-16', 90, '0606906789'),
('Technology: New Gadgets Unveiled at Conference', '2022-01-17', 120, '0202902345'),
('Science: Breakthrough in Medical Research', '2022-01-18', 60, '0202902345'),
('Breaking News: Explosion at Factory', '2022-01-19', 180, '0303903456'),
('Interview with Bestselling Author', '2022-01-20', 90, '0202902345'),
('Sports: Baseball Game Highlights', '2022-01-21', 120, '0202902345'),
('Politics: Election Results Announced', '2022-01-22', 60, '0303903456'),
('Culture: Film Festival Awards Ceremony', '2022-01-23', 180, '0303903456'),
('Business: New Product Launch', '2022-01-24', 90, '0404904567'),
('Weather: Tornado Coverage', '2022-01-25', 120, '0505905678');

INSERT INTO Edition (EditionID, EditionDate, EditionTime, CPR_num, ItemId, Duration) VALUES
('ED001', '2022-01-01', '09:00:00', '0101901234', 'ITM00001', 120),
('ED002', '2022-01-01', '12:00:00', '0202902345', 'ITM00002', 60),
('ED003', '2022-01-02', '09:00:00', '0404904567', 'ITM00003', 90),
('ED004', '2022-01-02', '12:00:00', '0303903456', 'ITM00004', 1800),
('ED005', '2022-01-03', '09:00:00', '0606906789', 'ITM00005', 120),
('ED006', '2022-01-03', '12:00:00', '0808908901', 'ITM00006', 60),
('ED007', '2022-01-04', '09:00:00', '0909909012', 'ITM00007', 90),
('ED008', '2022-01-04', '12:00:00', '0707907890', 'ITM00008', 1800),
('ED009', '2022-01-05', '09:00:00', '0101901234', 'ITM00009', 120);


INSERT INTO Item (ItemID, EditionID, ItemTime, ItemDesc, TopicTitle, ItemViewers, CPR_num)
VALUES
('IT000001','ED001', '09:00:00', 'New report on climate change', 'Environment', 10000, '0101901234'),
('IT000002','ED002', '10:00:00', 'Interview with the CEO of a new startup', 'Business', 5000, '0202902345'),
('IT000003','ED003', '11:00:00', 'New study reveals benefits of meditation', 'Entertainment', 8000, '0303903456'),
('IT000004','ED004', '12:00:00', 'Controversial decision by local government', 'Politics', 9000, '0404904567'),
('IT000005','ED005', '13:00:00', 'New restaurant opens in downtown', 'Health', 6000, '0505905678'),
('IT000006','ED006', '14:00:00', 'Profile of a local artist', 'Science', 4000, '0606906789'),
('IT000007','ED001', '15:00:00', 'New findings on the effects of social media', 'Technology', 12000, '0707907890'),
('IT000008','ED002', '16:00:00', 'Latest developments on the stock market', 'Business', 7000, '0808908901'),
('IT000009','ED003', '17:00:00', 'Interview with a renowned author', 'Education', 3000, '0909909012'),
('IT000010','ED004', '18:00:00', 'Controversial decision by the federal government', 'Politics', 11000, '0101901234'),
('IT000011','ED005', '19:00:00', 'New research on a potential cure for cancer', 'Sports', 15000, '0101901234'),
('IT000012','ED006', '20:00:00', 'New exhibition at the local museum', 'Education', 4000, '0202902345'),
('IT000013','ED007', '21:00:00', 'Controversial art piece causes stir in the community', 'Health', 5000, '0303903456'),
('IT000014','ED008', '22:00:00', 'Interview with a local business owner', 'Business', 3000, '0404904567'),
('IT000015','ED009', '23:00:00', 'New developments in renewable energy', 'Environment', 8000, '0505905678'),
('IT000016','ED001', '09:00:00', 'Latest fashion trends for the season', 'Science', 7000, '0606906789'),
('IT000017','ED002', '10:00:00', 'Controversial decision by the state government', 'Politics', 9000, '0707907890'),
('IT000018','ED002', '11:00:00', 'New findings on the benefits of a plant-based diet', 'Sports', 10000, '0808908901');




/*queries*/

/*what journalist are raking in more views than half*/
select CPR_num, First_name, Last_name, avg(Itemviewers) from Item natural join journalist 
where Itemviewers > (select avg(Itemviewers) from Item)
GROUP BY CPR_num order by avg(Itemviewers) desc;
;

/*Show the top 5 hosts of editions that, overall, attracted the maximum number of views */
SELECT Journalist.First_Name, Journalist.Last_Name, SUM(Item.ItemViewers) AS Total_Viewers
FROM Journalist
JOIN Item ON Journalist.CPR_num = Item.CPR_num
GROUP BY Journalist.CPR_num
ORDER BY Total_Viewers DESC
LIMIT 5;

-- Show reporters whose footages were never broadcasted in the morning.
SELECT first_name, last_name, CPR_num
FROM journalist 
WHERE NOT EXISTS (
  SELECT 1 
  FROM item
  WHERE item.CPR_num = journalist.CPR_num AND item.itemtime >= '06:00:00' AND item.itemtime < '12:00:00'
);

/*Show Journalists ID, phone number and Email*/
SELECT Journalist.First_Name, Journalist.Last_Name, Journalist.CPR_num, GROUP_CONCAT(distinct telephone.phone_number), group_concat(distinct email.email)
FROM journalist
JOIN telephone ON Journalist.CPR_num = telephone.CPR_num
JOIN email ON Journalist.CPR_num = email.CPR_num
GROUP BY Journalist.CPR_num;

/*what topics have the most views*/
select TopicTitle, TopicDesc ,avg(Itemviewers) from Topic natural join Item
group by TopicTitle order by avg(Itemviewers) desc;

/*what journalist have been leaders*/
select CPR_num, First_name, Last_name from Journalist natural join Journalistrole
where JournalistRole="leader";

/*see list of person who have hosted most editions*/
SELECT CPR_num, First_name, Last_name, COUNT(CPR_num) 
FROM Edition natural JOIN Journalist
GROUP BY CPR_num order by COUNT(CPR_num) desc;

/*Identifying journalists who were both
curators and reporters, having shot at least
a footage that was used for a news item on
a topic they curated*/
SELECT DISTINCT j.CPR_num, j.First_Name, j.Last_Name
FROM Journalist j
JOIN Footage f ON j.CPR_num = f.CPR_num -- Combine Journalist table with Footage table
JOIN Item i ON j.CPR_num = i.CPR_num -- Combine Journalist table with Item table
JOIN JournalistRole jr ON j.CPR_num = jr.CPR_num AND i.TopicTitle = jr.TopicTitle -- Combine Journalist, Item, and JournalistRole table
WHERE jr.JournalistRole = 'leader'; -- Filter results to keep rows where the JournalistRole is 'leader'

-- For each topic, show the news item that attracted the maximum number of views.Works/
SELECT i.topictitle, i.ItemID, i.Itemviewers
FROM item i
JOIN (
  SELECT topictitle, MAX(Itemviewers) AS max_views
  FROM item
  GROUP BY topictitle
) m ON i.topictitle = m.topictitle AND i.Itemviewers = m.max_views;


-- Function that returns average item views, by journalist name as input

Delimiter //
CREATE FUNCTION get_avg_item_viewers(journalist_first_name VARCHAR(255))
RETURNS DECIMAL(10,2)
BEGIN
  DECLARE avg_item_viewers DECIMAL(10,2);

 SELECT AVG(ItemViewers) INTO avg_item_viewers
FROM Item a
JOIN Journalist j ON a.cpr_num = j.cpr_num
WHERE j.First_Name = journalist_first_name;

  IF avg_item_viewers IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Journalist not found';
    END IF;

  RETURN avg_item_viewers;
END //
delimiter ;

-- Function call
SELECT get_avg_item_viewers('mikkell') AS AverageViews, 
        (SELECT First_Name FROM Journalist WHERE first_name = 'mikkel') AS Name;



-- add new journalist procedure - adds to journalist, telephone, email, journalistRole tables
DELIMITER $$
CREATE PROCEDURE add_new_journalist (
    IN p_CPR_num VARCHAR(12),
    IN p_First_Name TEXT,
    IN p_Last_Name TEXT,
    IN p_Street_name VARCHAR(100),
    IN p_Civic_number VARCHAR(10),
    IN p_Country VARCHAR(30),
    IN p_Zipcode INT(4),
    IN p_Telephone JSON,
    IN p_email JSON,
    IN p_journalist_role JSON,
    IN p_Topic_title JSON
)

BEGIN
        DECLARE i INT DEFAULT 0;
        DECLARE j INT DEFAULT 0;
        DECLARE k INT DEFAULT 0;
        DECLARE phone_count INT DEFAULT JSON_LENGTH(p_Telephone);
        DECLARE email_count INT DEFAULT JSON_LENGTH(p_email);
        DECLARE journalist_role_count INT DEFAULT JSON_LENGTH(p_journalist_role);


    INSERT INTO Journalist (
        CPR_num, First_Name, Last_Name,
        Street_name, Civic_number, Country, Zipcode
    ) VALUES (
        p_CPR_num, p_First_Name, p_Last_Name,
        p_Street_name, p_Civic_number, p_Country, p_Zipcode
    );
        -- Loop through the phone numbers and insert them into the Telephone table
        
        WHILE i < phone_count DO
        INSERT INTO Telephone(CPR_num,phone_number)
            VALUES (p_CPR_num,JSON_EXTRACT(p_Telephone, CONCAT( '$[', i, ']')));
            set i=i+1;
        END WHILE;
        -- Loop through the email and insert them into the email table
        WHILE j < email_count DO
        INSERT INTO email(CPR_num,email)
            VALUES (p_CPR_num,JSON_UNQUOTE(JSON_EXTRACT(p_email, CONCAT('$[', j, ']'))));
            set j=j+1;
        END WHILE;
        
          -- Loop through the journalistrole and topic and insert them into the journlist table
        WHILE k < journalist_role_count DO
        INSERT INTO JournalistRole(CPR_num,JournalistRole,TopicTitle)
            VALUES (p_CPR_num,JSON_UNQUOTE(JSON_EXTRACT(p_journalist_role, CONCAT('$[', k, ']'))),JSON_UNQUOTE(JSON_EXTRACT(p_topic_title, CONCAT('$[', k, ']'))));
            set k=k+1;
        END WHILE;
	
END $$
DELIMITER ;

-- update statement
UPDATE journalist
SET civic_number = 23, Street_name='Voddervej', zipcode=6780
WHERE CPR_num = '0909909012';

-- delete statement
DELETE FROM journalist
WHERE cpr_num = '2702862512';


-- Trigger that creates a table journalistlog and adds a timestamp to that table everytime the procedure add_new_journalist is called.

-- Create table to log journalist inserts
CREATE TABLE journalistlog (
  CPR_num VARCHAR(12) NOT NULL,
  First_Name TEXT NOT NULL,
  Last_Name TEXT NOT NULL,
  Street_name VARCHAR(100) NOT NULL,
  Civic_number VARCHAR(10) NOT NULL,
  Country VARCHAR(30) NOT NULL,
  Zipcode INT(4) NOT NULL,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create trigger to insert new rows into journalistlog
DELIMITER //
CREATE TRIGGER journalist_after_insert
AFTER INSERT ON Journalist FOR EACH ROW
BEGIN
  INSERT INTO journalistlog (
    CPR_num, First_Name, Last_Name, Street_name,
    Civic_number, Country, Zipcode
  )
  VALUES (
    NEW.CPR_num, NEW.First_Name, NEW.Last_Name,
    NEW.Street_name, NEW.Civic_number, NEW.Country,
    NEW.Zipcode
  );
END //
DELIMITER ;

-- Select from journalistlog, to check if trigger works.
-- If all additions is to be shown, use this:
select * from journalistlog;







