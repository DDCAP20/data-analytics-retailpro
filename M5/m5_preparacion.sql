-- M5 - Preparacion de datos - Santiago Monjo
-- Agrega lo que falta para las consultas del M5 (segmento, territorios y canal).

USE Ventas_Tech_DB;
GO

-- Nueva tabla territorios
CREATE TABLE territorios (
    id_territorio INT PRIMARY KEY,
    region        VARCHAR(50) NOT NULL,
    pais          VARCHAR(50) NOT NULL,
    zona          VARCHAR(50)
);

INSERT INTO territorios VALUES (1, 'AMBA', 'Argentina', 'Buenos Aires');
INSERT INTO territorios VALUES (2, 'Centro', 'Argentina', 'Córdoba');
INSERT INTO territorios VALUES (3, 'Centro', 'Argentina', 'Santa Fe');
INSERT INTO territorios VALUES (4, 'Cuyo', 'Argentina', 'Mendoza');
INSERT INTO territorios VALUES (5, 'Norte', 'Argentina', 'Tucumán');

-- Columnas nuevas
ALTER TABLE clientes ADD segmento VARCHAR(30);
ALTER TABLE ventas ADD id_territorio INT;
ALTER TABLE ventas ADD canal VARCHAR(20);
ALTER TABLE ventas ADD FOREIGN KEY (id_territorio) REFERENCES territorios(id_territorio);
GO

-- Segmento de cada cliente
UPDATE clientes SET segmento = 'Empresa'    WHERE id_cliente IN (1, 4, 5);
UPDATE clientes SET segmento = 'Consumidor' WHERE id_cliente IN (2, 3);

-- Territorio y canal de cada venta
UPDATE ventas SET id_territorio = 1 WHERE id_cliente = 1;
UPDATE ventas SET id_territorio = 2 WHERE id_cliente = 2;
UPDATE ventas SET id_territorio = 3 WHERE id_cliente = 3;
UPDATE ventas SET id_territorio = 4 WHERE id_cliente = 4;
UPDATE ventas SET id_territorio = 5 WHERE id_cliente = 5;

UPDATE ventas SET canal = 'Online'     WHERE id_venta IN (1, 3, 4, 7, 9);
UPDATE ventas SET canal = 'Presencial' WHERE id_venta IN (2, 5, 6, 8, 10);

-- Un cliente y un producto nuevos, todavia sin ventas
INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_registro, segmento)
VALUES (6, 'Jorge Díaz', 'jorge@mail.com', 'Córdoba', '2024-03-10', 'Consumidor');

INSERT INTO productos VALUES (7, 'Webcam HD', 2, 65.00, 25, 1);
