/*
    POBLAMIENTO DE PRUEBA - MOLASH (SQL Server 2012)
    Periodo: 2020-2024 inclusive. 1,200 envios por mes = 14,400 por anio = 72,000 envios.
    Datos ficticios; importes en soles (PEN).
    -- Importante --
    Este script de poblamiento fue genrado con la asistencia de ChatGpt. 
    (Se modico el script original cambiando algunos datos o agregando datos manualmente)
    con el proposito de insertar datos transaccionales de prueba el volumen total de los datos generados
    supera el millon de filas insertadas en conjunto (clientes, envios, detalles, pagos, seguimiento y catalogos).
    los datos son 100% ficticios, el codigo fue validado manualmente ejecutandolo en SQL Server management, 
    confirmando que las intersecciones respetan todas las restricciones de integridad.
    
*/
USE Molash;
GO
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRY
BEGIN TRANSACTION;

DECLARE @TotalEnvios INT = 72000;
DECLARE @EnviosPorMes INT = 1200;
DECLARE @TotalEmpleados INT = 35;
DECLARE @TotalConductores INT = 15;
DECLARE @TotalVehiculos INT = 12;
DECLARE @EventosPorEnvio INT = 8;
DECLARE @TotalDireccionesObjetivo INT = 80;

DECLARE @CfgSucursales TABLE
(
    NombreSucursal VARCHAR(100) NOT NULL,
    Telefono VARCHAR(15) NOT NULL,
    Departamento VARCHAR(60) NOT NULL,
    Provincia VARCHAR(60) NOT NULL,
    Distrito VARCHAR(60) NOT NULL,
    CodigoPostal VARCHAR(15) NOT NULL,
    CalleNumero VARCHAR(150) NOT NULL,
    Referencia VARCHAR(150) NOT NULL
);
INSERT INTO @CfgSucursales VALUES
('Sucursal Trujillo','044500101','La Libertad','Trujillo','Trujillo','13001','Av. España 245','Centro de Trujillo'),
('Sucursal Lima - Centro','01500101','Lima','Lima','Lima','15001','Av. Abancay 420','Cercado de Lima'),
('Sucursal Lima - Miraflores','01500102','Lima','Lima','Miraflores','15074','Av. Larco 650','Miraflores'),
('Sucursal Lima - San Isidro','01500103','Lima','Lima','San Isidro','15046','Av. Arequipa 2800','San Isidro'),
('Sucursal Lima - San Miguel','01500104','Lima','Lima','San Miguel','15087','Av. La Marina 2200','San Miguel'),
('Sucursal Lima - Surco','01500105','Lima','Lima','Santiago de Surco','15039','Av. Benavides 3500','Santiago de Surco'),
('Sucursal Lima - Los Olivos','01500106','Lima','Lima','Los Olivos','15301','Av. Alfredo Mendiola 3600','Los Olivos'),
('Sucursal Chiclayo','074500103','Lambayeque','Chiclayo','Chiclayo','14001','Av. Balta 680','Centro de Chiclayo'),
('Sucursal Piura','073500104','Piura','Piura','Piura','20001','Av. Grau 550','Centro de Piura'),
('Sucursal Tumbes','072500105','Tumbes','Tumbes','Tumbes','24001','Av. Tumbes 420','Centro de Tumbes'),
('Sucursal Chimbote','043500106','Ancash','Santa','Chimbote','02800','Av. Pardo 510','Centro de Chimbote'),
('Sucursal Cajamarca','076500107','Cajamarca','Cajamarca','Cajamarca','06001','Jr. Del Comercio 320','Centro de Cajamarca'),
('Sucursal Huaraz','043500108','Ancash','Huaraz','Huaraz','02001','Av. Luzuriaga 470','Centro de Huaraz');
DECLARE @TotalSucursales INT;
SELECT @TotalSucursales=COUNT(*) FROM @CfgSucursales;

DECLARE @CfgServicios TABLE
(
    Nombre VARCHAR(60) NOT NULL,
    TiempoEntregaHr INT NOT NULL,
    TarifaBase DECIMAL(10,2) NOT NULL,
    Orden INT NOT NULL
);
INSERT INTO @CfgServicios VALUES
('Express',24,22.00,1),
('Estándar',72,16.00,2),
('Económico',120,10.00,3);

DECLARE @CfgCargos TABLE (Nombre VARCHAR(60) NOT NULL, Orden INT NOT NULL);
INSERT INTO @CfgCargos VALUES
('Conductor',1),('Personal',2),('Almacén',3),('Administración',4),('Gerente General',5);

DECLARE @CfgTiposVehiculo TABLE
(
    Nombre VARCHAR(60) NOT NULL,
    CapacidadMaximaKg DECIMAL(8,2) NOT NULL
);
INSERT INTO @CfgTiposVehiculo VALUES
('Moto',40.00),('Furgoneta',900.00),('Camión',5000.00);

DECLARE @CfgVehiculos TABLE
(
    Placa VARCHAR(10) NOT NULL,
    TipoVehiculo VARCHAR(60) NOT NULL,
    CapacidadKg DECIMAL(8,2) NOT NULL
);
INSERT INTO @CfgVehiculos VALUES
('4821-AB','Moto',35.00),('5932-CD','Moto',35.00),('6147-EF','Moto',40.00),('7258-GH','Moto',30.00),
('BXY-201','Furgoneta',800.00),('CZA-314','Furgoneta',850.00),('DLM-427','Furgoneta',900.00),('FNP-538','Furgoneta',750.00),
('TQK-601','Camión',4500.00),('VRS-712','Camión',5000.00),('WHT-823','Camión',4800.00),('XJP-934','Camión',5000.00);

DECLARE @CfgEventos TABLE
(
    Numero INT NOT NULL,
    ProgresoPorcentaje INT NOT NULL,
    Ubicacion VARCHAR(150) NOT NULL,
    Observacion VARCHAR(250) NOT NULL,
    Estado VARCHAR(60) NOT NULL
);
INSERT INTO @CfgEventos VALUES
(1,0,'Agencia de origen','Envio registrado en la sucursal de origen','Registrado'),
(2,5,'Agencia de origen','Paquete recibido, pesado y etiquetado','Registrado'),
(3,12,'Centro de clasificacion','Paquete clasificado para despacho','En tránsito'),
(4,25,'Unidad de transporte','Vehiculo salio hacia el siguiente centro logistico','En tránsito'),
(5,40,'Centro logistico regional','Paquete recibido y escaneado en centro regional','En tránsito'),
(6,60,'Sucursal de destino','Paquete recibido en la sucursal de destino','En tránsito'),
(7,80,'Zona de reparto','Paquete asignado a una ruta de reparto','En reparto'),
(8,100,'Destino final','Estado final del envio','DINAMICO');

IF @TotalSucursales<>13
    RAISERROR('La configuracion debe contener 13 sucursales.',16,1);
IF (SELECT COUNT(*) FROM @CfgVehiculos)<>@TotalVehiculos
    RAISERROR('La cantidad de placas configuradas no coincide con @TotalVehiculos.',16,1);
IF (SELECT COUNT(*) FROM @CfgEventos)<>@EventosPorEnvio
    RAISERROR('La cantidad de eventos configurados no coincide con @EventosPorEnvio.',16,1);
IF @TotalConductores>@TotalEmpleados
    RAISERROR('Los conductores no pueden superar el total de empleados.',16,1);

/* 1. Catalogos */
IF NOT EXISTS (SELECT 1 FROM Tipo_Documento)
 INSERT Tipo_Documento(Nombre,Longitud) VALUES ('DNI',8),('CE',12),('RUC',11);
IF NOT EXISTS (SELECT 1 FROM Estado_Envio)
 INSERT Estado_Envio(Nombre) VALUES ('Registrado'),('En tránsito'),('En reparto'),('Entregado'),('Retrasado'),('Cancelado');
/* Normalizar nombres antiguos si se reutiliza una base de pruebas anterior. */
UPDATE Tipo_Servicio SET Nombre='Estándar' WHERE Nombre='Estandar';
UPDATE Tipo_Servicio SET Nombre='Económico' WHERE Nombre='Prioritario';
INSERT Tipo_Servicio(Nombre,Tiempo_Entrega_Hr,Tarifa_Base)
SELECT c.Nombre,c.TiempoEntregaHr,c.TarifaBase FROM @CfgServicios c
WHERE NOT EXISTS (SELECT 1 FROM Tipo_Servicio t WHERE t.Nombre=c.Nombre);
UPDATE t SET Tiempo_Entrega_Hr=c.TiempoEntregaHr,Tarifa_Base=c.TarifaBase
FROM Tipo_Servicio t JOIN @CfgServicios c ON c.Nombre=t.Nombre;
IF NOT EXISTS (SELECT 1 FROM Tipo_Paquete)
 INSERT Tipo_Paquete(Nombre,Recargo) VALUES ('Sobre',0),('Caja pequeña',3.00),('Caja mediana',7.00),('Frágil',12.00);
IF NOT EXISTS (SELECT 1 FROM Condicion_Pago)
 INSERT Condicion_Pago(Nombre) VALUES ('Prepago'),('Contra entrega');
IF NOT EXISTS (SELECT 1 FROM Estado_Pago)
 INSERT Estado_Pago(Nombre) VALUES ('Pagado'),('Pendiente'),('Anulado');
IF NOT EXISTS (SELECT 1 FROM Metodo_Pago)
 INSERT Metodo_Pago(Nombre) VALUES ('Efectivo'),('Tarjeta'),('Transferencia'),('Billetera digital');
IF NOT EXISTS (SELECT 1 FROM Tipo_Comprobante)
 INSERT Tipo_Comprobante(Nombre) VALUES ('Boleta'),('Factura');
IF NOT EXISTS (SELECT 1 FROM Tipo_Incidencia)
 INSERT Tipo_Incidencia(Nombre) VALUES ('Retraso por clima'),('Dirección incompleta'),('Paquete dañado'),('Destinatario ausente');
IF NOT EXISTS (SELECT 1 FROM Canal_Notificacion)
 INSERT Canal_Notificacion(Nombre) VALUES ('Correo'),('SMS'),('Aplicación');
IF NOT EXISTS (SELECT 1 FROM Estado_Notificacion)
 INSERT Estado_Notificacion(Nombre) VALUES ('Enviada'),('Pendiente'),('Fallida');
UPDATE Cargo SET Nombre='Administración' WHERE Nombre='Administrador';
UPDATE Cargo SET Nombre='Personal' WHERE Nombre='Agente de operaciones';
UPDATE Cargo SET Nombre='Almacén' WHERE Nombre='Atención al cliente';
INSERT Cargo(Nombre)
SELECT c.Nombre FROM @CfgCargos c
WHERE NOT EXISTS (SELECT 1 FROM Cargo x WHERE x.Nombre=c.Nombre);
IF NOT EXISTS (SELECT 1 FROM Categoria_Licencia)
 INSERT Categoria_Licencia(Nombre) VALUES ('A-IIa'),('A-IIb'),('A-IIIa');
IF NOT EXISTS (SELECT 1 FROM Estado_Vehiculo)
 INSERT Estado_Vehiculo(Nombre) VALUES ('Operativo'),('Mantenimiento'),('Inactivo');
UPDATE Tipo_Vehiculo SET Nombre='Moto' WHERE Nombre='Motocicleta';
UPDATE Tipo_Vehiculo SET Nombre='Camión' WHERE Nombre='Camion';
INSERT Tipo_Vehiculo(Nombre,Capacidad_Maxima_Kg)
SELECT c.Nombre,c.CapacidadMaximaKg FROM @CfgTiposVehiculo c
WHERE NOT EXISTS (SELECT 1 FROM Tipo_Vehiculo t WHERE t.Nombre=c.Nombre);
UPDATE t SET Capacidad_Maxima_Kg=c.CapacidadMaximaKg
FROM Tipo_Vehiculo t JOIN @CfgTiposVehiculo c ON c.Nombre=t.Nombre;
IF NOT EXISTS (SELECT 1 FROM Zona)
 INSERT Zona(Nombre) VALUES ('Local'),('Regional'),('Nacional');

/* 2. Geografia realista: departamentos, provincias y distritos usados por sucursales.
      Se insertan solo las combinaciones que no existan, evitando duplicados. */
INSERT Departamento(Nombre)
SELECT DISTINCT c.Departamento FROM @CfgSucursales c
WHERE NOT EXISTS (SELECT 1 FROM Departamento d WHERE d.Nombre=c.Departamento);

INSERT Provincia(Nombre,Departamento_Id_Departamento)
SELECT DISTINCT c.Provincia,d.Id_Departamento
FROM @CfgSucursales c
JOIN Departamento d ON d.Nombre=c.Departamento
WHERE NOT EXISTS
(
    SELECT 1 FROM Provincia p
    WHERE p.Nombre=c.Provincia AND p.Departamento_Id_Departamento=d.Id_Departamento
);

INSERT Distrito(Nombre,Codigo_Postal,Provincia_Id_Provincia)
SELECT DISTINCT c.Distrito,c.CodigoPostal,p.Id_Provincia
FROM @CfgSucursales c
JOIN Departamento d ON d.Nombre=c.Departamento
JOIN Provincia p ON p.Nombre=c.Provincia AND p.Departamento_Id_Departamento=d.Id_Departamento
WHERE NOT EXISTS
(
    SELECT 1 FROM Distrito x
    WHERE x.Nombre=c.Distrito AND x.Provincia_Id_Provincia=p.Id_Provincia
);

/* 3. Direcciones y sucursales. Cada sucursal usa su direccion configurada.
      Las direcciones adicionales sirven para personas/remitentes/destinatarios. */
INSERT Direccion(Calle_Numero,Referencia,Distrito_Id_Distrito)
SELECT c.CalleNumero,c.Referencia,x.Id_Distrito
FROM @CfgSucursales c
JOIN Departamento d ON d.Nombre=c.Departamento
JOIN Provincia p ON p.Nombre=c.Provincia AND p.Departamento_Id_Departamento=d.Id_Departamento
JOIN Distrito x ON x.Nombre=c.Distrito AND x.Provincia_Id_Provincia=p.Id_Provincia
WHERE NOT EXISTS
(
    SELECT 1 FROM Direccion a
    WHERE a.Calle_Numero=c.CalleNumero AND a.Distrito_Id_Distrito=x.Id_Distrito
);

DECLARE @iDir INT=1, @dist INT;
WHILE (SELECT COUNT(*) FROM Direccion)<@TotalDireccionesObjetivo
BEGIN
    SELECT @dist=Id_Distrito
    FROM
    (
        SELECT Id_Distrito,ROW_NUMBER() OVER(ORDER BY Id_Distrito) rn FROM Distrito
    ) d
    WHERE rn=((@iDir-1)%(SELECT COUNT(*) FROM Distrito))+1;

    IF NOT EXISTS (SELECT 1 FROM Direccion WHERE Calle_Numero=CONCAT('Av. Los Olivos ',100+@iDir))
        INSERT Direccion(Calle_Numero,Referencia,Distrito_Id_Distrito)
        VALUES(CONCAT('Av. Los Olivos ',100+@iDir),CONCAT('Direccion ficticia para pruebas ',@iDir),@dist);
    SET @iDir+=1;
END;

INSERT Sucursal(Nombre,Telefono,Direccion_Id_Direccion)
SELECT c.NombreSucursal,c.Telefono,a.Id_Direccion
FROM @CfgSucursales c
JOIN Departamento d ON d.Nombre=c.Departamento
JOIN Provincia p ON p.Nombre=c.Provincia AND p.Departamento_Id_Departamento=d.Id_Departamento
JOIN Distrito x ON x.Nombre=c.Distrito AND x.Provincia_Id_Provincia=p.Id_Provincia
JOIN Direccion a ON a.Calle_Numero=c.CalleNumero AND a.Distrito_Id_Distrito=x.Id_Distrito
WHERE NOT EXISTS (SELECT 1 FROM Sucursal s WHERE s.Nombre=c.NombreSucursal);

IF NOT EXISTS (SELECT 1 FROM Persona)
BEGIN
 DECLARE @iPer INT=1, @dirPer INT, @tipoDoc INT;
 WHILE @iPer<=600
 BEGIN
  SELECT @dirPer=Id_Direccion FROM (SELECT Id_Direccion,ROW_NUMBER() OVER(ORDER BY Id_Direccion) rn FROM Direccion) x WHERE rn=((@iPer-1)% (SELECT COUNT(*) FROM Direccion))+1;
  SELECT @tipoDoc=Id_Tipo_Documento FROM Tipo_Documento WHERE Nombre=CASE WHEN @iPer%10=0 THEN 'CE' ELSE 'DNI' END;
  INSERT Persona(Nombre,Apellido,Documento,Telefono,Correo,Tipo_Documento_Id_Tipo_Documento,Direccion_Id_Direccion)
  VALUES (CASE @iPer%12 WHEN 0 THEN 'María' WHEN 1 THEN 'José' WHEN 2 THEN 'Lucía' WHEN 3 THEN 'Diego' WHEN 4 THEN 'Valeria' WHEN 5 THEN 'Carlos' WHEN 6 THEN 'Andrea' WHEN 7 THEN 'Luis' WHEN 8 THEN 'Camila' WHEN 9 THEN 'Jorge' WHEN 10 THEN 'Daniela' ELSE 'Miguel' END,
  CASE @iPer%10 WHEN 0 THEN 'García' WHEN 1 THEN 'Rojas' WHEN 2 THEN 'Torres' WHEN 3 THEN 'Flores' WHEN 4 THEN 'Díaz' WHEN 5 THEN 'Vargas' WHEN 6 THEN 'Castillo' WHEN 7 THEN 'Ramírez' WHEN 8 THEN 'Paredes' ELSE 'Mendoza' END,
  CASE WHEN @iPer%10=0 THEN CONCAT('CE',RIGHT('0000000000'+CAST(@iPer AS VARCHAR(10)),10)) ELSE RIGHT('00000000'+CAST(10000000+@iPer AS VARCHAR(8)),8) END,
  CONCAT('9',RIGHT('00000000'+CAST(10000000+@iPer AS VARCHAR(8)),8)),CONCAT('persona',@iPer,'@example.test'),@tipoDoc,@dirPer);
  SET @iPer+=1;
 END
END;

/* 4. Personal, flota, rutas y tarifas.
      Distribución del personal: 15 conductores, 7 personal, 7 almacén y 6 administración. */
IF NOT EXISTS (SELECT 1 FROM Empleado)
BEGIN
    DECLARE @iEmp INT=1, @CargoNombre VARCHAR(60), @CargoId INT, @SucursalId INT;
    WHILE @iEmp<=@TotalEmpleados
    BEGIN
        SET @CargoNombre=CASE
            WHEN @iEmp<=@TotalConductores THEN 'Conductor'
            WHEN @iEmp<=@TotalConductores+7 THEN 'Personal'
            WHEN @iEmp<=@TotalConductores+14 THEN 'Almacén'
            ELSE 'Administración'
        END;
        SELECT @CargoId=Id_Cargo FROM Cargo WHERE Nombre=@CargoNombre;
        SELECT @SucursalId=Id_Sucursal
        FROM
        (
            SELECT Id_Sucursal,ROW_NUMBER() OVER(ORDER BY Id_Sucursal) rn FROM Sucursal
        ) q
        WHERE rn=1+((@iEmp-1)%@TotalSucursales);

        INSERT Empleado(Nombre,Apellido,Fecha_Ingreso,Cargo_Id_Cargo,Sucursal_Id_Sucursal)
        VALUES(CONCAT('Empleado',RIGHT('00'+CAST(@iEmp AS VARCHAR(2)),2)),'Prueba',
               DATEADD(DAY,-(@iEmp*31),CONVERT(DATETIME,'20241231',112)),@CargoId,@SucursalId);
        SET @iEmp+=1;
    END
END;
insert Empleado values('Gerente', 'Generalio', CONVERT(DATETIME,'20000101',112), 9, 25)

IF NOT EXISTS (SELECT 1 FROM Conductor)
BEGIN
    INSERT Conductor(Licencia,Vencimiento_Licencia,Empleado_Id_Empleado,Categoria_Licencia_Id_Categoria_Licencia)
    SELECT CONCAT('LIC',RIGHT('000000'+CAST(e.Id_Empleado AS VARCHAR(6)),6)),
           DATEADD(YEAR,3,CONVERT(DATETIME,'20240101',112)),e.Id_Empleado,c.Id_Categoria_Licencia
    FROM Empleado e
    JOIN Cargo ca ON ca.Id_Cargo=e.Cargo_Id_Cargo AND ca.Nombre='Conductor'
    CROSS JOIN (SELECT TOP 1 Id_Categoria_Licencia FROM Categoria_Licencia ORDER BY Id_Categoria_Licencia)c;
END;

/* Doce vehiculos exactos en una base limpia; placas unicas y cuatro por tipo. */
INSERT Vehiculo(Placa,Capacidad_Kg,Tipo_Vehiculo_Id_Tipo_Vehiculo,Estado_Vehiculo_Id_Estado_Vehiculo)
SELECT c.Placa,c.CapacidadKg,t.Id_Tipo_Vehiculo,e.Id_Estado_Vehiculo
FROM @CfgVehiculos c
JOIN Tipo_Vehiculo t ON t.Nombre=c.TipoVehiculo
CROSS JOIN (SELECT TOP 1 Id_Estado_Vehiculo FROM Estado_Vehiculo WHERE Nombre='Operativo' ORDER BY Id_Estado_Vehiculo)e
WHERE NOT EXISTS (SELECT 1 FROM Vehiculo v WHERE v.Placa=c.Placa);

IF NOT EXISTS (SELECT 1 FROM Ruta)
BEGIN
 INSERT Ruta(Distancia_Km,Duracion_Estimada_Minu,Sucursal_Id_Sucursal_Origen,Sucursal_Id_Sucursal_Destino)
 SELECT CASE WHEN a.rn=b.rn THEN 15 ELSE 250+ABS(CHECKSUM(NEWID()))%650 END,
 CASE WHEN a.rn=b.rn THEN 60 ELSE 300+ABS(CHECKSUM(NEWID()))%900 END,a.Id_Sucursal,b.Id_Sucursal
 FROM (SELECT Id_Sucursal,ROW_NUMBER() OVER(ORDER BY Id_Sucursal) rn FROM Sucursal)a
 CROSS JOIN (SELECT Id_Sucursal,ROW_NUMBER() OVER(ORDER BY Id_Sucursal) rn FROM Sucursal)b WHERE a.Id_Sucursal<>b.Id_Sucursal;
END;
IF NOT EXISTS (SELECT 1 FROM Tarifa)
 INSERT Tarifa(Peso_Min,Peso_Max,Precio,Tipo_Servicio_Id_Tipo_Servicio,Zona_Id_Zona)
 SELECT v.PesoMin,v.PesoMax,v.Precio,ts.Id_Tipo_Servicio,z.Id_Zona
 FROM (VALUES (0.00,1.00,8.00),(1.01,5.00,14.00),(5.01,15.00,25.00),(15.01,30.00,42.00),(30.01,100.00,75.00))v(PesoMin,PesoMax,Precio)
 CROSS JOIN Tipo_Servicio ts CROSS JOIN Zona z;
IF NOT EXISTS (SELECT 1 FROM Licencia_Tipo_Vehiculo)
 INSERT Licencia_Tipo_Vehiculo(Categoria_Licencia_Id_Categoria_Licencia,Tipo_Vehiculo_Id_Tipo_Vehiculo)
 SELECT c.Id_Categoria_Licencia,t.Id_Tipo_Vehiculo FROM Categoria_Licencia c CROSS JOIN Tipo_Vehiculo t;

/* 5. 72,000 envíos (1,200 por mes; 14,400 por año) y entidades relacionadas */
DECLARE @n INT=1, @anio INT, @mes INT, @fecha DATETIME, @rem INT, @des INT, @dirO INT, @dirD INT,
 @serv INT, @estado INT, @dias INT, @paquete INT, @tipoP INT, @cond INT,
 @peso DECIMAL(8,2), @valor DECIMAL(10,2), @base DECIMAL(10,2), @subtotal DECIMAL(10,2),
 @pago INT, @monto DECIMAL(10,2), @estadoPago INT, @metodo INT, @personaPago INT,
 @sucursal INT, @ruta INT, @vehiculo INT, @conductor INT, @despacho INT, @tipoComp INT,
 @subtotalComp DECIMAL(10,2), @igv DECIMAL(10,2), @total DECIMAL(10,2), @tipoInc INT;
DECLARE @MapaEnvio TABLE(n INT PRIMARY KEY, id_envio INT, id_paquete INT, fecha DATETIME, id_rem INT, id_des INT, id_estado INT, total DECIMAL(10,2));
/* Mapear las personas que realmente existen. No asumir que sus IDs empiezan en 1 ni son consecutivos. */
DECLARE @MapaPersonas TABLE(rn INT PRIMARY KEY, id_persona INT NOT NULL, id_direccion INT NOT NULL);
INSERT @MapaPersonas(rn,id_persona,id_direccion)
SELECT ROW_NUMBER() OVER(ORDER BY Id_Persona),Id_Persona,Direccion_Id_Direccion
FROM Persona;
DECLARE @totalPersonas INT=(SELECT COUNT(*) FROM @MapaPersonas);
IF @totalPersonas<2
 RAISERROR('Se necesitan al menos dos personas con direccion registrada para generar envios.',16,1);
WHILE @n<=@TotalEnvios
BEGIN
 SET @anio=2020+((@n-1)/14400);
 SET @mes=1+((@n-1)%14400)/1200;
 /* Día válido del mes: permite meses de 28, 29, 30 y 31 días. */
 SET @fecha=DATEADD(MINUTE,(@n*37)%1440,
            DATEADD(DAY,((@n*17)%DAY(EOMONTH(DATEFROMPARTS(@anio,@mes,1)))),
            CONVERT(DATETIME,CONCAT(@anio,RIGHT('0'+CAST(@mes AS VARCHAR(2)),2),'01'),112)));
 SELECT @rem=id_persona,@dirO=id_direccion FROM @MapaPersonas WHERE rn=1+((@n*7)%@totalPersonas);
 SELECT @des=id_persona,@dirD=id_direccion FROM @MapaPersonas WHERE rn=1+((@n*13+97)%@totalPersonas);
 IF @des=@rem
  SELECT @des=id_persona,@dirD=id_direccion FROM @MapaPersonas WHERE rn=1+((@n*13+98)%@totalPersonas);
 SELECT @serv=Id_Tipo_Servicio FROM (SELECT Id_Tipo_Servicio,ROW_NUMBER() OVER(ORDER BY CASE Nombre WHEN 'Express' THEN 1 WHEN 'Estándar' THEN 2 ELSE 3 END) rn FROM Tipo_Servicio WHERE Nombre IN ('Express','Estándar','Económico'))x WHERE rn=1+((@n-1)%3);
 SELECT @dias=CASE Nombre WHEN 'Express' THEN 1 WHEN 'Estándar' THEN 3 ELSE 5 END FROM Tipo_Servicio WHERE Id_Tipo_Servicio=@serv;
 SET @estado=CASE WHEN @n%100<72 THEN (SELECT Id_Estado_Envio FROM Estado_Envio WHERE Nombre='Entregado') WHEN @n%100<88 THEN (SELECT Id_Estado_Envio FROM Estado_Envio WHERE Nombre='En tránsito') WHEN @n%100<94 THEN (SELECT Id_Estado_Envio FROM Estado_Envio WHERE Nombre='Retrasado') WHEN @n%100<98 THEN (SELECT Id_Estado_Envio FROM Estado_Envio WHERE Nombre='En reparto') ELSE (SELECT Id_Estado_Envio FROM Estado_Envio WHERE Nombre='Cancelado') END;
 INSERT Envio(Codigo_Seguimiento,Fecha_Registro,Fecha_Estimada_Entrega,Fecha_Real_Entrega,Id_Remitente,Id_Destinatario,Id_Direccion_Origen,Id_Direccion_Destino,Id_Tipo_Servicio,Id_Estado_Envio)
 VALUES(CONCAT('ML',@anio,RIGHT('000000'+CAST(@n AS VARCHAR(6)),6)),@fecha,DATEADD(DAY,@dias,CAST(@fecha AS DATE)),
 CASE WHEN @estado=(SELECT Id_Estado_Envio FROM Estado_Envio WHERE Nombre='Entregado') THEN DATEADD(DAY,@dias,@fecha) ELSE NULL END,
 @rem,@des,@dirO,@dirD,@serv,@estado);
 DECLARE @envio INT=SCOPE_IDENTITY();
 SET @peso=CAST((1+(@n%2500)/100.0) AS DECIMAL(8,2));
 SET @valor=CAST(20+((@n*19)%3000) AS DECIMAL(10,2));
 SELECT @tipoP=Id_Tipo_Paquete FROM (SELECT Id_Tipo_Paquete,ROW_NUMBER() OVER(ORDER BY Id_Tipo_Paquete) rn FROM Tipo_Paquete)x WHERE rn=1+(@n%4);
 SELECT @cond=Id_Condicion_Pago FROM Condicion_Pago WHERE Nombre=CASE WHEN @n%5=0 THEN 'Contra entrega' ELSE 'Prepago' END;
 SELECT @base=Tarifa_Base FROM Tipo_Servicio WHERE Id_Tipo_Servicio=@serv;
 SELECT @subtotal=CAST(@base + @peso*1.75 + tp.Recargo + CASE WHEN @valor>1000 THEN 8 ELSE 0 END AS DECIMAL(10,2)) FROM Tipo_Paquete tp WHERE tp.Id_Tipo_Paquete=@tipoP;
 INSERT Paquete(Descripcion,Peso_Kg,Largo_cm,Ancho_cm,Alto_cm,Valor_Declarado,Asegurado,SubTotal,Envio_Id_Envio,Tipo_Paquete_Id_Tipo_Paquete,Condicion_Pago_Id_Condicion_Pago)
 VALUES(CASE @n%5 WHEN 0 THEN 'Documentos' WHEN 1 THEN 'Ropa y accesorios' WHEN 2 THEN 'Artículos para el hogar' WHEN 3 THEN 'Repuestos' ELSE 'Productos varios' END,@peso,10+(@n%50),10+(@n%35),5+(@n%25),@valor,CASE WHEN @valor>=1000 OR @n%4=0 THEN 1 ELSE 0 END,@subtotal,@envio,@tipoP,@cond);
 SET @paquete=SCOPE_IDENTITY();
 SET @monto=@subtotal;
 SET @estadoPago=CASE WHEN @estado=(SELECT Id_Estado_Envio FROM Estado_Envio WHERE Nombre='Cancelado') THEN (SELECT Id_Estado_Pago FROM Estado_Pago WHERE Nombre='Anulado') WHEN @n%100<85 THEN (SELECT Id_Estado_Pago FROM Estado_Pago WHERE Nombre='Pagado') ELSE (SELECT Id_Estado_Pago FROM Estado_Pago WHERE Nombre='Pendiente') END;
 SELECT @metodo=Id_Metodo_Pago FROM (SELECT Id_Metodo_Pago,ROW_NUMBER() OVER(ORDER BY Id_Metodo_Pago) rn FROM Metodo_Pago)x WHERE rn=1+(@n%4);
 SET @personaPago=CASE WHEN @cond=(SELECT Id_Condicion_Pago FROM Condicion_Pago WHERE Nombre='Contra entrega') THEN @des ELSE @rem END;
 INSERT Pago(Monto,Fecha,Persona_Id_Persona,Metodo_Pago_Id_Metodo_Pago,Estado_Pago_Id_Estado_Pago)
 VALUES(@monto,CASE WHEN @cond=(SELECT Id_Condicion_Pago FROM Condicion_Pago WHERE Nombre='Contra entrega') THEN DATEADD(DAY,@dias,@fecha) ELSE @fecha END,@personaPago,@metodo,@estadoPago);
 SET @pago=SCOPE_IDENTITY();
 INSERT Detalle_Pago(Monto_Asignado,Pago_Id_Pago,Paquete_Id_Paquete) VALUES(@monto,@pago,@paquete);
 IF @estadoPago=(SELECT Id_Estado_Pago FROM Estado_Pago WHERE Nombre='Pagado')
 BEGIN
  SELECT @tipoComp=Id_Tipo_Comprobante FROM Tipo_Comprobante WHERE Nombre=CASE WHEN @n%6=0 THEN 'Factura' ELSE 'Boleta' END;
  SET @subtotalComp=CAST(@monto/1.18 AS DECIMAL(10,2)); SET @igv=CAST(@monto-@subtotalComp AS DECIMAL(10,2)); SET @total=@subtotalComp+@igv;
  INSERT Comprobante(Serie,Numero,Fecha,SubTotal,IGV,Total,Pago_Id_Pago,Tipo_Comprobante_Id_Tipo_Comprobante)
  VALUES(CASE WHEN @tipoComp=(SELECT Id_Tipo_Comprobante FROM Tipo_Comprobante WHERE Nombre='Factura') THEN 'F001' ELSE 'B001' END,RIGHT('00000000'+CAST(@n AS VARCHAR(8)),8),CASE WHEN @cond=(SELECT Id_Condicion_Pago FROM Condicion_Pago WHERE Nombre='Contra entrega') THEN DATEADD(DAY,@dias,@fecha) ELSE @fecha END,@subtotalComp,@igv,@total,@pago,@tipoComp);
 END;

 /* Ocho eventos cronologicos por envio, desde el registro hasta el estado final. */
 INSERT Seguimiento(Fecha_Hora,Ubicacion,Observacion,Envio_Id_Envio,Sucursal_Id_Sucursal,Estado_Envio_Id_Estado_Envio)
 SELECT
    CASE
      WHEN ce.Numero=@EventosPorEnvio AND @estado=(SELECT Id_Estado_Envio FROM Estado_Envio WHERE Nombre='Entregado')
      THEN DATEADD(DAY,@dias,@fecha)
      WHEN ce.Numero=@EventosPorEnvio THEN DATEADD(DAY,@dias,@fecha)
      ELSE DATEADD(MINUTE,CAST((@dias*24*60.0*ce.ProgresoPorcentaje)/100.0 AS INT),@fecha)
    END,
    ce.Ubicacion,ce.Observacion,@envio,
    (SELECT sx.Id_Sucursal FROM
       (SELECT Id_Sucursal,ROW_NUMBER() OVER(ORDER BY Id_Sucursal) rn FROM Sucursal)sx
     WHERE sx.rn=1+((@n+ce.Numero-2)%@TotalSucursales)),
    CASE WHEN ce.Numero=@EventosPorEnvio THEN @estado
         ELSE (SELECT ee.Id_Estado_Envio FROM Estado_Envio ee WHERE ee.Nombre=ce.Estado) END
 FROM @CfgEventos ce;

 /* Notificación al remitente y al destinatario */
 INSERT Notificacion(Mensaje,Fecha,Envio_Id_Envio,Persona_Id_Persona,Canal_Notificacion_Id_Canal_Notificacion,Estado_Notificacion_Id_Estado_Notificacion)
 SELECT CONCAT('Actualización del envío ',CONCAT('ML',@anio,RIGHT('000000'+CAST(@n AS VARCHAR(6)),6))),DATEADD(HOUR,1,@fecha),@envio,p.Persona_Id,cn.Id_Canal_Notificacion,en.Id_Estado_Notificacion
 FROM (VALUES(@rem),(@des))p(Persona_Id)
 CROSS JOIN (SELECT TOP 1 Id_Canal_Notificacion FROM Canal_Notificacion ORDER BY Id_Canal_Notificacion)cn
 CROSS JOIN (SELECT TOP 1 Id_Estado_Notificacion FROM Estado_Notificacion WHERE Nombre='Enviada')en;

 /* Incidencia para una muestra de envíos; se resuelve en datos entregados */
 IF @n%13=0
 BEGIN
  SELECT @tipoInc=Id_Tipo_Incidencia FROM (SELECT Id_Tipo_Incidencia,ROW_NUMBER() OVER(ORDER BY Id_Tipo_Incidencia) rn FROM Tipo_Incidencia)x WHERE rn=1+(@n%4);
  INSERT Incidencia(Fecha,Descripcion,Solucion,Envio_Id_Envio,Tipo_Incidencia_Id_Tipo_Incidencia)
  VALUES(DATEADD(HOUR,12,@fecha),'Incidencia ficticia detectada durante el transporte','Se coordinó con operaciones y se actualizó al cliente',@envio,@tipoInc);
 END;

 INSERT @MapaEnvio VALUES(@n,@envio,@paquete,@fecha,@rem,@des,@estado,@monto);
 SET @n+=1;
END;

/* 6. Despachos: agrupa hasta 10 envíos cercanos en fecha, con vehículo/conductor/ruta válidos. */
DECLARE @grupo INT=1,@maxGrupo INT=(@TotalEnvios/10),@fechaDesp DATETIME,@idVeh INT,@idCond INT,@idRuta INT,@idDesp INT;
WHILE @grupo<=@maxGrupo
BEGIN
 SELECT @fechaDesp=MIN(fecha) FROM @MapaEnvio WHERE n BETWEEN ((@grupo-1)*10+1) AND (@grupo*10);
 SELECT @idVeh=Id_Vehiculo FROM (SELECT Id_Vehiculo,ROW_NUMBER() OVER(ORDER BY Id_Vehiculo) rn FROM Vehiculo)x WHERE rn=1+((@grupo-1)%(SELECT COUNT(*) FROM Vehiculo));
 SELECT @idCond=Id_Conductor FROM (SELECT Id_Conductor,ROW_NUMBER() OVER(ORDER BY Id_Conductor) rn FROM Conductor)x WHERE rn=1+((@grupo-1)%(SELECT COUNT(*) FROM Conductor));
 SELECT @idRuta=Id_Ruta FROM (SELECT Id_Ruta,ROW_NUMBER() OVER(ORDER BY Id_Ruta) rn FROM Ruta)x WHERE rn=1+((@grupo-1)%(SELECT COUNT(*) FROM Ruta));
 INSERT Despacho(Fecha_Salida,Fecha_Llegada,Vehiculo_Id_Vehiculo,Conductor_Id_Conductor,Ruta_Id_Ruta)
 VALUES(DATEADD(HOUR,6,@fechaDesp),DATEADD(HOUR,18,@fechaDesp),@idVeh,@idCond,@idRuta);
 SET @idDesp=SCOPE_IDENTITY();
 INSERT Detalle_Despacho(Despacho_Id_Despacho,Envio_Id_Envio)
 SELECT @idDesp,id_envio FROM @MapaEnvio WHERE n BETWEEN ((@grupo-1)*10+1) AND (@grupo*10);
 SET @grupo+=1;
END;

COMMIT TRANSACTION;

/* Resumen de validación */
SELECT YEAR(Fecha_Registro) AS Anio,COUNT(*) AS Cantidad_Envios
FROM Envio WHERE Fecha_Registro>='20200101' AND Fecha_Registro<'20250101'
GROUP BY YEAR(Fecha_Registro) ORDER BY Anio;
SELECT YEAR(Fecha_Registro) AS Anio,MONTH(Fecha_Registro) AS Mes,COUNT(*) AS Cantidad_Envios
FROM Envio WHERE Fecha_Registro>='20200101' AND Fecha_Registro<'20250101'
GROUP BY YEAR(Fecha_Registro),MONTH(Fecha_Registro)
ORDER BY Anio,Mes;
SELECT 'Envios' Tabla,COUNT(*) Cantidad FROM Envio WHERE Fecha_Registro>='20200101' AND Fecha_Registro<'20250101'
UNION ALL SELECT 'Paquetes',COUNT(*) FROM Paquete p JOIN Envio e ON e.Id_Envio=p.Envio_Id_Envio WHERE e.Fecha_Registro>='20200101' AND e.Fecha_Registro<'20250101'
UNION ALL SELECT 'Pagos',COUNT(*) FROM Pago WHERE Fecha>='20200101' AND Fecha<'20250101'
UNION ALL SELECT 'Seguimientos',COUNT(*) FROM Seguimiento s JOIN Envio e ON e.Id_Envio=s.Envio_Id_Envio WHERE e.Fecha_Registro>='20200101' AND e.Fecha_Registro<'20250101'
UNION ALL SELECT 'Notificaciones',COUNT(*) FROM Notificacion n JOIN Envio e ON e.Id_Envio=n.Envio_Id_Envio WHERE e.Fecha_Registro>='20200101' AND e.Fecha_Registro<'20250101'
UNION ALL SELECT 'Despachos',COUNT(*) FROM Despacho WHERE Fecha_Salida>='20200101' AND Fecha_Salida<'20250101';

SELECT 'Sucursales' AS Tabla,COUNT(*) AS Cantidad FROM Sucursal
UNION ALL SELECT 'Empleados',COUNT(*) FROM Empleado
UNION ALL SELECT 'Conductores',COUNT(*) FROM Conductor
UNION ALL SELECT 'Vehiculos',COUNT(*) FROM Vehiculo
UNION ALL SELECT 'Tipos de servicio',COUNT(*) FROM Tipo_Servicio
UNION ALL SELECT 'Tipos de vehiculo',COUNT(*) FROM Tipo_Vehiculo
UNION ALL SELECT 'Cargos',COUNT(*) FROM Cargo;

SELECT s.Nombre AS Sucursal,d.Nombre AS Distrito,p.Nombre AS Provincia,dep.Nombre AS Departamento
FROM Sucursal s
JOIN Direccion a ON a.Id_Direccion=s.Direccion_Id_Direccion
JOIN Distrito d ON d.Id_Distrito=a.Distrito_Id_Distrito
JOIN Provincia p ON p.Id_Provincia=d.Provincia_Id_Provincia
JOIN Departamento dep ON dep.Id_Departamento=p.Departamento_Id_Departamento
ORDER BY dep.Nombre,p.Nombre,d.Nombre;

SELECT c.Nombre AS Cargo,COUNT(*) AS Empleados
FROM Empleado e JOIN Cargo c ON c.Id_Cargo=e.Cargo_Id_Cargo
GROUP BY c.Nombre ORDER BY c.Nombre;

SELECT t.Nombre AS TipoVehiculo,v.Placa,v.Capacidad_Kg
FROM Vehiculo v JOIN Tipo_Vehiculo t ON t.Id_Tipo_Vehiculo=v.Tipo_Vehiculo_Id_Tipo_Vehiculo
ORDER BY t.Nombre,v.Placa;
--REVICION DE PESO DE CADA TABLA Y NUMERO DE FILAS--
use Molash
select t.name as tabla, SUM(p.rows) as Filas, CAST(SUM(a.total_pages)*8/1024.0 as decimal(10,2)) as Total_Mb
from sys.tables t
join sys.indexes i on t.object_id=i.object_id and i.index_id<=1
join sys.partitions p on i.object_id=p.object_id and i.index_id=p.index_id
join sys.allocation_units a on (a.type in (1,3) and a.container_id=p.hobt_id)
or (a.type=2 and a.container_id=p.partition_id) group by t.name order by Filas desc;

exec sp_spaceused;
select MIN(Fecha_Registro) as Primer_Envio, MAX(Fecha_Registro) as Ultimo_Envio, 
COUNT(*) as total_Envios from Envio;

END TRY
BEGIN CATCH
 IF @@TRANCOUNT>0 ROLLBACK TRANSACTION;
 DECLARE @ErrorMsg NVARCHAR(4000)=ERROR_MESSAGE();
 RAISERROR('Error durante el poblamiento de Molash: %s',16,1,@ErrorMsg);
END CATCH;
GO
