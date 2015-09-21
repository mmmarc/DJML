--============================================================	
--			GESTION DE DATOS 2C 2015 - TP AEROLINEA FRBA						
-- ===========================================================

USE [GD2C2015]
GO

--============================================================	
--		CREACION DEL ESQUEMA CON EL NOMBRE DEL GRUPO--
-- ===========================================================

CREATE SCHEMA [DJML] AUTHORIZATION [GD]
GO

--============================================================
--                EMPEZAMOS A CREAR LAS TABLAS
-- =========================================================== 

CREATE PROCEDURE DJML.CREAR_ROLES
AS
BEGIN

--============================================================
						--TABLA ROLES
--============================================================

	CREATE TABLE DJML.ROLES(
		ROL_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		ROL_DESCRIPCION VARCHAR(40) NOT NULL,
		ROL_ACTIVO BIT NOT NULL
	)
	PRINT 'SE CREO TABLA ROLES CORRECTAMENTE'
	
	---MIGRACION DATOS TABLA ROLES---
	
	INSERT INTO DJML.ROLES VALUES ('ADMINISTRADOR',1)	
	INSERT INTO DJML.ROLES VALUES ('CLIENTE',1)
	
END
GO

CREATE PROCEDURE DJML.CREAR_FUNCIONALIDADES
AS 
BEGIN

--============================================================
				--TABLA FUNCIONALIDADES
--============================================================

	CREATE TABLE DJML.FUNCIONALIDAD(
		FUNC_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		DESCRIPCION VARCHAR(60) UNIQUE NOT NULL	
	)
	
	PRINT 'SE CREO TABLA FUNCIONALIDAD CORRECTAMENTE'
	
	---MIGRACION DATOS TABLA FUNIONALIDAD---
	
	INSERT INTO DJML.FUNCIONALIDAD VALUES ('ABM ROL')
	INSERT INTO DJML.FUNCIONALIDAD VALUES ('ABM CIUDAD')
	INSERT INTO DJML.FUNCIONALIDAD VALUES ('ABM RUTA AEREA')
	INSERT INTO DJML.FUNCIONALIDAD VALUES ('ABM AERONAVE')
	INSERT INTO DJML.FUNCIONALIDAD VALUES ('LOGIN Y SEGURIDAD')
	INSERT INTO DJML.FUNCIONALIDAD VALUES ('REGISTRO USUARIO')
	INSERT INTO DJML.FUNCIONALIDAD VALUES ('GENERAR VIAJE')
	INSERT INTO DJML.FUNCIONALIDAD VALUES ('REGISTRO DE LLEGADA A DESTINO')
	INSERT INTO DJML.FUNCIONALIDAD VALUES ('COMPRA PASAJE/ENCOMIENDA')
	INSERT INTO DJML.FUNCIONALIDAD VALUES ('DEVOLUCION/CANCELACION PASAJE/ENCOMIENDA')
	INSERT INTO DJML.FUNCIONALIDAD VALUES ('CONSULTA MILLAS PASAJERO')
	INSERT INTO DJML.FUNCIONALIDAD VALUES ('CANJE MILLAS')
	INSERT INTO DJML.FUNCIONALIDAD VALUES ('LISTADO ESTADISTICO')

	
	
--============================================================
					--TABLA ROL_FUNCIONALIDAD
--============================================================

	CREATE TABLE DJML.ROL_FUNCIONALIDAD(
		RXF_ROL_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.ROLES(ROL_ID),
		RXF_FUNC_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.FUNCIONALIDAD(FUNC_ID),
		RXF_ESTADO BIT NOT NULL,
		CONSTRAINT RXF_PK PRIMARY KEY(RXF_ROL_ID,RXF_FUNC_ID)
		)		
		PRINT 'SE CREO LA TABLA ROL_FUNCIONALIDAD CORRECTAMENTE'
		
		
		---MIGRACION DATOS TABLA ROL_FUNCIONALIDAD---
		
		
		
END
GO	

CREATE PROCEDURE DJML.CREAR_USUARIOS
AS 
BEGIN

--============================================================
						--TABLA USUARIOS
--============================================================


	CREATE TABLE DJML.USUARIOS (
		USUA_ID INT NOT NULL IDENTITY(1,1),
		USUA_USERNAME INT NOT NULL PRIMARY KEY,
		USUA_PASSWORD NVARCHAR(40),
		USUA_HABILITADO BIT NOT NULL,
		USUA_LOGIN_FALLIDOS INT NOT NULL,
		USUA_ROL_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.ROLES(ROL_ID)
		)

	PRINT 'SE CREO LA TABLA USUARIOS CORRECTAMENTE'
	
	---MIGRACION DATOS TABLA USUARIOS---
 
	
	INSERT INTO DJML.USUARIOS VALUES (10000000,'w23e',1,0,1)
	INSERT INTO DJML.USUARIOS VALUES (20000000,'w23e',1,0,1)
	INSERT INTO DJML.USUARIOS VALUES (30000000,'w23e',1,0,1)
	INSERT INTO DJML.USUARIOS VALUES (40000000,'w23e',1,0,1)
	
END
GO


CREATE PROCEDURE DJML.CREAR_CIUDADES
AS
BEGIN

--============================================================
						--TABLA CIUDAD
--============================================================

	CREATE TABLE DJML.CIUDADES(
	CIUD_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	CIUD_DETALLE NVARCHAR(255)
	)
	
	PRINT 'SE CREO LA TABLA CIUDAD CORRECTAMENTE'
	
	---MIGRACION DATOS TABLA CIUDADES---
	
	insert into djml.CIUDADES(CIUD_DETALLE)
	select distinct Ruta_Ciudad_Destino from gd_esquema.Maestra
	union
	select distinct ruta_ciudad_origen from gd_esquema.Maestra
		
END 
GO


CREATE PROCEDURE DJML.CREAR_RUTAS
AS
BEGIN

--============================================================
						--TABLA RUTA
--============================================================

	CREATE TABLE DJML.RUTAS(
	RUTA_CODIGO NUMERIC(18,0) NOT NULL PRIMARY KEY,
	RUTA_CIUDAD_ORIGEN INT NOT NULL FOREIGN KEY REFERENCES DJML.CIUDADES(CIUD_ID),
	RUTA_CIUDAD_DESTINO INT NOT NULL FOREIGN KEY REFERENCES DJML.CIUDADES(CIUD_ID),
	RUTA_SERVICIO_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.SERVICIOS(SERV_ID),
	RUTA_PRECIO_BASE_PASAJE NUMERIC(18,2) NOT NULL,
	RUTA_PRECIO_BASE_KILO NUMERIC(18,2)NOT NULL,
	)

	PRINT 'SE CREO LA TABLA RUTA CORRECTAMENTE'
	
	
	/*
	---MIGRACION DATOS TABLA RUTAS---
	
	insert into djml.RUTAS(RUTA_CODIGO,RUTA_CIUDAD_ORIGEN,RUTA_CIUDAD_DESTINO,RUTA_SERVICIO_ID,RUTA_PRECIO_BASE_PASAJE,RUTA_PRECIO_BASE_KILO)
	select  Ruta_Codigo, Ruta_Ciudad_Origen,Ruta_Ciudad_Destino, s.SERV_DESCRIPCION, sum(Ruta_Precio_BasePasaje) ,sum(Ruta_Precio_BaseKG) 
	from gd_esquema.Maestra m, djml.SERVICIOS s
	where s.SERV_DESCRIPCION = m.Tipo_Servicio
	group by Ruta_Codigo,Ruta_Ciudad_Origen,Ruta_Ciudad_Destino, s.SERV_DESCRIPCION
	ORDER BY 1


	select distinct  Ruta_Ciudad_Origen,Ruta_Ciudad_Destino, Tipo_Servicio
	from gd_esquema.Maestra 
	order by 11
	
	select distinct AERONAVES Ruta_Codigo,Ruta_Ciudad_Destino,Ruta_Ciudad_Origen from gd_esquema.Maestra
	order by 1
	
	*/
	
	
END
GO	


CREATE PROCEDURE DJML.CREAR_SERVICIOS
AS
BEGIN

--============================================================
						--TABLA SERVICIO
--============================================================

	CREATE TABLE DJML.SERVICIOS(
	SERV_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	SERV_DESCRIPCION NVARCHAR(255) NOT NULL
	)
	PRINT 'SE CREO LA TABLA SERVICIO CORRECTAMENTE'
	
	---MIGRACION DATOS TABLA SERVICIOS---
	
	insert into djml.SERVICIOS(SERV_DESCRIPCION)
	select distinct Tipo_Servicio from gd_esquema.Maestra
	
END
GO


CREATE PROCEDURE DJML.CREAR_AERONAVES
AS
BEGIN
	
	
--============================================================
					--TABLA TIPO_BUTACA
--============================================================

	CREATE TABLE DJML.TIPO_BUTACA(
	TIPO_BUTACA_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	DESCRIPCION NVARCHAR(15) NOT NULL,
	) 
	
	PRINT 'SE CREO LA TABLA TIPO_BUTACA CORRECTAMENTE'
	
	---MIGRACION DATOS TABLA TIPO_BUTACA---
	
	INSERT INTO DJML.TIPO_BUTACA(DESCRIPCION)
	SELECT DISTINCT BUTACA_TIPO FROM gd_esquema.Maestra 
	WHERE Butaca_Nro <> 0
	
	
--============================================================
						--TABLA AERONAVE
--============================================================

	CREATE TABLE DJML.AERONAVES(
	AERO_MATRICULA NVARCHAR(7) NOT NULL PRIMARY KEY,
	AERO_MODELO NVARCHAR(50) NOT NULL,
	AERO_FABRICANTE NVARCHAR(50) NOT NULL,
	AERO_KILOS_DISPONIBLES INT NOT NULL,
	AERO_SERVICIO_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.SERVICIOS(SERV_ID),
	AERO_BAJA_FUERA_SERVICIO BIT NOT NULL,
	AERO_BAJA_VIDA_UTIL BIT NOT NULL,
	AERO_FECHA_FUERA_SERVICIO DATETIME,
	AERO_FECHA_REINICIO_SERVICIO DATETIME CHECK(AERO_FECHA_REINICIO_SERVICIO >= AERO_FECHA_REINICIO_SERVICIO),
	AERO_FECHA_BAJA_DEF DATETIME
	)
	
	PRINT 'SE CREO LA TABLA AERONAVE CORRECTAMENTE'
	
	---MIGRACION DATOS TABLA AERONAVES---
	

	insert into djml.AERONAVES(AERO_MATRICULA, AERO_MODELO, AERO_FABRICANTE, AERO_KILOS_DISPONIBLES, AERO_SERVICIO_ID, AERO_BAJA_FUERA_SERVICIO, AERO_BAJA_VIDA_UTIL, AERO_FECHA_FUERA_SERVICIO, AERO_FECHA_REINICIO_SERVICIO, AERO_FECHA_BAJA_DEF)
	SELECT distinct AERONAVE_matricula, Aeronave_Modelo, Aeronave_Fabricante, Aeronave_KG_Disponibles, s.SERV_ID, 0,0,NULL, NULL, NULL
	FROM gd_esquema.Maestra m 
	join djml.SERVICIOS s on  m.Tipo_Servicio = s.SERV_DESCRIPCION
	ORDER BY 1 
	
	

	
--============================================================
							--TABLA BUTACA
--============================================================

	CREATE TABLE DJML.BUTACAS(
	BUTA_PK INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	BUTA_NRO NUMERIC(4,0) NOT NULL,
	BUTA_TIPO_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.TIPO_BUTACA(TIPO_BUTACA_ID),
	BUTA_PISO NUMERIC(1,0) NOT NULL
	)
	
	PRINT 'SE CREO LA TABLA BUTACA CORRECTAMENTE'
	
	---MIGRACION DATOS TABLA BUTACAS---


	insert into djml.BUTACAS(BUTA_NRO, BUTA_TIPO_ID, BUTA_PISO)
	SELECT distinct Butaca_Nro, n.TIPO_BUTACA_ID, Butaca_Piso
	FROM gd_esquema.Maestra m
	JOIN djml.TIPO_BUTACA n on  m.Butaca_Tipo = n.DESCRIPCION
	WHERE Butaca_Nro <> 0
	order by 1
	
	
	CREATE TABLE DJML.AERO_BUTACA(
	AE_PK INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	AE_BUTA_PK INT NOT NULL FOREIGN KEY REFERENCES DJML.BUTACAS(BUTA_PK),
	AE_AERO_MATRICULA NVARCHAR(7) NOT NULL FOREIGN KEY REFERENCES DJML.AERONAVES(AERO_MATRICULA),
	AE_ESTADO BIT NOT NULL
	)
	
	PRINT 'SE CREO LA TABLA AERO_BUTACA CORRECTAMENTE'

	
	---MIGRACION DATOS TABLA AERO_BUTACA---
	
	insert into djml.AERO_BUTACA(AE_BUTA_PK,AE_AERO_MATRICULA,AE_ESTADO)
	select distinct b.BUTA_PK, a.aero_matricula, 1 from gd_esquema.Maestra m
	join djml.AERONAVES a on m.Aeronave_Matricula = a.AERO_MATRICULA
	join djml.TIPO_BUTACA tb on m.Butaca_Tipo = tb.DESCRIPCION 
	join djml.BUTACAS b on tb.TIPO_BUTACA_ID = b.BUTA_TIPO_ID 
	and b.BUTA_NRO = m.Butaca_Nro 
	and b.BUTA_PISO = m.Butaca_Piso 
	where m.Pasaje_Codigo <> 0
	or m.Paquete_Codigo <> 0
	
	-----REVISAR MIGRACION POR LAS DUDAS
	
END
GO

CREATE PROCEDURE DJML.CREAR_VIAJES
AS
BEGIN

--============================================================
						--TABLA VIAJE
--============================================================

	CREATE TABLE DJML.VIAJES(
	VIAJE_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	VIAJE_FECHA_SALIDA DATETIME NOT NULL,
	VIAJE_FECHA_LLEGADA DATETIME NULL,
	VIAJE_FECHA_LLEGADA_ESTIMADA DATETIME NOT NULL,--SE PODRIA PONER UN CHECK QUE ESTA FECHA NO ES SUPERIOR A 24 HS DSP DE LA SALIDA
	VIAJE_AERO_ID NVARCHAR(7) NOT NULL FOREIGN KEY REFERENCES DJML.AERONAVES(AERO_MATRICULA),
	VIAJE_RUTA_ID NUMERIC(18,0) NOT NULL FOREIGN KEY REFERENCES DJML.RUTAS(RUTA_CODIGO)
	)

	PRINT 'SE CREO LA TABLA VIAJES CORRECTAMENTE'
	
	---MIGRACION DATOS TABLA VIAJES---
	
	
	
	
--============================================================
					--TABLA REGISTRO_DESTINO
--============================================================

	CREATE TABLE DJML.REGISTRO_DESTINO(
	RD_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	RD_VIAJE_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.VIAJES(VIAJE_ID),
	RD_AERO_ID NVARCHAR(7) NOT NULL FOREIGN KEY REFERENCES DJML.AERONAVES(AERO_MATRICULA),
	RD_FECHA_LLEGADA DATETIME NOT NULL ,
	RD_CIUDAD_ORIGEN_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.CIUDADES(CIUD_ID),     
	RD_CIUDAD_DESTINO_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.CIUDADES(CIUD_ID)
	)		
	--LAS CIUDADES ORIGEN/DESTINO REPRESENTAN A LOS AEROPUERTOS PORQUE NO HAY INFORMACION DE ELLOS.
	PRINT 'SE CREO LA TABLA REGISTRO_DESTINO CORRECTAMENTE'

	---MIRAGRACION DATOS TABLA REGISTRO_DESTINO---
	
END 
GO


CREATE PROCEDURE DJML.CREAR_CLIENTES
AS
BEGIN

--============================================================
						--TABLA CLIENTE
--============================================================

	CREATE TABLE DJML.CLIENTES(
	CLIE_DNI INT NOT NULL PRIMARY KEY,
	CLIE_NOMBRE NVARCHAR(255) NOT NULL,
	CLIE_APELLIDO NVARCHAR(255)NOT NULL,
	CLIE_DIRECCION NVARCHAR(255)NOT NULL,
	CLIE_EMAIL NVARCHAR(255),
	CLIE_TELEFONO NUMERIC(18,0) NOT NULL,
	CLIE_FECHA_NACIMIENTO DATETIME NOT NULL
	)

	PRINT 'SE CREO LA TABLA CLIENTE CORRECTAMENTE'

	---MIGRACION DATOS TABLA CLIENTES---
	
	insert into djml.CLIENTES(CLIE_DNI,CLIE_NOMBRE,CLIE_APELLIDO,CLIE_DIRECCION,CLIE_EMAIL, CLIE_TELEFONO, CLIE_FECHA_NACIMIENTO)
	select distinct Cli_Dni, Cli_Nombre,Cli_Apellido,Cli_Dir, Cli_Mail,Cli_Telefono,Cli_Fecha_Nac from gd_esquema.Maestra 
	where ((Pasaje_Codigo <> 0) or (Paquete_Codigo <> 0))
	AND Cli_Dni <> 23718649
	--EXCLUIMOS AL CLIENTE CON ESE DNI YA QUE HABIA REPETIDOS EN LA TABLA MAESTRA	
	
	


END
GO

--============================================================
						--EJECUTAR PROCEDURES
--============================================================

EXEC DJML.CREAR_ROLES
EXEC DJML.CREAR_FUNCIONALIDADES
EXEC DJML.CREAR_USUARIOS
EXEC DJML.CREAR_SERVICIOS
EXEC DJML.CREAR_CIUDADES
EXEC DJML.CREAR_RUTAS

EXEC DJML.CREAR_AERONAVES


EXEC DJML.CREAR_VIAJES
EXEC DJML.CREAR_CLIENTES




--============================================================
				--ELIMINAR TABLAS Y PROCEDURES
--============================================================

DROP TABLE DJML.USUARIOS
DROP TABLE DJML.ROL_FUNCIONALIDAD
DROP TABLE DJML.ROLES
DROP TABLE DJML.FUNCIONALIDAD
DROP TABLE DJML.VIAJES
DROP TABLE DJML.RUTAS
DROP TABLE DJML.CLIENTES
DROP TABLE DJML.CIUDADES
DROP TABLE DJML.REGISTRO_DESTINO
DROP TABLE DJML.AERO_BUTACA
DROP TABLE DJML.BUTACAS
DROP TABLE DJML.AERONAVES
DROP TABLE DJML.TIPO_BUTACA
DROP TABLE DJML.SERVICIOS

DROP PROCEDURE DJML.CREAR_AERONAVES
DROP PROCEDURE DJML.CREAR_CIUDADES
DROP PROCEDURE DJML.CREAR_CLIENTES
DROP PROCEDURE DJML.CREAR_ROLES
DROP PROCEDURE DJML.CREAR_RUTAS
DROP PROCEDURE DJML.CREAR_SERVICIOS
DROP PROCEDURE DJML.CREAR_VIAJES 
DROP PROCEDURE DJML.CREAR_FUNCIONALIDADES 
DROP PROCEDURE DJML.CREAR_USUARIOS


DROP SCHEMA DJML


