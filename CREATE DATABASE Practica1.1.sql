CREATE DATABASE Practica1;

 CREATE DOMAIN dom_nombre AS VARCHAR(25) NOT NULL;

 CREATE DOMAIN dom_cedula AS VARCHAR(8) NOT NULL;

 CREATE DOMAIN dom_direccion AS VARCHAR(90) NOT NULL;

 CREATE DOMAIN dom_tlf AS VARCHAR(9); ----LOS TELEFONOS SON 9 DIGITOS SI OBVIAMOS EL 0----

 CREATE DOMAIN dom_pais AS VARCHAR(20) NOT NULL; --Para diferenciar nombres propios de nombres de paises--

 CREATE DOMAIN dom_titulo AS VARCHAR(40) NOT NULL; --Los nombres de pleiculas pueden llegar a ser bastante mas largos que los propios

 CREATE DOMAIN dom_statusCli AS TEXT
    CHECK(
        VALUE = 'A' OR          ---------------ACTIVO-----------
        VALUE = 'S' OR          --------------SUSPENDIDO--------
        VALUE = 'R'             ----------------RETIRADO----------
    ) NOT NULL;


 CREATE DOMAIN dom_statusP AS TEXT
    CHECK(
        VALUE = 'VI' OR          ---------------VIGENTE-----------
        VALUE = 'AT' OR          --------------ATRASADO--------
        VALUE = 'CR' OR          ----------------Cerrado con retraso----------
        VALUE = 'CD'           ------------Cerrado al dia----------------
    ) NOT NULL; 

 CREATE DOMAIN dom_fecha AS date

-----------TABLAS ANTES DE LOS CAMBIOS------------------

 CREATE TABLE Cliente(  
    NumCliente int,
    Cedula dom_cedula, --ESTO ES UNIQUE
    NombreC dom_nombre,
    DireccionC dom_direccion,
    TlfCelular dom_tlf,
    EstatusC dom_statusCli,
    FechaAfiliacion dom_fecha NOT NULL
);
ALTER TABLE Cliente ADD CONSTRAINT PK_NumCliente PRIMARY KEY(NumCliente);

ALTER TABLE Cliente ADD CONSTRAINT UQ_ClienteCedula UNIQUE(Cedula);
-------------------------------------------------------------------------------
 CREATE TABLE Estudio(
    IdEstudio int,
    NombreEstudio dom_nombre, --ESTO ES UNIQUE
    PaisUbicacion dom_pais
);

ALTER TABLE Estudio ADD COINSTRAINT PK_IdEstudio PRIMARY KEY(IdEstudio);

ALTER TABLE Estudio ADD CONSTRAINT UQ_NombreEstudio(NombreEstudio);

-------------------------------------------------------------------------
 CREATE TABLE Actor(
    IdActor int,
    NombreActor dom_nombre,
    Nacionalidad dom_pais
);

ALTER TABLE ADD CONSTRAINT PK_IdActor PRIMARY KEY(IdActor);

-----------------------------------------------------------------------------
CREATE TABLE Pelicula(
    IdPelicula int,
    Titulo dom_titulo,
    IdEstudio int,
    FechaInclusion dom_fecha NOT NULL,
    FechaDesincorporacion dom_fecha ----NO ES OBLIGATORIA
); 

ALTER TABLE Pelicula ADD COINSTRAINT PK_IdPelicula PRIMARY KEY(IdPelicula);

ALTER TABLE Pelicula ADD CONSTRAINT FK_Pelicula_IdEstudio 
FOREING KEY(IdEstudio) REFERENCES Estudio(IdEstudio)
ON DELETE NO ACTION ON UPDATE CASCADE;
------------------------------------------------------------------
 CREATE TABLE Prestamo(
    NumCliente int, 
    IdPelicula int,
    FechaPrestamo dom_fecha,
    DiasPrestamos int,
    FechaDevolucion dom_fecha, --NO ES OBLIGATORIA
    EstatusP dom_statusP,
);

ALTER TABLE ADD COINSTRAINT PK_NumCliente_IdPelicula_FechaPrestamo
PRIMARY KEY(NumCliente,IdPelicula,FechaPrestamo);

ALTER TABLE Prestamo ADD CONSTRAINT FK_Prestamo_NumCliente 
FOREING KEY(NumCliente) REFERENCES Cliente(NumCliente)
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE Prestamo ADD CONSTRAINT FK_Prestamo_IdPelicula
FOREING KEY(IdPelicula) REFERENCES Pelicula(IdPelicula)
ON DELETE NO ACTION ON UPDATE CASCADE;

------------------------------------------------------------------------
 CREATE TABLE PeliculasActores(
    IdPelicula int,
    IdActor int,
    Personaje dom_nombre
);

ALTER TABLE ADD COINSTRAINT PK_IdPelicula_IdActor_Personaje PRIMARY KEY(IdPelicula,IdActor,Personaje);

ALTER TABLE ADD CONSTRAINT FK_PeliculasActores_IdPelicula 
FOREING KEY(IdPelicula) REFERENCES Pelicula(IdPelicula)
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE ADD CONSTRAINT FK_PeliculasActores_IdActor 
FOREING KEY(IdActor) REFERENCES Actor(IdActor)
ON DELETE NO ACTION ON UPDATE CASCADE;



------------------------------
-- create table CLIENTES(
--     RIFCliente int not null,
--     Cedula int,
--     NombreC varchar(60),
--     DireccionC dom_direccion,
--     TelefonoC dom_telefonos,
--     FechaNac date,
--     StatusC StatusC_D,
--     FechaAfiliacion dom_fechas,
--     FechaDesafiliacion dom_fechas
-- );