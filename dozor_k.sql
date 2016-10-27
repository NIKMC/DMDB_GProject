-—Messages
INSERT INTO Messages(fromid, toid, id, text, date) VALUES(‘3’, ‘1’, 1000, 'R U degenerate??', '2016-10-22 19:57:00')
INSERT INTO Messages(fromid, toid, id, text, date) VALUES(‘3’, ‘2’, 1001, 'Go tennis?', '2016-10-23 14:27:00')
INSERT INTO Messages(fromid, toid, id, text, date) VALUES('2', '3', 1002, 'Go gardening?', '2016-10-23 21:27:00')



SELECT m1.* 
FROM Messages m1
WHERE (m1.fromid = '3' OR m1.toid = '3')
	AND m1.date >= ALL(SELECT m2.date
			FROM Messages m2
			WHERE LEAST(m2.fromid, m2.toid) || GREATEST(m2.fromid, m2.toid) = LEAST(m1.fromid, m1.toid) || GREATEST(m1.fromid, m1.toid))
ORDER BY m1.date DESC



--end messages

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



--userfollowers

ALTER TABLE userfollowers ADD CONSTRAINT no_self_following CHECK (followerid != userid)

INSERT INTO userfollowers 	(userid, followerid)
		VALUES		('1', '1000');
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		('1', '1001');
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		('1', '1002');
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		('3', '1003');
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		('2', '1001');
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		('3', '1002');
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		('1000', '1');
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		('1001', '1');

—friends list
SELECT * 
FROM users JOIN (SELECT followerId
		FROM userfollowers u1
		WHERE u1.userid = '1'
			AND followerid IN  (	SELECT userId
						FROM userfollowers
						WHERE followerId = u1.userid)) as friend_ids
	ON followerid = id

--followers list
SELECT * 
FROM users JOIN (SELECT followerId
		FROM userfollowers u1
		WHERE u1.userid = '1'	) as follower_ids
	ON followerid = id

--subscriptions list
SELECT * 
FROM users JOIN (SELECT  userid
		FROM userfollowers u
		WHERE u.followerId = '1'	) as following_id
	ON userid = id

--end userfollowers