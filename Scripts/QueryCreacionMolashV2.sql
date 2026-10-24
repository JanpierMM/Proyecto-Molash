-- Generado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   en:        2026-10-23 00:13:12 PET
--   sitio:      SQL Server 2012
--   tipo:      SQL Server 2012
IF DB_ID('Molash') IS NULL
    CREATE DATABASE Molash;

use Molash


CREATE TABLE Canal_Notificacion 
    (
     Id_Canal_Notificacion INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL 
    )
GO

ALTER TABLE Canal_Notificacion ADD CONSTRAINT Canal_Notificacion_PK PRIMARY KEY CLUSTERED (Id_Canal_Notificacion)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Cargo 
    (
     Id_Cargo INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL 
    )
GO

ALTER TABLE Cargo ADD CONSTRAINT Cargo_PK PRIMARY KEY CLUSTERED (Id_Cargo)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Categoria_Licencia 
    (
     Id_Categoria_Licencia INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (15) NOT NULL 
    )
GO

ALTER TABLE Categoria_Licencia ADD CONSTRAINT Categoria_Licencia_PK PRIMARY KEY CLUSTERED (Id_Categoria_Licencia)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Comprobante 
    (
     Id_Comprobante INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Serie VARCHAR (15) NOT NULL , 
     Numero VARCHAR (15) NOT NULL , 
     Fecha DATETIME NOT NULL , 
     SubTotal DECIMAL (10,2) NOT NULL , 
     IGV DECIMAL (10,2) NOT NULL , 
     Total DECIMAL (10,2) NOT NULL , 
     Pago_Id_Pago INTEGER NOT NULL , 
     Tipo_Comprobante_Id_Tipo_Comprobante INTEGER NOT NULL 
    )
GO

ALTER TABLE Comprobante ADD CONSTRAINT Comprobante_PK PRIMARY KEY CLUSTERED (Id_Comprobante)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO
ALTER TABLE Comprobante ADD CONSTRAINT UQ_Comprobante_Pago UNIQUE NONCLUSTERED (Pago_Id_Pago)
GO
ALTER TABLE Comprobante ADD CONSTRAINT UQ_Comprobante_Tipo_Serie_Numero UNIQUE NONCLUSTERED (Tipo_Comprobante_Id_Tipo_Comprobante, Serie, Numero)
GO

CREATE TABLE Condicion_Pago 
    (
     Id_Condicion_Pago INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL 
    )
GO

ALTER TABLE Condicion_Pago ADD CONSTRAINT Condicion_Pago_PK PRIMARY KEY CLUSTERED (Id_Condicion_Pago)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Conductor 
    (
     Id_Conductor INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Licencia VARCHAR (15) NOT NULL , 
     Vencimiento_Licencia DATE NOT NULL , 
     Empleado_Id_Empleado INTEGER NOT NULL , 
     Categoria_Licencia_Id_Categoria_Licencia INTEGER NOT NULL 
    )
GO

ALTER TABLE Conductor ADD CONSTRAINT Conductor_PK PRIMARY KEY CLUSTERED (Id_Conductor)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO
ALTER TABLE Conductor ADD CONSTRAINT UQ_Conductor_Licencia UNIQUE NONCLUSTERED (Licencia)
GO

CREATE TABLE Departamento 
    (
     Id_Departamento INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL 
    )
GO

ALTER TABLE Departamento ADD CONSTRAINT Departamento_PK PRIMARY KEY CLUSTERED (Id_Departamento)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Despacho 
    (
     Id_Despacho INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Fecha_Salida DATETIME NOT NULL , 
     Fecha_Llegada DATETIME , 
     Vehiculo_Id_Vehiculo INTEGER NOT NULL , 
     Conductor_Id_Conductor INTEGER NOT NULL , 
     Ruta_Id_Ruta INTEGER NOT NULL 
    )
GO

ALTER TABLE Despacho ADD CONSTRAINT Despacho_PK PRIMARY KEY CLUSTERED (Id_Despacho)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Detalle_Despacho 
    (
     Id_Detalle_Despacho INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Despacho_Id_Despacho INTEGER NOT NULL , 
     Envio_Id_Envio INTEGER NOT NULL 
    )
GO

ALTER TABLE Detalle_Despacho ADD CONSTRAINT Detalle_Despacho_PK PRIMARY KEY CLUSTERED (Id_Detalle_Despacho)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Detalle_Pago 
    (
     Id_Detalle_Pago INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Monto_Asignado DECIMAL (10,2) NOT NULL , 
     Pago_Id_Pago INTEGER NOT NULL , 
     Paquete_Id_Paquete INTEGER NOT NULL 
    )
GO

ALTER TABLE Detalle_Pago ADD CONSTRAINT Detalle_Pago_PK PRIMARY KEY CLUSTERED (Id_Detalle_Pago)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Direccion 
    (
     Id_Direccion INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Calle_Numero VARCHAR (150) NOT NULL , 
     Referencia VARCHAR (150) NOT NULL , 
     Distrito_Id_Distrito INTEGER NOT NULL 
    )
GO

ALTER TABLE Direccion ADD CONSTRAINT Direccion_PK PRIMARY KEY CLUSTERED (Id_Direccion)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Distrito 
    (
     Id_Distrito INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL , 
     Codigo_Postal VARCHAR (15) NOT NULL , 
     Provincia_Id_Provincia INTEGER NOT NULL 
    )
GO

ALTER TABLE Distrito ADD CONSTRAINT Distrito_PK PRIMARY KEY CLUSTERED (Id_Distrito)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Empleado 
    (
     Id_Empleado INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL , 
     Apellido VARCHAR (60) NOT NULL , 
     Fecha_Ingreso DATETIME NOT NULL , 
     Cargo_Id_Cargo INTEGER NOT NULL , 
     Sucursal_Id_Sucursal INTEGER NOT NULL 
    )
GO

ALTER TABLE Empleado ADD CONSTRAINT Empleado_PK PRIMARY KEY CLUSTERED (Id_Empleado)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Envio 
    (
     Id_Envio INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Codigo_Seguimiento VARCHAR (20) NOT NULL , 
     Fecha_Registro DATETIME NOT NULL , 
     Fecha_Estimada_Entrega DATE NOT NULL , 
     Fecha_Real_Entrega DATE , 
     Id_Remitente INTEGER NOT NULL , 
     Id_Destinatario INTEGER NOT NULL , 
     Id_Direccion_Origen INTEGER NOT NULL , 
     Id_Direccion_Destino INTEGER NOT NULL , 
     Id_Tipo_Servicio INTEGER NOT NULL , 
     Id_Estado_Envio INTEGER NOT NULL 
    )
GO

ALTER TABLE Envio ADD CONSTRAINT Envio_PK PRIMARY KEY CLUSTERED (Id_Envio)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO
ALTER TABLE Envio ADD CONSTRAINT UQ_Envio_Codigo_Seguimiento UNIQUE NONCLUSTERED (Codigo_Seguimiento)
GO

CREATE TABLE Estado_Envio 
    (
     Id_Estado_Envio INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL 
    )
GO

ALTER TABLE Estado_Envio ADD CONSTRAINT Estado_Envio_PK PRIMARY KEY CLUSTERED (Id_Estado_Envio)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Estado_Notificacion 
    (
     Id_Estado_Notificacion INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL 
    )
GO

ALTER TABLE Estado_Notificacion ADD CONSTRAINT Estado_Notificacion_PK PRIMARY KEY CLUSTERED (Id_Estado_Notificacion)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Estado_Pago 
    (
     Id_Estado_Pago INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (30) NOT NULL 
    )
GO

ALTER TABLE Estado_Pago ADD CONSTRAINT Estado_Pago_PK PRIMARY KEY CLUSTERED (Id_Estado_Pago)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Estado_Vehiculo 
    (
     Id_Estado_Vehiculo INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (30) NOT NULL 
    )
GO

ALTER TABLE Estado_Vehiculo ADD CONSTRAINT Estado_Vehiculo_PK PRIMARY KEY CLUSTERED (Id_Estado_Vehiculo)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Incidencia 
    (
     Id_Incidencia INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Fecha DATETIME NOT NULL , 
     Descripcion VARCHAR (250) NOT NULL , 
     Solucion VARCHAR (250) NOT NULL , 
     Envio_Id_Envio INTEGER NOT NULL , 
     Tipo_Incidencia_Id_Tipo_Incidencia INTEGER NOT NULL 
    )
GO

ALTER TABLE Incidencia ADD CONSTRAINT Incidencia_PK PRIMARY KEY CLUSTERED (Id_Incidencia)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Licencia_Tipo_Vehiculo 
    (
     Id_Licencia_Tipo_Vehiculo INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Categoria_Licencia_Id_Categoria_Licencia INTEGER NOT NULL , 
     Tipo_Vehiculo_Id_Tipo_Vehiculo INTEGER NOT NULL 
    )
GO

ALTER TABLE Licencia_Tipo_Vehiculo ADD CONSTRAINT Licencia_Tipo_Vehiculo_PK PRIMARY KEY CLUSTERED (Id_Licencia_Tipo_Vehiculo)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO
ALTER TABLE Licencia_Tipo_Vehiculo ADD CONSTRAINT UQ_Licencia_Tipo_Vehiculo_Categoria_Tipo UNIQUE NONCLUSTERED (Categoria_Licencia_Id_Categoria_Licencia, Tipo_Vehiculo_Id_Tipo_Vehiculo)
GO

CREATE TABLE Metodo_Pago 
    (
     Id_Metodo_Pago INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL 
    )
GO

ALTER TABLE Metodo_Pago ADD CONSTRAINT Metodo_Pago_PK PRIMARY KEY CLUSTERED (Id_Metodo_Pago)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Notificacion 
    (
     Id_Notificacion INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Mensaje VARCHAR (250) NOT NULL , 
     Fecha DATETIME NOT NULL , 
     Envio_Id_Envio INTEGER NOT NULL , 
     Persona_Id_Persona INTEGER NOT NULL , 
     Canal_Notificacion_Id_Canal_Notificacion INTEGER NOT NULL , 
     Estado_Notificacion_Id_Estado_Notificacion INTEGER NOT NULL 
    )
GO

ALTER TABLE Notificacion ADD CONSTRAINT Notificacion_PK PRIMARY KEY CLUSTERED (Id_Notificacion)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Pago 
    (
     Id_Pago INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Monto DECIMAL (10,2) NOT NULL , 
     Fecha DATETIME NOT NULL , 
     Persona_Id_Persona INTEGER NOT NULL , 
     Metodo_Pago_Id_Metodo_Pago INTEGER NOT NULL , 
     Estado_Pago_Id_Estado_Pago INTEGER NOT NULL 
    )
GO

ALTER TABLE Pago ADD CONSTRAINT Pago_PK PRIMARY KEY CLUSTERED (Id_Pago)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Paquete 
    (
     Id_Paquete INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Descripcion VARCHAR (200) NOT NULL , 
     Peso_Kg DECIMAL (8,2) NOT NULL , 
     Largo_cm DECIMAL (8,2) NOT NULL , 
     Ancho_cm DECIMAL (8,2) NOT NULL , 
     Alto_cm DECIMAL (8,2) NOT NULL , 
     Valor_Declarado DECIMAL (10,2) NOT NULL , 
     Asegurado BIT NOT NULL , 
     SubTotal DECIMAL (10,2) NOT NULL , 
     Envio_Id_Envio INTEGER NOT NULL , 
     Tipo_Paquete_Id_Tipo_Paquete INTEGER NOT NULL , 
     Condicion_Pago_Id_Condicion_Pago INTEGER NOT NULL 
    )
GO

ALTER TABLE Paquete ADD CONSTRAINT Paquete_PK PRIMARY KEY CLUSTERED (Id_Paquete)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Persona 
    (
     Id_Persona INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL , 
     Apellido VARCHAR (60) NOT NULL , 
     Documento VARCHAR (15) NOT NULL , 
     Telefono VARCHAR (15) NOT NULL , 
     Correo VARCHAR (100), 
     Tipo_Documento_Id_Tipo_Documento INTEGER NOT NULL , 
     Direccion_Id_Direccion INTEGER NOT NULL 
    )
GO

ALTER TABLE Persona ADD CONSTRAINT Persona_PK PRIMARY KEY CLUSTERED (Id_Persona)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO
ALTER TABLE Persona ADD CONSTRAINT UQ_Persona_Tipo_Documento_Documento UNIQUE NONCLUSTERED (Documento, Tipo_Documento_Id_Tipo_Documento)
GO

CREATE TABLE Provincia 
    (
     Id_Provincia INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL , 
     Departamento_Id_Departamento INTEGER NOT NULL 
    )
GO

ALTER TABLE Provincia ADD CONSTRAINT Provincia_PK PRIMARY KEY CLUSTERED (Id_Provincia)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Ruta 
    (
     Id_Ruta INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Distancia_Km DECIMAL (8,2) NOT NULL , 
     Duracion_Estimada_Minu INTEGER NOT NULL , 
     Sucursal_Id_Sucursal_Origen INTEGER NOT NULL , 
     Sucursal_Id_Sucursal_Destino INTEGER NOT NULL 
    )
GO

ALTER TABLE Ruta ADD CONSTRAINT Ruta_PK PRIMARY KEY CLUSTERED (Id_Ruta)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Seguimiento 
    (
     Id_Seguimiento INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Fecha_Hora DATETIME NOT NULL , 
     Ubicacion VARCHAR (150) NOT NULL , 
     Observacion VARCHAR (250) NOT NULL , 
     Envio_Id_Envio INTEGER NOT NULL , 
     Sucursal_Id_Sucursal INTEGER NOT NULL , 
     Estado_Envio_Id_Estado_Envio INTEGER NOT NULL 
    )
GO

ALTER TABLE Seguimiento ADD CONSTRAINT Seguimiento_PK PRIMARY KEY CLUSTERED (Id_Seguimiento)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Sucursal 
    (
     Id_Sucursal INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (100) NOT NULL , 
     Telefono VARCHAR (15) NOT NULL , 
     Direccion_Id_Direccion INTEGER NOT NULL 
    )
GO

ALTER TABLE Sucursal ADD CONSTRAINT Sucursal_PK PRIMARY KEY CLUSTERED (Id_Sucursal)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Tarifa 
    (
     Id_Tarifa INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Peso_Min DECIMAL (8,2) NOT NULL , 
     Peso_Max DECIMAL (8,2) NOT NULL , 
     Precio DECIMAL (10,2) NOT NULL , 
     Tipo_Servicio_Id_Tipo_Servicio INTEGER NOT NULL , 
     Zona_Id_Zona INTEGER NOT NULL 
    )
GO

ALTER TABLE Tarifa ADD CONSTRAINT Tarifa_PK PRIMARY KEY CLUSTERED (Id_Tarifa)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Tipo_Comprobante 
    (
     Id_Tipo_Comprobante INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL 
    )
GO

ALTER TABLE Tipo_Comprobante ADD CONSTRAINT Tipo_Comprobante_PK PRIMARY KEY CLUSTERED (Id_Tipo_Comprobante)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Tipo_Documento 
    (
     Id_Tipo_Documento INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (50) NOT NULL , 
     Longitud INTEGER NOT NULL 
    )
GO

ALTER TABLE Tipo_Documento ADD CONSTRAINT Tipo_Documento_PK PRIMARY KEY CLUSTERED (Id_Tipo_Documento)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Tipo_Incidencia 
    (
     Id_Tipo_Incidencia INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL 
    )
GO

ALTER TABLE Tipo_Incidencia ADD CONSTRAINT Tipo_Incidencia_PK PRIMARY KEY CLUSTERED (Id_Tipo_Incidencia)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Tipo_Paquete 
    (
     Id_Tipo_Paquete INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL , 
     Recargo DECIMAL (10,2) NOT NULL 
    )
GO

ALTER TABLE Tipo_Paquete ADD CONSTRAINT Tipo_Paquete_PK PRIMARY KEY CLUSTERED (Id_Tipo_Paquete)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Tipo_Servicio 
    (
     Id_Tipo_Servicio INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL , 
     Tiempo_Entrega_Hr INTEGER NOT NULL , 
     Tarifa_Base DECIMAL (10,2) NOT NULL 
    )
GO

ALTER TABLE Tipo_Servicio ADD CONSTRAINT Tipo_Servicio_PK PRIMARY KEY CLUSTERED (Id_Tipo_Servicio)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Tipo_Vehiculo 
    (
     Id_Tipo_Vehiculo INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL , 
     Capacidad_Maxima_Kg DECIMAL (8,2) NOT NULL 
    )
GO

ALTER TABLE Tipo_Vehiculo ADD CONSTRAINT Tipo_Vehiculo_PK PRIMARY KEY CLUSTERED (Id_Tipo_Vehiculo)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Vehiculo 
    (
     Id_Vehiculo INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Placa VARCHAR (10) NOT NULL , 
     Capacidad_Kg DECIMAL (8,2) NOT NULL , 
     Tipo_Vehiculo_Id_Tipo_Vehiculo INTEGER NOT NULL , 
     Estado_Vehiculo_Id_Estado_Vehiculo INTEGER NOT NULL 
    )
GO

ALTER TABLE Vehiculo ADD CONSTRAINT Vehiculo_PK PRIMARY KEY CLUSTERED (Id_Vehiculo)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO
ALTER TABLE Vehiculo ADD CONSTRAINT UQ_Vehiculo_Placa UNIQUE NONCLUSTERED (Placa)
GO

CREATE TABLE Zona 
    (
     Id_Zona INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR (60) NOT NULL 
    )
GO

ALTER TABLE Zona ADD CONSTRAINT Zona_PK PRIMARY KEY CLUSTERED (Id_Zona)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

ALTER TABLE Comprobante 
    ADD CONSTRAINT Comprobante_Pago_FK FOREIGN KEY 
    ( 
     Pago_Id_Pago
    ) 
    REFERENCES Pago 
    ( 
     Id_Pago 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Comprobante 
    ADD CONSTRAINT Comprobante_Tipo_Comprobante_FK FOREIGN KEY 
    ( 
     Tipo_Comprobante_Id_Tipo_Comprobante
    ) 
    REFERENCES Tipo_Comprobante 
    ( 
     Id_Tipo_Comprobante 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Conductor 
    ADD CONSTRAINT Conductor_Categoria_Licencia_FK FOREIGN KEY 
    ( 
     Categoria_Licencia_Id_Categoria_Licencia
    ) 
    REFERENCES Categoria_Licencia 
    ( 
     Id_Categoria_Licencia 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Conductor 
    ADD CONSTRAINT Conductor_Empleado_FK FOREIGN KEY 
    ( 
     Empleado_Id_Empleado
    ) 
    REFERENCES Empleado 
    ( 
     Id_Empleado 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Despacho 
    ADD CONSTRAINT Despacho_Conductor_FK FOREIGN KEY 
    ( 
     Conductor_Id_Conductor
    ) 
    REFERENCES Conductor 
    ( 
     Id_Conductor 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Despacho 
    ADD CONSTRAINT Despacho_Ruta_FK FOREIGN KEY 
    ( 
     Ruta_Id_Ruta
    ) 
    REFERENCES Ruta 
    ( 
     Id_Ruta 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Despacho 
    ADD CONSTRAINT Despacho_Vehiculo_FK FOREIGN KEY 
    ( 
     Vehiculo_Id_Vehiculo
    ) 
    REFERENCES Vehiculo 
    ( 
     Id_Vehiculo 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Detalle_Despacho 
    ADD CONSTRAINT Detalle_Despacho_Despacho_FK FOREIGN KEY 
    ( 
     Despacho_Id_Despacho
    ) 
    REFERENCES Despacho 
    ( 
     Id_Despacho 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Detalle_Despacho 
    ADD CONSTRAINT Detalle_Despacho_Envio_FK FOREIGN KEY 
    ( 
     Envio_Id_Envio
    ) 
    REFERENCES Envio 
    ( 
     Id_Envio 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Detalle_Pago 
    ADD CONSTRAINT Detalle_Pago_Pago_FK FOREIGN KEY 
    ( 
     Pago_Id_Pago
    ) 
    REFERENCES Pago 
    ( 
     Id_Pago 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Detalle_Pago 
    ADD CONSTRAINT Detalle_Pago_Paquete_FK FOREIGN KEY 
    ( 
     Paquete_Id_Paquete
    ) 
    REFERENCES Paquete 
    ( 
     Id_Paquete 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Direccion 
    ADD CONSTRAINT Direccion_Distrito_FK FOREIGN KEY 
    ( 
     Distrito_Id_Distrito
    ) 
    REFERENCES Distrito 
    ( 
     Id_Distrito 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Distrito 
    ADD CONSTRAINT Distrito_Provincia_FK FOREIGN KEY 
    ( 
     Provincia_Id_Provincia
    ) 
    REFERENCES Provincia 
    ( 
     Id_Provincia 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Empleado 
    ADD CONSTRAINT Empleado_Cargo_FK FOREIGN KEY 
    ( 
     Cargo_Id_Cargo
    ) 
    REFERENCES Cargo 
    ( 
     Id_Cargo 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Empleado 
    ADD CONSTRAINT Empleado_Sucursal_FK FOREIGN KEY 
    ( 
     Sucursal_Id_Sucursal
    ) 
    REFERENCES Sucursal 
    ( 
     Id_Sucursal 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Envio 
    ADD CONSTRAINT Envio_Direccion_Destino_FK FOREIGN KEY 
    ( 
     Id_Direccion_Destino
    ) 
    REFERENCES Direccion 
    ( 
     Id_Direccion 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Envio 
    ADD CONSTRAINT Envio_Direccion_Origen_FK FOREIGN KEY 
    ( 
     Id_Direccion_Origen
    ) 
    REFERENCES Direccion 
    ( 
     Id_Direccion 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Envio 
    ADD CONSTRAINT Envio_Estado_Envio_FK FOREIGN KEY 
    ( 
     Id_Estado_Envio
    ) 
    REFERENCES Estado_Envio 
    ( 
     Id_Estado_Envio 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Envio 
    ADD CONSTRAINT Envio_Persona_Destinatario_FK FOREIGN KEY 
    ( 
     Id_Destinatario
    ) 
    REFERENCES Persona 
    ( 
     Id_Persona 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Envio 
    ADD CONSTRAINT Envio_Persona_Remitente_FK FOREIGN KEY 
    ( 
     Id_Remitente
    ) 
    REFERENCES Persona 
    ( 
     Id_Persona 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Envio 
    ADD CONSTRAINT Envio_Tipo_Servicio_FK FOREIGN KEY 
    ( 
     Id_Tipo_Servicio
    ) 
    REFERENCES Tipo_Servicio 
    ( 
     Id_Tipo_Servicio 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Incidencia 
    ADD CONSTRAINT Incidencia_Envio_FK FOREIGN KEY 
    ( 
     Envio_Id_Envio
    ) 
    REFERENCES Envio 
    ( 
     Id_Envio 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Incidencia 
    ADD CONSTRAINT Incidencia_Tipo_Incidencia_FK FOREIGN KEY 
    ( 
     Tipo_Incidencia_Id_Tipo_Incidencia
    ) 
    REFERENCES Tipo_Incidencia 
    ( 
     Id_Tipo_Incidencia 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Licencia_Tipo_Vehiculo 
    ADD CONSTRAINT Licencia_Tipo_Vehiculo_Categoria_Licencia_FK FOREIGN KEY 
    ( 
     Categoria_Licencia_Id_Categoria_Licencia
    ) 
    REFERENCES Categoria_Licencia 
    ( 
     Id_Categoria_Licencia 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Licencia_Tipo_Vehiculo 
    ADD CONSTRAINT Licencia_Tipo_Vehiculo_Tipo_Vehiculo_FK FOREIGN KEY 
    ( 
     Tipo_Vehiculo_Id_Tipo_Vehiculo
    ) 
    REFERENCES Tipo_Vehiculo 
    ( 
     Id_Tipo_Vehiculo 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Notificacion 
    ADD CONSTRAINT Notificacion_Canal_Notificacion_FK FOREIGN KEY 
    ( 
     Canal_Notificacion_Id_Canal_Notificacion
    ) 
    REFERENCES Canal_Notificacion 
    ( 
     Id_Canal_Notificacion 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Notificacion 
    ADD CONSTRAINT Notificacion_Envio_FK FOREIGN KEY 
    ( 
     Envio_Id_Envio
    ) 
    REFERENCES Envio 
    ( 
     Id_Envio 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Notificacion 
    ADD CONSTRAINT Notificacion_Estado_Notificacion_FK FOREIGN KEY 
    ( 
     Estado_Notificacion_Id_Estado_Notificacion
    ) 
    REFERENCES Estado_Notificacion 
    ( 
     Id_Estado_Notificacion 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Notificacion 
    ADD CONSTRAINT Notificacion_Persona_FK FOREIGN KEY 
    ( 
     Persona_Id_Persona
    ) 
    REFERENCES Persona 
    ( 
     Id_Persona 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Pago 
    ADD CONSTRAINT Pago_Estado_Pago_FK FOREIGN KEY 
    ( 
     Estado_Pago_Id_Estado_Pago
    ) 
    REFERENCES Estado_Pago 
    ( 
     Id_Estado_Pago 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Pago 
    ADD CONSTRAINT Pago_Metodo_Pago_FK FOREIGN KEY 
    ( 
     Metodo_Pago_Id_Metodo_Pago
    ) 
    REFERENCES Metodo_Pago 
    ( 
     Id_Metodo_Pago 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Pago 
    ADD CONSTRAINT Pago_Persona_Pagador_FK FOREIGN KEY 
    ( 
     Persona_Id_Persona
    ) 
    REFERENCES Persona 
    ( 
     Id_Persona 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Paquete 
    ADD CONSTRAINT Paquete_Condicion_Pago_FK FOREIGN KEY 
    ( 
     Condicion_Pago_Id_Condicion_Pago
    ) 
    REFERENCES Condicion_Pago 
    ( 
     Id_Condicion_Pago 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Paquete 
    ADD CONSTRAINT Paquete_Envio_FK FOREIGN KEY 
    ( 
     Envio_Id_Envio
    ) 
    REFERENCES Envio 
    ( 
     Id_Envio 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Paquete 
    ADD CONSTRAINT Paquete_Tipo_Paquete_FK FOREIGN KEY 
    ( 
     Tipo_Paquete_Id_Tipo_Paquete
    ) 
    REFERENCES Tipo_Paquete 
    ( 
     Id_Tipo_Paquete 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Persona 
    ADD CONSTRAINT Persona_Direccion_FK FOREIGN KEY 
    ( 
     Direccion_Id_Direccion
    ) 
    REFERENCES Direccion 
    ( 
     Id_Direccion 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Persona 
    ADD CONSTRAINT Persona_Tipo_Documento_FK FOREIGN KEY 
    ( 
     Tipo_Documento_Id_Tipo_Documento
    ) 
    REFERENCES Tipo_Documento 
    ( 
     Id_Tipo_Documento 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Provincia 
    ADD CONSTRAINT Provincia_Departamento_FK FOREIGN KEY 
    ( 
     Departamento_Id_Departamento
    ) 
    REFERENCES Departamento 
    ( 
     Id_Departamento 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Ruta 
    ADD CONSTRAINT Ruta_Sucursal_Destino_FK FOREIGN KEY 
    ( 
     Sucursal_Id_Sucursal_Destino
    ) 
    REFERENCES Sucursal 
    ( 
     Id_Sucursal 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Ruta 
    ADD CONSTRAINT Ruta_Sucursal_Origen_FK FOREIGN KEY 
    ( 
     Sucursal_Id_Sucursal_Origen
    ) 
    REFERENCES Sucursal 
    ( 
     Id_Sucursal 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Seguimiento 
    ADD CONSTRAINT Seguimiento_Envio_FK FOREIGN KEY 
    ( 
     Envio_Id_Envio
    ) 
    REFERENCES Envio 
    ( 
     Id_Envio 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Seguimiento 
    ADD CONSTRAINT Seguimiento_Estado_Envio_FK FOREIGN KEY 
    ( 
     Estado_Envio_Id_Estado_Envio
    ) 
    REFERENCES Estado_Envio 
    ( 
     Id_Estado_Envio 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Seguimiento 
    ADD CONSTRAINT Seguimiento_Sucursal_FK FOREIGN KEY 
    ( 
     Sucursal_Id_Sucursal
    ) 
    REFERENCES Sucursal 
    ( 
     Id_Sucursal 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Sucursal 
    ADD CONSTRAINT Sucursal_Direccion_FK FOREIGN KEY 
    ( 
     Direccion_Id_Direccion
    ) 
    REFERENCES Direccion 
    ( 
     Id_Direccion 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Tarifa 
    ADD CONSTRAINT Tarifa_Tipo_Servicio_FK FOREIGN KEY 
    ( 
     Tipo_Servicio_Id_Tipo_Servicio
    ) 
    REFERENCES Tipo_Servicio 
    ( 
     Id_Tipo_Servicio 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Tarifa 
    ADD CONSTRAINT Tarifa_Zona_FK FOREIGN KEY 
    ( 
     Zona_Id_Zona
    ) 
    REFERENCES Zona 
    ( 
     Id_Zona 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Vehiculo 
    ADD CONSTRAINT Vehiculo_Estado_Vehiculo_FK FOREIGN KEY 
    ( 
     Estado_Vehiculo_Id_Estado_Vehiculo
    ) 
    REFERENCES Estado_Vehiculo 
    ( 
     Id_Estado_Vehiculo 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Vehiculo 
    ADD CONSTRAINT Vehiculo_Tipo_Vehiculo_FK FOREIGN KEY 
    ( 
     Tipo_Vehiculo_Id_Tipo_Vehiculo
    ) 
    REFERENCES Tipo_Vehiculo 
    ( 
     Id_Tipo_Vehiculo 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            38
-- CREATE INDEX                             0
-- ALTER TABLE                             93
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
