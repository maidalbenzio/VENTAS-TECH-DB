--- voy a chequar que me este tomando la base de datos que quiero ---
SELECT *
FROM ventas;
-- para sacar el mes ahora le pedimos que me agrupe la venta ---
SELECT MONTH(fecha_venta) AS mes
FROM ventas
GROUP BY MONTH(fecha_venta);
--- ahora tenemos que calcular cuanto se facturo --- 
SELECT 
MONTH(fecha_venta) AS mes,
SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY MONTH(fecha_venta);
--- ahora vamos con la cantidad de pedidos ---
SELECT 
MONTH(fecha_venta) AS mes,
SUM(cantidad * precio_unitario) AS total_facturado,
COUNT(*) AS cantidad_pedidos
FROM ventas
GROUP BY MONTH(fecha_venta);
--- ahora voy a mirar cual es el ticket promedio con el resumen ejecutivo mensual ---
SELECT 
MONTH(fecha_venta) AS mes,
SUM(cantidad * precio_unitario) AS total_facturado,
COUNT(*) AS cantidad_pedidos,
AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta);
--- ahora para responder al ranking de productos ---
SELECT
id_producto
FROM ventas
GROUP BY id_producto;
--- ahora para ver cuantas unidades vendimos de cada producto ---
SELECT 
id_producto,
SUM(cantidad) AS unidades_vendidas
FROM ventas
GROUP BY id_producto;
--- ahora hay que ver cuanta plata trajo cada producto --
SELECT
id_producto,
SUM(cantidad) AS unidades_vendidas,
SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto;
--- ahora vamos a hacer el ranking y los ordenamos de mayor a menor --- 
SELECT 
id_producto,
SUM(cantidad) AS unidades_vendidas,
SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;
-- ahora solo quiero que me topee los primeros 5 ---
SELECT TOP 5
id_producto,
SUM(cantidad) AS unidades_vendidas,
SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;
--- ahora vamos con los clientes recurrentes, 1ero vamos a agrupar por clientes --- 
SELECT id_cliente
FROM ventas
GROUP BY id_cliente;
--- ahora cuento cuantos pedidos hizo cada cliente ---
SELECT id_cliente,
COUNT(*) AS cantidad_pedidos
FROM ventas
GROUP BY id_cliente;
--- quiero que me muestre solo los clientes recurrentes, uso HAVING para que filtre por grupos ---
SELECT     id_cliente,
COUNT(*) AS cantidad_pedidos
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;
--- ahora el gasto de cliente recurrente --> Agrupamos las ventas x cliente + count cuantos pedidos + sum para el gasto y el having para contar los que compran una vez ---
SELECT id_cliente,
COUNT(*) AS cantidad_pedidos,
SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;
--- ahora la facturacion mensual del promedio ---
SELECT MONTH(fecha_venta) AS mes,
SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas 
GROUP BY MONTH(fecha_venta);
--- ahora calculamos el promedio, metemos el AVG adentro de la otra consulta para hacer una subconsulta ---
SELECT AVG(total_facturado)
FROM ( SELECT MONTH(fecha_venta) AS mes,
SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY MONTH(fecha_venta)
) AS resumen_mensual;
--- ahora vamos a probar el CASE WHEN que sirve para que SQL decida algo (si pasa algo hago esto, si no hago lo otro) ---
SELECT MONTH(fecha_venta) AS mes,
SUM(cantidad * precio_unitario) AS total_facturado,
CASE WHEN SUM(cantidad * precio_unitario) > 6444
THEN 'Por encima' 
ELSE 'Por debajo'
END AS comparacion
FROM ventas GROUP BY MONTH(fecha_venta);
-- ahora para la facturacion - group by para la fact mensual + avg promedio + casa when comparar ---
SELECT MONTH(fecha_venta) AS mes,
SUM(cantidad * precio_unitario) AS total_facturado,
CASE WHEN SUM(cantidad * precio_unitario) > (
SELECT AVG(total_facturado)
FROM (SELECT MONTH(fecha_venta) AS mes,
SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY MONTH(fecha_venta)
) AS resumen_mensual)
THEN 'Por encima'
ELSE 'Por debajo'
END AS comparacion
FROM ventas
GROUP BY MONTH(fecha_venta);

--- Hallazgo 1: el producto 2 es el más popular en ventas ya que tiene la mayor cantidad ---
--- Hallazgo 2: el ticket promedio en realidad es mucho menor pero hubo 2 ventas que concentraron el monto mas alto del valor del producto aumentandolo ---
--- Hallazgo 3: El producto con mayor volumen de ventas no es el que más factura (producto 2 a un costo de $28) y esto indica que el volumen de ventas por si solo no muestra una métrica de valor, conviene evaluar cantidad y ticket ---

