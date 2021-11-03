CREATE DATABASE Practica1;

 CREATE DOMAIN StatusCli AS TEXT
    CHECK(
        VALUE = 'A' OR          ---------------ACTIVO-----------
        VALUE = 'S' OR          --------------SUSPENDIDO--------
        VALUE = 'R'             ----------------RETIRADO----------
    );

CREATE DOMAIN StatusP AS TEXT
    CHECK(
        VALUE = 'VI' OR          ---------------VIGENTE-----------
        VALUE = 'AT' OR          --------------ATRASADO--------
        VALUE = 'CR' OR          ----------------Cerrado con retraso----------
        VALUE = 'CD'           ------------Cerrado al dia----------------
    );


-----------TABLAS ANTES DE LOS CAMBIOS------------------
CREATE TABLE Cliente(  
    NumCliente int NOT NULL,
    Cedula int,
    NombreC ,
    DireccionC,
    TlfCelular,
    EstatusC,
    FechaAfiliacion



);

CREATE TABLE Prestamo(
    NumCliente,
    IdPelicula,
    FechaPrestamo,
    DiasPrestamos,
    FechaDevolucion,
    EstatusP,
);

CREATE TABLE Pelicula(
    IdPelicula,
    Titulo,
    IdEstudios,
    FechaInclusion,
    FechaDesincorporacion

); 

CREATE TABLE Estudio(
    IdPelicula,
    NombreEstudio,
    PaisUbicacion

);

CREATE TABLE PeliculasActores(
    IdPelicula,
    IdActor,
    Personaje

);

CREATE TABLE Actores(
    IdActor,
    NombreActor,
    Nacionalidad

);

------------------------------
    create table CLIENTES(
        RIFCliente int not null,
        Cedula int,
        NombreC varchar(60),
        DireccionC dom_direccion,
        TelefonoC dom_telefonos,
        FechaNac date,
        StatusC StatusC_D,
        FechaAfiliacion dom_fechas,
        FechaDesafiliacion dom_fechas
    );
