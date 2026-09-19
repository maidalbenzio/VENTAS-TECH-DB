# RetailPro — Análisis de Datos

Proyecto de análisis de datos para una tienda retail (TechStore), desarrollado
en el curso de Data Analytics de Coderhouse. Cubre desde el modelado de base
de datos hasta un modelo analítico en Power BI con medidas DAX.

## Estructura del repositorio

- `M3/` — Script SQL de creación de la base Ventas_Tech_DB (tablas: Ventas, clientes, productos, Categorias).
- `M4/` — Consultas exploratorias: facturación mensual, ranking de productos, clientes recurrentes.
- `M5/` — Consultas con INNER JOIN, LEFT JOIN y UNION ALL (`m5_consultas_joins.sql`).
- `M6/` — Pipeline de limpieza en Power Query (archivo `.pbix`).
- `M8/` — Modelo de datos en Power BI: relaciones, tabla calendario y medidas DAX core.
- `M9/` — Documentación del uso de IA en el proyecto.

## Herramientas utilizadas

- SQL Server / SSMS (modelado y consultas)
- Power BI Desktop (ETL, modelado, DAX)
- Git / GitHub (control de versiones)

## Nota sobre el esquema

Algunas columnas de las tablas mezclan mayúsculas y minúsculas en su nomenclatura
(por ejemplo `Nombre_Categoria`, `ID_Categoria` junto a `fecha_venta`, `cantidad`).
Tenerlo en cuenta al escribir consultas nuevas sobre estas tablas.

## Cómo ejecutar los scripts SQL

1. Abrir SQL Server Management Studio (SSMS).
2. Ejecutar el script de `M3/` para crear la base Ventas_Tech_DB y sus tablas.
3. Verificar que la base activa en el desplegable de SSMS sea Ventas_Tech_DB (o agregar `USE Ventas_Tech_DB;` al inicio del script).
4. Ejecutar los scripts de `M4/` y `M5/` sobre esa base.

## Estado actual

El modelo de datos en Power BI (M8) ya está completo, con relaciones activas,
tabla calendario y las 5 medidas DAX core. M9 documenta el uso de IA como
asistente en el proyecto (optimización de consultas, generación de insights
y este mismo README).

## Autor

Mailen Dalbenzio — Proyecto RetailPro, curso de Data Analytics.
