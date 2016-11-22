INSERT INTO Cities (Name, Center_Latitude, Center_Longitude)
    VALUES ('Ульяновск', 0.1, 0.1);
INSERT INTO Cities (Name, Center_Latitude, Center_Longitude)
    VALUES ('Innopolis', 0.1, 0.1);
INSERT INTO Users (UserName, FirstName, LastName, Email, Other, CityId, isAdmin)
    VALUES ('NIKMC', 'Ivan', 'Nikitin', 'i.nikitin@innopolis.ru','Innopolis', 2, 1);
INSERT INTO Users (UserName, FirstName, LastName, Email, Other, CityId)
    VALUES ('Hummer', 'H','','nikmc10@mail.ru','Ульяновск - city', 1);
INSERT INTO Users ( UserName, FirstName, LastName, Email, Other, CityId)
    VALUES ('GHOST', 'G','','nikmc10@yandex.ru','Other', 1);
INSERT INTO Users ( UserName, FirstName, LastName, Email, Other, CityId)
    VALUES ('qwerty', 'G','','qwerty@qwerty.ru','qwerty', 1);
INSERT INTO Users ( UserName, FirstName, LastName, Email, Other, CityId)
    VALUES ('hama', 'G','','hama@hama.ru','hama', 1);
INSERT INTO Users ( UserName, FirstName, LastName, Email, Other, CityId)
    VALUES ('StanislavStanislav', 'Stanislav','Nikitin','stas@nik.ru','qwerty', 2);
INSERT INTO Users ( UserName, FirstName, LastName, Email, Other, CityId)
    VALUES ('Frolow', 'Konstantin','Frollow','konstantin@frol.ru','hama', 2);

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

INSERT INTO LocationTaskApplicationUsers VALUES (1,1), (3,1), (3, 2), (3,3);
INSERT INTO LocationTaskApplicationUsers VALUES (1,2);
INSERT INTO LocationTaskApplicationUsers VALUES (1,4);

INSERT INTO QuestionLocationTasks ( Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description)
    VALUES ( 'Посетите Политех', 54.3513933317246, 48.3873583518057, 350, 1, 'light', 'В каком году был построен?');
INSERT INTO QuestionLocationTasks ( Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description, Answer)
    VALUES ( 'Посетите Стачку', 54.3196205081769, 48.4062026768323, 90, 1, 'medium', 'Дата первой Стачки', '2012');
INSERT INTO QuestionLocationTasks ( Task, Center_Latitude, Center_Longitude, Radius, CityId, Difficulty, Description, Answer)
    VALUES ( 'Посетите Innopolis', 0, 0, 0, 2, 'hard', 'Сколько кампусов?', '4');

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
