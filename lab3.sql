/*Pelicula
- id pelicula
- Titulo Distribucion
- Titulo Original
- Genero
- Idioma original
- Subtitulos (Si o no)
- Paises de origen -> (id pais, id pelicula) -> Pelicula (id pelicula)
- Año de produccion
- Url sitio web pelicula
- Duracion (Horas y minutos)
- calificacion (apta para todo publico, +9 años, +15 años, +18 años)
- Lista de directores (id director, id director) -> Director (id director)
- Reparto -> (id actor, id pelicula) -> Actor (id actor, nombre personaje)*/


/*Posiblemente de aqui solo sea una entidad llamada "persona" si su id aparece en lista de directores entonces es director
Director
- id director (primary key)
- nombre director (primary key)
- nacionalidad

Actor
- id actor (primary key)
- nombre actor (primary key)
- nacionalidad

Cine
- id cine
- nombre cine
- direccion
- contacto

Funcion
- id funcion
- id pelicula
- id sala
- fecha funcion
- hora funcion

Sala
- id sala
- id cine
- numero sala
- numero sillas

Rating
- id pelicula
- id opinion

Opinion
- id opinion
- nombre persona
- edad persona
- fecha registro
- calificacion pelicula (Obra maestra, muy buena, buena, regular, mala)
- comentario*/

CREATE TABLE pelicula(
	id_pelicula VARCHAR2(10) NOT NULL,
	titulo_distribucion VARCHAR2(50) NOT NULL,
	titulo_original VARCHAR2(50) NOT NULL,
	genero VARCHAR2(50),
	idioma_original VARCHAR2(10) NOT NULL,
	subtitulos VARCHAR2(2) NOT NULL, 
	año_produccion NUMBER,
	duracion_horas NUMBER NOT NULL,
	duracion_minutos NUMBER NOT NULL,
	calificacion VARCHAR2(22) NOT NULL,
	CONSTRAINT c_cine_pk_peliculas PRIMARY KEY (id_pelicula),
	CONSTRAINT c_cine_ck_subtitulos CHECK (subtitulos IN ('Si', 'No')),
	CONSTRAINT c_cine_ck_calificacion CHECK (calificacion IN ('Apta todo publico', '+9 años', '+15 años', '+18 años'))
);

CREATE TABLE pais (
	id_pais VARCHAR2(10) NOT NULL,
	nombre VARCHAR2(20),
	CONSTRAINT c_cine_pk_paises PRIMARY KEY (id_pais)
);

CREATE TABLE pelicula_pais (
	id_pais VARCHAR2(10) NOT NULL,
	id_pelicula VARCHAR2(10) NOT NULL,
	CONSTRAINT c_cine_pk_peliculaxpais PRIMARY KEY (id_pais, id_pelicula),
	CONSTRAINT c_cine_fk_pais FOREIGN KEY (id_pais) REFERENCES pais (id_pais),
	CONSTRAINT c_cine_fk_peliculaxpais FOREIGN KEY (id_pelicula) REFERENCES pelicula (id_pelicula)
);

CREATE TABLE director (
	id_director VARCHAR2(10) NOT NULL,
	nombre VARCHAR2(50) NOT NULL,
	nacionalidad VARCHAR2(20),
	CONSTRAINT c_cine_pk_director PRIMARY KEY(id_director)
);

CREATE TABLE pelicula_direccion (
	id_pelicula VARCHAR2(10) NOT NULL,
	id_director VARCHAR2(10) NOT NULL,
	CONSTRAINT c_cine_pk_direccionpelicula PRIMARY KEY (id_pelicula, id_director),
	CONSTRAINT c_cine_fk_director FOREIGN KEY (id_director) REFERENCES director (id_director),
	CONSTRAINT c_cine_fk_directorxpelicula FOREIGN KEY (id_pelicula) REFERENCES pelicula (id_pelicula)
);

CREATE TABLE actor (
	id_actor  VARCHAR2(10) NOT NULL,
	nombre VARCHAR2(50) NOT NULL,
	nacionalidad VARCHAR2(50),
	CONSTRAINT c_cine_pk_actor PRIMARY KEY (id_actor)
);

CREATE TABLE pelicula_reparto (
	id_pelicula VARCHAR2(10),
	id_actor VARCHAR2(10),
	CONSTRAINT c_cine_pk_repartopelicula PRIMARY KEY (id_pelicula, id_actor),
	CONSTRAINT c_cine_fk_actor FOREIGN KEY (id_actor) REFERENCES actor (id_actor),
	CONSTRAINT c_cine_fk_repartoxpelicula FOREIGN KEY (id_pelicula) REFERENCES pelicula (id_pelicula)
);

CREATE TABLE opinion (
	id_opinion VARCHAR2(10) NOT NULL,
	nombre_persona VARCHAR2(50) NOT NULL,
	edad_persona VARCHAR2(3),
	fecha_registro DATE NOT NULL,
	calificacion_pelicula VARCHAR2(15) NOT NULL,
	comentario VARCHAR2(255),
	CONSTRAINT c_cine_pk_opinion PRIMARY KEY (id_opinion),
	CONSTRAINT c_cine_ck_calificacion_opinion CHECK (calificacion_pelicula IN('Obra maestra', 'muy buena', 'buena', 'regular', 'mala'))
);

CREATE TABLE rating (
	id_pelicula VARCHAR2(10) NOT NULL,
	id_opinion VARCHAR2(10) NOT NULL,
	CONSTRAINT c_cine_pk_rating PRIMARY KEY (id_pelicula, id_opinion),
	CONSTRAINT c_cine_fk_opinion FOREIGN KEY (id_opinion) REFERENCES opinion (id_opinion),
	CONSTRAINT c_cine_fk_ratingxpelicula FOREIGN KEY (id_pelicula) REFERENCES pelicula (id_pelicula)
);

CREATE TABLE cine (
	id_cine VARCHAR2(10) NOT NULL,
	nombre VARCHAR2(50) NOT NULL,
	direccion VARCHAR2(50),
	contacto VARCHAR2(10),
	CONSTRAINT c_cine_pk_cine PRIMARY KEY (id_cine)
);

CREATE TABLE sala (
	id_sala VARCHAR2(10) NOT NULL,
	numero_sala VARCHAR2(2) NOT NULL,
	numero_sillas NUMBER NOT NULL,
	CONSTRAINT c_cine_pk_sala PRIMARY KEY (id_sala)
);

CREATE TABLE funcion (
	id_funcion VARCHAR2(10) NOT NULL,
	id_cine VARCHAR2(10) NOT NULL,
	id_sala VARCHAR2(10) NOT NULL,
	id_pelicula VARCHAR2(10) NOT NULL,
	nombre VARCHAR2(50) NOT NULL,
	fecha_funcion DATE NOT NULL,
	hora_funcion DATE NOT NULL,
	CONSTRAINT c_cine_pk_funcion PRIMARY KEY (id_funcion, id_cine, id_sala, id_pelicula),
	CONSTRAINT c_cine_fk_funcionxcine FOREIGN KEY (id_cine) REFERENCES cine (id_cine),
	CONSTRAINT c_cine_fk_funcionxsala FOREIGN KEY (id_sala) REFERENCES sala (id_sala),
	CONSTRAINT c_cine_fk_funcionxpelicula FOREIGN KEY (id_pelicula) REFERENCES pelicula (id_pelicula)
);


/* Uso de secuencias para la asignacion de "ID's" */

CREATE SEQUENCE seq_id_paises
  MINVALUE 1
  MAXVALUE 5
  START WITH 1
  INCREMENT BY 1
  
INSERT INTO pais
(id_pais, nombre)
VALUES
(seq_id_paises.nextval, 'Colombia');

INSERT INTO pais
(id_pais, nombre)
VALUES
(seq_id_paises.nextval, 'USA');

INSERT INTO pais
(id_pais, nombre)
VALUES
(seq_id_paises.nextval, 'India');

INSERT INTO pais
(id_pais, nombre)
VALUES
(seq_id_paises.nextval, 'Alemania');

INSERT INTO pais
(id_pais, nombre)
VALUES
(seq_id_paises.nextval, 'Korea');

select * from pais order by id_pais;

/*-----------------------------------*/

CREATE SEQUENCE seq_id_director
  MINVALUE 1
  MAXVALUE 5
  START WITH 1
  INCREMENT BY 1

INSERT INTO director
(id_director, nombre, nacionalidad)
VALUES
(seq_id_director.nextval, 'Neill Blomkamp', 'Sudafrica'); 

INSERT INTO director
(id_director, nombre, nacionalidad)
VALUES
(seq_id_director.nextval, 'David Fincher', 'Estados Unidos');

INSERT INTO director
(id_director, nombre, nacionalidad)
VALUES
(seq_id_director.nextval, 'Ron Howard', 'Estados Unidos');

INSERT INTO director
(id_director, nombre, nacionalidad)
VALUES
(seq_id_director.nextval, 'Christopher Nolan', 'Estados Unidos');

INSERT INTO director
(id_director, nombre, nacionalidad)
VALUES
(seq_id_director.nextval, 'Bong Joon-ho', 'Korea');

select * from director order by id_director;

/*-----------------------------------*/

CREATE SEQUENCE seq_id_actor
  MINVALUE 1
  MAXVALUE 5
  START WITH 1
  INCREMENT BY 1

INSERT INTO actor
(id_actor, nombre, nacionalidad)
VALUES
(seq_id_actor.nextval, 'Bruce Willis', 'Estados Unidos');

INSERT INTO actor
(id_actor, nombre, nacionalidad)
VALUES
(seq_id_actor.nextval, 'Christian Bale', 'Inglaterra');

INSERT INTO actor
(id_actor, nombre, nacionalidad)
VALUES
(seq_id_actor.nextval, 'Daisy Ridley', 'Inglaterra');

INSERT INTO actor
(id_actor, nombre, nacionalidad)
VALUES
(seq_id_actor.nextval, 'Scarlett Johansson', 'Estados Unidos');

INSERT INTO actor
(id_actor, nombre, nacionalidad)
VALUES
(seq_id_actor.nextval, 'Adam Driver', 'Estados Unidos');

select * from actor

/*-----------------------------------*/
/* CREANDO PELICULAS */


INSERT INTO pelicula
(id_pelicula, titulo_distribucion, titulo_original, genero, idioma_original, subtitulos, año_produccion, duracion_horas, duracion_minutos, calificacion)
VALUES
('001', 'A todo gas', 'Fast and Furious', 'Accion', 'Ingles', 'Si', 2009, 2, 30, '+9 años');

INSERT INTO pelicula
(id_pelicula, titulo_distribucion, titulo_original, genero, idioma_original, subtitulos, año_produccion, duracion_horas, duracion_minutos, calificacion)
VALUES
('002', 'Sector 9', 'District 9', 'Aliens', 'Ingles', 'No', 2009, 1, 80, '+18 años'); 

select * from pelicula

/*-----------------------------------*/
/* Asignando paises a peliculas */

INSERT INTO pelicula_pais
(id_pais, id_pelicula)
VALUES
('1', '002');

INSERT INTO pelicula_pais
(id_pais, id_pelicula)
VALUES
('4', '001');

INSERT INTO pelicula_pais
(id_pais, id_pelicula)
VALUES
('2', '001');

select * from pelicula_pais

/*-----------------------------------*/
/* Asignando directores a las peliculas creadas */

INSERT INTO pelicula_direccion
(id_pelicula, id_director)
VALUES
('001', '3');

INSERT INTO pelicula_direccion
(id_pelicula, id_director)
VALUES
('002', '1');

INSERT INTO pelicula_direccion
(id_pelicula, id_director)
VALUES
('002', '2');

select * from director
select * from pelicula_direccion

/*-----------------------------------*/
/* Asignando actores a las peliculas creadas */

INSERT INTO pelicula_reparto
(id_pelicula, id_actor)
VALUES
('001', '1');

INSERT INTO pelicula_reparto
(id_pelicula, id_actor)
VALUES
('001', '2');

INSERT INTO pelicula_reparto
(id_pelicula, id_actor)
VALUES
('001', '3');

INSERT INTO pelicula_reparto
(id_pelicula, id_actor)
VALUES
('002', '4');

INSERT INTO pelicula_reparto
(id_pelicula, id_actor)
VALUES
('002', '1');

select * from actor
select * from pelicula_reparto 

/*-----------------------------------*/
/* Creando la "opinion" de una persona */

INSERT INTO opinion
(id_opinion, nombre_persona, edad_persona, fecha_registro, calificacion_pelicula, comentario)
VALUES
('op1', 'Mateo', '24', TO_DATE('06/06/2020 18:20' ,'DD/MM/YYYY HH24:SS'), 'Obra maestra', 'Estaba melita');

select * from opinion

/*-----------------------------------*/
/* Asignando una "opinion" de una persona a una pelicula*/

INSERT INTO rating
(id_pelicula, id_opinion)
VALUES
('002','op1')

/* Query para saber las opiniones que tiene una pelicula */
SELECT pelicula.titulo_original, opinion.comentario
FROM pelicula
JOIN rating ON pelicula.id_pelicula = rating.id_pelicula
JOIN opinion ON rating.id_opinion = opinion.id_opinion;


/*-----------------------------------*/
/* Creando un cine*/
INSERT INTO cine
(id_cine, nombre, direccion, contacto)
VALUES
('cine1','CINECOLOMBIA VIVA', '', '');

/* Creando salas */ 
INSERT INTO sala
(id_sala, numero_sala, numero_sillas)
VALUES
('001','1',112);

INSERT INTO sala
(id_sala, numero_sala, numero_sillas)
VALUES
('002','5',80)

/* Asignando salas, cine y pelicula a una funcion */
INSERT INTO funcion
(id_funcion, id_cine, id_sala, id_pelicula, nombre, fecha_funcion, hora_funcion)
VALUES
('funcion1','cine1','001','002','Tarde-noche',TO_DATE('10-06-2020','DD-MM-YYYY'), TO_DATE('10:55','HH24:SS'))

INSERT INTO funcion
(id_funcion, id_cine, id_sala, id_pelicula, nombre, fecha_funcion, hora_funcion)
VALUES
('funcion2','cine1','002','001','mañana',TO_DATE('10-06-2020','DD-MM-YYYY'), TO_DATE('20:30','HH24:SS'))


/*Consulta para conocer funciones, numero de sala y fecha de funcion de las peliculas disponibles*/
SELECT pelicula.titulo_original, sala.numero_sala, funcion.fecha_funcion
FROM pelicula
JOIN funcion ON pelicula.id_pelicula = funcion.id_pelicula
JOIN sala ON funcion.id_sala = sala.id_sala;


/* DESARROLLO DEL CRUD: Se realizo sobre la tabla "FUNCION"*/
/* Procedimiento "Create" */

DECLARE
id_f funcion.id_funcion%TYPE;
id_c funcion.id_cine%TYPE;
id_s funcion.id_sala%TYPE;
id_p funcion.id_pelicula%TYPE;
nom funcion.nombre%TYPE;
f_f funcion.fecha_funcion%TYPE;
h_f funcion.hora_funcion%TYPE;
BEGIN
id_f := 'funcion3';
id_c := 'cine1';
id_s := '001';
id_p := '002';
nom := 'Por la noche pai';
f_f := SYSDATE;
h_f := SYSDATE;

INSERT INTO funcion VALUES(id_f, id_c,id_s, id_p, nom, f_f, h_f);

dbms_output.put_line('Funcion ingresada exitosamente ('||id_f||')');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN dbms_output.put_line('La funcion '||id_f||' ya se encuentra registrada');
END;


/* Procedimiento "Read"*/

select * from funcion
SELECT pelicula.titulo_original, sala.numero_sala, funcion.fecha_funcion, sala.id_sala, funcion.id_funcion, pelicula.id_pelicula
FROM pelicula
JOIN funcion ON pelicula.id_pelicula = funcion.id_pelicula
JOIN sala ON funcion.id_sala = sala.id_sala;


DECLARE

    p_nom pelicula.titulo_original%TYPE;
    s_ns sala.numero_sala%TYPE;
    f_ff funcion.fecha_funcion%TYPE;
    f_id funcion.id_pelicula%TYPE := '001';
    s_id sala.id_sala%TYPE := '002';
    
BEGIN

    SELECT pelicula.titulo_original, sala.numero_sala, funcion.fecha_funcion 
    INTO p_nom, s_ns, f_ff 
    FROM pelicula 
    JOIN funcion ON pelicula.id_pelicula = f_id
    JOIN sala ON funcion.id_sala = s_id;
    
    dbms_output.put_line('La pelicula '||p_nom||' se da el '||f_ff||' en la sala '||s_ns);
    EXCEPTION 
        WHEN TOO_MANY_ROWS THEN dbms_output.put_line('Varias opciones coinciden con su busqueda');
        WHEN NO_DATA_FOUND THEN dbms_output.put_line('No hay coincidencias con su busqueda');
END;

select * from funcion where id_funcion = 'funcion4'


/* Procedimiento "Update" */
DECLARE
    f_id funcion.id_funcion%type := 'funcion4';
    f_var_fecha funcion.fecha_funcion%type := TO_DATE('07-06-2020','DD-MM-YYYY');
    
BEGIN

    UPDATE funcion
    SET fecha_funcion = f_var_fecha
    WHERE id_funcion = f_id;
    
    /* Como se esta haciendo un UPDATE y con este no se puede usar un SELECT INTO, que es la entrada que solicita
       la exception NO_FOUND_DATA, entonces se usa el SQL%ROWCOUNT para avisar que el registro con la ID que se piensa editar 
       no esta registrado*/
    IF SQL%ROWCOUNT = 0 THEN
        dbms_output.put_line('El dato con la ID ingresada no existe, no se elimino ningun dato');
    ELSE
        dbms_output.put_line('Dato actualizado correctamente');
    END IF;
    /* A pesar de que no se esta modificando (puntualmente en este caso) la clave primaria de funcion, segun la documentacion leida,
       es mejor incluir esta excepcion*/
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN dbms_output.put_line('No puede modificar la ID de la funcion');
END;

/* Procedimiento "Delete" */
DECLARE
    f_id funcion.id_funcion%TYPE := 'funcion3';
BEGIN
    DELETE FROM funcion WHERE id_funcion = f_id;
    
     /* Como se esta haciendo un DELETE y con este no se puede usar un SELECT INTO, que es la entrada que solicita
       la exception NO_FOUND_DATA, entonces se usa el SQL%ROWCOUNT para avisar que el registro con la ID que se piensa editar 
       no esta registrado*/
    IF SQL%ROWCOUNT = 0 THEN
        dbms_output.put_line('El dato con la ID ingresada no existe, no se elimino ningun dato');
    ELSE
        dbms_output.put_line('Dato eliminado correctamente');
    END IF;
END;