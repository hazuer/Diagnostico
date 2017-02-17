
%Hipotesis de las posibles enfermedades
enfermedades(tuberculosis):- tuberculosis,!. %enfermedad con su echo, hace un corte si detecta que es tuberculosis,
enfermedades(dengue):- dengue,!.
enfermedades(influeza):- influenza,!.
enfermedades(chikungunya):- chikungunya,!.
enfermedades(diabetes_mellitus):- diabetes_mellitus,!.
enfermedades('No hay enfermedad asociada a sintomas').

% Reglas de seleccion, pregunta de inicio que diferencia a cada una de
% las enfermedades
presenta_tuberculosis:- pregunta('¿Presenta tos persistente?'),!.
presenta_dengue:- pregunta('¿Presenta dolor de ojos retroocular?'),!.
padece_influenza:- pregunta('¿Presenta rinorrea?'),!.
padece_chikungunya:- pregunta('¿Presenta fiebre mayor a 39° C?'),!.
padece_diabetes_mellitus:- pregunta('¿Presenta mucha sed?'),!.

% Reglas de cada enfermedad
tuberculosis :- presenta_tuberculosis,
	pregunta('¿Presenta hemoptisis?'),
	pregunta('¿Presenta fiebre vespertina?'),
	pregunta('¿Presenta fiebre nocturna?'),
	pregunta('¿Presenta astenia?'),
	pregunta('¿Presenta adinamia?').


dengue :- presenta_dengue,
	pregunta('¿Presenta Cefalea intensa (generalmente frontal)?'),
	pregunta('¿Presenta mialgias?'),
	pregunta('¿Presenta artralgias?'),
	pregunta('¿Presenta exantema transitorio?'),
	pregunta('¿Presenta fotofobia?'),
	pregunta('¿Presenta insomnio?'),
	pregunta('¿Presenta prurito?'),
	pregunta('¿Presenta diarrea?'),
	pregunta('¿Presenta náusea?'),
	pregunta('¿Presenta vómito?'),
	pregunta('¿Presenta dolor abdominal?'),
	pregunta('¿Presenta anorexia?'),
	pregunta('¿Presenta hiperestesia?'),
	pregunta('¿Presenta dolores generalizados?'),
	pregunta('¿Presenta congestión faríngea?'),
	pregunta('¿Presenta conjuntivitis?').


influenza :- padece_influenza,
	pregunta('¿Presenta coriza?'),
	pregunta('¿Presenta artralgias?'),
	pregunta('¿Presenta mialgias?'),
	pregunta('¿Presenta postración?'),
	pregunta('¿Presenta odinofagia?'),
	pregunta('¿Presenta dolor abdominal?'),
	pregunta('¿Presenta congestión nasal?'),
	pregunta('¿Presenta diarrea?').


chikungunya :- padece_chikungunya,
	pregunta('¿Presenta dolor en articulaciones?'),
	pregunta('¿Presenta dolor intenso asociado a hinchazón?'),
	pregunta('¿Presenta dolor de cabeza?'),
	pregunta('¿Presenta dolor de espalda?'),
	pregunta('¿Presenta dolores musculares?'),
	pregunta('¿Presenta nauseas?'),
	pregunta('¿Presenta manchas rojas en la piel(erupciones)?'),
	pregunta('¿Presenta conjuntivitis(enrojecimiento de los ojos)?').

diabetes_mellitus :- padece_diabetes_mellitus,
	pregunta('¿Presenta mucha hambre?'),
	pregunta('¿Presenta aumento veces orinar?'),
	pregunta('¿Presenta debilidad?'),
	pregunta('¿Presenta fatiga?'),
	pregunta('¿Presenta pérdida de peso?').


desconocido :- enfermedad_desconocida.

% Creacion de botones para dialogo de preguntas
:-dynamic si/1,no/1. %Varible donde depositara las veces presionado Si o No

%Creacion del formulario  donde incluye botones Si y No
preguntar(Problema):- new(Dg,dialog('Diagnostico Medico')),%Nombre de la ventana
new(Label1,label(texto,'Responde la siguiente pregunta medica')),
new(Label2,label(prob,Problema)),

	new(Boton1,button(si,and(message(Dg,return,si)))),
	new(Boton2,button(no,and(message(Dg,return,no)))),

send(Dg,append(Label1)), % Insertamos los objetos labels y botones, en el objet Dg.
	send(Dg,append(Label2)),
	send(Dg,append(Boton1)),
	send(Dg,append(Boton2)),
	send(Label1, font, font(times, bold, 15)),

send(Dg,default_button,si),
send(Dg,open_centered),get(Dg,confirm,Answer),
write(Answer),send(Dg,destroy),

((Answer==si)->assert(si(Problema));
assert(no(Problema)),fail).
pregunta(S):- (si(S)->true; (no(S)->fail; preguntar(S))).
limpiar:- retract(si(_)),fail.
limpiar:- retract(no(_)),fail.
limpiar.

%para limpiarlos de la memoria
botones :- lim,
send(@boton,free),
send(@ventana,free),
enfermedades(Enfer),
send(@texto, selection('De acuerdo a los síntomas que usted presenta. Padece de:')),


send(@diag,selection(Enfer)),
new(@boton, button('Inicia valuacion',message(@prolog, botones))),
send(Sistema, display,@boton,point(40,50)),
send(Sistema, display,@ventana,point(20,50)),
limpiar.
lim:- send(@diag, selection(' ')).







