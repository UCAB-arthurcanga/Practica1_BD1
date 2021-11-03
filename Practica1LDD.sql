CREATE DATABASE Practica1;

 CREATE DOMAIN dom_nombre AS VARCHAR(25) NOT NULL;

 CREATE DOMAIN dom_cedula AS VARCHAR(8) NOT NULL;

 CREATE DOMAIN dom_direccion AS VARCHAR(90) NOT NULL;

 CREATE DOMAIN dom_tlf AS VARCHAR(9); ----LOS TELEFONOS SON 9 DIGITOS SI OBVIAMOS EL 0----

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
    Cedula dom_cedula,
    NombreC dom_nombre,
    DireccionC dom_direccion,
    TlfCelular dom_tlf,
    EstatusC dom_statusCli,
    FechaAfiliacion dom_fecha NOT NULL
);

 CREATE TABLE Prestamo(
    NumCliente int,
    IdPelicula int,
    FechaPrestamo dom_fecha NOT NULL,
    DiasPrestamos int,
    FechaDevolucion dom_fecha,
    EstatusP dom_statusP,
);

 CREATE TABLE Pelicula(
    IdPelicula int,
    Titulo dom_nombre,
    IdEstudios int,
    FechaInclusion dom_fecha NOT NULL,
    FechaDesincorporacion dom_fecha ----
); 

 CREATE TABLE Estudio(
    IdPelicula int,
    NombreEstudio dom_nombre,
    PaisUbicacion dom_nombre
);

 CREATE TABLE PeliculasActores(
    IdPelicula int,
    IdActor int,
    Personaje dom_nombre
);

 CREATE TABLE Actores(
    IdActor int,
    NombreActor dom_nombre,
    Nacionalidad dom_nombre
);

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