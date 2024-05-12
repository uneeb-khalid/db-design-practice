USE [blog_db]
GO

INSERT INTO [dbo].[Users]
           (
           [first_name]
           ,[last_name]
           ,[email]
           ,[pass]
           ,[creation_datetime]
           ,[last_edit])
     VALUES
           ('Max'
           ,'Mustermann'
           ,'max.mustermann@gmail.com'
           ,'pass12345'
           ,SYSDATETIME()
           ,SYSDATETIME())
GO


INSERT INTO [dbo].[Categories] VALUES  ( null, 'Electronics' ,SYSDATETIME())
INSERT INTO [dbo].[Categories] VALUES  ( null, 'Information Technology' ,SYSDATETIME())
INSERT INTO [dbo].[Categories] VALUES  (2, 'Big Data' ,SYSDATETIME())
INSERT INTO [dbo].[Categories] VALUES  (2, 'Internet Of Things'   ,SYSDATETIME())
INSERT INTO [dbo].[Categories] VALUES  (2, 'Artificial Intelligence'   ,SYSDATETIME())

select * from [Categories]
select * from [Categories] where category_name like '%Internet%'


INSERT INTO [dbo].[Tags]  VALUES ('SQL' ,SYSDATETIME()  ,SYSDATETIME())
INSERT INTO [dbo].[Tags]  VALUES ('NoSQL' ,SYSDATETIME()  ,SYSDATETIME())
INSERT INTO [dbo].[Tags]  VALUES ('MachineLearning' ,SYSDATETIME()  ,SYSDATETIME())
INSERT INTO [dbo].[Tags]  VALUES ('Transformers' ,SYSDATETIME()  ,SYSDATETIME())
INSERT INTO [dbo].[Tags]  VALUES ('NeuralNetwork' ,SYSDATETIME()  ,SYSDATETIME())
INSERT INTO [dbo].[Tags]  VALUES ('MQTT' ,SYSDATETIME()  ,SYSDATETIME())
INSERT INTO [dbo].[Tags]  VALUES ('ZigBee' ,SYSDATETIME()  ,SYSDATETIME())

select * from [Tags]
select * from [Users]


INSERT INTO [dbo].[Posts]
           ([category_id]
           ,[title]
           ,[introduction]
           ,[body]
           ,[summary]
           ,[author_id]
           ,[is_published]
           ,[publish_datetime]
           ,[creation_datetime]
           ,[last_edit])
VALUES  (4, 'My test post on Internet On Things'  ,'This is intro to IoT Blog Post'  ,'Test Post body'  ,'Test post Summary'  ,1 ,1 ,SYSDATETIME() ,SYSDATETIME() ,SYSDATETIME())
GO

INSERT INTO [dbo].[Posts]
           ([category_id]
           ,[title]
           ,[introduction]
           ,[body]
           ,[summary]
           ,[author_id]
           ,[is_published]
           ,[publish_datetime]
           ,[creation_datetime]
           ,[last_edit])
VALUES  (5, 'My test post on Artifical Intelligence'  ,'This is test post intro'  ,'Test Post body'  ,'Test post Summary'  ,1 ,1 ,SYSDATETIME() ,SYSDATETIME() ,SYSDATETIME())
GO

INSERT INTO [dbo].[Posts]
           ([category_id]
           ,[title]
           ,[introduction]
           ,[body]
           ,[summary]
           ,[author_id]
           ,[is_published]
           ,[publish_datetime]
           ,[creation_datetime]
           ,[last_edit])
VALUES  (3, 'My test post on Big Data'  ,'This is intro to IoT Blog Post'  ,'Test Post body'  ,'Test post Summary'  ,1 ,1 ,SYSDATETIME() ,SYSDATETIME() ,SYSDATETIME())
GO


select * from Posts 

INSERT INTO [dbo].[Posts_Tags]  ([tag_id] ,[post_id])  VALUES (6, 1)
INSERT INTO [dbo].[Posts_Tags]  ([tag_id] ,[post_id])  VALUES (7, 1)
INSERT INTO [dbo].[Posts_Tags]  ([tag_id] ,[post_id])  VALUES (3, 2)

select * from [Posts_Tags]


INSERT INTO [dbo].[Metadata]  VALUES   ((select id from Posts where title like '%Artifical%'), 'description' ,'This is the test post' ,SYSDATETIME())
INSERT INTO [dbo].[Metadata]  VALUES   (2, 'robots' ,'follow, index' ,SYSDATETIME())

INSERT INTO [dbo].[Metadata]  VALUES   (1, 'description' ,'This is the test post' ,SYSDATETIME())
INSERT INTO [dbo].[Metadata]  VALUES   (1, 'robots' ,'follow, index' ,SYSDATETIME())

select * from [Metadata]


INSERT INTO [dbo].[Comments]
           ([parent_id]
           ,[content]
           ,[user_id]
           ,[post_id]
           ,[creation_datetime]
           ,[last_edit])
     VALUES
           (null
           ,'This is test comment 1'
           ,1
           ,1
            ,SYSDATETIME()
           ,SYSDATETIME())


INSERT INTO [dbo].[Comments]
           ([parent_id]
           ,[content]
           ,[user_id]
           ,[post_id]
           ,[creation_datetime]
           ,[last_edit])
     VALUES
           (null
           ,'This is test comment 2'
           ,1
           ,1
            ,SYSDATETIME()
           ,SYSDATETIME())

INSERT INTO [dbo].[Comments]
           ([parent_id]
           ,[content]
           ,[user_id]
           ,[post_id]
           ,[creation_datetime]
           ,[last_edit])
     VALUES
           (1
           ,'This is the reply on test comment'
           ,1
           ,1
           ,SYSDATETIME()
           ,SYSDATETIME())

select * from [Comments] where post_id in ( select id from posts where title like '%Internet%' )


 -- Get all posts with category & user name   --

SELECT p.[id]
	  ,c.id as category_id
	  ,c.category_name
	  ,CONCAT(u.first_name, ' ', u.last_name) as 'User'
      ,p.[title]
      ,p.[introduction]
      ,p.[body]
      ,p.[summary]
      ,p.[author_id]
      ,p.[is_published]
      ,p.[publish_datetime]
      ,p.[creation_datetime]
      ,p.[last_edit]
  FROM [dbo].[posts] p
  JOIN [dbo].[categories] c on c.id = p.category_id
  JOIN [dbo].[users] u on u.id = p.author_id
  
  -- Get all posts with category & user name  by parent category --

SELECT p.[id]
	  ,c.id as category_id
	  ,c.category_name
	  ,CONCAT(u.first_name, ' ', u.last_name) as 'User'
      ,p.[title]
      ,p.[introduction]
      ,p.[body]
      ,p.[summary]
      ,p.[author_id]
      ,p.[is_published]
      ,p.[publish_datetime]
      ,p.[creation_datetime]
      ,p.[last_edit]
  FROM [dbo].[posts] p
  JOIN [dbo].[categories] c on c.id = p.category_id
  JOIN [dbo].[users] u on u.id = p.author_id
  Where c.id in (select id from categories where parent_id = 2)


-- Get All the tags by post id 

SELECT p.id, p.title, t.tag_name

	FROM  posts_tags pt
	JOIN [dbo].[tags] t on t.id = pt.tag_id
	JOIN [dbo].Posts p on p.id = pt.post_id
	Where p.id  = 1

	  -- Get all the meta data by post id

SELECT
	  p.id as post_id,
	  md.meta_key, 
	  md.content 
	 
	 FROM [dbo].Metadata md
	 JOIN [dbo].[posts] p  on md.post_id = p.id
  	 Where p.id  = 1

  -- Get all the comments by post id
SELECT
	c.id, 
	p.id as post_id,
	p.title,
	c.content, 
	c.creation_datetime
  FROM [dbo].[comments] c
  JOIN [dbo].Posts p on p.id = c.post_id
  where c.post_id = 1 and c.parent_id is null
  order by c.creation_datetime desc



    -- Get all the sub comments 
SELECT
	c.id, p.id as post_id, 
	c.content, 
	c.creation_datetime	
	FROM [dbo].[comments] c
	JOIN [dbo].Posts p on p.id = c.post_id
	where c.post_id = 1 and c.parent_id = 1
	order by c.creation_datetime desc

