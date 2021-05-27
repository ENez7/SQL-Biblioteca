-- VERIFICACION DE LIBRO
alter procedure VerificarLibro 
	@IdLibro as char(10),
	@Respuesta as varchar(21) output
as
begin
	declare @cantidad as int
	SET NOCOUNT ON;
	select @cantidad = count(*) from dbo.Libros where IdLibro = @IdLibro
	if(@cantidad = 0)
	begin
		set @Respuesta = 'Libro no encontrado'
	end
	else
	begin
		set @Respuesta = 'Libro encontrado'
	end
end
go

-- VERIFICACION DE AUTOR/ES
alter procedure VerificarAutor 
	@IdAutor as char(10),
	@Respuesta as varchar(21) output
as
begin
	declare @cantidad as int
	SET NOCOUNT ON;
	select @cantidad = count(*) from dbo.Autores where IdAutor = @IdAutor
	if(@cantidad = 0)
	begin
		set @Respuesta = 'Autor no encontrado'
	end
	else
	begin
		set @Respuesta = 'Autor encontrado'
	end
end
go

-- VERIFICACION DE AUTORIAS
alter procedure VerificarAutoria 
	@IdAutor as char(10),
	@IdLibro as char(10),
	@Respuesta as varchar(21) output
as
begin
	declare @cantidad as int
	SET NOCOUNT ON;
	select @cantidad = count(*) from dbo.Autorias where IdAutor = @IdAutor and IdLibro = @IdLibro

	if @cantidad = 0
	begin
		set @Respuesta = 'Autoria no encontrada'
	end
	else
	begin
		set @Respuesta = 'Autoria encontrada'
	end
end
go

-- REGISTRAR LIBRO
alter procedure RegistrarLibro
	@IdLibro as char(10),
	@Titulo as varchar(40),
	@SubTitulo as varchar(40),
	@Editorial as varchar(40),
	@Area as varchar(30),
	@AnoPublicacion as char(10),
	@TotalPaginas as int,
	@Edicion as varchar(10),
	@Respuesta as varchar(16) output
as
begin

	insert into [dbo].[Libros]
           ([IdLibro], [Titulo] ,[SubTitulo] ,[Editorial] ,[Area], [AnoPublicacion], [TotalPaginas], [Edicion])
    values
           (@IdLibro, @Titulo, @SubTitulo, @Editorial, @Area, @AnoPublicacion, @TotalPaginas, @Edicion)
	set @Respuesta = 'Libro registrado'
end
go

-- REGISTRAR AUTOR
alter procedure RegistrarAutor
	@IdAutor as char(10),
	@Nombre as varchar(40),
	@Nacionalidad as varchar(40),
	@Respuesta as varchar(16) output
as
begin
	insert into [dbo].[Autores]
           ([IdAutor], [Nombre], [Nacionalidad])
     values
           (@IdAutor, @Nombre, @Nacionalidad)
	set @Respuesta = 'Autor registrado'
end
go

-- REGISTRAR AUTORIA
alter procedure RegistrarAutoria
	@IdAutor as char(10),
	@IdLibro as char(10),
	@Respuesta as varchar(20) output
as
begin
	insert into dbo.Autorias
			([IdAutor], [IdLibro])
	 values
			(@IdAutor, @IdLibro)
	set @Respuesta = 'Autoria registrada'
end
go
