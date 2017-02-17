%%declaraciones de enfermedades

enfermedad(gripe).

enfermedad(rubeola).

enfermedad(malaria).

enfermedad(hepatitis).

enfermedad(tuberculosis).

enfermedad(anemia).

%enfermode(manuel,gripe).

%tienesintoma(alicia,cansancio).

%declaraciones de s�ntomas, seg�n enfermedad

%podemos hacer consultas por ejemplo

%mostrar una enfermedad y sus s�ntomas o las enfermedades y s�ntomas

%determinar un s�ntoma a que enfermedad(es) pertecene

sintomade(tos, gripe). %la tos es s�ntoma de gripe

sintomade(cansancio, gripe). %el cansancio es s�ntoma de gripe

sintomade(fiebre, gripe). %la fiebre es s�ntoma de gripe

sintomade(dolorcabeza, gripe). %dolor de cabeza es s�ntoma de gripe

sintomade(nauseas, hepatitis). %las nauseas son s�ntoma de hepatitis

sintomade(diarrea, hepatitis). %la diarrea es s�ntoma de hepatitis

sintomade(ictericia, hepatitis). %la ictericia es s�ntoma de hepatitis

sintomade(cansancio, anemia). %cansancio es s�ntoma de anemia

sintomade(apatia, anemia). %apat�a es s�ntoma de anemia

sintomade(nausea, anemia). %las nauseas son s�ntomas de anemia

sintomade(tos, tuberculosis). %la tos es s�ntoma de la tuberculosis

sintomade(cansancio, tuberculosis). %el cansancio es s�ntoma de tuberculosis

sintomade(fiebre, tuberculosis). %la fiebre es s�ntoma de la tuberculosis

sintomade(escalofrios, tuberculosis). %los escalofr�os es s�ntoma de tuberculosis

sintomade(escalofrios, malaria). %los escalofr�os son s�ntomas de la malaria

sintomade(fiebre , malaria). %la fiebre es s�ntoma de malaria

sintomade(diarrea , malaria). %la diarrea es s�ntoma de malaria

sintomade(ictericia, malaria). %la ictericia es s�ntoma de malaria

sintomade(fiebre, rubeola). %la fiebre es s�ntoma de rub�ola

sintomade(jaqueca, rubeola). %la jaqueca es s�ntoma de rub�ola

sintomade(secrecion, rubeola). %la secreci�n es s�ntoma de rubeola

% Reglas para determinar que probabilidad una persona puede tener una

% enfermedad X dado n s�ntomas

% %La funci�n buscar busca las enfermedades que contengan como m�nimo los s�ntomas %suministrados

% % primer par�metro (lista de enfermedades)

% % segundo par�metro (Enfermedad)

% %tercer par�metro cantidad de ocurrencias

% %(a decir verdad tendr�a que ser la misma cantidad que el arreglo entregado)

buscar([], _F , 0).

buscar(X , F , 1) :- sintomade(X, F).

buscar([X|Xs] , F , P) :- enfermedad(F) , buscar(X , F , S1) , buscar(Xs , F ,S2) , P is S1 + S2.

%%funci�n que devuelve la cantidad de s�ntomas totales de la enfermedad seleccionada

cantSint(F , C) :- findall(X , sintoma(X, F) , L) , length(L , R), C is R.

%%Esta funci�n es parecida a la de buscar con la excepci�n que en el ultimo argumento te entrega

%% el (porcentaje de probabilidad de la enfermedad)

diagnostico([X|Xs] , F , K) :- buscar([X|Xs] , F , P) , cantSint(F , T) , K is P * 100 / T.








