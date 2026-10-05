-- M5 - Pre-Entrega - Santiago Monjo
-- Consultas con JOIN y UNION sobre Ventas_Tech_DB

USE Ventas_Tech_DB;

-- Consulta 1: Vista base del proyecto (INNER JOIN)

SELECT
    v.fecha_venta,
    c.nombre                        AS cliente,
    c.segmento,
    t.region,
    p.nombre_producto               AS producto,
    cat.nombre_categoria            AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario  AS total_venta,
    v.canal
FROM ventas v
INNER JOIN clientes c     ON v.id_cliente = c.id_cliente
INNER JOIN productos p    ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
INNER JOIN territorios t  ON v.id_territorio = t.id_territorio
ORDER BY v.fecha_venta;

-- Consulta 2: Clientes sin ventas (LEFT JOIN)
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- Consulta 3: Productos sin ventas (LEFT JOIN)
SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;

-- Consulta 4: Total por canal (UNION ALL)
SELECT
    canal,
    SUM(total_venta) AS total_facturado
FROM (
    SELECT 'Online' AS canal, cantidad * precio_unitario AS total_venta
    FROM ventas
    WHERE canal = 'Online'
    UNION ALL
    SELECT 'Presencial' AS canal, cantidad * precio_unitario AS total_venta
    FROM ventas
    WHERE canal = 'Presencial'
) AS ventas_por_canal
GROUP BY canal;

-- Hallazgos
-- 1. La vista base devuelve las 10 ventas con todos sus datos. La region AMBA (cliente 1) es la que mas facturo: $2640.
-- 2. Jorge Díaz se registro en marzo y todavia no compro nada. Se le podria mandar una promo de bienvenida.
-- 3. La Webcam HD no tiene ninguna venta. Habria que revisar el precio o darle mas visibilidad.
-- 4. Online facturo $4410 contra $2034 de Presencial, o sea casi el 70% de las ventas son online.
