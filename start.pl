:-([control,matrice,insert,funz_agenti,oneDirection,rosa_dei_venti,matrixFunction,astar]).

flush:-
%	abolish(direzione/2),
%	abolish(coordX_attuale/2),
%	abolish(coordY_attuale/2),
%	abolish(numero_passi_effettuati/2),
%	abolish(ambiente/4),
%	abolish(deny/3),
%	unload_file('D:\\WORKSPACE\\ExpertSystemWBFS\\testAd.pl').
abolish(direzione/2),
abolish(coordX_attuale/2),
abolish(coordY_attuale/2),
abolish(numero_passi_effettuati/2),
abolish(coord_goal/3),
abolish(è_un/2),
abolish(numero_passi_in_direz/2),
abolish(numero_passi_x_step/2),
abolish(id/2).

start :- 
	setFileAndEnvVar,
	make_dim_matrix(10,10,Matrix),
	b_getval(file, File),
	update_on_file(File,Matrix),
	writeln('Scrivi il file Scenario da Caricare: '),
	read(Scenario),
	consult(Scenario),
	findall(Agente,(è_un(Agente,agente)),Agenti),
	findall(Ostacolo,(è_un(Ostacolo,ostacolo_fisso)),Ostacoli_fissi),
	append(Agenti,Ostacoli_fissi,AgentiAndOstacoli),
	insert_agents(AgentiAndOstacoli,Matrix,Enviroment),!,%write(Enviroment),
	insertStartAndTarget(Enviroment,CompleteEnviroment),
	
				%insert_theOneAndTarget(Enviroment,CompleteEnviroment),!,
		%QUI FACCIO ANCHE L'INSERIMENTO DEL TARGET E DI NEO
	update_on_file(File,CompleteEnviroment),
	can_reached(neo,target),			%BFS ALGORITMH 4 CHECK IF MAKE SENSE DO TO COMPUTATION.
	pathfind(normalPhase,neo,target,NeoPath), 
							%raggiungi_traguardo(CompleteEnviroment,GameComplete).
	muovi_agenti(Agenti,CompleteEnviroment,NeoPath,_MatrixFinal).
	%write('Passi effettuati da Neo per uscire da Matrix: '),numero_passi_effettuati(neo, X),writeln(X), 
	%flush.
	