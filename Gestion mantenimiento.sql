--Creacion inicial de BD

CREATE TABLE Marcas (
    id_marca    NUMBER PRIMARY KEY, 
    nombre      VARCHAR2(50) NOT NULL UNIQUE
);

INSERT INTO Marcas (id_marca, nombre)
values  (1, 'ABB');

INSERT INTO Marcas (id_marca, nombre)
values  (2, 'SIEMENS');

INSERT INTO Marcas (id_marca, nombre)
values  (3, 'SCHNEIDER');

select * from Marcas;

CREATE TABLE Estados_equipos (
    id_estado    NUMBER PRIMARY KEY, 
    estado      VARCHAR2(50) NOT NULL UNIQUE
);

select * from Estados_equipos;

DESC Estados_equipos;

INSERT INTO Estados_equipos (id_estado, estado)
VALUES (1, 'ACTIVO');

INSERT INTO Estados_equipos (id_estado, estado)
VALUES (2, 'EN MANTENIMIENTO');

INSERT INTO Estados_equipos (id_estado, estado)
VALUES (3, 'FUERA DE SERVICIO');

INSERT INTO Estados_equipos (id_estado, estado)
VALUES (4, 'DADO DE BAJA');


CREATE TABLE Ubicacion (
    id_ubicacion   NUMBER PRIMARY KEY, 
    ubicacion      VARCHAR2(50) NOT NULL UNIQUE
);



INSERT INTO Ubicacion (id_ubicacion, ubicacion)
VALUES (1, 'Planta Bogotá');

INSERT INTO Ubicacion (id_ubicacion, ubicacion)
VALUES (2, 'Planta Medellín');

INSERT INTO Ubicacion (id_ubicacion, ubicacion)
VALUES (3, 'Planta Cali');

INSERT INTO Ubicacion (id_ubicacion, ubicacion)
VALUES (4, 'Bodega Principal');


SELECT *
FROM Ubicacion
ORDER BY id_ubicacion;

CREATE TABLE Equipos (
    id_equipo   NUMBER PRIMARY KEY, 
    equipo      VARCHAR2(50) NOT NULL,
    modelo      VARCHAR2 (50) NOT NULL,

    id_marca        NUMBER NOT NULL,
    id_estado       NUMBER NOT NULL,
    id_ubicacion    NUMBER NOT NULL,

    FOREIGN KEY (id_marca)
    REFERENCES  Marcas(id_marca),
    FOREIGN KEY (id_estado)
    REFERENCES  Estados_equipos(id_estado),
    FOREIGN KEY (id_ubicacion)
    REFERENCES  Ubicacion(id_ubicacion)
);

INSERT INTO Equipos
(id_equipo, equipo, modelo, id_marca, id_estado, id_ubicacion)
VALUES
(1, 'Transformador', 'T-500', 1, 1, 1);

INSERT INTO Equipos
(id_equipo, equipo, modelo, id_marca, id_estado, id_ubicacion)
VALUES
(2, 'Celda eléctrica', 'SIVACON S8', 2, 1, 1);

INSERT INTO Equipos
(id_equipo, equipo, modelo, id_marca, id_estado, id_ubicacion)
VALUES
(3, 'Interruptor', 'SF6-200', 3, 2, 2);

INSERT INTO Equipos
(id_equipo, equipo, modelo, id_marca, id_estado, id_ubicacion)
VALUES
(4, 'Transformador', 'T-800', 1, 3, 3);

INSERT INTO Equipos
(id_equipo, equipo, modelo, id_marca, id_estado, id_ubicacion)
VALUES
(5, 'Celda eléctrica', 'NXPLUS', 2, 1, 4);

SELECT *
FROM Equipos
ORDER BY id_equipo;

SELECT
    e.equipo,
    e.modelo,
    m.nombre AS marca
FROM Equipos e
INNER JOIN Marcas m
    ON e.id_marca = m.id_marca;


CREATE TABLE Especialidades(
    id_especialidad     NUMBER PRIMARY KEY,
    especialidad        VARCHAR2(50) NOT NULL UNIQUE
);

CREATE TABLE Tecnicos (
    id_tecnico      NUMBER PRIMARY KEY,
    nombre          VARCHAR2(50) NOT NULL,
    apellido        VARCHAR2(50) NOT NULL,
    documento       NUMBER NOT NULL UNIQUE,
    telefono        VARCHAR2(20)  NOT NULL,
    correo          VARCHAR2(50) NOT NULL,

    id_especialidad NUMBER NOT NULL,

    FOREIGN KEY (id_especialidad)
    REFERENCES  Especialidades(id_especialidad)
);

INSERT INTO Especialidades (id_especialidad, especialidad)
VALUES (1, 'Electricista');

INSERT INTO Especialidades (id_especialidad, especialidad)
VALUES (2, 'Electronica');

INSERT INTO Especialidades (id_especialidad, especialidad)
VALUES (3, 'Mecatronica');

INSERT INTO Especialidades (id_especialidad, especialidad)
VALUES (4, 'Instrumentacion');

INSERT INTO Tecnicos
(id_tecnico, nombre, apellido, documento, telefono, correo, id_especialidad)
VALUES
(1, 'Carlos', 'Perez', 1001001001, '3001234567', 'carlos.perez@empresa.com', 1);

INSERT INTO Tecnicos
(id_tecnico, nombre, apellido, documento, telefono, correo, id_especialidad)
VALUES
(2, 'Andres', 'Gomez', 1001001002, '3012345678', 'andres.gomez@empresa.com', 2);

INSERT INTO Tecnicos
(id_tecnico, nombre, apellido, documento, telefono, correo, id_especialidad)
VALUES
(3, 'Laura', 'Rodriguez', 1001001003, '3023456789', 'laura.rodriguez@empresa.com', 3);

INSERT INTO Tecnicos
(id_tecnico, nombre, apellido, documento, telefono, correo, id_especialidad)
VALUES
(4, 'Miguel', 'Torres', 1001001004, '3034567890', 'miguel.torres@empresa.com', 1);

INSERT INTO Tecnicos
(id_tecnico, nombre, apellido, documento, telefono, correo, id_especialidad)
VALUES
(5, 'Daniela', 'Martinez', 1001001005, NULL, 'daniela.martinez@empresa.com', 4);



SELECT
    t.id_tecnico,
    t.nombre,
    t.apellido,
    t.documento,
    e.especialidad,
    t.telefono,
    t.correo
FROM Tecnicos t
INNER JOIN Especialidades e
    ON t.id_especialidad = e.id_especialidad;

 
 CREATE TABLE Tipo_mantenimiento (
    id_tipo             NUMBER PRIMARY KEY,
    tipo                VARCHAR2(50) NOT NULL UNIQUE
 );


CREATE TABLE Mantenimientos(
    id_mantenimiento    NUMBER PRIMARY KEY,
    descripcion         VARCHAR2(500),
    costo               NUMBER(12,2) NOT NULL,
    fecha_mantenimiento DATE NOT NULL,

    id_equipo           NUMBER NOT NULL,
    id_tecnico          NUMBER NOT NULL,
    id_tipo             NUMBER NOT NULL,


    FOREIGN KEY (id_equipo)
    REFERENCES  Equipos(id_equipo),

    FOREIGN KEY (id_tecnico)
    REFERENCES  Tecnicos(id_tecnico),

    FOREIGN KEY (id_tipo)
    REFERENCES  Tipo_mantenimiento(id_tipo)

);

INSERT INTO Tipo_mantenimiento (id_tipo, tipo)
VALUES (1, 'PREVENTIVO');

INSERT INTO Tipo_mantenimiento (id_tipo, tipo)
VALUES (2, 'CORRECTIVO');

INSERT INTO Tipo_mantenimiento (id_tipo, tipo)
VALUES (3, 'PREDICTIVO');


INSERT INTO Mantenimientos
(id_mantenimiento, descripcion, costo, fecha_mantenimiento, id_equipo, id_tecnico, id_tipo)
VALUES
(1, 'Inspeccion general y limpieza', 350000, DATE '2026-08-05', 1, 1, 1);

INSERT INTO Mantenimientos
(id_mantenimiento, descripcion, costo, fecha_mantenimiento, id_equipo, id_tecnico, id_tipo)
VALUES
(2, 'Cambio de componente defectuoso', 850000, DATE '2026-08-10', 2, 2, 2);

INSERT INTO Mantenimientos
(id_mantenimiento, descripcion, costo, fecha_mantenimiento, id_equipo, id_tecnico, id_tipo)
VALUES
(3, 'Pruebas y mediciones preventivas', 275000, DATE '2026-08-15', 3, 3, 1);

INSERT INTO Mantenimientos
(id_mantenimiento, descripcion, costo, fecha_mantenimiento, id_equipo, id_tecnico, id_tipo)
VALUES
(4, 'Analisis de comportamiento del equipo', 450000, DATE '2026-08-20', 1, 1, 3);

INSERT INTO Mantenimientos
(id_mantenimiento, descripcion, costo, fecha_mantenimiento, id_equipo, id_tecnico, id_tipo)
VALUES
(5, 'Reparacion de conexion electrica', 620000, DATE '2026-08-25', 4, 4, 2);

SELECT
    m.id_mantenimiento,
    e.equipo,
    e.modelo,
    t.nombre,
    t.apellido,
    tm.tipo,
    m.fecha_mantenimiento,
    m.costo,
    m.descripcion
FROM Mantenimientos m
INNER JOIN Equipos e
    ON e.id_equipo = m.id_equipo
INNER JOIN Tecnicos t
    ON t.id_tecnico = m.id_tecnico
INNER JOIN Tipo_mantenimiento tm
    ON tm.id_tipo = m.id_tipo;



--Cuanto dinero se ha gastado en mantenimiento?
SELECT 
        SUM(costo)
FROM    mantenimientos;

--Cual es el costo promedio de un mantenimiento?

SELECT 
        AVG(costo)
FROM    mantenimientos;

--Cuantos mantenimineto han realizado cada tecnico?

SELECT 
    COUNT(m.id_mantenimiento) AS Total_mantenimientos,
    t.nombre                    ,
    t.apellido                  
FROM    
    Tecnicos t
JOIN
    mantenimientos m ON t.id_tecnico = m.id_tecnico
GROUP BY 
    t.nombre, t.apellido;                

--¿Qué equipo ha recibido más mantenimientos?

SELECT
    COUNT(m.id_mantenimiento) AS Total,
    e.equipo                  AS Nombre,
    e.modelo                  AS Modelo
FROM Mantenimientos m
JOIN Equipos e
    ON e.id_equipo = m.id_equipo
GROUP BY
    e.equipo,
    e.modelo
ORDER BY
    Total DESC;

--¿Cuánto se ha gastado por tipo de mantenimiento?

SELECT
    m.id_equipo       AS ID,
    SUM(m.costo)    AS total,
    e.equipo        AS Nombre,
    e.modelo        AS Modelo
FROM
    mantenimientos m
JOIN Equipos e
    ON e.id_equipo = m.id_equipo
GROUP BY
    e.equipo,
    e.modelo,
    m.id_equipo;


---Desarrollo de PL/SQL

DECLARE
    total NUMBER;
BEGIN

    SELECT SUM(costo)
    INTO total
    FROM Mantenimientos;

    DBMS_OUTPUT.PUT_LINE('Total gastado: ' || total);

END;
/


--Costo promedio de los manteniminetos.

DECLARE
    total NUMBER;
BEGIN

    SELECT AVG(costo)
    INTO total
    FROM Mantenimientos;

    DBMS_OUTPUT.PUT_LINE('Costo promedio: ' || total);

END;
/

--La empresa quiere saber si el gasto promedio en mantenimiento es alto o normal.
--Si el promedio supera 500.000, mostrar: "El costo promedio es alto".
--De lo contrario: "El costo promedio es normal".

DECLARE
    promedio NUMBER;
BEGIN

    SELECT AVG(costo)
    INTO promedio
    FROM Mantenimientos;


IF promedio > 500000 THEN
    DBMS_OUTPUT.PUT_LINE('El costo promedio es alto ' || promedio);
ELSE
    DBMS_OUTPUT.PUT_LINE('El costo promedio es normal ' || promedio);
END IF;

END;
/

--Si el total supera 2.000.000, mostrar "Gasto elevado"; 
--de lo contrario, mostrar "Gasto controlado".

DECLARE
    total NUMBER;
BEGIN

    SELECT SUM(costo)
    INTO total
    FROM Mantenimientos;


IF total > 2000000 THEN
    DBMS_OUTPUT.PUT_LINE('Gasto elevado ' || total);
ELSE
    DBMS_OUTPUT.PUT_LINE('Gasto controlado ' || total);
END IF;

END;
/

-- PROCEDURES

--Cacula el gasto total

CREATE OR REPLACE PROCEDURE calcular_gasto_total
IS
    total NUMBER;
BEGIN

    SELECT  SUM(costo)
    INTO    total
    FROM    Mantenimientos;

    DBMS_OUTPUT.PUT_LINE('Total gastado ' || total);
END;
/

EXEC calcular_gasto_total;

--PROCEDURE con parámetros

--Quiero saber cuánto dinero se ha gastado en mantenimientos de un equipo específico.


CREATE OR REPLACE PROCEDURE calcular_gasto_equipo (p_id NUMBER) 
IS total NUMBER;

BEGIN

    SELECT  SUM(costo)
    INTO    total
    FROM    Mantenimientos
    WHERE   id_equipo = p_id;

    DBMS_OUTPUT.PUT_LINE('Total gastado ' || total);
END;
/

EXEC calcular_gasto_equipo(1);
EXEC calcular_gasto_equipo(2);
EXEC calcular_gasto_equipo(3);
EXEC calcular_gasto_equipo(4);


--¿Cuánto dinero se ha gastado en mantenimientos para un equipo específico?

CREATE OR REPLACE FUNCTION calcular_gasto_por_equipo (p_id NUMBER)
RETURN NUMBER
IS
total NUMBER;

BEGIN
    SELECT  SUM(costo)
    INTO    total
    FROM    Mantenimientos
    WHERE   id_equipo = p_id;

    RETURN  total;

END;
/

SELECT calcular_gasto_por_equipo(1)
FROM dual;

--¿Cuánto se ha gastado en cada equipo de la tabla Equipos?

