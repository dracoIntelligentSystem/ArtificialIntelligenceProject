insertStartAndTarget(Enviroment,Complete):-
	insertStart(Enviroment,Sim),!,
	insertTarget(Sim),!,
	insert_theOneAndTarget(Enviroment, Complete).
	
insertStart(Enviroment,Sim):-
	nl,write('Inserisci la COORDINATA X di NEO: '), read(X),
	write('Inserisci la COORDINATA Y di NEO: '), read(Y),
	controlInsideEnv(X,Y),
	controlPosition(neo,X,Y,Enviroment,Sim),
	write('Coordinate START POINT ACCETTATE'),
	cambia_coord_attuali(neo,X,Y),!;
	writeln('Coordinate START POINT NON CORRETTE. Vuoi inserirne di nuove?(y/n): '),read(Choice), 
	(
		Choice=y,!,insertStart(Enviroment,Sim);
		writeln('GIOCO TERMINATO'),false
	).
	
insertTarget(SimEnvNeo):-
	nl,nl,write('Inserisci la COORDINATA X del TARGET POINT: '), read(X),
	write('Inserisci la COORDINATA Y del TARGET POINT: '), read(Y),
	controlInsideEnv(X,Y),
	controlPosition(target,X,Y,SimEnvNeo,_),
	write('Coordinate del TARGET POINT ACCETTATE'),
	retractall(coord_goal(target,_,_)),assert(coord_goal(target,X,Y)),!;
	writeln('Coordinate del TARGET POINT NON CORRETTE. Vuoi inserirne di nuove?(y/n)'),read(Choice),
	(
		Choice=y,!,insertTarget(SimEnvNeo);
		riteln('GIOCO TERMINATO'),false
	).
	
insertFixObstacle(FinalStepMatrix,UpdFinalStepMatrix):-
	nl,nl,writeln('Vuoi inserirne un nuovo OSTACOLO FISSO?(y/n)'),read(Choice),
	Choice=y,
	nl,write('Inserisci la COORDINATA X del nuovo OSTACOLO FISSO: '), read(X),
	write('Inserisci la COORDINATA Y del nuovo OSTACOLO FISSO: '), read(Y),
	controlInsideEnv(X,Y),
	posizione_attuale(FinalStepMatrix, InfoPosizione,X, Y),
	InfoPosizione='0',
	findall(Ostacolo, è_un(Ostacolo,ostacolo_fisso), Ostacoli),
	max_member(Ostacoli,Max),
	assert(è_un(Max,ostacolo_fisso)),
	assert(id(Max,'W')),
	assert(coordX_attuale(Max,X)),
	assert(coordY_attuale(Max, Y)),
	change_value_matrix(FinalStepMatrix, X, Y, 'W', UpdFinalStepMatrix),
	writeln('E'' stato INSERITO un OSTACOLO FISSO NELL''AMBIENTE.'),!;
	writeln('Coordinate del nuovo OSTACOLO FISSO NON CORRETTE.'),
	writeln('NON VERRA'' INSERITO NULLA NELL''AMBIENTE, LASCIANDOLO INVARIATO.'),
	UpdFinalStepMatrix=FinalStepMatrix,!.