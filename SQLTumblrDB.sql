CREATE DATABASE TumblrDB
GO 
USE TumblrDB
GO
CREATE TABLE [Usuarios]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Nombre] NVARCHAR(50) NOT NULL UNIQUE,
	CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED ([Id])
)
GO

CREATE TABLE [Publicaciones]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Usuario] INT NOT NULL,
	[Contenido] NVARCHAR(280) NOT NULL,
	[Fecha] DATETIME NOT NULL DEFAULT GETDATE(),
	CONSTRAINT [PK_Publicacion] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_UsuarioPublicacion] FOREIGN KEY ([Usuario]) REFERENCES [Usuarios] ([Id]) ON DELETE No Action ON UPDATE No Action
)
GO 

CREATE PROCEDURE Proc_Create_Users
	@Nombre NVARCHAR(50)
AS 
BEGIN
	INSERT INTO [Usuarios]([Nombre]) 
	VALUES (@Nombre);
END
GO

CREATE PROCEDURE Proc_Create_Posts
	@Usuario INT,
	@Contenido NVARCHAR(280)
AS 
BEGIN
	INSERT INTO [Publicaciones]([Usuario],[Contenido])
	VALUES (@Usuario,@Contenido);
END
GO

CREATE PROCEDURE Proc_Get_Users
AS 
BEGIN
	SELECT [Id],
		[Nombre]
	FROM [Usuarios];
END
GO

CREATE PROCEDURE Proc_Get_Posts
AS 
BEGIN
	SELECT [Id],
		[Usuario],
		[Contenido],
		[Fecha]
	FROM [Publicaciones];
END
GO

CREATE PROCEDURE Proc_Modify_Users
	@Id INT,
	@Nombre NVARCHAR(50)
AS 
BEGIN
	UPDATE [Usuarios]
	SET [Nombre] = @Nombre
	WHERE [Id] = @Id
END
GO

CREATE PROCEDURE Proc_Modify_PostFromUserName
	@UsuarioId INT,
	@Contenido NVARCHAR(280)
AS 
BEGIN
	UPDATE [Publicaciones]
	SET [Contenido] = @Contenido
	WHERE [Usuario] = @UsuarioId
END
GO

CREATE PROCEDURE Proc_Delete_User_ByUsername
	@Nombre NVARCHAR(50)
AS
BEGIN 
	DELETE FROM [Usuarios]
	WHERE [Nombre] = @Nombre
END
GO

CREATE PROCEDURE Proc_Delete_User_ById
	@Id INT
AS
BEGIN 
	DELETE FROM [Usuarios]
	WHERE [Id] = @Id
END
GO

CREATE PROCEDURE Proc_Delete_PostById
	@Id INT
AS
BEGIN 
	DELETE FROM [Publicaciones]
	WHERE [Id] = @Id
END
GO