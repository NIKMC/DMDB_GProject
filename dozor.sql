--drop tables

drop table if exists LocationTaskApplicationUsers;
drop table if exists QuestionAnswerApplicationUsers;
drop table if exists QuestionLocationTaskApplicationUsers;
drop table if exists QuestionLocationTasks;
drop table if exists QuestionAnswers;
drop table if exists LocationTasks;
drop table if exists Messages;
drop table if exists UserFollowers;
drop table if exists Users;
drop table if exists Cities;

--create tables

CREATE TABLE Cities(
Id 		        serial NOT NULL,
Name       	        varchar NULL,
Center_Latitude  	FLOAT (53)     DEFAULT ((0)) NOT NULL,
Center_Longitude 	FLOAT (53)     DEFAULT ((0)) NOT NULL,
CONSTRAINT PK_Cities PRIMARY KEY (Id)
);

CREATE TABLE Users(
Id 		        serial NOT NULL,
FirstName              varchar NULL,
LastName               varchar NULL,
Email                  varchar (256) NOT NULL,
PasswordHash           varchar NULL,
LockoutEndDateUtc      timestamp        NULL,
UserName               varchar(256) NOT NULL,
Other                  varchar NULL,
LastLocation_Latitude  FLOAT (53)     DEFAULT ((0)) NOT NULL,
LastLocation_Longitude FLOAT (53)     DEFAULT ((0)) NOT NULL,
LastSeen               timestamp        DEFAULT ('1900-01-01T00:00:00.00') NOT NULL,
Level                  FLOAT (53)     DEFAULT ((0)) NOT NULL,
CityId                 INT            DEFAULT ((0)) NOT NULL,
CONSTRAINT PK_Users PRIMARY KEY (Id),
CONSTRAINT FK_Users_Cities_CityId FOREIGN KEY (CityId) REFERENCES Cities (Id)
);


/*
CREATE TABLE Users(
Id 		       varchar(128) NOT NULL,
FirstName              varchar NULL,
LastName               varchar NULL,
Email                  varchar (256) NULL,
EmailConfirmed         BIT            NOT NULL,
PasswordHash           varchar NULL,
SecurityStamp          varchar NULL,
PhoneNumber            varchar NULL,
PhoneNumberConfirmed   BIT            NOT NULL,
TwoFactorEnabled       BIT            NOT NULL,
LockoutEndDateUtc      timestamp        NULL,
LockoutEnabled         BIT            NOT NULL,
AccessFailedCount      INT            NOT NULL,
UserName               varchar(256) NOT NULL,
Other                  varchar NULL,
LastLocation_Latitude  FLOAT (53)     DEFAULT ((0)) NOT NULL,
LastLocation_Longitude FLOAT (53)     DEFAULT ((0)) NOT NULL,
LastSeen               timestamp        DEFAULT ('1900-01-01T00:00:00.00') NOT NULL,
Level                  FLOAT (53)     DEFAULT ((0)) NOT NULL,
CityId                 INT            DEFAULT ((0)) NOT NULL,
CONSTRAINT PK_Users PRIMARY KEY (Id),
CONSTRAINT FK_Users_Cities_CityId FOREIGN KEY (CityId) REFERENCES Cities (Id)
);
*/

CREATE TABLE LocationTasks(
Id 		        serial NOT NULL,
Task       	        varchar NOT NULL,
Center_Latitude  	FLOAT (53)     NOT NULL,
Center_Longitude 	FLOAT (53)     NOT NULL,
Radius  	FLOAT (53)     NOT NULL,
CityId 		integer     DEFAULT ((0)) NOT NULL,
Difficulty  	varchar     NOT NULL,
Description 	varchar     NULL,
CONSTRAINT PK_LocationTasks PRIMARY KEY (Id),
CONSTRAINT FK_LocationTasks_Cities_CityId FOREIGN KEY (CityId) REFERENCES Cities (Id) ON DELETE CASCADE
);

CREATE TABLE QuestionAnswers(
Id 		        serial NOT NULL,
Task       	        varchar NOT NULL,
CityId 		integer     DEFAULT ((0)) NOT NULL,
Answer  	varchar     NOT NULL,
Difficulty  	varchar     NOT NULL,
Description 	varchar     NULL,
CONSTRAINT PK_QuestionAnswers PRIMARY KEY (Id),
CONSTRAINT FK_QuestionAnswers_Cities_CityId FOREIGN KEY (CityId) REFERENCES Cities (Id) ON DELETE CASCADE
);
CREATE TABLE QuestionLocationTasks(
Id 		        serial NOT NULL,
Task       	        varchar NOT NULL,
Center_Latitude  	FLOAT (53)     NOT NULL,
Center_Longitude 	FLOAT (53)     NOT NULL,
Radius  	FLOAT (53)     NOT NULL,
CityId 		integer     DEFAULT ((0)) NOT NULL,
Difficulty  	varchar     NOT NULL,
Description 	varchar     NULL,
Answer  		varchar     NULL,
CONSTRAINT PK_QuestionLocationTasks PRIMARY KEY (Id),
CONSTRAINT FK_QuestionLocationTasks_Cities_CityId FOREIGN KEY (CityId) REFERENCES Cities (Id) ON DELETE CASCADE
);

CREATE TABLE Messages(
FromId 		       integer NOT NULL,
ToId 		       integer NOT NULL,
Id 		       serial NOT NULL,
Text		       varchar NULL,
Date 		       timestamp NOT NULL,
CONSTRAINT PK_Messages PRIMARY KEY (FromId, ToId, Id),
CONSTRAINT FK_Messages_Users_FromId FOREIGN KEY (FromId) REFERENCES Users (Id),
CONSTRAINT FK_Messages_Users_ToId FOREIGN KEY (ToId) REFERENCES Users (Id)
);
/*
CREATE TABLE FriendRequests(
UserId			varchar(128) NOT NULL,
FollowerId		varchar(128) NOT NULL,
Viewed			boolean,
CONSTRAINT PK_Friendrequests PRIMARY KEY (UserId, FollowerId),
CONSTRAINT FK_Friendrequests_Users_UserId FOREIGN KEY (UserId) REFERENCES Users (Id) ON DELETE CASCADE,
CONSTRAINT FK_Friendrequests_Users_FollowerId FOREIGN KEY (FollowerId) REFERENCES Users (Id) ON DELETE CASCADE
);
*/
CREATE TABLE UserFollowers(
UserId			integer NOT NULL,
FollowerId		integer NOT NULL,
CONSTRAINT PK_UserFollowers PRIMARY KEY (UserId, FollowerId),
CONSTRAINT FK_UserFollowers_Users_UserId FOREIGN KEY (UserId) REFERENCES Users (Id) ON DELETE CASCADE,
CONSTRAINT FK_UserFollowers_Users_FollowerId FOREIGN KEY (FollowerId) REFERENCES Users (Id) ON DELETE CASCADE,
CONSTRAINT no_self_following CHECK (followerid != userid)
);

CREATE TABLE LocationTaskApplicationUsers(
Task_Id			integer NOT NULL,
User_Id			integer NOT NULL,
CONSTRAINT PK_LocationTaskApplicationUsers PRIMARY KEY (Task_Id, User_Id),
CONSTRAINT FK_LocationTaskApplicationUsers_Tasks_Task_Id FOREIGN KEY (Task_Id) REFERENCES LocationTasks (Id) ON DELETE CASCADE,
CONSTRAINT FK_LocationTaskApplicationUsers_Users_User_Id FOREIGN KEY (User_Id) REFERENCES Users (Id) ON DELETE CASCADE
);

CREATE TABLE QuestionAnswerApplicationUsers(
Task_Id		integer NOT NULL,
User_Id		integer NOT NULL,
CONSTRAINT PK_QuestionAnswerApplicationUsers PRIMARY KEY (Task_Id, User_Id),
CONSTRAINT FK_QuestionAnswerApplicationUsers_Tasks_Task_Id FOREIGN KEY (Task_Id) REFERENCES QuestionAnswers (Id) ON DELETE CASCADE,
CONSTRAINT FK_QuestionAnswerApplicationUsers_Users_User_Id FOREIGN KEY (User_Id) REFERENCES Users (Id) ON DELETE CASCADE
);

CREATE TABLE QuestionLocationTaskApplicationUsers(
Task_Id			integer NOT NULL,
User_Id			integer NOT NULL,
CONSTRAINT PK_QuestionLocationTaskApplicationUsers PRIMARY KEY (Task_Id, User_Id),
CONSTRAINT FK_QuestionLocationTaskApplicationUsers_Tasks_Task_Id FOREIGN KEY (Task_Id) REFERENCES QuestionLocationTasks (Id) ON DELETE CASCADE,
CONSTRAINT FK_QuestionLocationTaskApplicationUsers_Users_User_Id FOREIGN KEY (User_Id) REFERENCES Users (Id) ON DELETE CASCADE
);


/*-----------------------------------------------------------------------------*/
--INSERT
INSERT INTO Cities (Name) VALUES ('Ульяновск');
INSERT INTO Cities (Name, Center_Latitude, Center_Longitude)
    VALUES ('Innopolis', 0.1, 0.1);
INSERT INTO 	Cities (Id, Name, Center_Latitude, Center_Longitude)
		VALUES (1000, 'Manaus', 100.2, 340.221);

INSERT INTO 	Cities (Id, Name, Center_Latitude, Center_Longitude)
		VALUES (1001, 'Varasi', 100.2, 250.2);

INSERT INTO 	Cities (Id, Name, Center_Latitude, Center_Longitude)
		VALUES (1002, 'Monaco', 193.4, 222.2);

INSERT INTO 	Cities (Id, Name, Center_Latitude, Center_Longitude)
		VALUES (1003, 'Riga', 53.2, 102.8);
INSERT INTO 	Cities (Id, Name, Center_Latitude, Center_Longitude)
		VALUES (3, ‘Antananariva’, 123, 65.8);
INSERT INTO 	Cities (Id, Name, Center_Latitude, Center_Longitude)
		VALUES (5, ‘Khabul’, 123.4, 283.1);
INSERT INTO 	Cities (Id, Name, Center_Latitude, Center_Longitude)
		VALUES (4, ‘Sao Paolo’, 219.3, 261.1);
INSERT INTO 	Cities (Id, Name, Center_Latitude, Center_Longitude)
		VALUES (6, ‘Cusco’, 82.9, 202.4);
--end cities	




INSERT INTO Users (UserName, FirstName, LastName, Email, Other, CityId)
    VALUES ('NIKMC', 'Ivan', 'Nikitin', 'i.nikitin@innopolis.ru','Innopolis', 2);
INSERT INTO Users (UserName, FirstName, LastName, Email, Other, CityId)
    VALUES ('Hummer', 'H','','nikmc10@mail.ru','Ульяновск - city', 1);
INSERT INTO Users ( UserName, FirstName, LastName, Email, Other, CityId)
    VALUES ('GHOST', 'G','','nikmc10@yandex.ru','Other', 1);
INSERT INTO Users ( UserName, FirstName, LastName, Email, Other, CityId)
    VALUES ('qwerty', 'G','','qwerty@qwerty.ru','qwerty', 1);
INSERT INTO Users ( UserName, FirstName, LastName, Email, Other, CityId)
    VALUES ('hama', 'G','','hama@hama.ru','hama', 1);



INSERT INTO userfollowers 	(userid, followerid)
		VALUES		(1, 2);
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		(1, 3);
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		(1, 4);
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		(2, 1);
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		(3, 1);
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		(3, 2);
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		(2, 3);
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		(5, 1);
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		(1, 1000);
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		(1, 1001);
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		(1, 1002);
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		(3, 1003);
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		(2, 1001);
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		(3, 1002);
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		(1000, 1);
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		(1001, 1);




INSERT INTO Messages (FromId, ToId, Text, Date)
    VALUES (1, 2, 'Привет' , '2016-10-22 12:23:00');
INSERT INTO Messages (FromId, ToId, Text, Date)
    VALUES (2, 1, 'Привет' ,'2016-10-22 12:24:00');
INSERT INTO Messages (FromId, ToId, Text, Date)
    VALUES ( 1, 3, 'Hi' ,'2016-10-22 12:25:00');
INSERT INTO Messages (FromId, ToId, Text, Date)
    VALUES ( 1, 2, 'Как дела?' ,'2016-10-22 12:26:00');
INSERT INTO Messages (FromId, ToId, Text, Date)
    VALUES ( 1, 2, 'Что делаешь?' ,'2016-10-22 12:27:00');
INSERT INTO Messages (FromId, ToId, Text, Date)
    VALUES ( 2, 1, 'Работаю с БД' ,'2016-10-22 12:28:00');
INSERT INTO Messages (FromId, ToId, Text, Date)
    VALUES ( 3, 1, 'Hello' ,'2016-10-22 12:29:00');
INSERT INTO Messages (FromId, ToId, Text, Date)
    VALUES ( 1, 2, 'Работает?' ,'2016-10-22 12:30:00');
INSERT INTO Messages (FromId, ToId, Text, Date)
    VALUES ( 2, 3, 'Who are you?' ,'2016-10-22 12:31:00');
INSERT INTO Messages (FromId, ToId, Text, Date)
    VALUES ( 3, 2, 'Vasy?' ,'2016-10-22 12:32:00');
INSERT INTO Messages (FromId, ToId, Text, Date)
    VALUES ( 4, 1, 'hi man' ,'2016-10-22 12:33:00');
INSERT INTO Messages (FromId, ToId, Text, Date)
    VALUES ( 1, 5, 'FOr five' ,'2016-10-22 12:34:00');

INSERT INTO Locationtasks ( Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES ( 'Посетите Политех', 54.3513933317246, 48.3873583518057, 350, 1, 'light', '');
INSERT INTO Locationtasks ( Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES ( 'Посетите Стачку', 54.3196205081769, 48.4062026768323, 90, 1, 'medium', '');
INSERT INTO Locationtasks ( Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES ( 'Посетите Innopolis', 0, 0, 0, 2, 'hard', '');
INSERT INTO Locationtasks ( Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES ( 'Visit Bakhetle', 84, 3, 350, 2, 'light', 'have some food');
INSERT INTO Locationtasks ( Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES ( 'Find Water Supply Station', 113, 75, 3, 2, 'medium', 'take a run');
INSERT INTO Locationtasks ( Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES ( 'Reach the forest', 341, 12, 10, 2, 'hard', 'pick berries');
INSERT INTO Locationtasks ( Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES ( 'Climb the Eiffel Tower', 341, 12, 10, 1, 'hard', 'if it is there');
INSERT INTO Locationtasks ( Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES ( 'Collect 100 coconuts', 113, 90, 170, 3, 'medium', 'look upwards');
INSERT INTO Locationtasks ( Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES ( 'Climb the Eiffel Tower', 341, 12, 10, 3, 'hard', 'if it is there');
INSERT INTO Locationtasks ( Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES ( 'Amir Timur Museum', 89, 190.2, 1, 4, 'easy', 'try to find a free way in');
INSERT INTO Locationtasks ( Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES ( 'Swim across the Kazanka river', 192.4, 190.2, 1, 5, 'hard', 'Ask Michael Phelps how to')
INSERT INTO Locationtasks ( Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES ( 'Find Christo Monument', 89, 190.2, 1, 7, 'medium', 'reminds of something');




INSERT INTO LocationTaskApplicationUsers VALUES (1,1), (3,1), (3, 2), (3,3);
INSERT INTO LocationTaskApplicationUsers VALUES (1,2);
INSERT INTO LocationTaskApplicationUsers VALUES (1,4);

INSERT INTO QuestionLocationTasks ( Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES ( 'Посетите Политех', 54.3513933317246, 48.3873583518057, 350, 1, 'light', 'В каком году был построен?');
INSERT INTO QuestionLocationTasks ( Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description, Answer)
    VALUES ( 'Посетите Стачку', 54.3196205081769, 48.4062026768323, 90, 1, 'medium', 'Дата первой Стачки', '2012');
INSERT INTO QuestionLocationTasks ( Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description, Answer)
    VALUES ( 'Посетите Innopolis', 0, 0, 0, 2, 'hard', 'Сколько кампусов?', '4');

INSERT INTO QuestionLocationtasks ( Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description, Answer)
    VALUES ( 'Go to paintball playground', 89, 190.2, 1, 2, 'medium', 'What can you see on your left?’, 'A corpse');
INSERT INTO QuestionLocationtasks ( Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description, Answer)
    VALUES ( 'Visit golfclub', 233.3, 101.2, 1, 2, 'hard', 'How many kinds of clubs are available here?' '15');





INSERT INTO QuestionLocationTaskApplicationUsers VALUES (1,1), (3,1), (3, 2), (3,3);
INSERT INTO QuestionLocationTaskApplicationUsers VALUES (2,2);
INSERT INTO QuestionLocationTaskApplicationUsers VALUES (1,4);

INSERT INTO QuestionAnswers ( Task, CityId, Difficulty, Description, Answer)
    VALUES ( 'Посетите Политех', 1, 'light', 'В каком году был построен?', '');
INSERT INTO QuestionAnswers ( Task, CityId, Difficulty, Description, Answer)
    VALUES ( 'Посетите Стачку', 1, 'medium', 'Дата первой Стачки', '2012');
INSERT INTO QuestionAnswers ( Task, CityId, Difficulty, Description, Answer)
    VALUES ( 'Посетите Innopolis', 2, 'hard', 'Сколько кампусов?', '4');

INSERT INTO QuestionAnswerApplicationUsers VALUES (1,1), (3,1), (3, 2), (3,3);
INSERT INTO QuestionAnswerApplicationUsers VALUES (2,2);
INSERT INTO QuestionAnswerApplicationUsers VALUES (1,4);






/*  selects Cities   */

SELECT * FROM Cities

SELECT Id, Name, Center_Latitude, Center_Longitude FROM Cities

SELECT * FROM Cities WHERE Id = 1

SELECT Id, Name, Center_Latitude, Center_Longitude FROM Cities WHERE Id = 1

/*  selects, insert, update, delete Users   */
select * from Users
select Id, FirstName, LastName, Email, UserName, Other, LastLocation_Latitude, LastLocation_Longitude, Level from Users

select * from Users where CityId = 1
select Id, FirstName, LastName, Email, UserName, Other, LastLocation_Latitude, LastLocation_Longitude, Level from Users where CityId = 1

select * from Users where Id = 1
select Id, FirstName, LastName, Email, UserName, Other, LastLocation_Latitude, LastLocation_Longitude, Level from Users where Id = 1


--INSERT INTO Cities VALUES (2, 'Innopolis', 0.55 , 0.55);

UPDATE Cities SET Name = 'Ульяновск', Center_Latitude = 0.55, Center_Longitude = 0.55
WHERE Id = 1;
UPDATE Cities SET Name = 'Ульяновск'
WHERE Id = 1;
UPDATE Cities SET Center_Latitude = 0.55, Center_Longitude = 0.55
WHERE Id = 1;

DELETE FROM Cities WHERE Id = 1;



--INSERT INTO Users VALUES (1, 'Ivan','Nikitin','i.nikitin@innopolis.ru','NIKMC', 'Innopolis');
--INSERT INTO Users VALUES (2, 'H','','nikmc10@mail.ru','Hummer', 'Ульяновск');
--INSERT INTO Users VALUES (3, 'G','','nikmc10@yandex.ru','GHOST', 'Other');
--INSERT INTO Users VALUES (4, 'qwerty','','qwerty@qwerty.ru','qwerty', 'Other');
--INSERT INTO Users VALUES (5, 'hama','','hama@hama.ru','hama', 'Other');

UPDATE User SET FirstName = 'Ульяновск', 
LastName = 'Ульяновск', 
Email = 'Ульяновск', 
UserName = 'NIKMC',
Other = 'ADMIN'
WHERE Id = 1;

UPDATE User SET FirstName = 'Иван'
WHERE Id = 1;

UPDATE User SET LastName = 'Никитин'
WHERE Id = 1;

UPDATE User SET Email = 'nikmc10@gmail.com'
WHERE Id = 1;

UPDATE User SET UserName = 'NIKMC'
WHERE Id = 1;

UPDATE User SET Other = 'ADMIN'
WHERE Id = 1;

UPDATE User SET Level = '9.999'
WHERE Id = 1;

UPDATE User SET CityId = 1
WHERE Id = 1;

UPDATE User SET Center_Latitude = 0.55, Center_Longitude = 0.55
WHERE Id = 1;

DELETE FROM Users WHERE Id = 0;

/*getFriends doesnt work*/
--friends list
SELECT * 
FROM users JOIN (SELECT followerId
		FROM userfollowers u1
		WHERE u1.userid = 1
			AND followerid IN  (	SELECT userId
						FROM userfollowers
						WHERE followerId = u1.userid)) as friend_ids
	ON followerid = id
/*getFolowers doesnt work*/
select * from Users where Id = (select FollowerId from UserFollowers where UserId = 1)
select Id, FirstName, LastName, Email, UserName, Other, LastLocation_Latitude, LastLocation_Longitude, Level from Users  where Id = (select FollowerId from UserFollowers where UserId = 1)




--followers list - doesnt work
SELECT * 
FROM users JOIN (SELECT followerId
		FROM userfollowers u1
		WHERE u1.userid = 1	) as follower_ids
	ON followerid = id

--followers list
SELECT * 
FROM users JOIN (SELECT followerId
  FROM userfollowers u1
  WHERE u1.userid = 1
   AND NOT EXISTS (SELECT * 
     FROM userfollowers uf2 
     WHERE uf2.userid = u1.followerid
      AND uf2.followerid = u1.userid)) as follower_ids
 ON followerid = id

--subscriptions list
SELECT * 
FROM users JOIN (SELECT  userid
		FROM userfollowers u
		WHERE u.followerId = 1	) as following_id
	ON userid = id

--end userfollowers

SELECT * 
FROM users JOIN (SELECT userId
  FROM userfollowers u1
  WHERE u1.followerId = 1
   AND NOT EXISTS (SELECT * 
     FROM userfollowers uf2 
     WHERE uf2.userid = u1.followerid
      AND uf2.followerid = u1.userid)) as follower_ids
 ON userid = id


--select Top-50 users in the city
select Id, FirstName, LastName, Email, UserName, Other, LastLocation_Latitude, LastLocation_Longitude, Level, CityId
from Users where CityId = 1 
Order By Level desc, Username Asc
Limit 50;



/*  selects, insert, update, delete Messages   */

/* getListMessage = Dialog - works*/
select * from Messages 
where FromId = 1 and ToId = 2 or FromId = 2 and ToId = 1
ORDER by Date 

/* getListDialogs = Dialogs - works*/

--version 1
SELECT * FROM 
(
    SELECT DISTINCT ON (interlocutor) * FROM
    (
        SELECT Id, FromId, toId, text, date, fromid AS interlocutor FROM messages WHERE toId= 1
        UNION ALL
        SELECT  Id, FromId, toId, text, date, toId AS interlocutor FROM messages WHERE fromId= 1
    ) AS _t1
    ORDER BY interlocutor, date DESC
) AS _t2
ORDER BY date DESC;

--version 2 better
SELECT m1.* 
FROM Messages m1
WHERE (m1.fromid = 1 OR m1.toid = 1)
 AND m1.date >= ALL(SELECT m2.date
   FROM Messages m2
   WHERE LEAST(m2.fromid::text, m2.toid::text) || GREATEST(m2.fromid::text, m2.toid::text) = LEAST(m1.fromid::text, m1.toid::text) || GREATEST(m1.fromid::text, m1.toid::text))
ORDER BY m1.date DESC



/*  selects, insert, update, delete LocationTasks   */

select * from LocationTasks

select Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description from LocationTasks

select * from LocationTasks where CityId IN (select CityId from Users where Id = 1)

select Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description 
from LocationTasks where CityId IN (select CityId from Users where Id = 1)

select * from LocationTasks where Id = 1

select Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description 
from LocationTasks where Id = 1

--select Top-50 tasks in the city
select Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description from LocationTasks
where Id in (select Task_Id 
		from LocationTaskApplicationUsers 
		group by Task_id 
		order by count(User_Id) desc, Task_Id asc
	)
and CityId = 2
limit 50

--select Rating Task 
select Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description, (select Count(Task_Id) 
		from LocationTaskApplicationUsers
		where LocationTasks.Id = LocationTaskApplicationUsers.Task_id
		group by Task_id  ) AS Rating
from LocationTasks 
where CityId = 2
order by Rating desc


UPDATE LocationTasks SET Task = 'Ульяновск', Center_Latitude = '0.0', Center_Longitude = '0.0', 
Radius = '100', CityId = 1, Difficulty = 'hard', Description = ''
WHERE Id = 1;

UPDATE LocationTasks SET Center_Latitude = '0.0', Center_Longitude = '0.0', Radius = '100'
WHERE Id = 1;

UPDATE LocationTasks SET Center_Latitude = '0.0', Center_Longitude = '0.0',
WHERE Id = 1;

UPDATE LocationTasks SET Radius = '100' WHERE Id = 1;

UPDATE LocationTasks SET Task = 'Ульяновск2', Difficulty = 'hard', Description = ''
WHERE Id = 1;

DELETE FROM LocationTasks WHERE Id = 0;


--INSERT INTO LocationTaskApplicationUsers VALUES(2,1000), (3,1000), (1, 1), (2,1);
select * from LocationTaskApplicationUsers
/* get list Completed LocationTasks work */
--completed  tasks in user's city
SELECT *
FROM locationtasks JOIN (SELECT task_id
			FROM LocationTaskApplicationUsers AU JOIN locationtasks T ON AU.task_id=T.id JOIN users U ON U.id = AU.user_id
			WHERE user_id = 1
				AND U.cityid = T.cityid
				) as completedTasksForUser
		ON task_id = id
--with city -- simplier
select *
from locationTasks 
		where Id IN 
			(select task_id from locationTaskApplicationUsers where user_id = 1)
		and cityId IN 
			(select cityId from users where Id = 1)
--without city
select * from locationTasks where Id IN (select task_id from locationTaskApplicationUsers where user_id = 1)

/* get list UnCompleted LocationTasks work */
--offered (non-completed tasks)
SELECT T.*
FROM locationtasks T, users U
WHERE T.cityid = U.cityid
	AND U.id = 3 						--userid
	AND T.id NOT IN	(SELECT task_id 
			FROM LocationTaskApplicationUsers 
			WHERE user_id = 3)	 		--userid

--end LocationTaskApplicationUsers 


/* QuestionLocationTasks */

select * from QuestionLocationTasks

select Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description, Answer from QuestionLocationTasks

--for users
select Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description from QuestionLocationTasks

select * from QuestionLocationTasks where CityId IN (select CityId from Users where Id = 1)

select Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description, Answer 
from QuestionLocationTasks where CityId IN (select CityId from Users where Id = 1)

select * from QuestionLocationTasks where Id = 1

select Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description, Answer 
from QuestionLocationTasks where Id = 1

--select Top-50 tasks in the city
select Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description from QuestionLocationTasks
where Id in (select Task_Id 
		from QuestionLocationTaskApplicationUsers 
		group by Task_id 
		order by count(User_Id) desc, Task_Id asc
	)
and CityId = 1
limit 50

--select Rating Task 
select Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description, (select Count(Task_Id) 
		from QuestionLocationTaskApplicationUsers
		where QuestionLocationTasks.Id = QuestionLocationTaskApplicationUsers.Task_id
		group by Task_id  ) AS Rating
from QuestionLocationTasks 
where CityId = 1
order by Rating desc

UPDATE QuestionLocationTasks SET Task = 'Ульяновск', Center_Latitude = '0.0', Center_Longitude = '0.0', 
Radius = '100', CityId = 1, Difficulty = 'hard', Description = '', Answer = ''
WHERE Id = 1;

UPDATE QuestionLocationTasks SET Center_Latitude = '0.0', Center_Longitude = '0.0', Radius = '100'
WHERE Id = 1;

UPDATE QuestionLocationTasks SET Center_Latitude = '0.0', Center_Longitude = '0.0',
WHERE Id = 1;

UPDATE QuestionLocationTasks SET Radius = '100' WHERE Id = 1;

UPDATE QuestionLocationTasks SET Task = 'Ульяновск2', Difficulty = 'hard', Description = '', Answer = ''
WHERE Id = 1;

UPDATE QuestionLocationTasks SET Task = 'Ульяновск2', Description = '', Answer = ''
WHERE Id = 1;

DELETE FROM QuestionLocationTasks WHERE Id = 0;
/* get list Completed QuestionLocationTasks doesnt work */
--Insert into QuestionLocationTaskApplicationUsers set (Tasks)
--INSERT INTO QuestionLocationTaskApplicationUsers VALUES (1,2);

select * from QuestionLocationTaskApplicationUsers

/* get list Completed QuestionLocationTasks work */
--completed  tasks in user's city
SELECT *
FROM QuestionLocationTasks JOIN (SELECT task_id
			FROM QuestionLocationTaskApplicationUsers AU JOIN QuestionLocationTasks T ON AU.task_id=T.id JOIN users U ON U.id = AU.user_id
			WHERE user_id = 1
				AND U.cityid = T.cityid
				) as completedTasksForUser
		ON task_id = id
--with city -- simplier
select *
from QuestionLocationTasks 
		where Id IN 
			(select task_id from QuestionLocationTaskApplicationUsers where user_id = 1)
		and cityId IN 
			(select cityId from users where Id = 1)
--without city
select * from QuestionLocationTasks where Id IN (select task_id 
from QuestionLocationTaskApplicationUsers where user_id = 2)

/* get list UnCompleted QuestionLocationTasks work */
--offered (non-completed tasks)
SELECT T.Id, T.task, T.center_latitude, T.center_longitude, T.radius, T.cityId, T.difficulty, T.description
FROM QuestionLocationTasks T, users U
WHERE T.cityid = U.cityid
	AND U.id = 2 						--userid
	AND T.id NOT IN	(SELECT task_id 
			FROM QuestionLocationTaskApplicationUsers 
			WHERE user_id = 2)	 		--userid
--end QuestionLocationTaskApplicationUsers 



--QuestionAnswerApplicationUsers


/* QuestionAnswers */
/*
Id 		        integer NOT NULL,
Task       	        varchar NOT NULL,
CityId 		integer     DEFAULT ((0)) NOT NULL,
Answer  	varchar     NOT NULL,
Difficulty  	varchar     NOT NULL,
Description 	varchar     NULL,

 */
select * from QuestionAnswers

select Id, Task, CityId, Difficulty, Description, Answer from QuestionAnswers

--for users
select Id, Task, CityId, Difficulty, Description from QuestionAnswers

select * from QuestionAnswers where CityId IN (select CityId from Users where Id = 1)

select Id, Task, CityId, Difficulty, Description, Answer 
from QuestionAnswers where CityId IN (select CityId from Users where Id = 1)

select * from QuestionAnswers where Id = 1

select Id, Task, CityId, Difficulty, Description, Answer 
from QuestionAnswers where Id = 1

--select Top-50 tasks in the city
select Id, Task, CityId, Difficulty, Description from QuestionAnswers
where Id in (select Task_Id 
		from QuestionAnswerApplicationUsers 
		group by Task_id 
		order by count(User_Id) desc, Task_Id asc
	)
and CityId = 1
limit 50

--select Rating Task 
select Id, Task, CityId, Difficulty, Description, (select Count(Task_Id) 
		from QuestionAnswerApplicationUsers
		where QuestionAnswers.Id = QuestionAnswerApplicationUsers.Task_id
		group by Task_id  ) AS Rating
from QuestionAnswers 
where CityId = 1
order by Rating desc

UPDATE QuestionAnswers SET Task = 'Ульяновск', CityId = 1, Difficulty = 'hard', Description = '', Answer = ''
WHERE Id = 1;

UPDATE QuestionAnswers SET Difficulty = '', Description = '', Answer = ''
WHERE Id = 1;

UPDATE QuestionAnswers SET  Description = '', Answer = ''
WHERE Id = 1;

UPDATE QuestionAnswers SET Difficulty = '' WHERE Id = 1;

UPDATE QuestionAnswers SET Task = 'Ульяновск2', Difficulty = 'hard', Description = '', Answer = ''
WHERE Id = 1;

UPDATE QuestionAnswers SET Task = 'Ульяновск2', Description = '', Answer = ''
WHERE Id = 1;


DELETE FROM QuestionAnswers WHERE Id = 0;
--Insert into QuestionAnswerApplicationUsers set (Tasks)
--INSERT INTO QuestionAnswerApplicationUsers VALUES (1,2);
select * from QuestionAnswerApplicationUsers
--QuestionAnswers
/* get list Completed QuestionLocationTasks work */
--completed  tasks in user's city
SELECT Id, task, cityId, difficulty, description
FROM QuestionAnswers JOIN (SELECT task_id
			FROM QuestionAnswerApplicationUsers AU JOIN QuestionAnswers T ON AU.task_id=T.id JOIN users U ON U.id = AU.user_id
			WHERE user_id = 1
				AND U.cityid = T.cityid
				) as completedTasksForUser
		ON task_id = id
--with city -- simplier
select Id, task, cityId, difficulty, description
from QuestionAnswers 
		where Id IN 
			(select task_id from QuestionAnswerApplicationUsers where user_id = 1)
		and cityId IN 
			(select cityId from users where Id = 1)
--without city
select Id, task, cityId, difficulty, description from QuestionAnswers where Id IN (select task_id 
from QuestionAnswerApplicationUsers where user_id = 2)

/* get list UnCompleted QuestionAnswers work */
--offered (non-completed tasks)
SELECT T.Id, T.task, T.cityId, T.difficulty, T.description
FROM QuestionAnswers T, users U
WHERE T.cityid = U.cityid
	AND U.id = 2 						--userid
	AND T.id NOT IN	(SELECT task_id 
			FROM QuestionAnswerApplicationUsers 
			WHERE user_id = 2)	 		--userid
--end QuestionAnswers 



/*-----------------------------------------------------------------------------*/


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

/*-----------------------------------------------------------------------------*/

--level update trigger

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
--end trigger

/*-----------------------------------------------------------------------------*/

/*-----------------------------------------------------------------------------*/

--level update trigger

CREATE OR REPLACE FUNCTION UpdateExperienceFoo2() RETURNS TRIGGER AS $UpdateExperience2$
	DECLARE 
	taskdif VARCHAR;
	tdif DOUBLE PRECISION;
	BEGIN
		taskdif = (SELECT difficulty FROM questionlocationtasks WHERE id = NEW.task_id);
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
$UpdateExperience2$ LANGUAGE plpgsql;

CREATE TRIGGER UpdateExperience2 
	AFTER INSERT ON QuestionLocationTaskApplicationUsers
FOR EACH ROW EXECUTE PROCEDURE UpdateExperienceFoo2();
--end trigger

/*-----------------------------------------------------------------------------*/

/*-----------------------------------------------------------------------------*/

--level update trigger

CREATE OR REPLACE FUNCTION UpdateExperienceFoo3() RETURNS TRIGGER AS $UpdateExperience3$
	DECLARE 
	taskdif VARCHAR;
	tdif DOUBLE PRECISION;
	BEGIN
		taskdif = (SELECT difficulty FROM QuestionAnswers WHERE id = NEW.task_id);
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
$UpdateExperience3$ LANGUAGE plpgsql;

CREATE TRIGGER UpdateExperience3 
	AFTER INSERT ON QuestionAnswerApplicationUsers
FOR EACH ROW EXECUTE PROCEDURE UpdateExperienceFoo3()
--end trigger

/*-----------------------------------------------------------------------------*/

