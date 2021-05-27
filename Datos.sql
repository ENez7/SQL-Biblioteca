create database Parcial3

use Parcial3

create table Autores
(
	IdAutor char(10) not null,
	Nombre varchar(40) not null,
	Nacionalidad varchar(40) not null,
	constraint PKAutor primary key(IdAutor),
)
create table Libros
(
	IdLibro char(10) not null,
	Titulo varchar(40) not null,
	SubTitulo varchar(40),
	Editorial varchar(40) not null,
	Area varchar(30) not null,
	AnoPublicacion char(10) not null,
	TotalPaginas int not null,
	Edicion varchar(10) not null,
	constraint PKLibro primary key( IdLibro),
)
create table Estudiantes
(
	NroRegistro char(10) not null,
	CI varchar(20) not null,
	Nombre varchar(40) not null,
	Direccion varchar(40) not null,
	Telefono varchar(15) not null,
	Carrera varchar(20) not null,
	Edad int not null,
	constraint PKEstudiante primary key( NroRegistro),
)
create table Autorias
(
	IdAutor char(10) not null,
	IdLibro char(10) not null,
	constraint PkAutoria primary key(IdAutor,IdLibro),
	constraint FKAutor foreign key (IdAutor) references Autores,
	constraint FKLibros foreign key (IdLibro) references Libros,
)
create table Prestamos
(
	NroRegistro char(10) not null,
	IdLibro char(10) not null,
	FechaPrestamo date not null,
	FechaDebeDevolver date not null,
	FechaDevolucion date ,
	constraint PkPrestamo primary key(NroRegistro,IdLibro, FechaPrestamo),
	constraint FKEstudiante foreign key (NroRegistro) references Estudiantes,
	constraint FKLibro foreign key (IdLibro) references Libros,
)


insert into Autores values ('A1','Simon Fred','Espanola')
insert into Autores values ('A2','Federico Vau','Italiana')
insert into Autores values ('A3','Leonardo Vincenti','Francesa')
insert into Autores values ('A4','Juan de las Casas','Espanola')
insert into Autores values ('A5','Simon Bali','Argentina')
insert into Autores values ('A6','Stuart Russel','Inglesa')
insert into Autores values ('A7','Peter Norvig','Inglesa')

insert into Libros values ('L1','Amanecer','Infragante','Alfaguara','Literatura','1999','300','1 Edicion')
insert into Libros values ('L2','Fracciones','Matematica Basica','Aguilar','Matematica','1988','400','2 Edicion')
insert into Libros values ('L3','Segmentos','Por la vida','Alba','Literatura','1998','150','1 Edicion')
insert into Libros values ('L4','Crepusculo','Amanecer','Little','Literatura','2000','200','3 Edicion')
insert into Libros values ('L5','Ecuaciones','Algebra','Basic','Matematica','1999','150','1 Edicion')
insert into Libros values ('L6','Artificial Intelligence','A modern Approach','Pearson','IA','2010','1115','3 Edicion')



insert into Estudiantes values ('2019116341','6303655','Adriana Salmon','Barrio Las Misiones','75007873','Industrial','20')
insert into Estudiantes values ('2019112523','6087958','Maely Zambrana','Barrio Equipetrol','70879637','Industrial','19')
insert into Estudiantes values ('2019110518','6589637','Florencia Ramirez','Barrio Hamacas','77859637','Industrial','20')
insert into Estudiantes values ('2019110875','58963852','Fabio Arteaga','Barrio Palmito','78596398','Sistemas','21')
insert into Estudiantes values ('2019118796','47895263','Matias Aleman','Barrio Hamacas','75896348','Medicina','22')
insert into Estudiantes values ('92113281','3888186','Wilfredo Terrazas','Noorte La Molina','78528705','Sistemas','46')

insert into Autorias values ('A1','L3')
insert into Autorias values ('A2','L2')
insert into Autorias values ('A3','L2')
insert into Autorias values ('A4','L5')
insert into Autorias values ('A5','L1')
insert into Autorias values ('A6','L6')
insert into Autorias values ('A7','L6')

insert into Prestamos values ('2019116341','L2','2001-08-03','2001-08-07','2001-08-06')
insert into Prestamos values ('2019112523','L3','2001-09-10','2001-08-16','2001-08-14')
insert into Prestamos values ('2019118796','L5','2001-08-03','2001-08-07','2001-08-06')
insert into Prestamos values ('2019116341','L1','2001-05-01','2001-05-24','2001-05-28')
insert into Prestamos values ('2019110875','L4','2001-10-06','2001-10-19','2001-10-18')
insert into Prestamos values ('92113281','L6','2001-10-06','2001-10-19','2001-10-18')
insert into Prestamos  (NroRegistro, IdLibro, fechaPrestamo, FechaDebeDevolver) values ('2019118796','L4','2001-10-06','2001-10-19')
insert into Prestamos  (NroRegistro, IdLibro, fechaPrestamo, FechaDebeDevolver) values ('2019118796','L1','2001-10-06','2001-10-19')