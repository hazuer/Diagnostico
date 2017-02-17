:-use_module(library(pce)). % Declaracion de libreria para hace en modo grafico
:-use_module(library(pce_style_item)). % Libreria par crear botones, labels, etc.
:- use_module(library(error)).
:- pce_image_directory('./imagenes').

main:-
	%Creacion de los objecos conla funcion new
	new(Sistema, dialog('SISTEMA EXPERTO PARA DIAGNOSTICO COMUNES', size(400,400))),
	new(L,label(nombre,'DIAGNOSTICO DE ENFERMEDADES:')),
new(L2,label(nombre,'TUBERCULOSIS, DENGUE, INFLUENZA, CHIKUNGUNYA, DIABETES.')),
	new(@texto, label(nombre,'Presiona el siguiente botón para realizar el diagnostico.')),
	new(@diag, label(nombre,' ')),
	new(@boton,button('Comenzar Diagnostico',message(@prolog,botones))),
	new(Salir,button('SALIR',and(message(Sistema,destroy),message(Sistema,free)))),

	send(Sistema, display,L2,point(25,50)),
	send(Sistema, append(L)),new(@ventana,button('¿Diagnostico?')),
	send(Sistema, display,L,point(170,20)),
	send(Sistema, display,@boton,point(250,170)),
	send(Sistema, display,@texto,point(160,120)),
	send(Sistema, display,Salir,point(650,270)),
	send(Sistema, display,@diag,point(250,170)), % Resultado diagnostico

	send(@boton, font, font(times, bold, 15)),
	send(L, font, font(times, bold, 18)),
	send(@texto, font, font(times, bold, 15)),
	send(L2, font, font(times, bold, 18)),
	send(@diag, font, font(times, bold, 20)),
	send(Salir, font, font(times, bold, 15)),

	send(Sistema, open_centered).
resource(imagen, image, image('C:/imagenes/Metodologia.jpg')).

putWindowImage(Ventana,Imagen,Posicion,Figura):-
new(Figura,figure),
new(Bitmap,bitmap(resource(Imagen),@on)),
send(Bitmap,name,1),
send(Figura,display,Bitmap),
send(Figura,status,1),
send(Ventana,display,Figura,Posicion).

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






























