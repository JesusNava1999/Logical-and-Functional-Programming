/* Sistema Experto: experto.pl
Trata los sintomas como una lista. La cabeza es el diagnostico y la “cola” son los sintomas.
Utiliza assert/1 para cambiar dinamicamente la base de conocimientos. Determina la verdad y falsedad de los sintomas conocidos.
Puede contestar a las preguntas 'porque' e incluye capacidad de explicacion. Elimina dinamicamente las aseveraciones agregadas despues de cada consulta.
*/
:- dynamic conocido/1. consulta:-
haz_diagnostico(x), escribe_diagnostico(x), ofrece_explicacion_diagnostico(x), clean_scratchpad.
consulta:-
write('No hay suficiente conocimiento para elaborar un diagnostico.'), clean_scratchpad.
haz_diagnostico(diagnostico):- obten_hipotesis_y_sintomas(diagnostico, ListaDeSintomas), prueba_presencia_de(diagnostico, ListaDeSintomas).
obten_hipotesis_y_sintomas(diagnostico, ListaDeSintomas):- conocimiento(diagnostico, ListaDeSintomas).
prueba_presencia_de(diagnostico, []).
prueba_presencia_de(diagnostico, [Head | Tail]):- prueba_verdad_de(diagnostico, Head),
prueba_presencia_de(diagnostico, Tail).
prueba_verdad_de(diagnostico, Sintoma):- conocido(Sintoma). 
prueba_verdad_de(diagnostico, Sintoma):- not(conocido(is_false(Sintoma))),
pregunta_sobre(diagnostico, Sintoma, Reply), Reply = si. 
pregunta_sobre(diagnostico, Sintoma, Reply):- write('Es verdad que '),
write(Sintoma), write('? '),
read(Respuesta), process(diagnostico, Sintoma, Respuesta, Reply).
process(diagnostico, Sintoma, si, si):- asserta(conocido(Sintoma)). 
process(diagnostico, Sintoma, no, no):- asserta(conocido(is_false(Sintoma))). 
process(diagnostico, Sintoma, porque, Reply):- nl,
write('Estoy investigando la hipotesis siguiente: '),
write(diagnostico), write('.'), nl, write('Para esto necesito saber si '), write(Sintoma), write('.'), nl, pregunta_sobre(diagnostico, Sintoma, Reply).
process(diagnostico, Sintoma, Respuesta, Reply):- Respuesta \== no, Respuesta \== si, Respuesta \== porque, nl,
write('Debes contestar si, no o porque.'), nl, pregunta_sobre(diagnostico, Sintoma, Reply).
escribe_diagnostico(diagnostico):- write('El diagnostico es '), write(diagnostico), write('.'), nl.
ofrece_explicacion_diagnostico(diagnostico):- pregunta_si_necesita_explicacion(Respuesta), actua_consecuentemente(diagnostico, Respuesta).
pregunta_si_necesita_explicacion(Respuesta):-
write('Quieres que justifique este diagnostico? '), read(RespuestaUsuario), asegura_respuesta_si_o_no(RespuestaUsuario, Respuesta).
asegura_respuesta_si_o_no(si, si).
asegura_respuesta_si_o_no(no, no).
asegura_respuesta_si_o_no(_, Respuesta):- write('Debes contestar si o no.'),
pregunta_si_necesita_explicacion(Respuesta).
actua_consecuentemente(diagnostico, no).
actua_consecuentemente(diagnostico, si):- conocimiento(diagnostico, ListaDeSintomas),
        write('Se determino este diagnostico porque se encontraron los siguentes
sintomas: '), nl,
escribe_lista_de_sintomas(ListaDeSintomas).
escribe_lista_de_sintomas([]). escribe_lista_de_sintomas([Head | Tail]):-
write(Head), nl, escribe_lista_de_sintomas(Tail).
clean_scratchpad:- retract(conocido(x)), fail. clean_scratchpad.
conocido(_):- fail.
not(x):- x,!,fail.
not(_).