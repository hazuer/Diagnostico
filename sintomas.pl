
% predicados principales
enfermedad(presenta,tuberculosis).
enfermedad(presenta, dengue).
enfermedad(presenta,influenza).
enfermedad(presenta, chikungunya).
enfermedad(presenta, diabetes_mellitus).

% Hechos de sintomas que presentan cada enfermedad. predcado-objeto
sintomade(tos_persistente ,tuberculosis).
sintomade(hemoptisis, tuberculosis).
sintomade(fiebre_vespertina , tuberculosis).
sintomade(fiebre_nocturna , tuberculosis).
sintomade(sudoracion_nocturna, tuberculosis).
sintomade(astania, tuberculosis).
sintomade(adinamia, tuberculosis).

sintomade(cefalea_intensa  , dengue).
sintomade(mialgias, dengue).
sintomade(artralgias , dengue).
sintomade(dolor_de_ojos	, dengue).
sintomade(exantema_transitorio , dengue).
sintomade(fotofobia , dengue).
sintomade(insomnio , dengue).
sintomade(prurito , dengue).
sintomade(diarrea , dengue).
sintomade(nauseas , dengue).
sintomade(vomito , dengue).
sintomade(dolor_abdominal , dengue).
sintomade(anorexia , dengue).
sintomade(hiperestesia , dengue).
sintomade(dolores_generalizados , dengue).
sintomade(congestion_faringea , dengue).
sintomade(congestion_conjuntivitis , dengue).


sintomade(rinorrea , influenza).
sintomade(coriza , influenza).
sintomade(artralgias , influenza).
sintomade(mialgias , influenza).
sintomade(postracion , influenza).
sintomade(odinofagia , influenza).
sintomade(dolor_abdominal , influenza).
sintomade(congestion_nasal  , influenza).
sintomade(diarrea , influenza).


sintomade(fiebre_mayor_a_39_C, chikungunya).
sintomade(dolor_articulacione , chikungunya).
sintomade(dolor_cabeza , chikungunya).
sintomade(dolor_espalda , chikungunya).
sintomade(dolor_musculos , chikungunya).
sintomade(nauseas , chikungunya).
sintomade(manchas_rojas_piel , chikungunya).
sintomade(conjuntivitis , chikungunya).


sintomade(mucha_sed , diabetes_mellitus).
sintomade(mucha_ambre , diabetes_mellitus).
sintomade(aumento_veces_orinar , diabetes_mellitus).
sintomade(debilidad , diabetes_mellitus).
sintomade(fatiga , diabetes_mellitus).
sintomade(perdida_de_peso , diabetes_mellitus).


sintomade(estornudo , gripe).
sintomade(calentura , gripe).
sintomade(dolor_de_cabeza, gripe).
sintomade(nauseas , gripe).

reseta('XL3', gripe).


% Reglas para indentificar la enfermedad que presena en base al sintoma
% indicado
% diag de X  si X = sintoma, es sintoma relacionado de  Z = Enfermedad
% sentencia write va escribir en Z hasta que sea falzo
diag(X):-sintomade(X,Z),write(Z),nl,true.

%Regla que pregunta pos todos los sintomas de la enfermedad
diags(Y):-sintomade(Z,Y),write(Z),nl,true.

% Regla que permite dar una solucion al problema
reseta(P):-reseta(F,P),write(F),nl.
















