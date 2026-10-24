-- Generado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   en:        2026-10-23 00:31:37 PET
--   sitio:      SQL Server 2012
--   tipo:      SQL Server 2012
IF DB_ID('Molash_Dim') IS NULL
    CREATE DATABASE Molash_Dim

go
use Molash_Dim

CREATE TABLE DIM_Cliente 
    (
     Sk_Cliente INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Id_Persona INTEGER NOT NULL , 
     Nombre VARCHAR (60) NOT NULL , 
     Apellido VARCHAR (60) NOT NULL , 
     Tipo_Documento VARCHAR (60) NOT NULL , 
     Documento VARCHAR (15) NOT NULL , 
     Correo VARCHAR (100) NOT NULL , 
     Telefono VARCHAR (15) NOT NULL , 
     Distrito VARCHAR (60) NOT NULL , 
     Provincia VARCHAR (60) NOT NULL , 
     Departamento VARCHAR (60) NOT NULL , 
     Fecha_Inicio DATE NOT NULL , 
     Fecha_Fin DATE , 
     Es_Actual BIT NOT NULL DEFAULT 1 
    )
GO

ALTER TABLE DIM_Cliente ADD CONSTRAINT PK_DIM_Cliente PRIMARY KEY CLUSTERED (Sk_Cliente)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO
ALTER TABLE DIM_Cliente ADD CONSTRAINT UQ_Cliente_Version UNIQUE NONCLUSTERED (Id_Persona, Fecha_Inicio)
GO

CREATE TABLE DIM_Conductor 
    (
     Sk_Conductor INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL , 
     Apellido VARCHAR (60) NOT NULL , 
     Licencia VARCHAR (15) NOT NULL , 
     Categoria VARCHAR (15) NOT NULL 
    )
GO

ALTER TABLE DIM_Conductor ADD CONSTRAINT PK_DIM_Conductor PRIMARY KEY CLUSTERED (Sk_Conductor)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE DIM_Estado_Envio 
    (
     Sk_Estado INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL 
    )
GO

ALTER TABLE DIM_Estado_Envio ADD CONSTRAINT PK_DIM_Estado_Envio PRIMARY KEY CLUSTERED (Sk_Estado)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE DIM_Estado_Pago 
    (
     Sk_Estado_Pago INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (30) NOT NULL 
    )
GO

ALTER TABLE DIM_Estado_Pago ADD CONSTRAINT PK_DIM_Estado_Pago PRIMARY KEY CLUSTERED (Sk_Estado_Pago)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE DIM_Metodo_Pago 
    (
     Sk_Metodo_Pago INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL 
    )
GO

ALTER TABLE DIM_Metodo_Pago ADD CONSTRAINT PK_DIM_Metodo_Pago PRIMARY KEY CLUSTERED (Sk_Metodo_Pago)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE DIM_Ruta 
    (
     Sk_Ruta INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Sucursal_Origen VARCHAR (100) NOT NULL , 
     Sucursal_Destino VARCHAR (100) NOT NULL , 
     Distancia_Km DECIMAL (8,2) NOT NULL , 
     Duracion_Estimada_Min INTEGER NOT NULL 
    )
GO

ALTER TABLE DIM_Ruta ADD CONSTRAINT PK_DIM_Ruta PRIMARY KEY CLUSTERED (Sk_Ruta)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE DIM_Servicio 
    (
     Sk_Servicio INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Id_Tipo_Servicio INTEGER NOT NULL , 
     Nombre VARCHAR (60) NOT NULL , 
     Tiempo_Entrega_Horas INTEGER NOT NULL , 
     Tarifa_Base DECIMAL (10,2) NOT NULL 
    )
GO

ALTER TABLE DIM_Servicio ADD CONSTRAINT PK_DIM_Servicio PRIMARY KEY CLUSTERED (Sk_Servicio)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE DIM_Sucursal 
    (
     Sk_Sucursal INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (100) NOT NULL , 
     Telefono VARCHAR (15) NOT NULL , 
     Distrito VARCHAR (60) NOT NULL , 
     Provincia VARCHAR (60) NOT NULL , 
     Departamento VARCHAR (60) NOT NULL 
    )
GO

ALTER TABLE DIM_Sucursal ADD CONSTRAINT PK_DIM_Sucursal PRIMARY KEY CLUSTERED (Sk_Sucursal)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE DIM_Tiempo 
    (
     Sk_Tiempo INTEGER NOT NULL , 
     Fecha DATE NOT NULL , 
     Dia INTEGER NOT NULL , 
     Nombre_Dia VARCHAR (15) NOT NULL , 
     Semana INTEGER NOT NULL , 
     Mes INTEGER NOT NULL , 
     Nombre_Mes VARCHAR (15) NOT NULL , 
     Trimestre INTEGER NOT NULL , 
     Anio INTEGER NOT NULL , 
     Es_Fin_de_Semana BIT NOT NULL 
    )
GO

ALTER TABLE DIM_Tiempo ADD CONSTRAINT PK_DIM_Tiempo PRIMARY KEY CLUSTERED (Sk_Tiempo)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE DIM_Tipo_Comprobante 
    (
     Sk_Tipo_Comprobante INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL 
    )
GO

ALTER TABLE DIM_Tipo_Comprobante ADD CONSTRAINT PK_DIM_Tipo_Comprobante PRIMARY KEY CLUSTERED (Sk_Tipo_Comprobante)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE DIM_Tipo_Incidencia 
    (
     Sk_Tipo_Incidencia INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL 
    )
GO

ALTER TABLE DIM_Tipo_Incidencia ADD CONSTRAINT PK_DIM_Tipo_Incidencia PRIMARY KEY CLUSTERED (Sk_Tipo_Incidencia)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE DIM_Ubicacion 
    (
     Sk_Ubicacion INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Distrito VARCHAR (60) NOT NULL , 
     Provincia VARCHAR (60) NOT NULL , 
     Departamento VARCHAR (60) NOT NULL 
    )
GO

ALTER TABLE DIM_Ubicacion ADD CONSTRAINT PK_DIM_Ubicacion PRIMARY KEY CLUSTERED (Sk_Ubicacion)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE DIM_Vehiculo 
    (
     Sk_Vehiculo INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Placa VARCHAR (10) NOT NULL , 
     Tipo_Vehiculo VARCHAR (60) NOT NULL , 
     Capacidad_Kg DECIMAL (8,2) NOT NULL , 
     Estado VARCHAR (30) NOT NULL 
    )
GO

ALTER TABLE DIM_Vehiculo ADD CONSTRAINT PK_DIM_Vehiculo PRIMARY KEY CLUSTERED (Sk_Vehiculo)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE FACT_Despacho 
    (
     Id_Despacho INTEGER NOT NULL , 
     Id_Envio INTEGER NOT NULL , 
     Sk_Tiempo_Salida INTEGER NOT NULL , 
     Sk_Tiempo_Llegada INTEGER , 
     Sk_Vehiculo INTEGER NOT NULL , 
     Sk_Conductor INTEGER NOT NULL , 
     Sk_Ruta INTEGER NOT NULL , 
     Sk_Sucursal_Origen INTEGER NOT NULL , 
     Sk_Sucursal_Destino INTEGER NOT NULL , 
     Cantidad_Paquetes INTEGER NOT NULL , 
     Peso_Transportado_Kg DECIMAL (10,2) NOT NULL , 
     Distancia_Km DECIMAL (8,2) NOT NULL , 
     Duracion_Viaje_Min INTEGER , 
     Porcentaje_Ocupacion DECIMAL (5,2) NOT NULL 
    )
GO

ALTER TABLE FACT_Despacho ADD CONSTRAINT PK_FACT_Despacho PRIMARY KEY CLUSTERED (Id_Despacho, Id_Envio)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE FACT_Envio 
    (
     Id_Envio INTEGER NOT NULL , 
     Sk_Tiempo_Registro INTEGER NOT NULL , 
     Sk_Tiempo_Estimada INTEGER NOT NULL , 
     Sk_Tiempo_Real INTEGER , 
     Sk_Cliente_Remitente INTEGER NOT NULL , 
     Sk_Cliente_Destinatario INTEGER NOT NULL , 
     Sk_Ubicacion_Origen INTEGER NOT NULL , 
     Sk_Ubicacion_Destino INTEGER NOT NULL , 
     Sk_Servicio INTEGER NOT NULL , 
     Sk_Estado INTEGER NOT NULL , 
     Sk_Sucursal INTEGER NOT NULL , 
     Cantidad_Paquetes INTEGER NOT NULL , 
     Peso_Total_Kg DECIMAL (10,2) NOT NULL , 
     Volumen_Total DECIMAL (12,2) NOT NULL , 
     Valor_Declarado_Total DECIMAL (10,2) NOT NULL , 
     Costo_Total DECIMAL (10,2) NOT NULL , 
     Tiempo_Entrega_Dias INTEGER , 
     Dias_Retraso INTEGER , 
     Entregado_a_Tiempo BIT , 
     Paquetes_Pago_Origen INTEGER NOT NULL , 
     Paquetes_Contra_Entrega INTEGER NOT NULL , 
     Monto_Pagado DECIMAL (10,2) NOT NULL , 
     Monto_Pendiente DECIMAL (10,2) NOT NULL 
    )
GO

ALTER TABLE FACT_Envio ADD CONSTRAINT PK_FACT_Envio PRIMARY KEY CLUSTERED (Id_Envio)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE FACT_Incidencia 
    (
     Id_Incidencia INTEGER NOT NULL , 
     Id_Envio INTEGER NOT NULL , 
     Sk_Tiempo INTEGER NOT NULL , 
     Sk_Tipo_Incidencia INTEGER NOT NULL , 
     Sk_Cliente INTEGER NOT NULL , 
     Sk_Servicio INTEGER NOT NULL , 
     Sk_Ubicacion_Destino INTEGER NOT NULL , 
     Cantidad_Incidencias INTEGER NOT NULL 
    )
GO

ALTER TABLE FACT_Incidencia ADD CONSTRAINT PK_FACT_Incidencia PRIMARY KEY CLUSTERED (Id_Incidencia)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE FACT_Pago 
    (
     Id_Pago INTEGER NOT NULL , 
     Serie VARCHAR (15) NOT NULL , 
     Numero_Comprobante VARCHAR (15) NOT NULL , 
     Sk_Tiempo INTEGER NOT NULL , 
     Sk_Cliente_Pagador INTEGER NOT NULL , 
     Sk_Metodo_Pago INTEGER NOT NULL , 
     Sk_Estado_Pago INTEGER NOT NULL , 
     Sk_Tipo_Comprobante INTEGER NOT NULL , 
     Monto DECIMAL (10,2) NOT NULL , 
     Subtotal DECIMAL (10,2) NOT NULL , 
     IGV DECIMAL (10,2) NOT NULL , 
     Total DECIMAL (10,2) NOT NULL 
    )
GO

ALTER TABLE FACT_Pago ADD CONSTRAINT PK_FACT_Pago PRIMARY KEY CLUSTERED (Id_Pago)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

ALTER TABLE FACT_Despacho 
    ADD CONSTRAINT FK_FACT_Despacho_Conductor FOREIGN KEY 
    ( 
     Sk_Conductor
    ) 
    REFERENCES DIM_Conductor 
    ( 
     Sk_Conductor 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Despacho 
    ADD CONSTRAINT FK_FACT_Despacho_Ruta FOREIGN KEY 
    ( 
     Sk_Ruta
    ) 
    REFERENCES DIM_Ruta 
    ( 
     Sk_Ruta 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Despacho 
    ADD CONSTRAINT FK_FACT_Despacho_Sucursal_Destino FOREIGN KEY 
    ( 
     Sk_Sucursal_Destino
    ) 
    REFERENCES DIM_Sucursal 
    ( 
     Sk_Sucursal 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Despacho 
    ADD CONSTRAINT FK_FACT_Despacho_Sucursal_Origen FOREIGN KEY 
    ( 
     Sk_Sucursal_Origen
    ) 
    REFERENCES DIM_Sucursal 
    ( 
     Sk_Sucursal 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Despacho 
    ADD CONSTRAINT FK_FACT_Despacho_Tiempo_Llegada FOREIGN KEY 
    ( 
     Sk_Tiempo_Llegada
    ) 
    REFERENCES DIM_Tiempo 
    ( 
     Sk_Tiempo 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Despacho 
    ADD CONSTRAINT FK_FACT_Despacho_Tiempo_Salida FOREIGN KEY 
    ( 
     Sk_Tiempo_Salida
    ) 
    REFERENCES DIM_Tiempo 
    ( 
     Sk_Tiempo 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Despacho 
    ADD CONSTRAINT FK_FACT_Despacho_Vehiculo FOREIGN KEY 
    ( 
     Sk_Vehiculo
    ) 
    REFERENCES DIM_Vehiculo 
    ( 
     Sk_Vehiculo 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Envio 
    ADD CONSTRAINT FK_FACT_Envio_Cliente_Destinatario FOREIGN KEY 
    ( 
     Sk_Cliente_Destinatario
    ) 
    REFERENCES DIM_Cliente 
    ( 
     Sk_Cliente 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Envio 
    ADD CONSTRAINT FK_FACT_Envio_Cliente_Remitente FOREIGN KEY 
    ( 
     Sk_Cliente_Remitente
    ) 
    REFERENCES DIM_Cliente 
    ( 
     Sk_Cliente 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Envio 
    ADD CONSTRAINT FK_FACT_Envio_Estado FOREIGN KEY 
    ( 
     Sk_Estado
    ) 
    REFERENCES DIM_Estado_Envio 
    ( 
     Sk_Estado 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Envio 
    ADD CONSTRAINT FK_FACT_Envio_Servicio FOREIGN KEY 
    ( 
     Sk_Servicio
    ) 
    REFERENCES DIM_Servicio 
    ( 
     Sk_Servicio 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Envio 
    ADD CONSTRAINT FK_FACT_Envio_Sucursal FOREIGN KEY 
    ( 
     Sk_Sucursal
    ) 
    REFERENCES DIM_Sucursal 
    ( 
     Sk_Sucursal 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Envio 
    ADD CONSTRAINT FK_FACT_Envio_Tiempo_Estimada FOREIGN KEY 
    ( 
     Sk_Tiempo_Estimada
    ) 
    REFERENCES DIM_Tiempo 
    ( 
     Sk_Tiempo 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Envio 
    ADD CONSTRAINT FK_FACT_Envio_Tiempo_Real FOREIGN KEY 
    ( 
     Sk_Tiempo_Real
    ) 
    REFERENCES DIM_Tiempo 
    ( 
     Sk_Tiempo 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Envio 
    ADD CONSTRAINT FK_FACT_Envio_Tiempo_Registro FOREIGN KEY 
    ( 
     Sk_Tiempo_Registro
    ) 
    REFERENCES DIM_Tiempo 
    ( 
     Sk_Tiempo 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Envio 
    ADD CONSTRAINT FK_FACT_Envio_Ubicacion_Destino FOREIGN KEY 
    ( 
     Sk_Ubicacion_Destino
    ) 
    REFERENCES DIM_Ubicacion 
    ( 
     Sk_Ubicacion 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Envio 
    ADD CONSTRAINT FK_FACT_Envio_Ubicacion_Origen FOREIGN KEY 
    ( 
     Sk_Ubicacion_Origen
    ) 
    REFERENCES DIM_Ubicacion 
    ( 
     Sk_Ubicacion 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Incidencia 
    ADD CONSTRAINT FK_FACT_Incidencia_Cliente FOREIGN KEY 
    ( 
     Sk_Cliente
    ) 
    REFERENCES DIM_Cliente 
    ( 
     Sk_Cliente 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Incidencia 
    ADD CONSTRAINT FK_FACT_Incidencia_Servicio FOREIGN KEY 
    ( 
     Sk_Servicio
    ) 
    REFERENCES DIM_Servicio 
    ( 
     Sk_Servicio 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Incidencia 
    ADD CONSTRAINT FK_FACT_Incidencia_Tiempo FOREIGN KEY 
    ( 
     Sk_Tiempo
    ) 
    REFERENCES DIM_Tiempo 
    ( 
     Sk_Tiempo 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Incidencia 
    ADD CONSTRAINT FK_FACT_Incidencia_Tipo_Incidencia FOREIGN KEY 
    ( 
     Sk_Tipo_Incidencia
    ) 
    REFERENCES DIM_Tipo_Incidencia 
    ( 
     Sk_Tipo_Incidencia 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Incidencia 
    ADD CONSTRAINT FK_FACT_Incidencia_Ubicacion_Destino FOREIGN KEY 
    ( 
     Sk_Ubicacion_Destino
    ) 
    REFERENCES DIM_Ubicacion 
    ( 
     Sk_Ubicacion 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Pago 
    ADD CONSTRAINT FK_FACT_Pago_Cliente_Pagador FOREIGN KEY 
    ( 
     Sk_Cliente_Pagador
    ) 
    REFERENCES DIM_Cliente 
    ( 
     Sk_Cliente 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Pago 
    ADD CONSTRAINT FK_FACT_Pago_Estado_Pago FOREIGN KEY 
    ( 
     Sk_Estado_Pago
    ) 
    REFERENCES DIM_Estado_Pago 
    ( 
     Sk_Estado_Pago 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Pago 
    ADD CONSTRAINT FK_FACT_Pago_Metodo_Pago FOREIGN KEY 
    ( 
     Sk_Metodo_Pago
    ) 
    REFERENCES DIM_Metodo_Pago 
    ( 
     Sk_Metodo_Pago 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Pago 
    ADD CONSTRAINT FK_FACT_Pago_Tiempo FOREIGN KEY 
    ( 
     Sk_Tiempo
    ) 
    REFERENCES DIM_Tiempo 
    ( 
     Sk_Tiempo 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACT_Pago 
    ADD CONSTRAINT FK_FACT_Pago_Tipo_Comprobante FOREIGN KEY 
    ( 
     Sk_Tipo_Comprobante
    ) 
    REFERENCES DIM_Tipo_Comprobante 
    ( 
     Sk_Tipo_Comprobante 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            17
-- CREATE INDEX                             0
-- ALTER TABLE                             45
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE DATABASE                          0
-- CREATE DEFAULT                           0
-- CREATE INDEX ON VIEW                     0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE ROLE                              0
-- CREATE RULE                              0
-- CREATE SCHEMA                            0
-- CREATE SEQUENCE                          0
-- CREATE PARTITION FUNCTION                0
-- CREATE PARTITION SCHEME                  0
-- 
-- DROP DATABASE                            0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
