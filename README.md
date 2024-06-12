-- 1. Obtener la lista de todos los productos con sus precio
~~~sql
SELECT nombre, precio
FROM toproductos;
~~~
 -- 2. Encontrar todos los pedidos realizados por un usuario específico, por ejemplo, Juan Perez
 ~~~sql
 SELECT tu.tousuarios_id, tu.nombre, td.id_pedido
 FROM tousuarios AS tu
 INNER JOIN topedidos AS tp
 ON tu.tousuarios_id = tp.tousuarios_id
 INNER JOIN todetallep AS td
 ON td.id_pedido = tp.topedidos_id
 WHERE tu.nombre = 'Juan Perez';
 ~~~
-- 3. Listar los detalles de todos los pedidos, incluyendo el nombre del producto, cantidad y precio unitario
~~~sql
SELECT tp.topedidos_id, tpro.nombre, td.cantidad, td.precio_unitario
FROM topedidos AS tp
INNER JOIN todetallep AS td 
ON tp.topedidos_id = td.id_pedido
INNER JOIN toproductos AS tpro 
ON td.toproductos_id = tpro.toproductos_id;
~~~

-- 4. Calcular el total gastado por cada usuario en todos sus pedidos
~~~sql
SELECT tu.nombre, SUM(td.cantidad * td.precio_unitario) AS total_gastado
FROM tousuarios AS tu
INNER JOIN topedidos AS tp 
ON tu.tousuarios_id = tp.tousuarios_id
INNER JOIN todetallep AS td 
ON tp.topedidos_id = td.id_pedido
GROUP BY tu.nombre, tu.correo_electronico;
~~~

-- 5. Encontrar los productos más caros (precio mayor a $500)
~~~sql
SELECT nombre, precio
FROM toproductos
WHERE precio > 500;
~~~

-- 6. Listar los pedidos realizados en una fecha específica, por ejemplo, 2024-03-10
~~~sql
SELECT topedidos_id, total AS Valor_del_Pedido
FROM topedidos
WHERE DATE (fecha) = '2024-03-10';
~~~
-- 7. Obtener el número total de pedidos realizados por cada usuario
~~~sql
 SELECT tu.tousuarios_id AS ID, tu.nombre, SUM(td.id_pedido) AS Pedidos_realizados
 FROM tousuarios AS tu
 INNER JOIN topedidos AS tp
 ON tu.tousuarios_id = tp.tousuarios_id
 INNER JOIN todetallep AS td
 ON td.id_pedido = tp.topedidos_id
 GROUP BY tu.tousuarios_id, tu.nombre;
 
~~~
-- 8. Encontrar el nombre del producto más vendido (mayor cantidad total vendida)
~~~sql
SELECT tp.nombre, SUM(td.cantidad) AS total_vendido
FROM toproductos AS tp
INNER JOIN todetallep AS td 
ON tp.toproductos_id = td.toproductos_id
GROUP BY tp.nombre
ORDER BY total_vendido DESC
LIMIT 1;

~~~
-- 9. Listar todos los usuarios que han realizado al menos un pedido
~~~sql
SELECT tu.nombre
FROM tousuarios AS tu
INNER JOIN topedidos AS tp
ON tu.tousuarios_id = tp.tousuarios_id;

~~~


-- 10. Obtener los detalles de un pedido específico, incluyendo los productos y cantidades, porejemplo, pedido con id 1
~~~sql
SELECT tp.topedidos_id, tpro.nombre, td.cantidad, td.precio_unitario
FROM topedidos AS tp
INNER JOIN todetallep AS td 
ON tp.topedidos_id = td.id_pedido
INNER JOIN toproductos AS tpro 
ON td.toproductos_id = tpro.toproductos_id
WHERE tp.topedidos_id = 1;

~~~
-- Subconsultas

-- 1. Encontrar el nombre del usuario que ha gastado más en total
~~~sql

SELECT tu.nombre, SUM(tp.total) AS TotalGastado
FROM tousuarios AS tu
INNER JOIN topedidos AS tp 
ON tu.tousuarios_id = tp.tousuarios_id
GROUP BY tu.nombre
ORDER BY TotalGastado DESC
LIMIT 1;
~~~


-- 2. Listar los productos que han sido pedidos al menos una vez
~~~sql
SELECT DISTINCT tp.nombre
FROM toproductos AS tp
INNER JOIN todetallep AS td 
ON tp.toproductos_id = td.toproductos_id;

~~~

-- 3. Obtener los detalles del pedido con el total más alto
~~~sql
SELECT tp.topedidos_id, tp.fecha, tp.total,
       td.id_pedido, td.toproductos_id, td.cantidad,
       tpr.nombre AS nombre_producto
FROM topedidos AS tp
INNER JOIN todetallep AS td 
ON tp.topedidos_id = td.id_pedido
INNER JOIN toproductos AS tpr 
ON td.toproductos_id = tpr.toproductos_id
INNER JOIN (
    SELECT MAX(total) AS max_total
    FROM topedidos
) AS max_total_pedido ON tp.total = max_total_pedido.max_total;

~~~
-- 4. Listar los usuarios que han realizado más de un pedido
~~~sql

SELECT tu.nombre, COUNT(tp.topedidos_id) AS cantidad_pedidos
FROM tousuarios AS tu
INNER JOIN (
    SELECT tousuarios_id, COUNT(*) AS num_pedidos
    FROM topedidos
    GROUP BY tousuarios_id
    HAVING COUNT(*) > 1
) AS pedidos_multiples ON tu.tousuarios_id = pedidos_multiples.tousuarios_id
INNER JOIN topedidos AS tp 
ON tu.tousuarios_id = tp.tousuarios_id
GROUP BY tu.nombre;

~~~
-- 5. Encontrar el producto más caro que ha sido pedido al menos una vez


-- Procedimientos Almacenados

-- Crear un procedimiento almacenado para agregar un nuevo producto
-- Enunciado: Crea un procedimiento almacenado llamado AgregarProducto que reciba como parámetros el nombre, descripción y precio de un nuevo producto y lo inserte en la tabla Productos .



-- Crear un procedimiento almacenado para obtener los detalles de un pedido
-- Enunciado: Crea un procedimiento almacenado llamado ObtenerDetallesPedido que reciba como parámetro el ID del pedido y devuelva los detalles del pedido, incluyendo el nombre del producto, cantidad y precio unitario.


-- Crear un procedimiento almacenado para actualizar el precio de un producto
-- Enunciado: Crea un procedimiento almacenado llamado ActualizarPrecioProducto que reciba como parámetros el ID del producto y el nuevo precio, y actualice el precio del producto en la tabla Productos .


-- Crear un procedimiento almacenado para eliminar un producto
-- Enunciado: Crea un procedimiento almacenado llamado EliminarProducto que reciba como parámetro el ID del producto y lo elimine de la tabla Productos .


-- Crear un procedimiento almacenado para obtener el total gastado por un usuario
-- Enunciado: Crea un procedimiento almacenado llamado TotalGastadoPorUsuario que reciba como parámetro el ID del usuario y devuelva el total gastado por ese usuario en todos sus pedidos.
