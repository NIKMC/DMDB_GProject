--create tables
/*CREATE TABLE Enroll(
student_id integer,
ClassNumber_id integer,
grade varchar(2),
PRIMARY KEY (student_id, ClassNumber_id),
FOREIGN KEY (student_id) REFERENCES students (sid),
FOREIGN KEY (ClassNumber_id) REFERENCES class (ClassNumber)
)*/
drop table if exists LocationTaskApplicationUsers;
drop table if exists QuestionAnswerApplicationUsers;
drop table if exists QuestionLocationTaskApplicationUsers;
drop table if exists QuestionLocationTasks;
drop table if exists QuestionAnswers;
drop table if exists LocationTasks;
drop table if exists Messages;
drop table if exists FriendRequests;
drop table if exists UserFollowers;
drop table if exists Users;
drop table if exists Cities;

CREATE TABLE Cities(
Id 		        integer NOT NULL,
Name       	        varchar NULL,
Center_Latitude  	FLOAT (53)     DEFAULT ((0)) NOT NULL,
Center_Longitude 	FLOAT (53)     DEFAULT ((0)) NOT NULL,
CONSTRAINT PK_Cities PRIMARY KEY (Id)
);

CREATE TABLE Users(
Id 		       varchar(128) NOT NULL,
FirstName              varchar NULL,
LastName               varchar NULL,
Email                  varchar (256) NULL,
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
Id 		        integer NOT NULL,
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
Id 		        integer NOT NULL,
Task       	        varchar NOT NULL,
CityId 		integer     DEFAULT ((0)) NOT NULL,
Answer  	varchar     NOT NULL,
Difficulty  	varchar     NOT NULL,
Description 	varchar     NULL,
CONSTRAINT PK_QuestionAnswers PRIMARY KEY (Id),
CONSTRAINT FK_QuestionAnswers_Cities_CityId FOREIGN KEY (CityId) REFERENCES Cities (Id) ON DELETE CASCADE
);
CREATE TABLE QuestionLocationTasks(
Id 		        integer NOT NULL,
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
FromId 		       varchar(128) NOT NULL,
ToId 		       varchar(128) NOT NULL,
Id 		       varchar(128) NOT NULL,
Text		       varchar NULL,
Date 		       timestamp NOT NULL,
CONSTRAINT PK_Messages PRIMARY KEY (FromId, ToId, Id),
CONSTRAINT FK_Messages_Users_FromId FOREIGN KEY (FromId) REFERENCES Users (Id),
CONSTRAINT FK_Messages_Users_ToId FOREIGN KEY (ToId) REFERENCES Users (Id)
);

CREATE TABLE FriendRequests(
UserId			varchar(128) NOT NULL,
FollowerId		varchar(128) NOT NULL,
Viewed			boolean,
CONSTRAINT PK_Friendrequests PRIMARY KEY (UserId, FollowerId),
CONSTRAINT FK_Friendrequests_Users_UserId FOREIGN KEY (UserId) REFERENCES Users (Id) ON DELETE CASCADE,
CONSTRAINT FK_Friendrequests_Users_FollowerId FOREIGN KEY (FollowerId) REFERENCES Users (Id) ON DELETE CASCADE
);

CREATE TABLE UserFollowers(
UserId			varchar(128) NOT NULL,
FollowerId		varchar(128) NOT NULL,
CONSTRAINT PK_UserFollowers PRIMARY KEY (UserId, FollowerId),
CONSTRAINT FK_UserFollowers_Users_UserId FOREIGN KEY (UserId) REFERENCES Users (Id) ON DELETE CASCADE,
CONSTRAINT FK_UserFollowers_Users_FollowerId FOREIGN KEY (FollowerId) REFERENCES Users (Id) ON DELETE CASCADE
);

CREATE TABLE LocationTaskApplicationUsers(
Task_Id			integer NOT NULL,
User_Id		varchar(128) NOT NULL,
CONSTRAINT PK_LocationTaskApplicationUsers PRIMARY KEY (Task_Id, User_Id),
CONSTRAINT FK_LocationTaskApplicationUsers_Tasks_Task_Id FOREIGN KEY (Task_Id) REFERENCES LocationTasks (Id) ON DELETE CASCADE,
CONSTRAINT FK_LocationTaskApplicationUsers_Users_User_Id FOREIGN KEY (User_Id) REFERENCES Users (Id) ON DELETE CASCADE
);

CREATE TABLE QuestionAnswerApplicationUsers(
Task_Id		integer NOT NULL,
User_Id		varchar(128) NOT NULL,
CONSTRAINT PK_QuestionAnswerApplicationUsers PRIMARY KEY (Task_Id, User_Id),
CONSTRAINT FK_QuestionAnswerApplicationUsers_Tasks_Task_Id FOREIGN KEY (Task_Id) REFERENCES QuestionAnswers (Id) ON DELETE CASCADE,
CONSTRAINT FK_QuestionAnswerApplicationUsers_Users_User_Id FOREIGN KEY (User_Id) REFERENCES Users (Id) ON DELETE CASCADE
);

CREATE TABLE QuestionLocationTaskApplicationUsers(
Task_Id			integer NOT NULL,
User_Id		varchar(128) NOT NULL,
CONSTRAINT PK_QuestionLocationTaskApplicationUsers PRIMARY KEY (Task_Id, User_Id),
CONSTRAINT FK_QuestionLocationTaskApplicationUsers_Tasks_Task_Id FOREIGN KEY (Task_Id) REFERENCES QuestionLocationTasks (Id) ON DELETE CASCADE,
CONSTRAINT FK_QuestionLocationTaskApplicationUsers_Users_User_Id FOREIGN KEY (User_Id) REFERENCES Users (Id) ON DELETE CASCADE
);

/*-----------------------------------------------------------------------------*/

/*  selects Cities   */

SELECT * FROM Cities

SELECT Id, Name, Center_Latitude, Center_Longitude FROM Cities

SELECT * FROM Cities WHERE Id = '1'

SELECT Id, Name, Center_Latitude, Center_Longitude FROM Cities WHERE Id = '1'

INSERT INTO Cities VALUES (1, 'Ульяновск');
INSERT INTO Cities (Id, Name, Center_Latitude, Center_Longitude)
    VALUES (2, 'Innopolis', 0.1, 0.1);

INSERT INTO Cities VALUES (2, 'Innopolis', 0.55 , 0.55);

UPDATE Cities SET Name = 'Ульяновск', Center_Latitude = 0.55, Center_Longitude = 0.55
WHERE Id = 1;
UPDATE Cities SET Name = 'Ульяновск'
WHERE Id = 1;
UPDATE Cities SET Center_Latitude = 0.55, Center_Longitude = 0.55
WHERE Id = 1;

DELETE FROM Cities WHERE Id = 1;

/*  selects, insert, update, delete Users   */
/*Id 		       varchar(128) NOT NULL,
FirstName              varchar NULL,
LastName               varchar NULL,
Email                  varchar (256) NULL,
PasswordHash           varchar NULL,
LockoutEndDateUtc      timestamp        NULL,
UserName               varchar(256) NOT NULL,
Other                  varchar NULL,
LastLocation_Latitude  FLOAT (53)     DEFAULT ((0)) NOT NULL,
LastLocation_Longitude FLOAT (53)     DEFAULT ((0)) NOT NULL,
LastSeen               timestamp        DEFAULT ('1900-01-01T00:00:00.00') NOT NULL,
Level                  FLOAT (53)     DEFAULT ((0)) NOT NULL,
CityId                 INT            DEFAULT ((0)) NOT NULL,
*/
select * from Users

select Id, FirstName, LastName, Email, UserName, Other, LastLocation_Latitude, LastLocation_Longitude, Level from Users

select * from Users where CityId = '1'
select Id, FirstName, LastName, Email, UserName, Other, LastLocation_Latitude, LastLocation_Longitude, Level from Users where CityId = '1'

select * from Users where Id = '1'
select Id, FirstName, LastName, Email, UserName, Other, LastLocation_Latitude, LastLocation_Longitude, Level from Users where Id = '1'


INSERT INTO Users VALUES (1, 'Ivan','Nikitin','i.nikitin@innopolis.ru','NIKMC', 'Innopolis');
INSERT INTO Users VALUES (2, 'H','','nikmc10@mail.ru','Hummer', 'Ульяновск');
INSERT INTO Users VALUES (3, 'G','','nikmc10@yandex.ru','GHOST', 'Other');
INSERT INTO Users VALUES (4, 'qwerty','','qwerty@qwerty.ru','qwerty', 'Other');
INSERT INTO Users VALUES (5, 'hama','','hama@hama.ru','hama', 'Other');

INSERT INTO Users (Id, UserName, FirstName, LastName, Email, Other, CityId)
    VALUES (1, 'NIKMC', 'Ivan', 'Nikitin', 'i.nikitin@innopolis.ru','Innopolis', 2);
INSERT INTO Users (Id, UserName, FirstName, LastName, Email, Other, CityId)
    VALUES (2, 'Hummer', 'H','','nikmc10@mail.ru','Ульяновск - city', 1);
INSERT INTO Users (Id, UserName, FirstName, LastName, Email, Other, CityId)
    VALUES (3, 'GHOST', 'G','','nikmc10@yandex.ru','Other', 1);
INSERT INTO Users (Id, UserName, FirstName, LastName, Email, Other, CityId)
    VALUES (4, 'qwerty', 'G','','qwerty@qwerty.ru','qwerty', 1);
INSERT INTO Users (Id, UserName, FirstName, LastName, Email, Other, CityId)
    VALUES (5, 'hama', 'G','','hama@hama.ru','hama', 1);
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
		WHERE u1.userid = '1'
			AND followerid IN  (	SELECT userId
						FROM userfollowers
						WHERE followerId = u1.userid)) as friend_ids
	ON followerid = id
/*getFolowers doesnt work*/
select * from Users where Id = (select FollowerId from UserFollowers where UserId = '1')
select Id, FirstName, LastName, Email, UserName, Other, LastLocation_Latitude, LastLocation_Longitude, Level from Users  where Id = (select FollowerId from UserFollowers where UserId = '1')

INSERT INTO userfollowers 	(userid, followerid)
		VALUES		('1', '2');
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		('1', '3');
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		('1', '4');
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		('2', '1');
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		('3', '1');
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		('3', '2');
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		('2', '3');
INSERT INTO userfollowers 	(userid, followerid)
		VALUES		('5', '1');
		select * from Users



--followers list - doesnt work
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




/*  selects, insert, update, delete Messages   */
/*
FromId 		       varchar(128) NOT NULL,
ToId 		       varchar(128) NOT NULL,
Id 		       varchar(128) NOT NULL,
Text		       varchar NULL,
Date 		       timestamp NOT NULL,
*/
INSERT INTO Messages (Id, FromId, ToId, Text, Date)
    VALUES (1, 1, 2, 'Привет' , '2016-10-22 12:23:00');
INSERT INTO Messages (Id, FromId, ToId, Text, Date)
    VALUES (2, 2, 1, 'Привет' ,'2016-10-22 12:24:00');
INSERT INTO Messages (Id, FromId, ToId, Text, Date)
    VALUES (3, 1, 3, 'Hi' ,'2016-10-22 12:25:00');
INSERT INTO Messages (Id, FromId, ToId, Text, Date)
    VALUES (4, 1, 2, 'Как дела?' ,'2016-10-22 12:26:00');
INSERT INTO Messages (Id, FromId, ToId, Text, Date)
    VALUES (5, 1, 2, 'Что делаешь?' ,'2016-10-22 12:27:00');
INSERT INTO Messages (Id, FromId, ToId, Text, Date)
    VALUES (6, 2, 1, 'Работаю с БД' ,'2016-10-22 12:28:00');
INSERT INTO Messages (Id, FromId, ToId, Text, Date)
    VALUES (7, 3, 1, 'Hello' ,'2016-10-22 12:29:00');
INSERT INTO Messages (Id, FromId, ToId, Text, Date)
    VALUES (8, 1, 2, 'Работает?' ,'2016-10-22 12:30:00');
INSERT INTO Messages (Id, FromId, ToId, Text, Date)
    VALUES (9, 2, 3, 'Who are you?' ,'2016-10-22 12:31:00');
INSERT INTO Messages (Id, FromId, ToId, Text, Date)
    VALUES (10, 3, 2, 'Vasy?' ,'2016-10-22 12:32:00');
INSERT INTO Messages (Id, FromId, ToId, Text, Date)
    VALUES (11, 4, 1, 'hi man' ,'2016-10-22 12:33:00');
INSERT INTO Messages (Id, FromId, ToId, Text, Date)
    VALUES (12, 1, 5, 'FOr five' ,'2016-10-22 12:34:00');
/* getListMessage = Dialog - works*/
select * from Messages 
where FromId = '1' and ToId = '2' or FromId = '2' and ToId = '1'
ORDER by Date 

/* getListDialogs = Dialogs - works*/

--version 1
SELECT * FROM 
(
    SELECT DISTINCT ON (interlocutor) * FROM
    (
        SELECT Id, FromId, toId, text, date, fromid AS interlocutor FROM messages WHERE toId= '1'
        UNION ALL
        SELECT  Id, FromId, toId, text, date, toId AS interlocutor FROM messages WHERE fromId= '1'
    ) AS _t1
    ORDER BY interlocutor, date DESC
) AS _t2
ORDER BY date DESC;

--version 2 better
SELECT m1.* 
FROM Messages m1
WHERE (m1.fromid = '1' OR m1.toid = '1')
 AND m1.date >= ALL(SELECT m2.date
   FROM Messages m2
   WHERE LEAST(m2.fromid, m2.toid) || GREATEST(m2.fromid, m2.toid) = LEAST(m1.fromid, m1.toid) || GREATEST(m1.fromid, m1.toid))
ORDER BY m1.date DESC



/*  selects, insert, update, delete LocationTasks   */
/*
Id 		        integer     NOT NULL,
Task       	        varchar     NOT NULL,
Center_Latitude  	FLOAT (53)  NOT NULL,
Center_Longitude 	FLOAT (53)  NOT NULL,
Radius  		FLOAT (53)  NOT NULL,
CityId 			integer     NOT NULL,
Difficulty  		varchar     NOT NULL,
Description 		varchar     NULL,
*/
select * from LocationTasks

select Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description from LocationTasks

select * from LocationTasks where CityId IN (select CityId from Users where Id = '1')

select Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description 
from LocationTasks where CityId IN (select CityId from Users where Id = '1')

select * from LocationTasks where Id = '1'

select Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description 
from LocationTasks where Id = '1'


INSERT INTO Locationtasks (Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES (1, 'Посетите Политех', 54.3513933317246, 48.3873583518057, 350, 1, 'light', '');
INSERT INTO Locationtasks (Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES (2, 'Посетите Стачку', 54.3196205081769, 48.4062026768323, 90, 1, 'medium', '');
INSERT INTO Locationtasks (Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES (3, 'Посетите Innopolis', 0, 0, 0, 2, 'hard', '');


UPDATE LocationTasks SET Task = 'Ульяновск', Center_Latitude = '0.0', Center_Longitude = '0.0', 
Radius = '100', CityId = '1', Difficulty = 'hard', Description = ''
WHERE Id = 1;

UPDATE LocationTasks SET Center_Latitude = '0.0', Center_Longitude = '0.0', Radius = '100'
WHERE Id = 1;

UPDATE LocationTasks SET Center_Latitude = '0.0', Center_Longitude = '0.0',
WHERE Id = 1;

UPDATE LocationTasks SET Radius = '100' WHERE Id = 1;

UPDATE LocationTasks SET Task = 'Ульяновск2', Difficulty = 'hard', Description = ''
WHERE Id = 1;

DELETE FROM LocationTasks WHERE Id = 0;


INSERT INTO LocationTaskApplicationUsers VALUES (1,1), (3,1), (3, 2), (3,3);
INSERT INTO LocationTaskApplicationUsers VALUES (1,2);
--INSERT INTO LocationTaskApplicationUsers VALUES(2,1000), (3,1000), (1, 1), (2,1);
select * from LocationTaskApplicationUsers
/* get list Completed LocationTasks work */
--completed  tasks in user's city
SELECT *
FROM locationtasks JOIN (SELECT task_id
			FROM LocationTaskApplicationUsers AU JOIN locationtasks T ON AU.task_id=T.id JOIN users U ON U.id = AU.user_id
			WHERE user_id = '1'
				AND U.cityid = T.cityid
				) as completedTasksForUser
		ON task_id = id
--with city -- simplier
select * 
from locationTasks 
		where Id IN 
			(select task_id from locationTaskApplicationUsers where user_id = '1')
		and cityId IN 
			(select cityId from users where Id = '1')
--without city
select * from locationTasks where Id IN (select task_id from locationTaskApplicationUsers where user_id = '1')

/* get list UnCompleted LocationTasks work */
--offered (non-completed tasks)
SELECT T.*
FROM locationtasks T, users U
WHERE T.cityid = U.cityid
	AND U.id = '3' 						--userid
	AND T.id NOT IN	(SELECT task_id 
			FROM LocationTaskApplicationUsers 
			WHERE user_id = '3')	 		--userid



--end LocationTaskApplicationUsers 


/* QuestionLocationTasks
Id 		        integer NOT NULL,
Task       	        varchar NOT NULL,
Center_Latitude  	FLOAT (53)     NOT NULL,
Center_Longitude 	FLOAT (53)     NOT NULL,
Radius  	FLOAT (53)     NOT NULL,
CityId 		integer     DEFAULT ((0)) NOT NULL,
Difficulty  	varchar     NOT NULL,
Description 	varchar     NULL,
Answer  		varchar     NULL,
*/

select * from QuestionLocationTasks

select Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description, Answer from QuestionLocationTasks

select * from QuestionLocationTasks where CityId IN (select CityId from Users where Id = '1')

select Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description, Answer 
from QuestionLocationTasks where CityId IN (select CityId from Users where Id = '1')

select * from QuestionLocationTasks where Id = '1'

select Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description, Answer 
from QuestionLocationTasks where Id = '1'


INSERT INTO QuestionLocationTasks (Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES (1, 'Посетите Политех', 54.3513933317246, 48.3873583518057, 350, 1, 'light', 'В каком году был построен?');
INSERT INTO QuestionLocationTasks (Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES (2, 'Посетите Стачку', 54.3196205081769, 48.4062026768323, 90, 1, 'medium', 'Дата первой Стачки');
INSERT INTO QuestionLocationTasks (Id, Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description, Answer)
    VALUES (3, 'Посетите Innopolis', 0, 0, 0, 2, 'hard', 'Сколько кампусов?', '4');


UPDATE QuestionLocationTasks SET Task = 'Ульяновск', Center_Latitude = '0.0', Center_Longitude = '0.0', 
Radius = '100', CityId = '1', Difficulty = 'hard', Description = '', Answer = ''
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

Insert into QuestionLocationTaskApplicationUsers set (Tasks)

/* get list UnCompleted QuestionLocationTasks doesnt work */



/*-----------------------------------------------------------------------------*/
/*

CREATE TABLE [dbo].[Messages] (
    [FromId] NVARCHAR (128) NOT NULL,
    [ToId]   NVARCHAR (128) NOT NULL,
    [Id]     NVARCHAR (128) NOT NULL,
    [Text]   NVARCHAR (MAX) NULL,
    [Date]   DATETIME       NOT NULL,
    CONSTRAINT [PK_dbo.Messages] PRIMARY KEY CLUSTERED ([FromId] ASC, [ToId] ASC, [Id] ASC),
    CONSTRAINT [FK_dbo.Messages_dbo.AspNetUsers_FromId] FOREIGN KEY ([FromId]) REFERENCES [dbo].[AspNetUsers] ([Id]),
    CONSTRAINT [FK_dbo.Messages_dbo.AspNetUsers_ToId] FOREIGN KEY ([ToId]) REFERENCES [dbo].[AspNetUsers] ([Id])
);

CREATE TABLE [dbo].[AspNetUsers] (
    [Id]                     NVARCHAR (128) NOT NULL,
    [FirstName]              NVARCHAR (MAX) NULL,
    [LastName]               NVARCHAR (MAX) NULL,
    [Email]                  NVARCHAR (256) NULL,
    [EmailConfirmed]         BIT            NOT NULL,
    [PasswordHash]           NVARCHAR (MAX) NULL,
    [SecurityStamp]          NVARCHAR (MAX) NULL,
    [PhoneNumber]            NVARCHAR (MAX) NULL,
    [PhoneNumberConfirmed]   BIT            NOT NULL,
    [TwoFactorEnabled]       BIT            NOT NULL,
    [LockoutEndDateUtc]      DATETIME       NULL,
    [LockoutEnabled]         BIT            NOT NULL,
    [AccessFailedCount]      INT            NOT NULL,
    [UserName]               NVARCHAR (256) NOT NULL,
    [Other]                  NVARCHAR (MAX) NULL,
    [LastLocation_Latitude]  FLOAT (53)     DEFAULT ((0)) NOT NULL,
    [LastLocation_Longitude] FLOAT (53)     DEFAULT ((0)) NOT NULL,
    [LastSeen]               DATETIME       DEFAULT ('1900-01-01T00:00:00.000') NOT NULL,
    [Level]                  FLOAT (53)     DEFAULT ((0)) NOT NULL,
    [CityId]                 INT            DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.AspNetUsers_dbo.Cities_CityId] FOREIGN KEY ([CityId]) REFERENCES [dbo].[Cities] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [dbo].[Cities] (
    [Id]               INT            IDENTITY (1, 1) NOT NULL,
    [Name]             NVARCHAR (MAX) NULL,
    [Center_Latitude]  FLOAT (53)     DEFAULT ((0)) NOT NULL,
    [Center_Longitude] FLOAT (53)     DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_dbo.Cities] PRIMARY KEY CLUSTERED ([Id] ASC)
);
CREATE TABLE [dbo].[LocationTasks] (
    [Id]               INT            IDENTITY (1, 1) NOT NULL,
    [Task]             NVARCHAR (MAX) NULL,
    [Center_Latitude]  FLOAT (53)     NOT NULL,
    [Center_Longitude] FLOAT (53)     NOT NULL,
    [Radius]           FLOAT (53)     NOT NULL,
    [CityId]           INT            DEFAULT ((1)) NOT NULL,
    [Difficulty]       NVARCHAR (MAX) NULL,
    [Description]      NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.LocationTasks] PRIMARY KEY CLUSTERED ([Id] ASC)
);
CREATE TABLE [dbo].[QuestionAnswers] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Task]        NVARCHAR (MAX) NULL,
    [Description] NVARCHAR (MAX) NULL,
    [Answer]      NVARCHAR (MAX) NULL,
    [CityId]      INT            NOT NULL,
    [Difficulty]  NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.QuestionAnswers] PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [dbo].[QuestionLocationTasks] (
    [Id]               INT            IDENTITY (1, 1) NOT NULL,
    [Task]             NVARCHAR (MAX) NULL,
    [Description]      NVARCHAR (MAX) NULL,
    [Center_Latitude]  FLOAT (53)     NOT NULL,
    [Center_Longitude] FLOAT (53)     NOT NULL,
    [Radius]           FLOAT (53)     NOT NULL,
    [Answer]           NVARCHAR (MAX) NULL,
    [Difficulty]       NVARCHAR (MAX) NULL,
    [CityId]           INT            NOT NULL,
    CONSTRAINT [PK_dbo.QuestionLocationTasks] PRIMARY KEY CLUSTERED ([Id] ASC)
);

*/