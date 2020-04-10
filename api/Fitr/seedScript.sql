-- 
-- USERS
--
USE [Fitr]
GO

DELETE FROM [dbo].[AspNetUsers]

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

DELETE FROM [dbo].[Workouts]

INSERT INTO [dbo].[Workouts]
           ([Name]
           ,[UserId])
     VALUES
           ('Full body', '1100287a-fe90-442a-ba92-24d5bcddeeb1'),
		   ('Upper lower split', '1100287a-fe90-442a-ba92-24d5bcddeeb1'),
		   ('Push pull legs', '1100287a-fe90-442a-ba92-24d5bcddeeb1'),
		   ('5x5 workout', '1200287a-fe90-442a-ba92-24d5bcddeeb2'),
		   ('Warmup routine', '1200287a-fe90-442a-ba92-24d5bcddeeb2')
GO

