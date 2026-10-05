-- M4 - Pre-Entrega - Santiago Monjo
-- Consultas de negocio sobre Ventas_Tech_DB

USE Ventas_Tech_DB;

-- Consulta 1: Resumen ejecutivo mensual
SELECT
    MONTH(fecha_venta)                             AS mes,
    SUM(cantidad * precio_unitario)                AS total_facturado,
    COUNT(*)                                       AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) / COUNT(*)     AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- Consulta 2: Top 5 productos por facturacion
SELECT TOP 5
    id_producto,
    SUM(cantidad)                   AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

-- Consulta 3: Clientes con mas de un pedido
SELECT
    id_cliente,
    COUNT(*)                        AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

-- Consulta 4: Meses por encima / por debajo del promedio
SELECT
    MONTH(fecha_venta)              AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE
        WHEN SUM(cantidad * precio_unitario) > (SELECT AVG(total_mes) FROM (SELECT SUM(cantidad * precio_unitario) AS total_mes FROM ventas GROUP BY MONTH(fecha_venta)) AS t) THEN 'Por encima'
        WHEN SUM(cantidad * precio_unitario) < (SELECT AVG(total_mes) FROM (SELECT SUM(cantidad * precio_unitario) AS total_mes FROM ventas GROUP BY MONTH(fecha_venta)) AS t) THEN 'Por debajo'
        ELSE 'Igual al promedio'
    END AS comparacion
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- Hallazgos
-- 1. El producto 1 (Laptop Pro 15) facturo $3600 de un total de $6444, o sea casi el 56% de las ventas.
-- 2. Los 5 clientes hicieron 2 pedidos cada uno, pero los clientes 1 y 5 juntos gastaron $4740 (casi el 74% del total).
-- 3. El producto 2 (Mouse Inalambrico) es el que mas unidades vendio (13) pero el que menos facturo del Top 5 ($364).
--    Ademas, todas las ventas son de marzo 2024, asi que para comparar meses hacen falta datos de mas meses.
