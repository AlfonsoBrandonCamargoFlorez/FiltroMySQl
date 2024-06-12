CREATE DATABASE tech_haven;
USE tech_haven;

CREATE TABLE tousuarios(
    tousuarios_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL,
    fecha_registro DATE
);


CREATE TABLE toproductos(
    toproductos_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2),
    descripcion VARCHAR(255)
);

CREATE TABLE topedidos(
    topedidos_id INT PRIMARY KEY AUTO_INCREMENT,
    tousuarios_id INT,
    fecha DATE,
    total DECIMAL(10, 2),
    FOREIGN KEY (tousuarios_id) REFERENCES tousuarios(tousuarios_id)
);

CREATE TABLE todetallep(
    id_pedido INT,
    toproductos_id INT,
    cantidad INT,
    precio_unitario DECIMAL(10, 2),
    PRIMARY KEY (id_pedido, toproductos_id),
    FOREIGN KEY (id_pedido) REFERENCES topedidos(topedidos_id),
    FOREIGN KEY (toproductos_id) REFERENCES toproductos(toproductos_id)
);

