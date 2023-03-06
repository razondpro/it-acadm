/*****************TIENDA**************/
/* 1- Llista el nom de tots els productes que hi ha en la taula producto. */
select nombre from producto
/* 2- Llista els noms i els preus de tots els productes de la taula producto. */
select nombre, precio from producto
/* 3- Llista totes les columnes de la taula producto. */
select * from productos
/* 4- Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).*/
select nombre, precio as Euros, round(precio*1.06, 2) as USD from producto
/* 5- Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).
 Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars.*/
select nombre, precio as Euros, round(precio*1.06, 2) as dolares from producto
/* 6- Llista els noms i els preus de tots els productes de la taula producto, convertint els 
noms a majúscula. */
select upper(nombre), precio from producto
/* 7- Llista els noms i els preus de tots els productes de la taula producto, convertint els 
noms a minúscula. */
select lower(nombre), precio from producto
/* 8- Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en 
majúscules els dos primers caràcters del nom del fabricant.*/
select nombre, upper(substring(nombre,1,2)) from fabricante
/* 9- Llista els noms i els preus de tots els productes de la taula producto, arrodonint el 
valor del preu. */
select nombre, round(precio, 0) as precio from producto
/* 10- Llista els noms i els preus de tots els productes de la taula producto, truncant el
 valor del preu per a mostrar-lo sense cap xifra decimal. */
select nombre, truncate(precio,0) as precio from producto
/* 11- Llista el codi dels fabricants que tenen productes en la taula producto. */
select codigo_fabricante from producto
/* 12- Llista el codi dels fabricants que tenen productes en la taula producto, 
eliminant els codis que apareixen repetits.*/
select distinct codigo_fabricante from producto
/* 13- Llista els noms dels fabricants ordenats de manera ascendent. */
select nombre from fabricante order by nombre asc
/* 14- Llista els noms dels fabricants ordenats de manera descendent. */
select nombre from fabricante order by nombre desc
/* 15- Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent i,
 en segon lloc, pel preu de manera descendent. */
select nombre, precio from producto order by nombre asc, precio desc
/* 16- Retorna una llista amb les 5 primeres files de la taula fabricante. */
select * from fabricante limit 5
/* 17- Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante.
 La quarta fila també s'ha d'incloure en la resposta.*/
select * from producto limit 3,2
/* 18- Llista el nom i el preu del producte més barat. (Utilitza solament les clàusules 
ORDER BY i LIMIT). NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY. */
select nombre, precio from producto order by precio asc limit 1
/* 19- Llista el nom i el preu del producte més car. (Utilitza solament les clàusules 
ORDER BY i LIMIT). NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY. */
select nombre, precio from producto order by precio desc limit 1
/* 20- Llista el nom de tots els productes del fabricant el codi de fabricant del 
qual és igual a 2. */
select nombre from producto where codigo_fabricante = 2
/* 21 - Retorna una llista amb el nom del producte, preu i nom de fabricant de 
tots els productes de la base de dades. */
select p.nombre, p.precio, f.nombre as nombre_fabricante 
from producto p inner join fabricante f on p.codigo_fabricante=f.codigo
/* 22- Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes 
de la base de dades. Ordena el resultat pel nom del fabricant, per ordre alfabètic. */
select p.nombre, p.precio, f.nombre as nombre_fabricante 
from producto p inner join fabricante f on p.codigo_fabricante=f.codigo
order by f.nombre
/* 23- Retorna una llista amb el codi del producte, nom del producte, codi del fabricador
 i nom del fabricador, de tots els productes de la base de dades. */
select p.codigo, p.nombre, f.codigo as codigo_fabricante, f.nombre as nombre_fabricante 
from producto p inner join fabricante f on p.codigo_fabricante=f.codigo
/* 24- Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat. */
select p.nombre, p.precio, f.nombre as nombre_fabricante 
from producto p inner join fabricante f on p.codigo_fabricante=f.codigo
order by p.precio asc limit 1
/* 25- Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car. */
select p.nombre, p.precio, f.nombre as nombre_fabricante 
from producto p inner join fabricante f on p.codigo_fabricante=f.codigo
order by p.precio desc limit 1
/* 26- Retorna una llista de tots els productes del fabricant Lenovo. */
select p.*, f.nombre as nombre_fabricante
from producto p inner join fabricante f on p.codigo_fabricante=f.codigo
where f.nombre = "lenovo"
/* 27- Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu 
major que 200 €. */
select p.*, f.nombre as nombre_fabricante
from producto p inner join fabricante f on p.codigo_fabricante=f.codigo
where f.nombre = "crucial" and p.precio > 200
/* 28- Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard
 y Seagate. Sense utilitzar l'operador IN. */
select p.*, f.nombre as nombre_fabricante
from producto p inner join fabricante f on p.codigo_fabricante=f.codigo
where f.nombre = "Hewlett-Packard" or f.nombre = "asus" or f.nombre = "seagate"
/* 29- Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard y Seagate.
 Fent servir l'operador IN. */
select p.*, f.nombre as nombre_fabricante
from producto p inner join fabricante f on p.codigo_fabricante=f.codigo
where f.nombre in ( "Hewlett-Packard", "asus", "seagate")
/* 30- Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels 
quals acabi per la vocal e. */
select p.nombre, p.precio, f.nombre as nombre_fabricante
from producto p inner join fabricante f on p.codigo_fabricante=f.codigo
where f.nombre like "%e"
/* 31- Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels 
quals contingui el caràcter w en el seu nom. */
select p.nombre, p.precio, f.nombre as nombre_fabricante
from producto p inner join fabricante f on p.codigo_fabricante=f.codigo
where f.nombre like "%w%"
/* 32- Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes
 que tinguin un preu major o igual a 180 €. Ordena el resultat, en primer lloc, pel preu 
 (en ordre descendent) i, en segon lloc, pel nom (en ordre ascendent).*/
select p.nombre, p.precio, f.nombre as nombre_fabricante
from producto p inner join fabricante f on p.codigo_fabricante=f.codigo
where p.precio > 180
order by p.precio desc, p.nombre asc
/* 33- Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants
 que tenen productes associats en la base de dades. */
select f.codigo, f.nombre
from fabricante f inner join producto p on f.codigo=p.codigo_fabricante
/* 34- Retorna un llistat de tots els fabricants que existeixen en la base de dades, 
juntament amb els productes que té cadascun d'ells. El llistat haurà de mostrar també aquells 
fabricants que no tenen productes associats.*/
select f.codigo, f.nombre, p.nombre
from fabricante f left join producto p on f.codigo=p.codigo_fabricante
/* 35- Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.*/
select nombre 
from fabricante f
where not exists (select * from producto p where p.codigo_fabricante=f.codigo)
/* 36- Retorna tots els productes del fabricador Lenovo. (Sense utilitzar INNER JOIN). */
select *
from producto p
where p.codigo_fabricante = (select codigo from fabricante f where f.nombre = "lenovo")
/* 37- Retorna totes les dades dels productes que tenen el mateix preu que el producte més 
car del fabricant Lenovo. (Sense usar INNER JOIN). */
select *
from producto p
where p.precio = (
    select max(precio) from producto p where p.codigo_fabricante = (
        select codigo from fabricante f where f.nombre = "lenovo")
) 
/* 38- Llista el nom del producte més car del fabricant Lenovo.*/
select *
from producto p
where p.codigo_fabricante = (select codigo from fabricante f where f.nombre = "lenovo")
order by p.precio desc limit 1
/* 39- Llista el nom del producte més barat del fabricant Hewlett-Packard. */
select *
from producto p
where p.codigo_fabricante = (select codigo from fabricante f where f.nombre = "Hewlett-Packard")
order by p.precio asc limit 1
/* 40- Retorna tots els productes de la base de dades que tenen un preu major
 o igual al producte més car del fabricant Lenovo. */
select *
from producto p
where p.precio > (
    select max(precio) from producto p where p.codigo_fabricante = (
        select codigo from fabricante f where f.nombre = "lenovo")
) 
/* 41- Llesta tots els productes del fabricant Asus que tenen un preu superior al preu mitjà
 de tots els seus productes.*/
select *
from producto p inner join fabricante f on p.codigo_fabricante=f.codigo
where f.nombre="Asus" 
and precio > (
    select avg(precio) 
    from producto 
    where codigo_fabricante = (
        select codigo 
        from fabricante 
        where nombre = "Asus")
)





