-—Messages

FROM messages m1 JOIN	(SELECT MAX(m2.date), m2.fromid, m2.toid
			FROM messages m2
			WHERE m2.toid = '1'
			--
			GROUP BY m2.fromid, m2.toid) AS maxDatedByFrom
			ON  m1.fromid = maxDatedByFrom.fromid AND m1.toid = maxDatedByFrom.toid AND m1.date = maxDatedByFrom.max
ORDER BY m1.date DESC


INSERT INTO Messages(fromid, toid, id, text, date) VALUES(3, 1, 1000, 'R U degenerate??', '2016-10-22 19:57:00')

—-end messages

--Users

INSERT INTO	Users(Id, UserName, FirstName, LastName, Email, Other, CityId) 
		VALUES('1000', 'ExploChamp', 'Ivan', 'Baranov', 'baran.sobaka@sb.com', 'weird', 2)

INSERT INTO	Users(Id, UserName, FirstName, LastName, Email, Other, CityId) 
		VALUES('1001', 'SlowPoke', 'Rimma', 'Turtle', 'speeda@sb.com', 'thunderbolt', 1000)

INSERT INTO	Users(Id, UserName, FirstName, LastName, Email, Other, CityId) 
		VALUES('1002', 'Liar', 'Guy', 'Ritchie', 'LockStock@TwoBarrels.com', 'filmmaker', 1001)

INSERT INTO	Users(Id, UserName, FirstName, LastName, Email, Other, CityId) 
		VALUES('1003', 'Dickens', 'David', 'Copperfield', 'illusionist@svn.com', 'invisible', 1000)

--end Users	

--Cities
INSERT INTO 	Cities (Id, Name, Center_Latitude, Center_Longitude)
		VALUES (1000, 'Manaus', 100.2, 340.221);

INSERT INTO 	Cities (Id, Name, Center_Latitude, Center_Longitude)
		VALUES (1001, 'Varasi', 100.2, 250.2);

INSERT INTO 	Cities (Id, Name, Center_Latitude, Center_Longitude)
		VALUES (1002, 'Monaco', 193.4, 222.2);

INSERT INTO 	Cities (Id, Name, Center_Latitude, Center_Longitude)
		VALUES (1003, 'Riga', 53.2, 102.8);
--end cities	