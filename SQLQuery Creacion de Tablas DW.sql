/*Secuencia de Creacion de DataWarehouse AdventureWorks2017*/


/*Creacion de Tablas*/
CREATE TABLE [Dim_Moneda] (
	[TasaCambioID] int NOT NULL,
    [CodigoMoneda] nvarchar(3) NOT NULL,
    [NombreMoneda] nvarchar(50) NOT NULL
)

CREATE TABLE[Dim_Territorio](
	[IdTerritorio] int NOT NULL,
	[NombreTerritorio] nvarchar(50) NOT NULL,
	[Grupo] nvarchar(50) NOT NULL
)

CREATE TABLE[Dim_Tiempo](
  [Fecha]       DATETIME NOT NULL, 
  [Dia]        AS DATEPART(DAY,      [Fecha]),
  [Mes]      AS DATEPART(MONTH,    [Fecha]) ,
  [NombreMes]  AS DATENAME(MONTH,    [Fecha]) ,
  [Semana]       AS DATEPART(WEEK,     [Fecha]) ,
  [Trimestre]    AS DATEPART(QUARTER,  [Fecha]) ,
  [Anno]       AS DATEPART(YEAR,     [Fecha]) ,  
)


CREATE TABLE [Dim_TarjetaPersona](
	[IdTarjeta] int NOT NULL,
	[Sexo] nvarchar(20) NOT NULL,
	[TipoTarjeta] nvarchar(50) NOT NULL,
	[FechaExp] int NOT NULL,
	[TipoPersona] nchar(2) NOT NULL

)


CREATE TABLE [Dim_MetodoEnvio](
	[IdMetodoEnvio] int NOT NULL,
	[NombreMetodo] nvarchar(50) NOT NULL
)


CREATE TABLE [H_Ventas](
	[IdVenta] int NOT NULL,
	[IdMetodoEnvio] int NOT NULL,
	[IdTarjeta] int,
	[IdTerritorio] int NOT NULL,
	[TasaCambioID] int,
	[FechaOrden] DateTime NOT NULL,
	[Subtotal] int NOT NULL,
	[Impuesto] int NOT NULL,
	[CostoEnvio] int NOT NULL,
	[Total] int NOT NULL
)

/*Definicion de claves primarias*/
ALTER TABLE [Dim_Moneda] 
ADD CONSTRAINT [TASACAMBIO_PK] PRIMARY KEY([TasaCambioID])

ALTER TABLE [Dim_Territorio]
ADD CONSTRAINT [IDTERRITORIO_PK] PRIMARY KEY(IdTerritorio)

ALTER TABLE [Dim_Tiempo]
ADD CONSTRAINT [FECHA_PK] PRIMARY KEY(Fecha)

ALTER TABLE [Dim_TarjetaPersona]
ADD CONSTRAINT [IDTARJETA_PK] PRIMARY KEY(IdTarjeta)

ALTER TABLE [Dim_MetodoEnvio]
ADD CONSTRAINT [IDMETODOENVIO_PK] PRIMARY KEY(IdMetodoEnvio)

ALTER TABLE [H_Ventas]
ADD CONSTRAINT [IDVENTA_PK] PRIMARY KEY(IdVenta)


/*Definicion de claves foraneas en la tabla hecho*/
ALTER TABLE [dbo].[H_Ventas]
WITH CHECK ADD CONSTRAINT [FK_IDMETODOENVIO_VENTAS] FOREIGN KEY ([IdMetodoEnvio]) REFERENCES[Dim_MetodoEnvio] ([IdMetodoEnvio])
GO

ALTER TABLE [H_Ventas]
WITH CHECK ADD CONSTRAINT [FK_IDTARJETA_VENTAS] FOREIGN KEY([IdTarjeta]) REFERENCES [Dim_TarjetaPersona] ([IdTarjeta])
GO

ALTER TABLE [H_Ventas]
WITH CHECK ADD CONSTRAINT [FK_IDTERRITORIO_VENTAS] FOREIGN KEY([IdTerritorio]) REFERENCES [Dim_Territorio] ([IdTerritorio])
GO

ALTER TABLE [H_Ventas]
WITH CHECK ADD CONSTRAINT [FK_CODIGOMONEDA_VENTAS] FOREIGN KEY([TasaCambioID]) REFERENCES[Dim_Moneda] ([TasaCambioID])
GO

ALTER TABLE [H_Ventas]
ADD CONSTRAINT [FK_FECHAORDEN_VENTAS] FOREIGN KEY([FechaOrden]) REFERENCES [Dim_Tiempo] ([Fecha])
GO

INSERT INTO [Dim_Moneda]
VALUES(0,'NIN','Ninguno')