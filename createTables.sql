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
PasswordHash           varchar NOT NULL,
Salt			varchar NOT NULL,
LockoutEndDateUtc      timestamp        NULL,
UserName               varchar(256) NOT NULL,
Other                  varchar NULL,
LastLocation_Latitude  FLOAT (53)     DEFAULT ((0)) NOT NULL,
LastLocation_Longitude FLOAT (53)     DEFAULT ((0)) NOT NULL,
LastSeen               timestamp        DEFAULT ('1900-01-01T00:00:00.00') NOT NULL,
Level                  FLOAT (53)     DEFAULT ((0)) NOT NULL,
CityId                 INT            DEFAULT ((1)) NOT NULL,
IsAdmin			integer		DEFAULT ((0)) NOT NULL,
CONSTRAINT PK_Users PRIMARY KEY (Id),
CONSTRAINT FK_Users_Cities_CityId FOREIGN KEY (CityId) REFERENCES Cities (Id)
);

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

CREATE TABLE UserFollowers(
UserId			integer NOT NULL,
FollowerId		integer NOT NULL,
CONSTRAINT PK_UserFollowers PRIMARY KEY (UserId, FollowerId),
CONSTRAINT FK_UserFollowers_Users_UserId FOREIGN KEY (UserId) REFERENCES Users (Id) ON DELETE CASCADE,
CONSTRAINT FK_UserFollowers_Users_FollowerId FOREIGN KEY (FollowerId) REFERENCES Users (Id) ON DELETE CASCADE
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
