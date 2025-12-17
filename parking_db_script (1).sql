-- ============================================
-- PARKING LOT DATABASE - SCRIPT COMPLETO
-- ============================================

DROP DATABASE IF EXISTS parking_lot;
CREATE DATABASE parking_lot;
USE parking_lot;

-- ============================================
-- CREACIÓN DE TABLAS
-- ============================================

-- Tabla: tipo_usuario
CREATE TABLE tipo_usuario (
    id_tipo_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre_tipo VARCHAR(50) NOT NULL UNIQUE
);

-- Tabla: tipo_documento
CREATE TABLE tipo_documento (
    id_tipo_documento INT PRIMARY KEY AUTO_INCREMENT,
    nombre_tipo VARCHAR(50) NOT NULL UNIQUE
);

-- Tabla: usuario
CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    id_tipo_documento INT NOT NULL,
    numero_documento VARCHAR(20) NOT NULL UNIQUE,
    nombre_completo VARCHAR(200) NOT NULL,
    email VARCHAR(100) NOT NULL,
    celular VARCHAR(20) NOT NULL,
    fotografia VARCHAR(255) NULL,
    id_tipo_usuario INT NOT NULL,
    password VARCHAR(255) NULL,
    estado ENUM('activo', 'inactivo') DEFAULT 'activo',
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_tipo_documento) REFERENCES tipo_documento(id_tipo_documento),
    FOREIGN KEY (id_tipo_usuario) REFERENCES tipo_usuario(id_tipo_usuario)
);

-- Tabla: marca_vehiculo
CREATE TABLE marca_vehiculo (
    id_marca INT PRIMARY KEY AUTO_INCREMENT,
    nombre_marca VARCHAR(50) NOT NULL UNIQUE
);

-- Tabla: vehiculo
CREATE TABLE vehiculo (
    id_vehiculo INT PRIMARY KEY AUTO_INCREMENT,
    placa VARCHAR(10) NOT NULL UNIQUE,
    color VARCHAR(30) NOT NULL,
    id_marca INT NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    id_usuario_propietario INT NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_marca) REFERENCES marca_vehiculo(id_marca),
    FOREIGN KEY (id_usuario_propietario) REFERENCES usuario(id_usuario)
);

-- Tabla: restriccion_pico_placa
CREATE TABLE restriccion_pico_placa (
    id_restriccion INT PRIMARY KEY AUTO_INCREMENT,
    dia_semana INT NOT NULL,
    ultimo_digito_placa INT NOT NULL,
    activo ENUM('si', 'no') DEFAULT 'si',
    UNIQUE KEY (dia_semana, ultimo_digito_placa)
);

-- Tabla: puerta_acceso
CREATE TABLE puerta_acceso (
    id_puerta INT PRIMARY KEY AUTO_INCREMENT,
    nombre_puerta VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(200) NOT NULL
);

-- Tabla: area_parqueo
CREATE TABLE area_parqueo (
    id_area INT PRIMARY KEY AUTO_INCREMENT,
    nombre_area VARCHAR(100) NOT NULL,
    piso_nivel VARCHAR(50) NOT NULL
);

-- Tabla: tipo_celda
CREATE TABLE tipo_celda (
    id_tipo_celda INT PRIMARY KEY AUTO_INCREMENT,
    nombre_tipo VARCHAR(50) NOT NULL UNIQUE
);

-- Tabla: celda_parqueo
CREATE TABLE celda_parqueo (
    id_celda INT PRIMARY KEY AUTO_INCREMENT,
    codigo_celda VARCHAR(20) NOT NULL UNIQUE,
    id_area INT NOT NULL,
    id_tipo_celda INT NOT NULL,
    estado ENUM('disponible', 'ocupado') DEFAULT 'disponible',
    FOREIGN KEY (id_area) REFERENCES area_parqueo(id_area),
    FOREIGN KEY (id_tipo_celda) REFERENCES tipo_celda(id_tipo_celda)
);

-- Tabla: entrada_salida
CREATE TABLE entrada_salida (
    id_movimiento INT PRIMARY KEY AUTO_INCREMENT,
    id_vehiculo INT NOT NULL,
    id_puerta_entrada INT NOT NULL,
    fecha_hora_entrada DATETIME NOT NULL,
    id_puerta_salida INT NULL,
    fecha_hora_salida DATETIME NULL,
    tiempo_transcurrido TIME NULL,
    id_celda INT NULL,
    id_usuario_registro_entrada INT NOT NULL,
    id_usuario_registro_salida INT NULL,
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(id_vehiculo),
    FOREIGN KEY (id_puerta_entrada) REFERENCES puerta_acceso(id_puerta),
    FOREIGN KEY (id_puerta_salida) REFERENCES puerta_acceso(id_puerta),
    FOREIGN KEY (id_celda) REFERENCES celda_parqueo(id_celda),
    FOREIGN KEY (id_usuario_registro_entrada) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_usuario_registro_salida) REFERENCES usuario(id_usuario)
);

-- Tabla: tipo_incidencia
CREATE TABLE tipo_incidencia (
    id_tipo_incidencia INT PRIMARY KEY AUTO_INCREMENT,
    nombre_tipo VARCHAR(100) NOT NULL UNIQUE
);

-- Tabla: incidencia
CREATE TABLE incidencia (
    id_incidencia INT PRIMARY KEY AUTO_INCREMENT,
    id_vehiculo INT NOT NULL,
    id_tipo_incidencia INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    descripcion TEXT NULL,
    id_usuario_registro INT NOT NULL,
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(id_vehiculo),
    FOREIGN KEY (id_tipo_incidencia) REFERENCES tipo_incidencia(id_tipo_incidencia),
    FOREIGN KEY (id_usuario_registro) REFERENCES usuario(id_usuario)
);

-- ============================================
-- INSERCIÓN DE DATOS
-- ============================================

-- Insertar tipos de usuario
INSERT INTO tipo_usuario (nombre_tipo) VALUES 
('Administrador'),
('Operador'),
('Usuario');

-- Insertar tipos de documento
INSERT INTO tipo_documento (nombre_tipo) VALUES 
('Cédula de Ciudadanía'),
('Cédula de Extranjería'),
('Pasaporte'),
('Tarjeta de Identidad');

-- Insertar usuarios (mínimo 20)
INSERT INTO usuario (id_tipo_documento, numero_documento, nombre_completo, email, celular, fotografia, id_tipo_usuario, password, estado) VALUES 
(1, '1001234567', 'Carlos Rodríguez López', 'carlos.rodriguez@email.com', '3001234567', NULL, 1, 'admin123', 'activo'),
(1, '1002345678', 'María García Sánchez', 'maria.garcia@email.com', '3002345678', NULL, 2, 'oper123', 'activo'),
(1, '1003456789', 'Juan Pérez Martínez', 'juan.perez@email.com', '3003456789', NULL, 2, 'oper456', 'activo'),
(1, '1004567890', 'Ana López Hernández', 'ana.lopez@email.com', '3004567890', NULL, 3, NULL, 'activo'),
(1, '1005678901', 'Pedro Gómez Torres', 'pedro.gomez@email.com', '3005678901', NULL, 3, NULL, 'activo'),
(1, '1006789012', 'Laura Martínez Ruiz', 'laura.martinez@email.com', '3006789012', NULL, 3, NULL, 'activo'),
(1, '1007890123', 'Diego Sánchez Díaz', 'diego.sanchez@email.com', '3007890123', NULL, 3, NULL, 'activo'),
(1, '1008901234', 'Carmen Torres Jiménez', 'carmen.torres@email.com', '3008901234', NULL, 3, NULL, 'activo'),
(1, '1009012345', 'Roberto Díaz Morales', 'roberto.diaz@email.com', '3009012345', NULL, 3, NULL, 'activo'),
(1, '1010123456', 'Elena Ruiz Navarro', 'elena.ruiz@email.com', '3010123456', NULL, 3, NULL, 'activo'),
(1, '1011234567', 'Francisco Morales Castro', 'francisco.morales@email.com', '3011234567', NULL, 3, NULL, 'activo'),
(1, '1012345678', 'Isabel Castro Romero', 'isabel.castro@email.com', '3012345678', NULL, 3, NULL, 'activo'),
(1, '1013456789', 'Miguel Romero Vega', 'miguel.romero@email.com', '3013456789', NULL, 3, NULL, 'activo'),
(1, '1014567890', 'Patricia Vega Ortiz', 'patricia.vega@email.com', '3014567890', NULL, 3, NULL, 'activo'),
(1, '1015678901', 'José Ortiz Mendoza', 'jose.ortiz@email.com', '3015678901', NULL, 3, NULL, 'activo'),
(1, '1016789012', 'Lucía Mendoza Silva', 'lucia.mendoza@email.com', '3016789012', NULL, 3, NULL, 'activo'),
(2, '2001234567', 'Andrés Silva Ramos', 'andres.silva@email.com', '3017890123', NULL, 3, NULL, 'activo'),
(2, '2002345678', 'Sofía Ramos Vargas', 'sofia.ramos@email.com', '3018901234', NULL, 3, NULL, 'activo'),
(1, '1017890123', 'Javier Vargas León', 'javier.vargas@email.com', '3019012345', NULL, 3, NULL, 'activo'),
(1, '1018901234', 'Gabriela León Flores', 'gabriela.leon@email.com', '3020123456', NULL, 3, NULL, 'activo'),
(1, '1019012345', 'Alberto Flores Reyes', 'alberto.flores@email.com', '3021234567', NULL, 3, NULL, 'inactivo'),
(1, '1020123456', 'Valentina Reyes Cruz', 'valentina.reyes@email.com', '3022345678', NULL, 3, NULL, 'activo');

-- Insertar marcas de vehículos
INSERT INTO marca_vehiculo (nombre_marca) VALUES 
('Toyota'),
('Chevrolet'),
('Mazda'),
('Renault'),
('Nissan'),
('Honda'),
('Hyundai'),
('Kia'),
('Ford'),
('Volkswagen'),
('Suzuki'),
('BMW');

-- Insertar vehículos (mínimo 20)
INSERT INTO vehiculo (placa, color, id_marca, modelo, id_usuario_propietario) VALUES 
('ABC123', 'Blanco', 1, 'Corolla 2022', 4),
('DEF456', 'Negro', 2, 'Spark 2021', 5),
('GHI789', 'Rojo', 3, 'CX-5 2023', 6),
('JKL012', 'Azul', 4, 'Logan 2020', 7),
('MNO345', 'Gris', 5, 'Sentra 2022', 8),
('PQR678', 'Blanco', 6, 'Civic 2021', 9),
('STU901', 'Negro', 7, 'Accent 2023', 10),
('VWX234', 'Plata', 8, 'Picanto 2022', 11),
('YZA567', 'Rojo', 9, 'Fiesta 2020', 12),
('BCD890', 'Azul', 10, 'Gol 2021', 13),
('EFG123', 'Verde', 1, 'Hilux 2023', 14),
('HIJ456', 'Blanco', 2, 'Onix 2022', 15),
('KLM789', 'Negro', 3, 'Mazda 3 2021', 16),
('NOP012', 'Gris', 4, 'Duster 2023', 17),
('QRS345', 'Rojo', 5, 'Versa 2020', 18),
('TUV678', 'Azul', 6, 'HR-V 2022', 19),
('WXY901', 'Blanco', 7, 'Tucson 2023', 20),
('ZAB234', 'Negro', 8, 'Sportage 2021', 4),
('CDE567', 'Plata', 9, 'Ecosport 2022', 5),
('FGH890', 'Rojo', 10, 'Tiguan 2023', 6),
('IJK123', 'Azul', 11, 'Swift 2021', 7),
('LMN456', 'Gris', 12, 'X1 2023', 8);

-- Insertar restricciones pico y placa
INSERT INTO restriccion_pico_placa (dia_semana, ultimo_digito_placa, activo) VALUES 
(1, 0, 'si'),
(1, 1, 'si'),
(2, 2, 'si'),
(2, 3, 'si'),
(3, 4, 'si'),
(3, 5, 'si'),
(4, 6, 'si'),
(4, 7, 'si'),
(5, 8, 'si'),
(5, 9, 'si');

-- Insertar puertas de acceso
INSERT INTO puerta_acceso (nombre_puerta, ubicacion) VALUES 
('Puerta Principal', 'Entrada Norte - Calle 50'),
('Puerta Secundaria', 'Entrada Sur - Carrera 20'),
('Puerta VIP', 'Entrada Este - Avenida Central');

-- Insertar áreas de parqueo
INSERT INTO area_parqueo (nombre_area, piso_nivel) VALUES 
('Zona A', 'Sótano 1'),
('Zona B', 'Sótano 1'),
('Zona C', 'Sótano 2'),
('Zona D', 'Sótano 2'),
('Zona E', 'Piso 1'),
('Zona VIP', 'Piso 1');

-- Insertar tipos de celda
INSERT INTO tipo_celda (nombre_tipo) VALUES 
('Carro'),
('Moto');

-- Insertar celdas de parqueo (mínimo 20)
INSERT INTO celda_parqueo (codigo_celda, id_area, id_tipo_celda, estado) VALUES 
('A-101', 1, 1, 'ocupado'),
('A-102', 1, 1, 'disponible'),
('A-103', 1, 1, 'ocupado'),
('A-104', 1, 1, 'disponible'),
('A-105', 1, 2, 'ocupado'),
('B-201', 2, 1, 'ocupado'),
('B-202', 2, 1, 'disponible'),
('B-203', 2, 1, 'ocupado'),
('B-204', 2, 2, 'disponible'),
('B-205', 2, 2, 'ocupado'),
('C-301', 3, 1, 'ocupado'),
('C-302', 3, 1, 'disponible'),
('C-303', 3, 1, 'ocupado'),
('C-304', 3, 1, 'disponible'),
('C-305', 3, 1, 'ocupado'),
('D-401', 4, 1, 'disponible'),
('D-402', 4, 1, 'ocupado'),
('D-403', 4, 2, 'disponible'),
('D-404', 4, 2, 'ocupado'),
('D-405', 4, 2, 'disponible'),
('E-501', 5, 1, 'ocupado'),
('E-502', 5, 1, 'disponible'),
('VIP-601', 6, 1, 'ocupado'),
('VIP-602', 6, 1, 'disponible'),
('VIP-603', 6, 1, 'ocupado');

-- Insertar entradas y salidas (mínimo 20)
INSERT INTO entrada_salida (id_vehiculo, id_puerta_entrada, fecha_hora_entrada, id_puerta_salida, fecha_hora_salida, tiempo_transcurrido, id_celda, id_usuario_registro_entrada, id_usuario_registro_salida) VALUES 
(1, 1, '2024-12-01 08:00:00', 1, '2024-12-01 17:30:00', '09:30:00', 1, 2, 2),
(2, 1, '2024-12-01 08:15:00', 2, '2024-12-01 18:00:00', '09:45:00', 3, 2, 3),
(3, 2, '2024-12-01 09:00:00', 1, '2024-12-01 19:00:00', '10:00:00', 6, 3, 2),
(4, 1, '2024-12-01 07:30:00', 1, '2024-12-01 16:00:00', '08:30:00', 8, 2, 2),
(5, 1, '2024-12-02 08:30:00', 2, '2024-12-02 17:00:00', '08:30:00', 11, 2, 3),
(6, 2, '2024-12-02 09:15:00', 1, '2024-12-02 18:30:00', '09:15:00', 13, 3, 2),
(7, 1, '2024-12-02 08:00:00', 2, '2024-12-02 17:45:00', '09:45:00', 15, 2, 3),
(8, 1, '2024-12-03 07:45:00', 1, '2024-12-03 16:30:00', '08:45:00', 17, 2, 2),
(9, 2, '2024-12-03 08:30:00', 1, '2024-12-03 19:00:00', '10:30:00', 19, 3, 2),
(10, 1, '2024-12-03 09:00:00', 2, '2024-12-03 17:30:00', '08:30:00', 21, 2, 3),
(11, 1, '2024-12-04 08:15:00', 1, '2024-12-04 17:00:00', '08:45:00', 23, 2, 2),
(12, 2, '2024-12-04 08:45:00', 2, '2024-12-04 18:15:00', '09:30:00', 3, 3, 3),
(13, 1, '2024-12-04 07:30:00', 1, '2024-12-04 16:45:00', '09:15:00', 6, 2, 2),
(14, 1, '2024-12-05 08:00:00', 2, '2024-12-05 17:30:00', '09:30:00', 8, 2, 3),
(15, 2, '2024-12-05 09:30:00', 1, '2024-12-05 19:15:00', '09:45:00', 11, 3, 2),
(16, 1, '2024-12-05 08:15:00', 1, '2024-12-05 17:00:00', '08:45:00', 13, 2, 2),
(1, 1, '2024-12-06 08:00:00', 1, '2024-12-06 18:00:00', '10:00:00', 1, 2, 2),
(2, 2, '2024-12-06 08:30:00', 2, '2024-12-06 17:45:00', '09:15:00', 3, 3, 3),
(3, 1, '2024-12-06 09:00:00', 1, '2024-12-06 19:30:00', '10:30:00', 6, 2, 2),
(4, 1, '2024-12-07 07:45:00', 2, '2024-12-07 16:30:00', '08:45:00', 8, 2, 3),
(5, 2, '2024-12-16 08:00:00', NULL, NULL, NULL, 1, 2, NULL),
(6, 1, '2024-12-16 08:30:00', NULL, NULL, NULL, 3, 2, NULL);

-- Insertar tipos de incidencia
INSERT INTO tipo_incidencia (nombre_tipo) VALUES 
('Rayones'),
('Choques'),
('Atropellamientos'),
('Golpes contra muros'),
('Robo de accesorios'),
('Daño en retrovisores');

-- Insertar incidencias (mínimo 20)
INSERT INTO incidencia (id_vehiculo, id_tipo_incidencia, fecha_hora, descripcion, id_usuario_registro) VALUES 
(1, 1, '2024-12-01 10:30:00', 'Rayón en la puerta del conductor', 2),
(3, 2, '2024-12-01 14:00:00', 'Choque leve con otro vehículo al reversar', 2),
(5, 4, '2024-12-02 11:15:00', 'Golpe contra muro en zona de parqueo', 3),
(7, 1, '2024-12-02 15:30:00', 'Rayón en el capó', 2),
(9, 2, '2024-12-03 12:00:00', 'Colisión en el estacionamiento', 3),
(11, 1, '2024-12-04 09:45:00', 'Rayón en la puerta trasera', 2),
(13, 4, '2024-12-04 16:20:00', 'Golpe al columna al estacionar', 2),
(15, 1, '2024-12-05 13:30:00', 'Rayón lateral', 3),
(2, 5, '2024-12-05 17:00:00', 'Robo de emblema del vehículo', 2),
(4, 6, '2024-12-06 10:00:00', 'Retrovisor derecho dañado', 2),
(6, 1, '2024-12-06 14:45:00', 'Rayones múltiples en costado', 3),
(8, 2, '2024-12-07 11:30:00', 'Choque al salir del parqueadero', 2),
(10, 4, '2024-12-08 15:00:00', 'Golpe en parachoques trasero', 3),
(12, 1, '2024-12-09 09:15:00', 'Rayón profundo en capó', 2),
(14, 5, '2024-12-10 16:30:00', 'Robo de tapacubos', 2),
(16, 1, '2024-12-11 12:45:00', 'Rayón en guardafango', 3),
(1, 4, '2024-12-12 10:20:00', 'Golpe leve en bumper', 2),
(3, 1, '2024-12-13 14:00:00', 'Rayón en puerta lateral', 2),
(5, 2, '2024-12-14 11:45:00', 'Choque menor con motocicleta', 3),
(7, 6, '2024-12-15 15:30:00', 'Retrovisor izquierdo averiado', 2);

-- ============================================
-- FIN DEL SCRIPT
-- ============================================