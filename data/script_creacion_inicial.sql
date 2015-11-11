--============================================================
				--ELIMINAR TABLAS Y PROCEDURES
--============================================================
/*
DROP TABLE DJML.USUARIOS
DROP TABLE DJML.ROL_FUNCIONALIDAD
DROP TABLE DJML.ROLES
DROP TABLE DJML.FUNCIONALIDAD
DROP TABLE DJML.REGISTRO_DESTINO
DROP TABLE DJML.VIAJES
DROP TABLE DJML.RUTAS
DROP TABLE DJML.RUTAS_LEGACY
DROP TABLE DJML.TRAMOS
DROP TABLE DJML.COMPRAS
DROP TABLE DJML.CLIENTES
DROP TABLE DJML.ENCOMIENDAS
DROP TABLE DJML.PASAJES
DROP TABLE DJML.TIPO_DOCUMENTO
DROP TABLE DJML.MILLAS
DROP TABLE DJML.CIUDADES
DROP TABLE DJML.BUTACA_AERO
DROP TABLE DJML.BUTACAS
DROP TABLE DJML.TIPO_BUTACA
DROP TABLE DJML.AERONAVES
DROP TABLE DJML.SERVICIOS
DROP TABLE DJML.MEDIOS_DE_PAGO
DROP TABLE DJML.TARJETAS_DE_CREDITO
DROP TABLE DJML.TIPOS_DE_TARJETA
DROP TABLE DJML.CANJES
DROP TABLE DJML.PRODUCTOS
DROP TABLE DJML.CANCELACIONES


DROP PROCEDURE DJML.CREAR_AERONAVES
DROP PROCEDURE DJML.CREAR_CIUDADES
DROP PROCEDURE DJML.CREAR_CLIENTES
DROP PROCEDURE DJML.CREAR_ROLES
DROP PROCEDURE DJML.CREAR_RUTAS
DROP PROCEDURE DJML.CREAR_SERVICIOS
DROP PROCEDURE DJML.CREAR_VIAJES 
DROP PROCEDURE DJML.CREAR_FUNCIONALIDADES 
DROP PROCEDURE DJML.CREAR_USUARIOS
DROP PROCEDURE DJML.CREAR_PASAJENCOMIENDA
DROP PROCEDURE DJML.CREAR_COMPRAS
DROP PROCEDURE DJML.CREAR_CANJES


DROP SCHEMA DJML
*/
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
		RXF_HABILITADO BIT
		)		
		PRINT 'SE CREO LA TABLA ROL_FUNCIONALIDAD CORRECTAMENTE'
		
		
		
		---MIGRACION DATOS TABLA ROL_FUNCIONALIDAD---

		---ADMIN
		insert into DJML.ROL_FUNCIONALIDAD (RXF_ROL_ID, RXF_FUNC_ID,RXF_HABILITADO)
		select distinct r.ROL_ID , f.FUNC_ID, 1
		from DJML.ROLES r
		cross join DJML.FUNCIONALIDAD f
		where r.ROL_DESCRIPCION = 'ADMINISTRADOR'

		--CLIENTE
		
		insert into DJML.ROL_FUNCIONALIDAD (RXF_ROL_ID, RXF_FUNC_ID,RXF_HABILITADO)
		select distinct r.ROL_ID , f.FUNC_ID, 1
		from DJML.ROLES r
		cross join DJML.FUNCIONALIDAD f
		where r.ROL_DESCRIPCION = 'CLIENTE'
		and f.DESCRIPCION in ('COMPRA PASAJE/ENCOMIENDA','CONSULTA MILLAS PASAJERO','CANJE MILLAS')	
		
		
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
		USUA_PASSWORD NVARCHAR(256),
		USUA_HABILITADO BIT NOT NULL,
		USUA_LOGIN_FALLIDOS INT NOT NULL,
		USUA_ROL_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.ROLES(ROL_ID)
		)

	PRINT 'SE CREO LA TABLA USUARIOS CORRECTAMENTE'
	
	---MIGRACION DATOS TABLA USUARIOS---


	
	INSERT INTO DJML.USUARIOS VALUES (10000000,'E6-B8-70-50-BF-CB-81-43-FC-B8-DB-01-70-A4-DC-9E-D0-0D-90-4D-DD-3E-2A-4A-D1-B1-E8-DC-0F-DC-9B-E7',1,0,1)
	INSERT INTO DJML.USUARIOS VALUES (20000000,'E6-B8-70-50-BF-CB-81-43-FC-B8-DB-01-70-A4-DC-9E-D0-0D-90-4D-DD-3E-2A-4A-D1-B1-E8-DC-0F-DC-9B-E7',1,0,1)
	INSERT INTO DJML.USUARIOS VALUES (30000000,'E6-B8-70-50-BF-CB-81-43-FC-B8-DB-01-70-A4-DC-9E-D0-0D-90-4D-DD-3E-2A-4A-D1-B1-E8-DC-0F-DC-9B-E7',1,0,1)
	INSERT INTO DJML.USUARIOS VALUES (40000000,'E6-B8-70-50-BF-CB-81-43-FC-B8-DB-01-70-A4-DC-9E-D0-0D-90-4D-DD-3E-2A-4A-D1-B1-E8-DC-0F-DC-9B-E7',1,0,1)
	
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

CREATE PROCEDURE DJML.CREAR_RUTAS
AS
BEGIN

--============================================================
						--TABLAS
--============================================================

	CREATE TABLE DJML.TRAMOS(
	TRAMO_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TRAMO_CIUDAD_ORIGEN INT NOT NULL FOREIGN KEY REFERENCES DJML.CIUDADES(CIUD_ID),
	TRAMO_CIUDAD_DESTINO INT NOT NULL FOREIGN KEY REFERENCES DJML.CIUDADES(CIUD_ID)
	)
	
	PRINT 'SE CREO LA TABLA TRAMOS CORRECTAMENTE'
	
	CREATE TABLE DJML.RUTAS(
	RUTA_CODIGO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	RUTA_TRAMO INT NOT NULL FOREIGN KEY REFERENCES DJML.TRAMOS(TRAMO_ID),
	RUTA_SERVICIO INT NOT NULL FOREIGN KEY REFERENCES DJML.SERVICIOS(SERV_ID),
	RUTA_PRECIO_BASE_PASAJE NUMERIC(18,2) NOT NULL,
	RUTA_PRECIO_BASE_KILO NUMERIC(18,2)NOT NULL,
	RUTA_IS_ACTIVE BIT NOT NULL
	)
	
	PRINT 'SE CREO LA TABLA RUTAS CORRECTAMENTE'
	
	CREATE TABLE DJML.RUTAS_LEGACY(
	RL_RUTA INT NOT NULL FOREIGN KEY REFERENCES DJML.TRAMOS(TRAMO_ID),
	RL_CODIGO NUMERIC(18,0) NOT NULL
	)
	
	PRINT 'SE CREO LA TABLA RUTAS_LEGACY CORRECTAMENTE'
	
--============================================================
						--MIGRACIONES
--============================================================
	
	INSERT INTO DJML.TRAMOS(TRAMO_CIUDAD_ORIGEN, TRAMO_CIUDAD_DESTINO)
	SELECT DISTINCT c1.CIUD_ID, c2.CIUD_ID
	FROM gd_esquema.Maestra
	JOIN DJML.CIUDADES c1 ON Ruta_Ciudad_Origen = c1.CIUD_DETALLE
	JOIN DJML.CIUDADES c2 ON Ruta_Ciudad_Destino = c2.CIUD_DETALLE
	ORDER BY 1
	
	PRINT 'SE MIGRO LA TABLA TRAMOS CORRECTAMENTE'
	
	INSERT INTO DJML.RUTAS(RUTA_TRAMO, RUTA_SERVICIO, RUTA_PRECIO_BASE_PASAJE, RUTA_PRECIO_BASE_KILO, RUTA_IS_ACTIVE)
	SELECT DISTINCT TRAMO_ID
				,SERV_ID
				,(select TOP 1 m3.Ruta_Precio_BasePasaje from gd_esquema.Maestra m3 where m3.Ruta_Codigo = m1.Ruta_Codigo and m3.Ruta_Precio_BaseKG = 0.00)
				,(select TOP 1 m2.Ruta_Precio_BaseKG from gd_esquema.Maestra m2 where m2.Ruta_Codigo = m1.Ruta_Codigo and m2.Ruta_Precio_BasePasaje = 0.00)
				, 1
	FROM gd_esquema.Maestra m1
	JOIN DJML.TRAMOS t ON (SELECT c1.CIUD_ID FROM DJML.CIUDADES c1 WHERE Ruta_Ciudad_Origen = c1.CIUD_DETALLE) = t.TRAMO_CIUDAD_ORIGEN
					 AND (SELECT c2.CIUD_ID FROM DJML.CIUDADES c2 WHERE Ruta_Ciudad_Destino = c2.CIUD_DETALLE) = t.TRAMO_CIUDAD_DESTINO
	JOIN DJML.SERVICIOS S ON s.SERV_DESCRIPCION = m1.Tipo_Servicio
	ORDER BY 1
	
	PRINT 'SE MIGRO LA TABLA RUTAS CORRECTAMENTE'
	
	INSERT INTO DJML.RUTAS_LEGACY(RL_RUTA, RL_CODIGO)
	SELECT DISTINCT r.RUTA_CODIGO, m.Ruta_Codigo
	FROM gd_esquema.Maestra m
	JOIN DJML.TRAMOS t ON (SELECT c1.CIUD_ID FROM DJML.CIUDADES c1 WHERE Ruta_Ciudad_Origen = c1.CIUD_DETALLE) = t.TRAMO_CIUDAD_ORIGEN
					 AND (SELECT c2.CIUD_ID FROM DJML.CIUDADES c2 WHERE Ruta_Ciudad_Destino = c2.CIUD_DETALLE) = t.TRAMO_CIUDAD_DESTINO
	JOIN DJML.SERVICIOS s ON s.SERV_DESCRIPCION = Tipo_Servicio
	JOIN DJML.RUTAS r ON r.RUTA_TRAMO = t.TRAMO_ID AND r.RUTA_SERVICIO = s.SERV_ID
	ORDER BY 1
	
	PRINT 'SE MIGRO LA TABLA RUTAS_LEGACY CORRECTAMENTE'

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
	AERO_FECHA_BAJA_DEF DATETIME,
	AERO_FECHA_ALTA DATETIME
	)
	
	PRINT 'SE CREO LA TABLA AERONAVE CORRECTAMENTE'
	
	---MIGRACION DATOS TABLA AERONAVES---
	

	insert into djml.AERONAVES(AERO_MATRICULA, AERO_MODELO, AERO_FABRICANTE, AERO_KILOS_DISPONIBLES, AERO_SERVICIO_ID, AERO_BAJA_FUERA_SERVICIO, AERO_BAJA_VIDA_UTIL, AERO_FECHA_FUERA_SERVICIO, AERO_FECHA_REINICIO_SERVICIO, AERO_FECHA_BAJA_DEF, AERO_FECHA_ALTA)
	SELECT distinct AERONAVE_matricula, Aeronave_Modelo, Aeronave_Fabricante, Aeronave_KG_Disponibles, s.SERV_ID, 0,0,NULL, NULL, NULL,NULL
	FROM gd_esquema.Maestra m 
	join djml.SERVICIOS s on  m.Tipo_Servicio = s.SERV_DESCRIPCION
	ORDER BY 1 
	

--============================================================
							--TABLA BUTACA
--============================================================

	CREATE TABLE DJML.BUTACAS(
	BUTA_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
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
	--WHERE Butaca_Tipo is not null
	order by 1
	
	
--============================================================
							--TABLA BUTACA_AERO
--============================================================

	CREATE TABLE DJML.BUTACA_AERO(
	BXA_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	BXA_BUTA_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.BUTACAS(BUTA_ID),
	BXA_AERO_MATRICULA NVARCHAR(7) NOT NULL FOREIGN KEY REFERENCES DJML.AERONAVES(AERO_MATRICULA),
	BXA_ESTADO BIT NOT NULL
	)
	
	PRINT 'SE CREO LA TABLA BUTACA_AERO CORRECTAMENTE'
	
	---MIGRACION DATOS TABLA BUTACA_AERO---
	
	insert into djml.BUTACA_AERO(BXA_BUTA_ID,BXA_AERO_MATRICULA,BXA_ESTADO)
	select distinct b.BUTA_ID, a.aero_matricula, 1 from gd_esquema.Maestra m
	join djml.AERONAVES a on m.Aeronave_Matricula = a.AERO_MATRICULA
	join djml.TIPO_BUTACA tb on m.Butaca_Tipo = tb.DESCRIPCION 
	join djml.BUTACAS b on tb.TIPO_BUTACA_ID = b.BUTA_TIPO_ID 
	and b.BUTA_NRO = m.Butaca_Nro 
	and b.BUTA_PISO = m.Butaca_Piso 
	where m.Pasaje_Codigo <> 0
	or m.Paquete_Codigo <> 0
	
	--HACER: REVISAR!!
	
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
	VIAJE_FECHA_SALIDA smalldatetime  NOT NULL,
	VIAJE_FECHA_LLEGADA smalldatetime  NULL,
	VIAJE_FECHA_LLEGADA_ESTIMADA  smalldatetime  NOT NULL,
	VIAJE_AERO_ID NVARCHAR(7) NOT NULL FOREIGN KEY REFERENCES DJML.AERONAVES(AERO_MATRICULA),
	VIAJE_RUTA_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.RUTAS(RUTA_CODIGO)
	)
	PRINT 'SE CREO LA TABLA VIAJES CORRECTAMENTE'

	---MIGRACION DATOS TABLA VIAJES---
	
	/*
	insert into djml.VIAJES(VIAJE_FECHA_SALIDA, VIAJE_FECHA_LLEGADA, VIAJE_FECHA_LLEGADA_ESTIMADA, VIAJE_AERO_ID, VIAJE_RUTA_ID)
	select distinct m.FechaSalida, m.FechaLLegada, m.Fecha_LLegada_Estimada, a.aero_matricula, r.RL_RUTA
	from gd_esquema.Maestra m
	join DJML.AERONAVES a on a.AERO_MATRICULA = m.aeronave_matricula
	join djml.RUTAS_LEGACY r on r.RL_CODIGO = m.ruta_codigo 
	where m.Paquete_Codigo <> 0 
	or m.Pasaje_Codigo <> 0
	and m.FechaSalida is not null
	and m.FechaLLegada is not null
	*/
	--HACER: REVISAR!!
	
	-- Version de Lucas
	insert into djml.VIAJES(VIAJE_FECHA_SALIDA, VIAJE_FECHA_LLEGADA, VIAJE_FECHA_LLEGADA_ESTIMADA, VIAJE_AERO_ID, VIAJE_RUTA_ID)
	select distinct m.FechaSalida, m.FechaLLegada, m.Fecha_LLegada_Estimada, a.aero_matricula, r.RUTA_CODIGO
	from gd_esquema.Maestra m
	join DJML.AERONAVES a on a.AERO_MATRICULA = m.aeronave_matricula
	JOIN DJML.SERVICIOS S ON s.SERV_DESCRIPCION = m.Tipo_Servicio
	JOIN DJML.TRAMOS t ON (SELECT c1.CIUD_ID FROM DJML.CIUDADES c1 WHERE Ruta_Ciudad_Origen = c1.CIUD_DETALLE) = t.TRAMO_CIUDAD_ORIGEN
						 AND (SELECT c2.CIUD_ID FROM DJML.CIUDADES c2 WHERE Ruta_Ciudad_Destino = c2.CIUD_DETALLE) = t.TRAMO_CIUDAD_DESTINO
	JOIN DJML.RUTAS r ON r.RUTA_TRAMO = t.TRAMO_ID AND r.RUTA_SERVICIO = s.SERV_ID
	where (m.Paquete_Codigo <> 0 or m.Pasaje_Codigo <> 0)
	and m.FechaSalida is not null
	and m.FechaLLegada is not null
	
	
	
--============================================================
					--TABLA REGISTRO_DESTINO
--============================================================

	CREATE TABLE DJML.REGISTRO_DESTINO(
	RD_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	RD_VIAJE_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.VIAJES(VIAJE_ID),
	RD_AERO_ID NVARCHAR(7) NOT NULL FOREIGN KEY REFERENCES DJML.AERONAVES(AERO_MATRICULA),
	RD_FECHA_LLEGADA smalldatetime  NOT NULL ,
	RD_CIUDAD_ORIGEN_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.CIUDADES(CIUD_ID),     
	RD_CIUDAD_DESTINO_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.CIUDADES(CIUD_ID)
	)		
	--LAS CIUDADES ORIGEN/DESTINO REPRESENTAN A LOS AEROPUERTOS PORQUE NO HAY INFORMACION DE ELLOS.
	PRINT 'SE CREO LA TABLA REGISTRO_DESTINO CORRECTAMENTE'

	---MIRAGRACION DATOS TABLA REGISTRO_DESTINO---
	--HACER: NO SE MIGRA!!
END 
GO


CREATE PROCEDURE DJML.CREAR_CLIENTES
AS
BEGIN

--============================================================
						--TABLA CLIENTE
--============================================================
	CREATE TABLE DJML.TIPO_DOCUMENTO(
	ID_TIPO_DOC INT IDENTITY(1,1) PRIMARY KEY,
	DESCRIPCION varchar(15) not null
	)
	
	PRINT 'SE CREO LA TABLA REGISTRO_DESTINO CORRECTAMENTE'
	
	--MIGRACION TABLA TIPO_DOCUMENTO

	INSERT INTO DJML.TIPO_DOCUMENTO (DESCRIPCION) VALUES ('DNI')
	INSERT INTO DJML.TIPO_DOCUMENTO (DESCRIPCION) VALUES ('LC')
	INSERT INTO DJML.TIPO_DOCUMENTO (DESCRIPCION) VALUES ('LE')

	
	CREATE TABLE DJML.CLIENTES(
	CLIE_ID INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
	CLIE_DNI INT NOT NULL,
	CLIE_TIPO_DOC INT NOT NULL FOREIGN KEY REFERENCES DJML.TIPO_DOCUMENTO(ID_TIPO_DOC),
	CLIE_NOMBRE NVARCHAR(255) NOT NULL,
	CLIE_APELLIDO NVARCHAR(255)NOT NULL,
	CLIE_DIRECCION NVARCHAR(255)NOT NULL,
	CLIE_EMAIL NVARCHAR(255),
	CLIE_TELEFONO NUMERIC(18,0) NOT NULL,
	CLIE_FECHA_NACIMIENTO DATETIME NOT NULL
	)

	PRINT 'SE CREO LA TABLA CLIENTE CORRECTAMENTE'

	---MIGRACION DATOS TABLA CLIENTES---
	
	insert into djml.CLIENTES(CLIE_DNI,CLIE_TIPO_DOC,CLIE_NOMBRE,CLIE_APELLIDO,CLIE_DIRECCION,CLIE_EMAIL, CLIE_TELEFONO, CLIE_FECHA_NACIMIENTO)
	select distinct Cli_Dni,t.ID_TIPO_DOC, Cli_Nombre,Cli_Apellido,Cli_Dir, Cli_Mail,Cli_Telefono,Cli_Fecha_Nac from gd_esquema.Maestra
	join djml.TIPO_DOCUMENTO t on t.DESCRIPCION = 'DNI' 
	where ((Pasaje_Codigo <> 0) or (Paquete_Codigo <> 0))
	AND Cli_Mail <> 'orencia@gmail.com'
	union
	select distinct Cli_Dni,t.ID_TIPO_DOC, Cli_Nombre,Cli_Apellido,Cli_Dir, Cli_Mail,Cli_Telefono,Cli_Fecha_Nac from gd_esquema.Maestra
	join djml.TIPO_DOCUMENTO t on t.DESCRIPCION = 'LE' 
	where ((Pasaje_Codigo <> 0) or (Paquete_Codigo <> 0))
	AND Cli_Mail = 'orencia@gmail.com'
	
	--HACER: REVISAR!!
	
--============================================================
						--TABLA MILLAS
--============================================================

/*  FALTA DEFINIR !!!!!!!!!!!
CREATE TABLE DJML.MILLAS(
	MILLAS_CLIENTE INT NOT NULL FOREIGN KEY REFERENCES DJML.CLIENTES(CLIE_DNI), 
	)
	PRINT 'SE CREO LA TABLA MILLAS CORRECTAMENTE'
	---MIGRACION DATOS TABLA MILLAS ---
	*/

-----NOTA: LUQUITAS FIJATE CUANDO IMPLEMENTES ESTO COMO LO HICIERON
-----------  GUIDO Y ELLOS, NO USAN UNA TABLA, LO CALCULAN.
----------- ESTARIA BUENO COPIARLES ESA IDEA!


END
GO


CREATE PROCEDURE DJML.CREAR_PASAJENCOMIENDA
AS
BEGIN
--============================================================
						--TABLA PASAJE
--============================================================
	CREATE TABLE DJML.PASAJES (
	PASA_ID INT NOT NULL PRIMARY KEY,
	PASA_VIAJE_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.VIAJES(VIAJE_ID),
	PASA_CLIE_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.CLIENTES(CLIE_ID),
	PASA_COMPRA_ID INT FOREIGN KEY REFERENCES DJML.COMPRAS(COMPRA_ID),
	PASA_BUTA_ID INT FOREIGN KEY REFERENCES DJML.BUTACA_AERO(BXA_ID) NOT NULL,
	PASA_PRECIO numeric(18,2)
	)

	PRINT 'SE CREO LA TABLA PASAJE CORRECTAMENTE'

	---MIGRACION DATOS TABLA PASAJES---

	insert into djml.PASAJES(PASA_ID, PASA_VIAJE_ID,PASA_CLIE_ID,PASA_COMPRA_ID,PASA_BUTA_ID,PASA_PRECIO)
	SELECT distinct Pasaje_Codigo, v.VIAJE_ID, C.CLIE_ID, NULL, B.BUTA_ID, Pasaje_Precio
	FROM [GD2C2015].[gd_esquema].[Maestra] m
	JOIN DJML.CLIENTES C ON M.Cli_Dni = C.CLIE_DNI
		AND M.Cli_Telefono = C.CLIE_TELEFONO
	JOIN DJML.VIAJES v on m.FechaSalida = v.VIAJE_FECHA_SALIDA
		AND m.FechaLLegada = v.VIAJE_FECHA_LLEGADA
		AND m.Fecha_LLegada_Estimada = v.VIAJE_FECHA_LLEGADA_ESTIMADA
		AND m.Aeronave_Matricula = v.VIAJE_AERO_ID
	JOIN DJML.RUTAS R ON V.VIAJE_RUTA_ID = R.RUTA_CODIGO
	JOIN DJML.TRAMOS T ON R.RUTA_TRAMO = T.TRAMO_ID
	JOIN DJML.BUTACAS B ON M.Butaca_Nro = B.BUTA_NRO
		AND M.Butaca_Piso = B.BUTA_PISO
	JOIN DJML.TIPO_BUTACA TP ON B.BUTA_TIPO_ID = TP.TIPO_BUTACA_ID
		AND M.Butaca_Tipo = TP.DESCRIPCION
	JOIN DJML.BUTACA_AERO BA ON B.BUTA_ID = BA.BXA_BUTA_ID
		AND M.Aeronave_Matricula = BA.BXA_AERO_MATRICULA
	WHERE Paquete_Codigo = 0
	AND (SELECT c1.CIUD_ID FROM DJML.CIUDADES c1 WHERE Ruta_Ciudad_Origen = c1.CIUD_DETALLE) = t.TRAMO_CIUDAD_ORIGEN
	AND (SELECT c2.CIUD_ID FROM DJML.CIUDADES c2 WHERE Ruta_Ciudad_Destino = c2.CIUD_DETALLE) = t.TRAMO_CIUDAD_DESTINO
	ORDER BY 1

	PRINT 'SE MIGRO LA TABLA PASAJE CORRECTAMENTE'




--============================================================
						--TABLA EMBALAJE
--============================================================
	CREATE TABLE DJML.ENCOMIENDAS (
	ENCO_ID INT NOT NULL PRIMARY KEY,
	ENCO_VIAJE_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.VIAJES(VIAJE_ID),
	ENCO_CLIE_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.CLIENTES(CLIE_ID),
	ENCO_COMPRA_ID INT FOREIGN KEY REFERENCES DJML.COMPRAS(COMPRA_ID), 
	ENCO_KG INT NOT NULL,
	ENCO_PRECIO INT NOT NULL
	)

	PRINT 'SE CREO LA TABLA ENCOMIENDA CORRECTAMENTE'

	---MIGRACION DATOS TABLA ENCOMIENDAS---

	insert into djml.ENCOMIENDAS(ENCO_ID,ENCO_VIAJE_ID,ENCO_CLIE_ID,ENCO_COMPRA_ID,ENCO_KG,ENCO_PRECIO)
	select distinct m.Paquete_Codigo, V.VIAJE_ID,C.CLIE_ID, null, m.Paquete_KG, m.Paquete_Precio 
	from gd_esquema.Maestra m
	JOIN DJML.VIAJES V on M.FechaSalida = V.VIAJE_FECHA_SALIDA
		AND M.FechaLLegada = V.VIAJE_FECHA_LLEGADA
		AND M.Fecha_LLegada_Estimada = V.VIAJE_FECHA_LLEGADA_ESTIMADA
		AND M.Aeronave_Matricula = V.VIAJE_AERO_ID
	JOIN DJML.RUTAS R ON V.VIAJE_RUTA_ID = R.RUTA_CODIGO
	JOIN DJML.TRAMOS T ON R.RUTA_TRAMO = T.TRAMO_ID
	JOIN DJML.CLIENTES C ON M.Cli_Dni = C.CLIE_DNI
		AND M.Cli_Telefono = C.CLIE_TELEFONO
	where m.Paquete_Codigo <> 0 
	AND m.Pasaje_Codigo = 0
	AND (SELECT c1.CIUD_ID FROM DJML.CIUDADES c1 WHERE Ruta_Ciudad_Origen = c1.CIUD_DETALLE) = t.TRAMO_CIUDAD_ORIGEN
	AND (SELECT c2.CIUD_ID FROM DJML.CIUDADES c2 WHERE Ruta_Ciudad_Destino = c2.CIUD_DETALLE) = t.TRAMO_CIUDAD_DESTINO
	ORDER BY 1
	
	PRINT 'SE MIGRO LA TABLA ENCOMIENDA CORRECTAMENTE'
	
END
GO


CREATE PROCEDURE DJML.CREAR_COMPRAS
AS 
BEGIN
--=======================================================================
                            -- TABLA MEDIO DE PAGO
--=======================================================================
	CREATE TABLE DJML.MEDIOS_DE_PAGO(
	MEDI_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	MEDI_DESCRIPCION VARCHAR(15) NOT NULL
	)

	--MIGRACION

	INSERT INTO DJML.MEDIOS_DE_PAGO(MEDI_DESCRIPCION) VALUES ('EFECTIVO')
	INSERT INTO DJML.MEDIOS_DE_PAGO(MEDI_DESCRIPCION) VALUES ('TC')


	--=======================================================================
                            -- TABLA TIPOS DE TARJETA
--=======================================================================


	CREATE TABLE DJML.TIPOS_DE_TARJETA (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    NOMBRE NVARCHAR(255) NOT NULL,
	CUOTAS INT DEFAULT 0   
)

 -- Migracion

	INSERT INTO DJML.TIPOS_DE_TARJETA (NOMBRE, CUOTAS)
	VALUES ('VISA', 6),
	('MASTERCARD', 12),
	('AMEX', 3),
	('DINERS', 0);

--=======================================================================
                            -- TABLA TARJETA DE CREDITO
--=======================================================================
	CREATE TABLE DJML.TARJETAS_DE_CREDITO(
	TARJ_NUMERO BIGINT NOT NULL PRIMARY KEY,
	TARJ_TIPO_ID INT FOREIGN KEY REFERENCES DJML.TIPOS_DE_TARJETA(ID),
	TARJ_CODIGO INT NOT NULL
	)

--=======================================================================
                            -- TABLA COMPRA
--=======================================================================

	CREATE TABLE DJML.COMPRAS(
	COMPRA_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	COMPRA_VIAJE_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.VIAJES(VIAJE_ID),
	COMPRA_CLIE_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.CLIENTES(CLIE_ID), 
	COMPRA_MEDIO_DE_PAGO INT FOREIGN KEY REFERENCES DJML.MEDIOS_DE_PAGO(MEDI_ID),
	COMPRA_TARJETA_DE_CREDITO BIGINT FOREIGN KEY REFERENCES DJML.TARJETAS_DE_CREDITO(TARJ_NUMERO),
	COMPRA_MONTO NUMERIC(18,0) NOT NULL,
	COMPRA_FECHA DATETIME NOT NULL,
	COMPRA_MILLAS INT
	)



	-- MIGRACION DATOS TABLA COMPRAS ---
-- FALTA HACER LA MIGRACION...

-- MIGRAR CON: MEDIO DE PAGO, TARJETA DE CREDITO EN NULL !!!!
-- ESTARIA COPADO HACER UN CHECK QUE CUANDO MEDIO DE PAGO SEA TC SE FIJE QUE TARJETA DE CREDITO NO ESTE EN NULL


--=======================================================================
                            -- TABLA CANCELACION
--=======================================================================

	CREATE TABLE DJML.CANCELACIONES (
    CANC_ID INT IDENTITY(1,1)PRIMARY KEY,
    CANC_FECHA_DEVOLUCION DATETIME NOT NULL,
    CANC_COMPRA_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.COMPRAS(COMPRA_ID),
    CANC_MOTIVO NVARCHAR(255)NOT NULL
	)
-------------------------------NO SE MIGRA

END 
GO

CREATE PROCEDURE DJML.CREAR_CANJES
AS
BEGIN

--============================================================
						--TABLA PRODUCTOS
--============================================================
CREATE TABLE DJML.PRODUCTO (
    PROD_ID  INT  IDENTITY(1,1)PRIMARY KEY,
    PROD_NOMBRE NVARCHAR(255)UNIQUE,
    PROD_MILLAS_REQUERIDAS INT NOT NULL,
    PROD_STOCK INT  NOT NULL    
	) 

------------------------------------------------------- NO SE MIGRA

--============================================================
						--TABLA CANJES
--============================================================

CREATE TABLE DJML.CANJES (
    CANJ_ID INT IDENTITY(1,1)     PRIMARY KEY,
	CANJ_CLIE_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.CLIENTES(CLIE_ID),
    CANJ_PRODUCTO_ID INT NOT NULL FOREIGN KEY REFERENCES DJML.PRODUCTO(PROD_ID),
    CANJ_CANTIDAD INT DEFAULT 1,
    CANJ_FECHA_CANJE DATETIME NOT NULL
	)
---------------------------------------------------- NO SE MIGRA

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
EXEC DJML.CREAR_COMPRAS
EXEC DJML.CREAR_PASAJENCOMIENDA



--============================================================
			--VIEW
--============================================================
/*	
CREATE VIEW DJML.v_rutas
	AS SELECT	c1.CIUD_DETALLE as 'Ciudad Origen'
			  , c1.CIUD_ID as 'OrigenID'
			  , c2.CIUD_DETALLE as 'Ciudad Destino'
			  , c2.CIUD_ID as 'DestinoID'
			  , s.SERV_DESCRIPCION as 'Servicio'
			  , s.SERV_ID as 'ServicioID'
			  , '$ ' + cast ([RUTA_PRECIO_BASE_PASAJE] as CHAR(100)) as 'Pasaje'
			  , '$ ' + cast ([RUTA_PRECIO_BASE_KILO] as CHAR(100)) as 'Kilo Encomienda'
		FROM DJML.RUTAS r
		JOIN DJML.SERVICIOS s ON s.SERV_ID = r.RUTA_SERVICIO
		JOIN DJML.TRAMOS t ON t.TRAMO_ID = r.RUTA_TRAMO
		JOIN DJML.CIUDADES c1 ON c1.CIUD_ID = t.TRAMO_CIUDAD_ORIGEN
		JOIN DJML.CIUDADES c2 ON c2.CIUD_ID = t.TRAMO_CIUDAD_DESTINO
		WHERE RUTA_IS_ACTIVE = 1
*/

