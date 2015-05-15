inverti_direzione(Agente):-
	%id(Agente,IdAgente),
	direzione(Agente, Dir),
	dir_opposta(Dir,Opp),
	retractall(direzione(Agente, Dir)),%sostituito retractall a retract
	assert(direzione(Agente,Opp)),
	retractall(numero_passi_effettuati(Agente,_)),%sostituito retractall a retract
	assert(numero_passi_effettuati(Agente,1)).

reset_dir_agenti([]):-!.
reset_dir_agenti([Agente|Restanti]):-
	direzione(Agente, Dir),
	dir_opposta(Dir,Opp),
	retractall(direzione(Agente, Dir)),%sostituito retractall a retract
	assert(direzione(Agente,Opp)),
	retractall(numero_passi_effettuati(Agente,_)),%sostituito retractall a retract
	numero_passi_in_direz(Agente,StepsDone),
	assert(numero_passi_effettuati(Agente,StepsDone)),
	reset_dir_agenti(Restanti).
	
prendi_coord_attuali(Agente,X,Y):-
	coordX_attuale(Agente,X),
	coordY_attuale(Agente,Y).
	
cambia_coord_attuali(Agente,NewX,NewY):-
	%id(Agente,IdAgente),
	retractall(coordX_attuale(Agente,_)),%sostituito retractall a retract
	assert(coordX_attuale(Agente,NewX)),
	retractall(coordY_attuale(Agente,_)),%sostituito retractall a retract
	assert(coordY_attuale(Agente,NewY)).
	
upd_done_steps(Agente):-
	numero_passi_effettuati(Agente,Done),
	numero_passi_x_step(Agente,OneMove),
	NewDone is Done + OneMove,
	retractall(numero_passi_effettuati(Agente,_)),%sostituito retractall a retract
	assert(numero_passi_effettuati(Agente,NewDone)).

editMovingCollision(Agente):-
	numero_passi_effettuati(Agente, AllowSteps),
	inverti_direzione(Agente),
	retractall(numero_passi_in_direz(Agente, _)),
	assert(numero_passi_in_direz(Agente,AllowSteps)).