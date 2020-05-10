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
DELETE FROM [dbo].Reps
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
		   (3, '04/11/2020 01:32:04 AM', 1),
		   (4, '03/19/2020 10:56:24 AM', 1),
		   (5, '04/06/2020 04:22:02 AM', 1)
GO

SET IDENTITY_INSERT [dbo].[Sessions] OFF

-- 
-- Sets
--
SET IDENTITY_INSERT [dbo].[Sets] ON

INSERT INTO [dbo].[Sets]
           ([Id], [ExerciseId], [Weight], [Unit], [UsesBands], [UsesChains])
     VALUES
           (1, 1, 84.0, 0, 'false', 'false'),
		   (2, 1, 80.0, 0, 'false', 'false'),
		   (3, 1, 100.0, 0, 'false', 'false'),
		   (4, 1, 101.0, 0, 'false', 'false'),
		   (5, 2, 100.0, 0, 'false', 'false'),
		   (6, 2, 105.0, 0, 'false', 'false'),
		   (7, 2, 100.0, 0, 'false', 'false'),
		   (8, 2, 106.0, 0, 'false', 'false'),
		   (9, 3, 58.0, 0, 'false', 'false'),
		   (10, 3, 58.0, 0, 'false', 'false'),
		   (11, 3, 60.0, 0, 'false', 'false'),
		   (12, 3, 61.0, 0, 'false', 'false'),
		   (13, 4, 30.0, 0, 'false', 'false'),
		   (14, 4, 31.0, 0, 'false', 'false'),
		   (15, 4, 32.0, 0, 'false', 'false'),
		   (16, 4, 32.0, 0, 'false', 'false'),
		   (17, 5, 10.0, 0, 'false', 'false'),
		   (18, 5, 11.0, 0, 'false', 'false'),
		   (19, 5, 10.0, 0, 'false', 'false'),
		   (20, 5, 12.0, 0, 'false', 'false')
GO

SET IDENTITY_INSERT [dbo].[Sets] OFF

-- 
-- Reps
--
SET IDENTITY_INSERT [dbo].[Reps] ON

INSERT INTO [dbo].[Reps]
           ([Id], [SetId], [ExerciseId], [Amount])
     VALUES
           (1, 1, 1, 12),
		   (2, 2, 1, 12),
		   (3, 3, 1, 12),
		   (4, 4, 1, 12),
		   (5, 5, 2, 6),
		   (6, 6, 2, 6),
		   (7, 7, 2, 6),
		   (8, 8, 2, 6),
		   (9, 9, 3, 3),
		   (10, 10, 3, 3),
		   (11, 11, 3, 3),
		   (12, 12, 3, 3),
		   (13, 13, 4, 12),
		   (14, 14, 4, 12),
		   (15, 15, 4, 12),
		   (16, 16, 4, 12),
		   (17, 17, 5, 15),
		   (18, 18, 5, 15),
		   (19, 19, 5, 15),
		   (20, 20, 5, 15)
GO

SET IDENTITY_INSERT [dbo].[Reps] OFF