library(lists).
make_dim_matrix(M,N,Matrix) :- make_matrix(M,N,Matrix),assert(ambiente(matrix,Matrix,M,N)).%M RIGHE N COLONNE

make_matrix(_, N, []) :- N =< 0, !.
make_matrix(M, _, []) :- M =< 0, !.
make_matrix(M, N, [R|Rs]) :-
    make_list(M,R),
    N2 is N - 1,!,
    make_matrix(M, N2, Rs).

make_list(N, [ ]) :- N =< 0, !.
make_list(N, ['0' | Rest]) :-
    N > 0,
    N2 is N - 1,!,
    make_list(N2, Rest).
    
%estrai_dim(Matrice,M,N):-
%	length(Matrice,M),
%	nth1(1,Matrice,Riga),
%	length(Riga,N).
    
update_on_file(NameFile,Matrix):- 
	open(NameFile,append,Stream),
	write(Stream,Matrix), nl(Stream),
	close(Stream).
	
change_value_matrix(Matrix, I, J, NewValue,Upd):-
	nth1(I,Matrix,OldRow,RestRows),
	nth1(J,OldRow,_,RestRow),
	nth1(J,NewRow,NewValue,RestRow),
	nth1(I, Upd, NewRow, RestRows).

%Agente = id es. smith0 è A
posizione_attuale(Matrice,Agente,I,J):-posizione_attuale_fw(Matrice,Agente,1,I,J).
posizione_attuale_fw(Matrice,Agente,Row,I,J):-
	nth1(Row,Matrice,Riga),
	nth1(J,Riga,Agente),I is Row,!;
	NextRow is Row+1,
	posizione_attuale_fw(Matrice,Agente,NextRow,I,J).

nuova_posizione(I,J,Direction,Step,NewI,NewJ):-
	ambiente(matrix,_,M,N),
	%estrai_dim(Matrix,M,N),
	calculate_newCoord(I,J,Direction,Step,NewI,NewJ),
	between(1,M,NewI),between(1,N,NewJ).

insert_agents([],EnviromentComplete,EnviromentComplete):-!.
%insert_agents([],AgentEnv,EnviromentComplete):-insert_theOneAndTarget(AgentEnv,EnviromentComplete),!.
insert_agents([Agente|Restanti_Agenti],Matrix,NewUp):-
%	(%
%		è_un(Agente,agente);
%		è_un(Agente,ostacolo_fisso)
%	),
	%è_un(Agente,agente), RIPRISTINARE QUESTO PREDICATO AL TERMINE DEL TEST
	prendi_coord_attuali(Agente, X, Y), 
	id(Agente,Id),
	change_value_matrix(Matrix, X, Y, Id, Upd),!,
	insert_agents(Restanti_Agenti,Upd,NewUp).
	
insert_theOneAndTarget(Matrix,Filled):-
	è_un(Neo,eletto),!,
	prendi_coord_attuali(Neo, X, Y),
	id(Neo,Id),
	change_value_matrix(Matrix, X, Y, Id, WithNeo),
	id(target,IdTarget),
	coord_goal(target, X_goal, Y_goal),
	change_value_matrix(WithNeo, X_goal, Y_goal, IdTarget, Filled).
	
find_direction(Neo,Target,[CoorectX,CoorectY],FinalDirectionsList):-
	prendi_coord_attuali(Neo, X, Y),coord_goal(Target, X_goal, Y_goal),
	OH_quad is (Y-Y_goal)^2,
	TH_quad is (X-X_goal)^2,
	Angle_alpha is acos(sqrt((OH_quad)/(OH_quad+TH_quad))),
	convert(Degree,Angle_alpha),
	adjust_goniometric_angle(Degree,Goniometric_Angle,X,Y,X_goal,Y_goal),
	find_Sort_direction_List(Goniometric_Angle, Rank_ListDirection),
	numero_passi_x_step(Neo, AllowStep),
	adjustListDirection([X,Y],AllowStep,Rank_ListDirection,[CoorectX,CoorectY],FinalDirectionsList).

adjustListDirection([X_Actual, Y_Actual],AllowStep,[[Primary_Direction,Distance]|AlternativeDirections],[CorrectX2go,CorrectY2go],FinalDirectionsList):-
	nuova_posizione(X_Actual, Y_Actual, Primary_Direction, AllowStep, CorrectX2go, CorrectY2go),
	FinalDirectionsList=[[Primary_Direction,Distance]|AlternativeDirections];
	calculate_newCoord(X_Actual, Y_Actual, CoorectDirection, AllowStep, CorrectX2go, CorrectY2go),%use this function for evaluate a direction starting from Start and end point
	selectchk([CoorectDirection,RealDistance], AlternativeDirections, RestRealAlternative),
	FinalDirectionsList=[[CoorectDirection,RealDistance],[Primary_Direction,Distance]|RestRealAlternative].
	
adeguatePath([[Intentional_X,Intentional_Y]|RestNeoPath],NewPath):-
	prendi_coord_attuali(neo,Intentional_X,Intentional_Y), %compare from where i'd 2 go and where real i'm positioned
	NewPath=RestNeoPath;
	pathfind(normalPhase,neo, target, NewPath).

convert(Degree,Radiants):-
	Degree is ((Radiants * 180)/pi).
	
end_game(Neo,Target):- %CONDIZIONE DI FINE COMPUTAZIONE
	prendi_coord_attuali(Neo, X, Y),
	coord_goal(Target, X, Y).
	
raggiungi_traguardo(Final,Final):-end_game(neo,target),!.%
raggiungi_traguardo(NeoEnv,Final):-%
	find_direction(neo,target,RankListDirection),!,
	muovi_eletto(NeoEnv,Final,RankListDirection).%

muovi_eletto(NeoEnv,Final,[[Primary_Direction|_]|Ranked_Alternative_Direction]):-%
	
	%allowCells(X, Y, AdjacentCells),%write(AdjacentCells),
	
	assert(direzione(neo, Primary_Direction)),
%	findall(DirPrev, deny(X,Y,DirPrev), ListDenyDir4Cell),%
%	not(memberchk(Primary_Direction, ListDenyDir4Cell)),%
	simulazione_sposta_light(NeoEnv,neo,Scenario,neo),
	%posizione_attuale(Scenario, 'N', IVirt, JVirt),%
	%not(member([IVirt,JVirt],CelleVisitate)),%
	%writeln(CelleVisitate),%
	findall(Agente,è_un(Agente,agente),ListaAgenti),
%	bagof(Agente,è_un(Agente,agente),ListaAgenti),
	who_has2change_direction(ListaAgenti,[],AgentiDirCambiata),
	(	
		choiseBestMove(Scenario,ListaAgenti,_BestMove),b_getval(neo_intercept, f),
		reset_dir_agenti(AgentiDirCambiata);
		b_setval(neo_intercept, f),
		reset_dir_agenti(AgentiDirCambiata), 
		false
	),
%	(%CONTROLLO PER BACKTRACKING
%		
%		assert(deny(X,Y,Primary_Direction))
%	),
	sposta(NeoEnv, neo, Final),
	update_on_file('D:\\WORKSPACE\\ExpertSystemWBFS\\decisionDir.txt', Primary_Direction),
	update_on_file('D:\\WORKSPACE\\ExpertSystemWBFS\\moveDetails.txt', Final),
	retractall(direzione(neo,_)),!;%sostituito retract con retractall
	neoEmergencyPhase(Ranked_Alternative_Direction,FinalDirectionsList),
	muovi_eletto(NeoEnv,Final,FinalDirectionsList).%
	
neoEmergencyPhase(Ranked_Alternative_Direction,FinalDirectionsList):-
	retractall(direzione(neo,_)),%sostituito retract con retractall
	pathfind(emergencyPhase,neo, target, [[CoorectX,CoorectY]|_EmergencyPath]),
	prendi_coord_attuali(neo, X, Y),
	numero_passi_x_step(neo, AllowStep),
	adjustListDirection([X,Y],AllowStep,Ranked_Alternative_Direction,[CoorectX,CoorectY],FinalDirectionsList).

simulazione_sposta_light(Matrix,Agente,MatrixUpdate,AgentedaInserire):-
	prendi_coord_attuali(Agente, I, J),
	direzione(Agente,Direction),
	id(Agente, Id),
	numero_passi_x_step(Agente, Step),
	posizione_attuale(Matrix,Id,I,J),
	nuova_posizione(I,J,Direction,Step,NewI,NewJ),
	posizione_attuale(Matrix,InfoPosizione,NewI,NewJ),%write(Agente),
	controlDestinationCell(Agente,InfoPosizione,AgentedaInserire),
	%(
	%	InfoPosizione='0';
	%	InfoPosizione='N',b_setval(neo_intercept,t);
	%	Agente=neo,InfoPosizione='T'
	%),
	%AgentedaInserire=Agente,
	change_value_matrix(Matrix,I,J,'0',Upd),
	change_value_matrix(Upd,NewI,NewJ,Id,MatrixUpdate),!;
	AgentedaInserire=[],MatrixUpdate=Matrix.

sposta(Matrix,Agente,MatrixUpdate):-
	prendi_coord_attuali(Agente, I, J),
	change_value_matrix(Matrix,I,J,'0',Upd),
	direzione(Agente, Direction),
	numero_passi_x_step(Agente, Step),
	nuova_posizione(I,J,Direction,Step,NewX,NewY),
	cambia_coord_attuali(Agente,NewX,NewY),
	upd_done_steps(Agente),
	id(Agente, Id),
	change_value_matrix(Upd,NewX,NewY,Id,MatrixUpdate).

	
muovi_agenti(_,FinalMatrix,_,FinalMatrix):-end_game(neo,target),!.	
muovi_agenti(ListaAgenti,Matrix,[[NextX,NextY]|RestNeoPath],Final):-
	who_has2change_direction(ListaAgenti,[],_Consentiti),
	choiseBestMove(Matrix,ListaAgenti,BestMove),
	muovi_agenti_single_step(BestMove,Matrix,Upd),
	(%%COMMENTANDO QUESTA PARTE SI PUO FISSARE N E OSSERVARE IL COMPORTAMENTO DEGLI AGENTI
		find_direction(neo,target,[NextX,NextY],RankListDirection),!,
		update_on_file('D:\\WORKSPACE\\ExpertSystemWBFS\\decisionDir.txt', RankListDirection),
		muovi_eletto(Upd,FinalStepMatrix,RankListDirection),
		adeguatePath([[NextX,NextY]|RestNeoPath],NewPath)
	),
	print_situation(BestMove,FinalStepMatrix),!,
	insertFixObstacle(FinalStepMatrix,UpdFinalStepMatrix),
	%muovi_agenti(ListaAgenti,UpdFinalStepMatrix,NewPath,Final).
	muovi_agenti(ListaAgenti,UpdFinalStepMatrix,NewPath,Final).
	
muovi_agenti_single_step([],Fin,Fin):-!.
muovi_agenti_single_step([Agente|Restanti_Agenti],Matrix,NewUp):-
	Agente=[],
	muovi_agenti_single_step(Restanti_Agenti,Matrix,NewUp);
	sposta(Matrix,Agente,MatrixUpdate),!,
	update_on_file('D:\\WORKSPACE\\ExpertSystemWBFS\\moveDetails.txt', MatrixUpdate),
	muovi_agenti_single_step(Restanti_Agenti,MatrixUpdate,NewUp).	
	
who_has2change_direction([],Consentiti,Consentiti):-!.
who_has2change_direction([Agente|Restanti],Parziale,Consentiti):-
	numero_passi_effettuati(Agente, DoneStep),numero_passi_in_direz(Agente, DoneStep),!,
	inverti_direzione(Agente),
	who_has2change_direction(Restanti, [Agente|Parziale],Consentiti);
	who_has2change_direction(Restanti, Parziale,Consentiti).
	
print_situation(_,MatriceIntermedia):-
	%length(Consentiti, 0);
	update_on_file('D:\\WORKSPACE\\ExpertSystemWBFS\\file.txt',MatriceIntermedia).
	
sort_move(_,_,[],Agenti_che_possono_muoversiBeta,Agenti_che_possono_muoversi):-
	reverse(Agenti_che_possono_muoversiBeta,Agenti_che_possono_muoversi),!.
sort_move(Ambiente,AmbienteSimulato,[Agente|Restanti_Agenti],Parziale,Esegui):-
	simulazione_sposta_light(Ambiente,Agente,AmbienteParzSimulato,Agente_da_Inserire),
	Agente_da_Inserire=[],!,
	sort_move(AmbienteParzSimulato,AmbienteSimulato,Restanti_Agenti,Parziale,Esegui);
	simulazione_sposta_light(Ambiente,Agente,AmbienteParzSimulato,Agente_da_Inserire),
	sort_move(AmbienteParzSimulato,AmbienteSimulato,Restanti_Agenti,[Agente_da_Inserire|Parziale],Esegui).
	
choiseBestMove(Ambiente,ListaAgenti,MigliorCombinazione):-
	bagof(Combinazione, permutation(ListaAgenti, Combinazione), TutteLeCombinazioni),
	schedulazioneCombinazioni(Ambiente,TutteLeCombinazioni,[],MigliorCombinazione).

schedulazioneCombinazioni(_,[],TheBest,TheBest):-!.
schedulazioneCombinazioni(Ambiente,[Combinazione|Restanti_Combinazioni],PartialTheBest,TheBest):-
	sort_move(Ambiente, [], Combinazione, [], RisultatoCombinazione),%%POTREBBE ESSERE PER IL FATTO CHE IL METODO SORT CAMBIA LA COMBINAZIONE ORIGINARIA CHE INTENDO COMPIERE
	length(RisultatoCombinazione, NumeroMosse),
	length(PartialTheBest, AttualeMaggiorNumeroMosse),
	NumeroMosse>=AttualeMaggiorNumeroMosse,!,
	schedulazioneCombinazioni(Ambiente,Restanti_Combinazioni,RisultatoCombinazione,TheBest);
	schedulazioneCombinazioni(Ambiente,Restanti_Combinazioni,PartialTheBest,TheBest).