 CREATE DATABASE CompraVentasDB;

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

 CREATE DOMAIN dom_fecha AS date;

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

 CREATE INDEX IndexNombreC ON Cliente(NombreC);
-------------------------------------------------------------------------------
 CREATE TABLE Estudio(
    IdEstudio int,
    NombreEstudio dom_nombre, --ESTO ES UNIQUE
    PaisUbicacion dom_pais
);

 ALTER TABLE Estudio ADD CONSTRAINT PK_IdEstudio PRIMARY KEY(IdEstudio);

 ALTER TABLE Estudio ADD CONSTRAINT UQ_NombreEstudio UNIQUE(NombreEstudio);

-------------------------------------------------------------------------
 CREATE TABLE Actor(
    IdActor int,
    NombreActor dom_nombre,
    Nacionalidad dom_pais
);

 ALTER TABLE Actor ADD CONSTRAINT PK_IdActor PRIMARY KEY(IdActor);

-----------------------------------------------------------------------------
 CREATE TABLE Pelicula(
    IdPelicula int,
    Titulo dom_titulo,
    IdEstudio int,
    FechaInclusion dom_fecha NOT NULL,
    FechaDesincorporacion dom_fecha ----NO ES OBLIGATORIA
); 

 ALTER TABLE Pelicula ADD CONSTRAINT PK_IdPelicula PRIMARY KEY(IdPelicula);

 ALTER TABLE Pelicula ADD CONSTRAINT FK_Pelicula_IdEstudio 
 FOREIGN KEY(IdEstudio) REFERENCES Estudio(IdEstudio)
 ON DELETE NO ACTION ON UPDATE CASCADE;

 ALTER TABLE Pelicula ADD CONSTRAINT CK_Peliculas_ValidaFechas 
 CHECK (FechaDesincorporacion>FechaInclusion);

 CREATE INDEX IndexTitulo_IDEstudios ON Pelicula(Titulo,IdEstudio);
------------------------------------------------------------------
 CREATE TABLE Prestamo(
    NumCliente int, 
    IdPelicula int,
    FechaPrestamo dom_fecha,
    DiasPrestamos int,
    FechaDevolucion dom_fecha, --NO ES OBLIGATORIA
    EstatusP dom_statusP
);

 ALTER TABLE Prestamo ADD CONSTRAINT PK_NumCliente_IdPelicula_FechaPrestamo
 PRIMARY KEY(NumCliente,IdPelicula,FechaPrestamo);

 ALTER TABLE Prestamo ADD CONSTRAINT FK_Prestamo_NumCliente 
 FOREIGN KEY(NumCliente) REFERENCES Cliente(NumCliente)
 ON DELETE NO ACTION ON UPDATE CASCADE;

 ALTER TABLE Prestamo ADD CONSTRAINT FK_Prestamo_IdPelicula
 FOREIGN KEY(IdPelicula) REFERENCES Pelicula(IdPelicula)
 ON DELETE NO ACTION ON UPDATE CASCADE;

 ALTER TABLE Prestamo ADD CONSTRAINT CK_Prestamo_ValidaFechas 
 CHECK (FechaDevolucion>=FechaPrestamo);

------------------------------------------------------------------------
 CREATE TABLE PeliculasActores(
    IdPelicula int,
    IdActor int,
    Personaje dom_nombre
);

 ALTER TABLE PeliculasActores ADD CONSTRAINT PK_IdPelicula_IdActor_Personaje PRIMARY KEY(IdPelicula,IdActor,Personaje);

 ALTER TABLE PeliculasActores ADD CONSTRAINT FK_PeliculasActores_IdPelicula 
 FOREIGN KEY(IdPelicula) REFERENCES Pelicula(IdPelicula)
 ON DELETE NO ACTION ON UPDATE CASCADE;

 ALTER TABLE PeliculasActores ADD CONSTRAINT FK_PeliculasActores_IdActor 
 FOREIGN KEY(IdActor) REFERENCES Actor(IdActor)
 ON DELETE NO ACTION ON UPDATE CASCADE;

----------------------------------------------

----COMANDOS DE MODIFICACION----

<<<<<<< HEAD
 DROP DOMAIN dom_statusCli CASCADE; ----NO PERMITE RESTRICT, USAMOS CASCADE Y ELIMINARA LA COLUMNA EstatusC EN LA TABLA CLIENTE
=======
DROP DOMAIN dom_statusCli CASCADE; ----NO PERMITE RESTRICT, USAMOS CASCADE Y ELIMINARA UNA COLUMNA EN LA TABLA CLIENTE
>>>>>>> ddab1341cf2e46a37eff976fe99111648e7bbd61

 ALTER TABLE Pelicula DROP COLUMN FechaDesincorporacion;

 ALTER TABLE Prestamo ADD CONSTRAINT CK_DiasPrestamos
 CHECK (DiasPrestamos>=1 AND DiasPrestamos<=7);

 CREATE DOMAIN dom_statusCli AS TEXT
    CHECK(
        VALUE = 'Activo' OR
        VALUE = 'Suspendido' OR
        VALUE = 'Retirado'
    ) NOT NULL;

<<<<<<< HEAD
 ALTER TABLE Cliente ADD COLUMN EstatusC dom_statusCli; ----RESTAURAMOS LA COLUMNA ELIMINADA EN EL PRIMER COMANDO

 ALTER TABLE Pelicula ADD COLUMN FechaDesincorporacion dom_fecha;
=======
ALTER TABLE Cliente ADD COLUMN EstatusC dom_statusCli; ----RESTAURAMOS LA COLUMNA ELIMINADA EN EL PRIMER COMANDO

ALTER TABLE Pelicula ADD COLUMN FechaDesincorporacion dom_fecha;
>>>>>>> ddab1341cf2e46a37eff976fe99111648e7bbd61
