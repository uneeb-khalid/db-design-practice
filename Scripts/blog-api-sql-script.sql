
--drop database blog_db

--create database blog_db

use blog_db


Create table users
(
	id int primary key not null identity(1,1),
	first_name varchar(100) not null,
	last_name varchar(100) not null,
	email varchar(500) not null,
	pass varchar(100) not null,
	creation_datetime datetime not null,
	last_edit datetime not null
	
);

Create table categories
(
	id int primary key not null identity(1,1),
	parent_id int null default null foreign key references Categories(id),
	category_name varchar(500) not null,
	last_edit datetime not null
);


Create table posts  
(
	id int primary key not null identity(1,1),
	category_id int not null foreign key references Categories(id),
	title nvarchar(1000) not null,
	introduction nvarchar(MAX) not null,
	body nvarchar(MAX) not null,
	summary nvarchar(MAX) not null,
	author_id int not null foreign key references Users(id),
	is_published bit not null default 0,
	publish_datetime datetime null default null,
	creation_datetime datetime not null,
	last_edit datetime not null,

);

Create table comments
(
	id int primary key not null identity(1,1),
	parent_id int null default null foreign key references Comments(id),
	content nvarchar(MAX) not null,
	user_id int not null foreign key references Users(id),
	post_id int not null foreign key references Posts(id),
	creation_datetime datetime not null,
	last_edit datetime not null
);



Create table tags
(
	id int primary key not null identity(1,1),
	tag_name varchar(500) not null,
	creation_datetime datetime not null,
	last_edit datetime not null
);

Create table posts_tags
(
	id int primary key not null identity(1,1),
	tag_id int not null foreign key references Tags(id),
	post_id int not null foreign key references Posts(id),
);


Create table metadata
(
	id int primary key not null identity(1,1),
	post_id int not null foreign key references Posts(id),
	meta_key varchar(1000) not null,
	content nvarchar(MAX) not null,
	last_edit datetime not null
);
