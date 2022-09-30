:-use_module(library(pce)).
:-use_module(library(pce_style_item)).

inicio:-
	new(Menu, dialog('Practica 3.9 Sistema experto completo', size(1000,800))),
	new(L,label(nombre,'SISTEMA DE DIAGNOSTICO MEDICO')),
	new(A,label(nombre,'')),
	new(@texto,label(nombre,'Responda un breve cuestionario para su diagnostico')),
	new(@respl,label(nombre,'')),
	new(Salir,button('Salir',and(message(Menu, destroy),message(Menu,free)))),
	new(@boton,button('Realizar Cuestionario',message(@prolog,botones))),

	send(Menu,append(L)),new(@btncarrera,button('Diagnostico')),
	send(Menu,display,L,point(125,20)),
	send(Menu,display,A,point(80,360)),
	send(Menu,display,@boton,point(100,150)),
	send(Menu,display,@texto,point(20,100)),
	send(Menu,display,Salir,point(20,400)),
	send(Menu,display,@respl,point(20,130)),
	send(Menu,open_centered).

fallas('USTED PADECE SARAMPION:
	TRATAMIENTO:
 Tomalo con calma. Descansa y evita las actividades ajetreadas.
Bebe algo a sorbos. Bebe mucha agua, jugo de frutas 
y te de hierbas para reemplazar los liquidos perdidos
 a causa de la fiebre y la sudoracion.
Busca alivio respiratorio. Usa un humidificador para 
aliviar la tos y el dolor de garganta.
Descansa la vista. Si a ti o a tu hijo les molesta la 
luz brillante, como les sucede a muchas personas con 
sarampion, manten las luces bajas o usa lentes de sol. 
Ademas, evita leer o mirar television si la luz de una 
lampara de lectura o de la television te resulta molesta.
'):-sarampion,!.

fallas('USTED PADECE INFLUENZA:
       TRATAMIENTO:
La gripe se trata principalmente con descanso y líquidos
 para que el cuerpo pueda combatir la infección por sí 
 solo. Los analgésicos antiinflamatorios de venta libre 
 pueden ayudar con los síntomas. Una vacuna anual puede 
 prevenir la gripe y limitar sus complicaciones.
'):-influenza,!.

fallas('USTED PADECE MALARIA:
TRATAMIENTO:
Las personas que viajan a regiones donde la malaria es 
común suelen utilizar fármacos preventivos antes, durante
 y después del viaje. El tratamiento incluye el uso de antipalúdicos.
'):-malaria,!.

fallas('USTED PADECE GRIPE:
TRATAMIENTO:
La gripe se trata principalmente con descanso y líquidos 
para que el cuerpo pueda combatir la infección por sí 
solo. Los analgésicos antiinflamatorios de venta libre 
pueden ayudar con los síntomas. Una vacuna anual puede
 prevenir la gripe y limitar sus complicaciones.
'):-gripe,!.

fallas('USTED PADECE TIFOIDEA:
TRATAMIENTO:
El tratamiento incluye el uso de antibióticos y la 
ingesta de líquidos.
'):-tifoidea,!.

fallas('sin resultados, usted no dio la informacion 
necesaria o suficiente
ERROR p560c4!').

% preguntas para dirigir a la enfermedad adecuada con su respectivo
% identificador de enfermedad

sarampion:- ssarampion,
	pregunta('El paciente esta cubierto de puntos?'),
	pregunta('El paciente tiene temperatura alta'),
	pregunta('El paciente tiene ojos rojos?');
	pregunta('El paciente tiene tos seca?').

influenza:- sinfluenza,
    pregunta('El paciente tiene dolor en las articulaciones?'),
	pregunta('El paciente tiene mucho estornudo?');
	pregunta('El paciente tiene dolor de cabeza?').

malaria:- smalaria,
	pregunta('El paciente tiene temperatura alta?'),
    pregunta('El paciente tiene dolor en las articulaciones?'),
	pregunta('El paciente tiembla violentamente?');
	pregunta('El paciente tiene escalofrios?').

gripe:- sgripe,
	pregunta('El paciente tiene cuerpo cortado?'),
	pregunta('El paciente tiene dolor de cabeza?');
	pregunta('El paciente tiene temparatura alta?').

tifoidea:- stifoidea,
	pregunta('El paciente tiene falta de apetito?'),
	pregunta('El paciente tiene temperatura alta?'),
	pregunta('El paciente tiene dolor abdominal?'),
	pregunta('El paciente tiene dolor de cabeza?');
	pregunta('El paciente tiene diarrea? ').

%identificador de falla que dirige a las preguntas correspondientes

ssarampion:-pregunta('El paciente esta cubierto de puntos?'),!.
sinfluenza:-pregunta('El paciente tiene dolor en las articulaciones?'),!.
smalaria:-pregunta('El paciente tiene temperatura alta?'),!.
sgripe:-pregunta('El paciente tiene cuerpo cortado?'),!.
stifoidea:-pregunta('El paciente tiene falta de apetito?'),!.

:-dynamic si/1,no/1.
preguntar(Problema):- new(Di,dialog('Diagnostico medico')),
     new(L2,label(texto,'Responde las siguientes preguntas')),
     new(La,label(prob,Problema)),
     new(B1,button(si,and(message(Di,return,si)))),
     new(B2,button(no,and(message(Di,return,no)))),

         send(Di,append(L2)),
	 send(Di,append(La)),
	 send(Di,append(B1)),
	 send(Di,append(B2)),

	 send(Di,default_button,si),
	 send(Di,open_centered),get(Di,confirm,Answer),
	 write(Answer),send(Di,destroy),
	 ((Answer==si)->assert(si(Problema));
	 assert(no(Problema)),fail).

pregunta(S):-(si(S)->true; (no(S)->fail; preguntar(S))).
limpiar :- retract(si(_)),fail.
limpiar :- retract(no(_)),fail.
limpiar.

botones :- lim,
	send(@boton,free),
	send(@btncarrera,free),
	fallas(Falla),
	send(@texto,selection(' ')),
	send(@respl,selection(Falla)),
	new(@boton,button('Inicia Procedimiento Medico',message(@prolog,botones))),
        send(Menu,display,@boton,point(40,50)),
        send(Menu,display,@btncarrera,point(20,50)),
limpiar.
lim :- send(@respl, selection('')).
