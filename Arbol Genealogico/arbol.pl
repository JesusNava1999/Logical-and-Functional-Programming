es_hombre(jose_guadalupe).
es_hombre(rogelio).
es_hombre(jose_luis).
es_hombre(gilberto).
es_hombre(rigoberto).
es_hombre(jesus).
es_hombre(sergio).
es_hombre(alejandro).
es_hombre(raymundo).
es_hombre(rogelio_jr).
es_hombre(daniel).
es_hombre(juan_pablo).
es_hombre(gilberto_jr).
es_hombre(armando).
es_hombre(oswaldo).

es_mujer(maria_jovita).
es_mujer(beatriz).
es_mujer(auxilio).
es_mujer(maria_antonia).
es_mujer(maria_de_la_luz).
es_mujer(liliana).
es_mujer(naomi).
es_mujer(eloisa).
es_mujer(gabriela).
es_mujer(angelica).
es_mujer(heidy).
es_mujer(brenda).

es_pareja_de(jose_guadalupe, maria_jovita).
es_pareja_de(rogelio, beatriz).
es_pareja_de(jose_luis, auxilio).
es_pareja_de(gilberto, maria_antonia).
es_pareja_de(rigoberto, maria_de_la_luz).
es_pareja_de(raymundo, liliana).
es_pareja_de(armando, angelica).

es_pareja_de(maria_jovita, jose_guadalupe).
es_pareja_de(beatriz, rogelio).
es_pareja_de(auxilio, jose_luis).
es_pareja_de(maria_antonia, gilberto).
es_pareja_de(maria_de_la_luz, rigoberto).
es_pareja_de(liliana, raymundo).
es_pareja_de(angelica, armando).

es_progenitor_de(jose_guadalupe, rogelio).
es_progenitor_de(jose_guadalupe, auxilio).
es_progenitor_de(jose_guadalupe, gilberto).
es_progenitor_de(jose_guadalupe, maria_de_la_luz).

es_progenitor_de(rogelio, raymundo).
es_progenitor_de(rogelio, alejandro).
es_progenitor_de(rogelio, sergio).
es_progenitor_de(rogelio, jesus).

es_progenitor_de(raymundo, rogelio_jr).
es_progenitor_de(raymundo, daniel).
es_progenitor_de(raymundo, naomi).

es_progenitor_de(jose_luis, eloisa).
es_progenitor_de(jose_luis, gabriela).
es_progenitor_de(jose_luis, juan_pablo).

es_progenitor_de(gilberto, gilberto_jr).
es_progenitor_de(gilberto, angelica).

es_progenitor_de(armando, heidy).

es_progenitor_de(rigoberto, oswaldo).
es_progenitor_de(rigoberto, brenda).

es_progenitor_de(maria_jovita, rogelio).
es_progenitor_de(maria_jovita, auxilio).
es_progenitor_de(maria_jovita, gilberto).
es_progenitor_de(maria_jovita, maria_de_la_luz).

es_progenitor_de(beatriz, raymundo).
es_progenitor_de(beatriz, alejandro).
es_progenitor_de(beatriz, sergio).
es_progenitor_de(beatriz, jesus).

es_progenitor_de(liliana, rogelio_jr).
es_progenitor_de(liliana, daniel).
es_progenitor_de(liliana, naomi).

es_progenitor_de(auxilio, eloisa).
es_progenitor_de(auxilio, gabriela).
es_progenitor_de(auxilio, juan_pablo).

es_progenitor_de(maria_antonia, gilberto_jr).
es_progenitor_de(maria_antonia, angelica).

es_progenitor_de(angelica, heidy).

es_progenitor_de(maria_de_la_luz, oswaldo).
es_progenitor_de(maria_de_la_luz, brenda).

es_hijo_de(X,Y):- es_progenitor_de(Y,X).
es_hermano_de(X,Y):- es_progenitor_de(Z,X), es_progenitor_de(Z,Y), not(Y==X).
es_abuelo_de(X,Y):- es_progenitor_de(Z,Y), es_progenitor_de(X,Z).
es_primo_de(X,Y):- es_progenitor_de(Z,X), es_progenitor_de(W,Y), es_hermano_de(Z,W).
es_cuniado_de(X,Y):- ((es_pareja_de(X,Z),es_hermano_de(Z,Y));(es_pareja_de(Y,Z),es_hermano_de(Z,X))).
es_tio_de(X,Y):- es_progenitor_de(Z,Y), (es_hermano_de(X,Z); es_cuniado_de(X,Z)).