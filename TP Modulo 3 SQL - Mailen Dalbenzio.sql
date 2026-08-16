--- TODO ESTO ES DDL, Voy a crear la base de datos VentasTechDB si no existe--
IF DB_ID('Ventas_Tech_DB') IS NULL
BEGIN
    CREATE DATABASE Ventas_Tech_DB;
END;
-- Seleccionar la base de datos como principal --
USE Ventas_Tech_DB;
--- Ahora es para decirle que si existe X tabla, eliminala ---
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;
--- Ahora vamos a crear las tablas diciendole: crea una tabla, desp definimos columnas, INT es para num enteros ---
CREATE TABLE Categorias (
ID_Categoria INT PRIMARY KEY,
Nombre_Categoria VARCHAR (50) NOT NULL,
Descripcion VARCHAR (200)
);
--- voy a chequear que haya quedado bien ---
SELECT *
FROM Categorias;
--- Ahora voy a crear la tabla de clientes ---
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    ciudad VARCHAR(50),
    fecha_registro DATE NOT NULL
);
-- chequeo nuevamente ---
SELECT *
FROM clientes;
--- Ahora voy a crear la tabla Productos, INT DEFAULT es para que ponga cero en el caso de no tener nada ---
CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    id_categoria INT,
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    activo TINYINT DEFAULT 1,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);
--- Ahora la tabla VENTAS, esta tabla es la que conecta todo con todo ---
CREATE TABLE ventas (
    id_venta INT PRIMARY KEY,
    id_cliente INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    fecha_venta DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
--- AHORA EMPEZAMOS CON DML, o sea vamos a meter los datos dentro de la estructura ---
INSERT INTO categorias VALUES (1, 'Computación', 'Laptops, PCs y monitores');
INSERT INTO categorias VALUES (2, 'Accesorios', 'Periféricos y complementos');
INSERT INTO categorias VALUES (3, 'Audio', 'Auriculares y parlantes');
INSERT INTO categorias VALUES (4, 'Almacenamiento', 'Discos y memorias');
--- vamos a chequear que se cargue bien ---
SELECT *
FROM Categorias;
--- ahora vamos a cargar los clientes ---
INSERT INTO clientes VALUES (1, 'María López',  'maria@mail.com',  'Buenos Aires', '2024-01-05');
INSERT INTO clientes VALUES (2, 'Carlos Ruiz',  'carlos@mail.com', 'Córdoba',      '2024-01-10');
INSERT INTO clientes VALUES (3, 'Ana Gómez',    'ana@mail.com',    'Rosario',      '2024-02-01');
INSERT INTO clientes VALUES (4, 'Pedro Sanz',   'pedro@mail.com',  'Mendoza',      '2024-02-15');
INSERT INTO clientes VALUES (5, 'Laura Torres','laura@mail.com',  'Tucumán',      '2024-03-01');
--- chequeamos ---
SELECT *
FROM clientes;
--- ahora vamos a cargar los productos ---
INSERT INTO productos VALUES (1, 'Laptop Pro 15',       1, 1200.00, 15, 1);
INSERT INTO productos VALUES (2, 'Mouse Inalámbrico',   2,   28.00, 80, 1);
INSERT INTO productos VALUES (3, 'Monitor 4K 27"',      1,  450.00, 12, 1);
INSERT INTO productos VALUES (4, 'Auriculares BT Pro',  3,  120.00, 35, 1);
INSERT INTO productos VALUES (5, 'SSD Externo 1TB',     4,  130.00, 18, 1);
INSERT INTO productos VALUES (6, 'Teclado Mecánico',    2,   95.00, 40, 1);
--- chequeo -- 
SELECT *
FROM productos;
--- Ahora cargo las ventas ---
INSERT INTO ventas VALUES (1,  1, 1, 2, 1200.00, '2024-03-05');
INSERT INTO ventas VALUES (2,  2, 2, 5,   28.00, '2024-03-06');
INSERT INTO ventas VALUES (3,  3, 3, 1,  450.00, '2024-03-07');
INSERT INTO ventas VALUES (4,  1, 4, 2,  120.00, '2024-03-08');
INSERT INTO ventas VALUES (5,  4, 5, 3,  130.00, '2024-03-10');
INSERT INTO ventas VALUES (6,  2, 6, 4,   95.00, '2024-03-11');
INSERT INTO ventas VALUES (7,  5, 1, 1, 1200.00, '2024-03-12');
INSERT INTO ventas VALUES (8,  3, 2, 8,   28.00, '2024-03-13');
INSERT INTO ventas VALUES (9,  4, 4, 1,  120.00, '2024-03-14');
INSERT INTO ventas VALUES (10, 5, 3, 2,  450.00, '2024-03-15');
--- pruebo ---
SELECT *
FROM ventas;
--- pruebo por ultimo que traiga las cosas bien ---
SELECT COUNT(*) AS cantidad_categorias
FROM categorias;

SELECT COUNT(*) AS cantidad_clientes
FROM clientes;

SELECT COUNT(*) AS cantidad_productos
FROM productos;

SELECT COUNT(*) AS cantidad_ventas
FROM ventas;
-- fin de ejercicio --