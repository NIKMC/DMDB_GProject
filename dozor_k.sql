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
		VALUES('1000', 'ExploChamp', 'Ivan', 'Baranov', 'baran.sobaka@sb.com', 'weird', 2);

INSERT INTO	Users(Id, UserName, FirstName, LastName, Email, Other, CityId) 
		VALUES('1001', 'SlowPoke', 'Rimma', 'Turtle', 'speeda@sb.com', 'thunderbolt', 1000);

INSERT INTO	Users(Id, UserName, FirstName, LastName, Email, Other, CityId) 
		VALUES('1002', 'Liar', 'Guy', 'Ritchie', 'LockStock@TwoBarrels.com', 'filmmaker', 1001);

INSERT INTO	Users(Id, UserName, FirstName, LastName, Email, Other, CityId) 
		VALUES('1003', 'Dickens', 'David', 'Copperfield', 'illusionist@svn.com', 'invisible', 1000);

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

ALTER TABLE userfollowers ADD CONSTRAINT no_self_following CHECK (followerid != userid);

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

--friends list
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
		WHERE u1.userid = '1'
			AND NOT EXISTS (SELECT * 
					FROM userfollowers uf2 
					WHERE uf2.userid = u1.followerid
						AND uf2.followerid = u1.userid)) as follower_ids
	ON followerid = id

--subscriptions list
SELECT * 
FROM users JOIN (SELECT  userid
		FROM userfollowers u
		WHERE u.followerId = '1'	) as following_id
	ON userid = id

--end userfollowers

-- location tsks

INSERT INTO Locationtasks (Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES (1000, 'Visit ass', 100.1, 340.0, 0, 1000, 'easy', '');
INSERT INTO Locationtasks (Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES (1001, 'Visit market', 100.1, 340.0, 0, 1000, 'hard', '');



-- end location tasks

--LocationTaskApplicationUsers
INSERT INTO LocationTaskApplicationUsers VALUES(1,1000), (1,1001), (1001, 1), (1001,2);
INSERT INTO LocationTaskApplicationUsers VALUES(2,1000), (3,1000), (1, 1), (2,1);
INSERT INTO Locationtasks (Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES (1002, 'Посетите музей Ильича', 0, 0, 0, 1, 'hard', 'harley');
UPDATE  users
SET cityid = 1
WHERE id = '1000'

--completed  tasks in user's city
SELECT *
FROM locationtasks JOIN (SELECT task_id
			FROM LocationTaskApplicationUsers AU JOIN locationtasks T ON AU.task_id=T.id JOIN users U ON U.id = AU.user_id
			WHERE user_id = '1000'
				AND U.cityid = T.cityid
				) as completedTasksForUser
		ON task_id = id

--offered (non-completed tasks)
SELECT T.*
FROM locationtasks T, users U
WHERE T.cityid = U.cityid
	AND U.id = '1' 						--userid
	AND T.id NOT IN	(SELECT task_id 
			FROM LocationTaskApplicationUsers 
			WHERE user_id = '1')	 		--userid



--level update nigger

CREATE OR REPLACE FUNCTION UpdateExperienceFoo() RETURNS TRIGGER AS $UpdateExperience$
	DECLARE 
	taskdif VARCHAR;
	tdif DOUBLE PRECISION;
	BEGIN
		taskdif = (SELECT difficulty FROM locationtasks WHERE id = NEW.task_id);
		CASE taskdif
			WHEN 'light' THEN
				tdif = 0.1;
			WHEN 'medium' THEN
				tdif = 0.2;
			WHEN 'hard' THEN
				tdif = 0.3; 
			ELSE	tdif = 0;
		END CASE;
		UPDATE users SET level = level + tdif --(SELECT task_id FROM NEW) 
		WHERE id = NEW.user_id;
		RETURN NEW;
	END;
$UpdateExperience$ LANGUAGE plpgsql;

CREATE TRIGGER UpdateExperience 
	AFTER INSERT ON LocationTaskApplicationUsers
FOR EACH ROW EXECUTE PROCEDURE UpdateExperienceFoo()
--end nigger


--most unpopular tasks by cities
SELECT c.name, t.task, wrapped.count
FROM		(
		SELECT *, row_number() OVER (PARTITION BY cityid )
		FROM		(
				SELECT  l.cityid, l.id, COUNT(*) 
				FROM LocationTasks l JOIN  LocationTaskApplicationUsers lu ON l.id = lu.task_id
				GROUP BY l.id
				UNION
				SELECT  l.cityid, l.id, 0 count
				FROM LocationTasks l 
				WHERE NOT EXISTS (	SELECT *
							FROM LocationTaskApplicationUsers
							WHERE l.id = task_id
							) 
				ORDER BY id
				) as tc
		WHERE count =	(
				SELECT MIN(count)
				FROM	
						(
						SELECT  l.cityid, l.id, COUNT(*) 
						FROM LocationTasks l JOIN  LocationTaskApplicationUsers lu ON l.id = lu.task_id
						GROUP BY l.id
						UNION
						SELECT  l.cityid, l.id, 0 count
						FROM LocationTasks l 
						WHERE NOT EXISTS (	SELECT *
									FROM LocationTaskApplicationUsers
									WHERE l.id = task_id
									) 
						ORDER BY id
						) as tc1
				WHERE cityid = tc.cityid
				)
		) as wrapped
		JOIN cities c ON c.id = wrapped.cityid
		JOIN LocationTasks t ON t.id = wrapped.id
WHERE wrapped.row_number = 1

--


--end LocationTaskApplicationUsers 



SELECT c.name, COUNT(u.*) as ExperiencedPlayersNumber
FROM users u JOIN cities c ON u.cityid = c.id
WHERE u.level > 0
GROUP BY c.name
ORDER BY c.name



--most unpopular tasks by cities
SELECT c.name, t.task, wrapped.count
FROM		(
		SELECT *, row_number() OVER (PARTITION BY cityid )
		FROM		(
				SELECT  l.cityid, l.id, COUNT(*) 
				FROM LocationTasks l JOIN  LocationTaskApplicationUsers lu ON l.id = lu.task_id
				GROUP BY l.id
				UNION
				SELECT  l.cityid, l.id, 0 count
				FROM LocationTasks l 
				WHERE NOT EXISTS (	SELECT *
							FROM LocationTaskApplicationUsers
							WHERE l.id = task_id
							) 
				ORDER BY id
				) as tc
		WHERE count =	(
				SELECT MIN(count)
				FROM	
						(
						SELECT  l.cityid, l.id, COUNT(*) 
						FROM LocationTasks l JOIN  LocationTaskApplicationUsers lu ON l.id = lu.task_id
						GROUP BY l.id
						UNION
						SELECT  l.cityid, l.id, 0 count
						FROM LocationTasks l 
						WHERE NOT EXISTS (	SELECT *
									FROM LocationTaskApplicationUsers
									WHERE l.id = task_id
									) 
						ORDER BY id
						) as tc1
				WHERE cityid = tc.cityid
				)
		) as wrapped
		JOIN cities c ON c.id = wrapped.cityid
		JOIN LocationTasks t ON t.id = wrapped.id
WHERE wrapped.row_number = 1

--

--top unpopular tasks in user's city
SELECT  t.task, coalesce (COUNT(tu.*), 0) as times_complete
FROM LocationTasks t LEFT JOIN LocationTaskApplicationUsers tu ON t.id = tu.task_id 
WHERE t.cityid = (SELECT cityid FROM users WHERE id = '2')
GROUP BY t.id
HAVING coalesce (COUNT(tu.*), 0) < 5
ORDER BY times_complete ASC

--