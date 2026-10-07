# RetailPro – Proyecto de Data Analytics

Proyecto del curso de Data Analytics. Análisis de ventas de **RetailPro**, una distribuidora de tecnología, desde la base de datos en SQL hasta el dashboard en Power BI.

**Pregunta de negocio:** ¿por qué el margen de RetailPro no crece igual que sus ventas, y qué región, categoría de producto o canal de venta lo explica?

## Herramientas

- **SQL Server** – base de datos `Ventas_Tech_DB`
- **Power BI Desktop** – limpieza con Power Query, modelo de datos y medidas DAX
- **GitHub** – entregas del proyecto

## Estructura del repositorio

| Carpeta | Contenido |
|---|---|
| `M3/` | `ventas_tech_db.sql` – crea las tablas y carga los datos iniciales |
| `M4/` | `m4_consultas_negocio.sql` – consultas con agregaciones (totales, ranking, clientes recurrentes) |
| `M5/` | `m5_preparacion.sql` – agrega territorios, segmento y canal · `m5_consultas_joins.sql` – consultas con JOIN y UNION |
| `M6/` | `Pipeline_ETL_Monjo_Santiago.pbix` – conexión a SQL Server y limpieza en Power Query |
| `M8/` | `Monjo_Santiago_Checkpoint2.pbix` – modelo estrella, tabla calendario y medidas DAX |

## Cómo ejecutar los scripts SQL

1. En SSMS ejecutar una sola vez: `CREATE DATABASE Ventas_Tech_DB;`
2. Ejecutar `M3/ventas_tech_db.sql` (crea `categorias`, `clientes`, `productos` y `ventas`).
3. Ejecutar **una sola vez** `M5/m5_preparacion.sql` (crea `territorios` y agrega segmento y canal).
4. Las consultas de `M4/` y `M5/m5_consultas_joins.sql` se pueden ejecutar todas las veces que se quiera.

> Importante: después del paso 3 no volver a ejecutar el script del M3, porque borra la tabla `ventas` con las columnas nuevas.

## Modelo de datos

- Tabla de hechos: `Fact_Ventas`
- Dimensiones: `Dim_Clientes`, `Dim_Productos`, `Dim_Categorias`, `Dim_Territorios` y `Dim_Fechas` (calendario)
- Medidas DAX: Total Ventas, Ventas Online, Ventas YTD, Ventas LY y % Crecimiento Anual

## Autor

Santiago Monjo
