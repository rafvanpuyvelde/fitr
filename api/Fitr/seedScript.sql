USE [Fitr]
GO

DELETE FROM [dbo].AspNetRoleClaims
DELETE FROM [dbo].AspNetRoles
DELETE FROM [dbo].AspNetUserClaims
DELETE FROM [dbo].AspNetUserLogins
DELETE FROM [dbo].AspNetUserRoles
DELETE FROM [dbo].AspNetUserTokens
DELETE FROM [dbo].Sets
DELETE FROM [dbo].Exercises
DELETE FROM [dbo].Sessions
DELETE FROM [dbo].WorkoutHasExercises
DELETE FROM [dbo].Workouts
DELETE FROM [dbo].AspNetUsers

-- 
-- USERS
--

INSERT INTO [dbo].[AspNetUsers]
           ([Id]
           ,[UserName]
           ,[NormalizedUserName]
           ,[Email]
           ,[NormalizedEmail]
           ,[EmailConfirmed]
           ,[PasswordHash]
           ,[SecurityStamp]
           ,[ConcurrencyStamp]
           ,[PhoneNumber]
           ,[PhoneNumberConfirmed]
           ,[TwoFactorEnabled]
           ,[LockoutEnd]
           ,[LockoutEnabled]
           ,[AccessFailedCount]
           ,[Name]
           ,[LastName])
     VALUES
           ('1100287a-fe90-442a-ba92-24d5bcddeeb1', 'JaneDoe123', 'JANEDOE123', 'jane.doe@test.com', 'JANE.DOE@TEST.COM', 0, 'AQAAAAEAACcQAAAAEA2j80uLZikDaLIGTIZoYD+V9O9FpeKBRrNpirjS+K5tWazVBoPozkXN731NT7OQ5Q==', 'BUM3233IQM6PDGJ3UJSGM5TMCVZRWN67', '0c895365-9152-464e-8c8b-f8ffa31ed0d3', null, 0, 0, null, 1, 0, 'Jane', 'Doe'),
		   ('1200287a-fe90-442a-ba92-24d5bcddeeb2', 'JohnDoe123', 'JOHNDOE123', 'john.doe@test.com', 'JOHN.DOE@TEST.COM', 0, 'AQAAAAEAACcQAAAAEA2j80uLZikDaLIGTIZoYD+V9O9FpeKBRrNpirjS+K5tWazVBoPozkXN731NT7OQ5Q==', 'BUM3233IQM6PDGJ3UJSGM5TMCVZRWN67', '0c895365-9152-464e-8c8b-f8ffa31ed0d3', null, 0, 0, null, 1, 0, 'John', 'Doe'),
           ('1300287a-fe90-442a-ba92-24d5bcddeeb3', 'JimDoe123', 'JIMDOE123', 'jim.doe@test.com', 'JIM.DOE@TEST.COM', 0, 'AQAAAAEAACcQAAAAEA2j80uLZikDaLIGTIZoYD+V9O9FpeKBRrNpirjS+K5tWazVBoPozkXN731NT7OQ5Q==', 'BUM3233IQM6PDGJ3UJSGM5TMCVZRWN67', '0c895365-9152-464e-8c8b-f8ffa31ed0d3', null, 0, 0, null, 1, 0, 'Jim', 'Doe')

GO

-- 
-- Workouts
--
SET IDENTITY_INSERT [dbo].[Workouts] ON

INSERT INTO [dbo].[Workouts]
           ([Id],[Name]
           ,[UserId]
		   ,[IsActive])
     VALUES
           (1, 'Full body', '1100287a-fe90-442a-ba92-24d5bcddeeb1', 1),
		   (2, 'Upper lower split', '1100287a-fe90-442a-ba92-24d5bcddeeb1', 0),
		   (3, 'Push pull legs', '1100287a-fe90-442a-ba92-24d5bcddeeb1', 0),
		   (4, '5x5 workout', '1200287a-fe90-442a-ba92-24d5bcddeeb2', 0),
		   (5, 'Warmup routine', '1200287a-fe90-442a-ba92-24d5bcddeeb2', 0)
GO

SET IDENTITY_INSERT [dbo].[Workouts] OFF

-- 
-- Exercises
--
SET IDENTITY_INSERT [dbo].[Exercises] ON

INSERT INTO [dbo].[Exercises]
           ([Id], [Name])
     VALUES
           (1, 'Bench press'),
		   (2, 'Squat'),
		   (3, 'Overhead press'),
		   (4, 'Tricep pushdown'),
		   (5, 'Lateral raise')
GO

SET IDENTITY_INSERT [dbo].[Exercises] OFF

-- 
-- WorkoutHasExercises
--
INSERT INTO [dbo].[WorkoutHasExercises]
           ([WorkoutId],
		   [ExerciseId])
     VALUES
           (1, 1),
		   (1, 2),
		   (1, 3),
		   (1, 4),
		   (1, 5)
GO

-- 
-- Sessions
--
SET IDENTITY_INSERT [dbo].[Sessions] ON

INSERT INTO [dbo].[Sessions]
           ([Id], [Date], [WorkoutId])
     VALUES
           (1, '01/07/2020 05:34:22 PM', 1),
		   (2, '02/27/2020 11:55:04 PM', 1),
		   (3, '04/11/2020 01:32:04 AM', 1)
GO

SET IDENTITY_INSERT [dbo].[Sessions] OFF

-- 
-- Sets
--
SET IDENTITY_INSERT [dbo].[Sets] ON

INSERT INTO [dbo].[Sets]
           ([Id], [ExerciseId], [Weight], [Unit], [UsesBands], [UsesChains], [Reps], [SessionId])
     VALUES
           (1, 1, 100.0, 0, 'false', 'false', 6, 1),
		   (2, 1, 100.0, 0, 'false', 'false', 6, 1),
		   (3, 1, 100.0, 0, 'false', 'false', 7, 1),

		   (4, 1, 101.0, 0, 'false', 'false', 6, 2),
		   (5, 1, 101.0, 0, 'false', 'false', 6, 2),
		   (6, 1, 101.0, 0, 'false', 'false', 6, 2),

		   (7, 1, 101.0, 0, 'false', 'false', 6, 3),
		   (8, 1, 101.0, 0, 'false', 'false', 7, 3),
		   (9, 1, 101.0, 0, 'false', 'false', 7, 3),


		   (10, 2, 120.0, 0, 'false', 'false', 6, 1),
		   (11, 2, 120.0, 0, 'false', 'false', 6, 1),
		   (12, 2, 120.0, 0, 'false', 'false', 7, 1),

		   (13, 2, 120.0, 0, 'false', 'false', 6, 2),
		   (14, 2, 120.0, 0, 'false', 'false', 6, 2),
		   (15, 2, 120.0, 0, 'false', 'false', 6, 2),

		   (16, 2, 120.0, 0, 'false', 'false', 6, 3),
		   (17, 2, 120.0, 0, 'false', 'false', 7, 3),
		   (18, 2, 120.0, 0, 'false', 'false', 7, 3),


		   (19, 3, 50.0, 0, 'false', 'false', 6, 1),
		   (20, 3, 50.0, 0, 'false', 'false', 6, 1),
		   (21, 3, 51.0, 0, 'false', 'false', 7, 1),

		   (22, 3, 51.0, 0, 'false', 'false', 6, 2),
		   (23, 3, 51.0, 0, 'false', 'false', 6, 2),
		   (24, 3, 51.0, 0, 'false', 'false', 6, 2),

		   (25, 3, 48.0, 0, 'false', 'false', 6, 3),
		   (26, 3, 48.0, 0, 'false', 'false', 7, 3),
		   (27, 3, 50.0, 0, 'false', 'false', 7, 3),


		   (28, 4, 30.0, 0, 'false', 'false', 10, 1),
		   (29, 4, 30.0, 0, 'false', 'false', 12, 1),
		   (31, 4, 30.0, 0, 'false', 'false', 15, 1),

		   (32, 4, 30.0, 0, 'false', 'false', 12, 2),
		   (33, 4, 30.0, 0, 'false', 'false', 12, 2),
		   (34, 4, 30.0, 0, 'false', 'false', 12, 2),

		   (35, 4, 30.0, 0, 'false', 'false', 15, 3),
		   (36, 4, 30.0, 0, 'false', 'false', 15, 3),
		   (37, 4, 30.0, 0, 'false', 'false', 15, 3),


		   (38, 5, 10.0, 0, 'false', 'false', 10, 1),
		   (39, 5, 10.0, 0, 'false', 'false', 10, 1),
		   (40, 5, 10.0, 0, 'false', 'false', 10, 1),

		   (41, 5, 10.0, 0, 'false', 'false', 12, 2),
		   (42, 5, 10.0, 0, 'false', 'false', 8, 2),
		   (43, 5, 10.0, 0, 'false', 'false', 10, 2),

		   (44, 5, 10.0, 0, 'false', 'false', 12, 3),
		   (45, 5, 10.0, 0, 'false', 'false', 12, 3),
		   (46, 5, 10.0, 0, 'false', 'false', 12, 3)
GO

SET IDENTITY_INSERT [dbo].[Sets] OFF