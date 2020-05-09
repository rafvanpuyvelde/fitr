DELETE FROM [dbo].AspNetRoleClaims
DELETE FROM [dbo].AspNetRoles
DELETE FROM [dbo].AspNetUserClaims
DELETE FROM [dbo].AspNetUserLogins
DELETE FROM [dbo].AspNetUserRoles
DELETE FROM [dbo].AspNetUserTokens
DELETE FROM [dbo].Exercises
DELETE FROM [dbo].Reps
DELETE FROM [dbo].Sessions
DELETE FROM [dbo].Sets
DELETE FROM [dbo].WorkoutHasExercises
DELETE FROM [dbo].Workouts
DELETE FROM [dbo].AspNetUsers

-- 
-- USERS
--
USE [Fitr]
GO

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
USE [Fitr]
GO

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
USE [Fitr]
GO

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
USE [Fitr]
GO

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