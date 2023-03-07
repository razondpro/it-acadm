/* Si us plau, descàrrega la base de dades del fitxer schema_universidad.sql,
 visualitza el diagrama E-R en un editor i efectua les següents consultes:*/

 /* 1- Retorna un llistat amb el primer cognom, segon cognom i el nom de tots 
 els/les alumnes.El llistat haurà d'estar ordenat alfabèticament de menor a major
 pel primer cognom, segon cognom i nom. */
select apellido1, apellido2, nombre
from persona
where tipo = "alumno"
order by apellido1 asc, apellido2 asc, nombre asc
/* 2- Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu
número de telèfon en la base de dades. */
select apellido1, apellido2, nombre
from persona
where tipo = "alumno" and telefono is null
/* 3- Retorna el llistat dels alumnes que van néixer en 1999. */
select *
from persona
where tipo = "alumno" and year(fecha_nacimiento) = 1999
/* 4- Retorna el llistat de professors/es que no han donat d'alta el seu número de 
telèfon en la base de dades i a més el seu NIF acaba en K. */
select *
from persona
where tipo = "profesor" and  nif like "%k" and telefono is null
/* 5- Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre,
en el tercer curs del grau que té l'identificador 7. */
select *
from asignatura 
where cuatrimestre = 1 and curso = 3 and id_grado = 7
/* 6- Retorna un llistat dels professors/es juntament amb el nom del departament 
al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom,
segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament 
de menor a major pels cognoms i el nom. */
select p.apellido1, p.apellido2, p.nombre, d.nombre as departamento
from persona p inner join profesor pr on p.id = pr.id_profesor
join departamento d on d.id = pr.id_departamento
order by p.apellido1 asc, p.apellido2 asc, p.nombre asc
/* 7- Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi 
del curs escolar de l'alumne/a amb NIF 26902806M. */
select a.nombre, c.anyo_inicio, c.anyo_fin
from asignatura a inner join alumno_se_matricula_asignatura asma on a.id = asma.id_asignatura
inner join persona p on p.id = asma.id_alumno
inner join curso_escolar c on c.id = asma.id_curso_escolar
where p.nif = "26902806M"
/* 8- Retorna un llistat amb el nom de tots els departaments que tenen professors/es 
que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015). */
select distinct d.nombre as nombre_departamento
from departamento d inner join profesor pr on d.id = pr.id_departamento
inner join asignatura a on a.id_profesor = pr.id_profesor
inner join grado g on g.id = a.id_grado
where g.nombre = "Grado en Ingeniería Informática (Plan 2015)"
/* 9- Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant
 el curs escolar 2018/2019. */
select p.*
from persona p inner join alumno_se_matricula_asignatura asma on p.id = asma.id_alumno
inner join curso_escolar ce on ce.id = asma.id_curso_escolar
where p.tipo = "alumno" and ce.anyo_inicio = 2018 and ce.anyo_fin = 2019

/******************************************************************/
/* Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.*/
/* 1- Retorna un llistat amb els noms de tots els professors/es i els departaments
 que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no 
 tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del 
 departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà 
 ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom. */
select  p.apellido1, p.apellido2, p.nombre, d.nombre as nombre_dep
from departamento d right join profesor pr on d.id = pr.id_departamento
left join persona p on p.id = pr.id_profesor
order by d.nombre asc, p.apellido1 asc, p.apellido2 asc, p.nombre asc
/* 2- Retorna un llistat amb els professors/es que no estan associats a un departament. */
/****no salen resultados ya que todos los profesores estan asignados a un departamento****/
select p.nombre, p.apellido1, p.apellido2
from persona p left join profesor pr ON p.id = pr.id_profesor 
left join departamento d on pr.id_departamento = d.id 
where p.tipo = 'profesor' AND d.nombre IS NULL; 
/* 3- Retorna un llistat amb els departaments que no tenen professors/es associats.*/
select d.nombre
from departamento d left join profesor pr on pr.id_departamento = d.id
where pr.id_profesor is null
/* 4- Retorna un llistat amb els professors/es que no imparteixen cap assignatura.*/
select p.* 
from profesor pr left join asignatura a on pr.id_profesor = a.id_profesor
left join persona p on p.id = pr.id_profesor
where a.id_profesor is null
/* 5- Retorna un llistat amb les assignatures que no tenen un professor/a assignat. */
select * from asignatura where id_profesor is null
/* 6- Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.*/
/*************no funciona**************/
select distinct d.nombre 
from departamento d left join profesor pr on d.id = pr.id_departamento 
left join asignatura a on pr.id_profesor = a.id_profesor 
left join alumno_se_matricula_asignatura asma on a.id = asma.id_asignatura 
left join curso_escolar ce ON asma.id_curso_escolar = ce.id 
where ce.anyo_inicio is null and ce.anyo_fin is null

/* Consultes resum: */
/* 1- Retorna el nombre total d'alumnes que hi ha.*/
select count(*)
from persona
where tipo = "alumno"
/* 2- Calcula quants alumnes van néixer en 1999. */
select count(*)
from persona
where year(fecha_nacimiento) = 1999
/* 3- Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes,
una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament.
El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat
de major a menor pel nombre de professors/es. */
select d.nombre, count(pr.id_departamento) 
from departamento d inner join profesor pr on d.id = pr.id_departamento 
group by d.nombre 
order by count(pr.id_departamento) desc
/* 4- Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. 
Tingui en compte que poden existir departaments que no tenen professors/es associats. 
Aquests departaments també han d'aparèixer en el llistat. */
select d.nombre, count(pr.id_departamento) 
from departamento d left join profesor pr on d.id = pr.id_departamento 
group by d.nombre 
/* 5- Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures
 que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. 
 Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures. */
select g.nombre, count(a.id_grado) as asignaturas
from grado g left join asignatura a on g.id = a.id_grado 
group by g.nombre 
order by count(a.id_grado) desc
/* 6- Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures
 que té cadascun, dels graus que tinguin més de 40 assignatures associades. */
select g.nombre, count(a.id_grado) as asignaturas
from grado g left join asignatura a on g.id = a.id_grado 
group by g.nombre 
having count(a.id_grado) > 40
/* 7- Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per
a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura 
i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus. */
select g.nombre, a.tipo, sum(a.creditos) 
from grado g inner join asignatura a on g.id = a.id_grado 
group by g.nombre, a.tipo
/* 8- Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun 
dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del 
curs escolar i una altra amb el nombre d'alumnes matriculats. */
select ce.anyo_inicio, count( asma.id_alumno ) as alumnat
from curso_escolar ce inner join alumno_se_matricula_asignatura asma on ce.id = asma.id_curso_escolar 
group by ce.anyo_inicio
/* 9- Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. 
El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura.
El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. 
El resultat estarà ordenat de major a menor pel nombre d'assignatures. */
select p.id, p.nombre, p.apellido1, p.apellido2, count(a.id_profesor) 
from persona p left join profesor pr on p.id = pr.id_profesor 
left join asignatura a on pr.id_profesor = a.id_profesor 
group by p.id, p.nombre, p.apellido1, p.apellido2 
order by count(a.id_profesor) desc
/* 10- Retorna totes les dades de l'alumne/a més jove. */
select * 
from persona 
where tipo = 'alumno' and fecha_nacimiento = ( 
SELECT MIN(fecha_nacimiento) from persona where tipo = 'alumno')
/* 11- Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura. */
select p.* 
from profesor pr inner join persona p on p.id = pr.id_profesor
where id_departamento is not null and id_profesor not in ( 
select id_profesor from asignatura )
