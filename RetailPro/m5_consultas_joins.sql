-- INNER JOIN, consulta 1 --
SELECT
fecha_venta,
Ventas.ID_cliente,
nombre_producto,
Nombre_Categoria,
cantidad,
precio_unitario,
cantidad * precio_unitario AS Total_Venta,
ciudad
FROM Ventas
INNER JOIN clientes ON Ventas.id_cliente = clientes.id_cliente
INNER JOIN productos ON Ventas.id_producto = productos.id_producto
INNER JOIN Categorias ON productos.id_categoria = Categorias.ID_Categoria
-- LEFT JOIN, consulta 2 --
SELECT
clientes.nombre,
clientes.email,
clientes.fecha_registro
FROM clientes
LEFT JOIN ventas ON clientes.id_cliente = ventas.id_cliente
WHERE ventas.id_venta IS NULL;
-- LEFT JOIN, consulta 3 --
SELECT
productos.nombre_producto,
Categorias.Nombre_Categoria,
productos.precio
FROM productos
INNER JOIN Categorias ON productos.id_categoria = Categorias.ID_Categoria
LEFT JOIN ventas ON productos.id_producto = ventas.id_producto
WHERE ventas.id_producto IS NULL; 
-- UNION ALL, consulta 4 --
-- Tomo como criterio las ciudades para distinguir Online de Presencial --
SELECT DISTINCT ciudad FROM clientes;
-- Consulta 4 -- 
SELECT canal, SUM(total) AS total_facturado
FROM (
SELECT
ventas.fecha_venta,
ventas.cantidad * ventas.precio_unitario AS total,
'Presencial' AS canal
FROM ventas
INNER JOIN clientes ON ventas.id_cliente = clientes.id_cliente
WHERE clientes.ciudad IN ('Mendoza', 'Rosario')
UNION ALL
SELECT 
ventas.fecha_venta,
ventas.cantidad * ventas.precio_unitario AS total,
'Online' AS canal
FROM ventas
INNER JOIN clientes ON ventas.id_cliente = clientes.id_cliente
WHERE clientes.ciudad NOT IN ('Mendoza', 'Rosario')
) 
AS ventas_por_canal
GROUP BY canal;
