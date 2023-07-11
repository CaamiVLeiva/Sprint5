###Construya una base de datos. 
CREATE DATABASE soporte;
USE soporte;
  ## Asigne un usuario con todos los privilegios. 
CREATE USER 'sprint'@'%' IDENTIFIED BY 'root';
GRANT ALL PRIVILEGES ON soporte.* TO 'sprint'@'%';
FLUSH PRIVILEGES;

  ## Construya las tablas.
  
# Tabla Usuario
CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    edad TINYINT,
    correo_electronico VARCHAR(100),
    veces_utilizado INT DEFAULT 1
);

# Tabla Operario
CREATE TABLE operario (
    id_operario INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    edad TINYINT,
    correo_electronico VARCHAR(100),
    veces_soporte INT DEFAULT 1
);

# Tabla Soporte
CREATE TABLE soporte (
    id_soporte INT PRIMARY KEY,
    id_operario INT,
    id_usuario INT,
    fecha DATETIME,
    FOREIGN KEY (id_operario) REFERENCES operario(id_operario),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

# Tabla Evaluacion
CREATE TABLE evaluacion (
    id_evaluacion INT PRIMARY KEY,
    id_soporte INT,
    nota TINYINT,
    comentario VARCHAR(255),
    FOREIGN KEY (id_soporte) REFERENCES soporte(id_soporte)
);

###Agregue 5 usuarios, 5 operadores y 10 operaciones de soporte. Los datos debe crearlos según su imaginación.
# Insertar usuarios
INSERT INTO usuario (id_usuario, nombre, apellido, edad, correo_electronico, veces_utilizado)
VALUES
    (1, 'Juan', 'Pérez', 30, 'juan@mail.com', 11),
    (2, 'María', 'González', 25, 'maria@mail.com', 3),
    (3, 'Carlos', 'López', 35, 'carlos@mail.com', 10),
    (4, 'Laura', 'Rodríguez', 28, 'laura@mail.com', 5),
    (5, 'Pedro', 'Sánchez', 32, 'pedro@mail.com', 8);

# Insertar operarios
INSERT INTO operario (id_operario, nombre, apellido, edad, correo_electronico, veces_soporte)
VALUES
    (1, 'Luis', 'Martínez', 40, 'luis@mail.com', 5),
    (2, 'Ana', 'Hernández', 27, 'ana@mail.com', 7),
    (3, 'Mario', 'García', 33, 'mario@mail.com', 9),
    (4, 'Sofía', 'Torres', 31, 'sofia@mail.com', 10),
    (5, 'Elena', 'Díaz', 19, 'elena@mail.com', 2);

# Insertar soportes
INSERT INTO soporte (id_soporte, id_operario, id_usuario, fecha)
VALUES
    (1, 1, 2, '2023-07-01 09:00:00'),
    (2, 3, 4, '2023-07-02 10:30:00'),
    (3, 2, 1, '2023-07-03 14:15:00'),
    (4, 4, 5, '2023-07-04 11:45:00'),
    (5, 5, 3, '2023-07-05 16:20:00'),
    (6, 1, 3, '2023-07-06 13:00:00'),
    (7, 2, 4, '2023-07-07 10:00:00'),
    (8, 3, 5, '2023-07-08 15:30:00'),
    (9, 4, 2, '2023-07-09 12:45:00'),
    (10, 5, 1, '2023-07-10 17:00:00');

# Insertar evaluaciones
INSERT INTO evaluacion (id_evaluacion, id_soporte, nota, comentario)
VALUES
    (1, 1, 7, 'Excelente servicio'),
    (2, 2, 5, 'Podría mejorar'),
    (3, 3, 6, 'Buen trato'),
    (4, 4, 4, 'Tiempo de respuesta lento'),
    (5, 5, 7, 'Muy amable'),
    (6, 6, 7, 'Resolvió mi problema rápidamente'),
    (7, 7, 6, 'Explicaciones claras'),
    (8, 8, 4, 'No quedé satisfecho'),
    (9, 9, 6, 'Regular'),
    (10, 10, 5, 'Se demoró en responder');

### Seleccione las 3 operaciones con mejor evaluación.
SELECT soporte.id_soporte, usuario.nombre AS nombre_usuario, operario.nombre AS nombre_operario, evaluacion.nota
FROM soporte
JOIN usuario ON soporte.id_usuario = usuario.id_usuario
JOIN operario ON soporte.id_operario = operario.id_operario
JOIN evaluacion ON soporte.id_soporte = evaluacion.id_soporte
ORDER BY evaluacion.nota DESC
LIMIT 3;


### Seleccione las 3 operaciones con menos evaluación.
SELECT soporte.id_soporte, usuario.nombre AS nombre_usuario, operario.nombre AS nombre_operario, evaluacion.nota
FROM soporte
JOIN usuario ON soporte.id_usuario = usuario.id_usuario
JOIN operario ON soporte.id_operario = operario.id_operario
JOIN evaluacion ON soporte.id_soporte = evaluacion.id_soporte
ORDER BY evaluacion.nota ASC
LIMIT 3;


### Seleccione al operario que más soportes ha realizado.
SELECT *
FROM operario
ORDER BY veces_soporte DESC
LIMIT 1;

### Seleccione al cliente que menos veces ha utilizado la aplicación.
SELECT *
FROM usuario
ORDER BY veces_utilizado ASC
LIMIT 1;

### Agregue 10 años a los tres primeros usuarios registrados.
UPDATE usuario
SET edad = edad + 10
WHERE id_usuario IN (1, 2, 3); #Antes eran: 30,25 y 35, ahora son: 40,35,45.

### Renombre todas las columnas ‘correo electrónico’. El nuevo nombre debe ser email.
ALTER TABLE usuario
CHANGE COLUMN correo_electronico email VARCHAR(100);

ALTER TABLE operario
CHANGE COLUMN correo_electronico email VARCHAR(100);

### Seleccione solo los operarios mayores de 20 años.
SELECT *
FROM operario
WHERE edad > 20; # 4 de 5 operarios son mayores de 20 años.

