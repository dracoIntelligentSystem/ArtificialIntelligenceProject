setFileAndEnvVar:-
	b_setval(file, 'D:\\WORKSPACE\\ExpertSystemWBFS\\file.txt'),
	b_setval(movementsDetails, 'D:\\WORKSPACE\\ExpertSystemWBFS\\moveDetails.txt'),
	b_setval(directionChoice, 'D:\\WORKSPACE\\ExpertSystemWBFS\\decisionDir.txt'),
	b_setval(neo_intercept,f),
	b_getval(movementsDetails,MovDetails),b_getval(file, File),b_getval(directionChoice, Directions),
	ListFile =[File,MovDetails,Directions],
	getexisting(ListFile,[],ExistingFile),
	trashOldCompFile(ExistingFile).

getexisting([],ListExistingFile,ListExistingFile):-!.
getexisting([FileName|Other],Partial,ExistingFile):-
	(
		exists_file(FileName),
		append([FileName], Partial, PartialExisting),
		getexisting(Other,PartialExisting,ExistingFile)
	);
	getexisting(Other,Partial,ExistingFile).
		

trashOldCompFile([]):-!.
trashOldCompFile([File|Other]):-
	delete_file(File),!,
	trashOldCompFile(Other).

controlInsideEnv(X,Y):-
	ambiente(matrix,_,Rows,Columns),
	between(1, Rows,X),between(1, Columns,Y).
	
controlPosition(UserObj,X,Y,Enviroment,Sim):-
	posizione_attuale(Enviroment, Info, X, Y),
	Info='0',%non siamo su una cella occupata
	%ma dobbiamo verificare che al primo step un agente non vada a intercettare l'eletto
	change_value_matrix(Enviroment, X, Y, 'N', Sim),
	findall(Agente,è_un(Agente,agente),Agenti),!,
	control1Step(UserObj,Sim,X,Y,Agenti,_).
	
control1Step(_,_,_,_,[],_):-!.	
control1Step(neo,Sim,X,Y,[Agente|Other],SimUpd):-
	direzione(Agente,Direction),
	id(Agente, Id),
	numero_passi_x_step(Agente, Step),
	posizione_attuale(Sim,Id,I,J),
	not(nuova_posizione(I,J,Direction,Step,X,Y)),
	control1Step(neo,Sim,X,Y,Other,SimUpd).
	
control1Step(target,Sim,X,Y,[Agente|Other],SimUpd):-
	direzione(Agente,Direction),
	id(Agente, Id),
	numero_passi_x_step(Agente, Step),
	numero_passi_in_direz(Agente, TotSteps),
	posizione_attuale(Sim,Id,I,J),
	numero_passi_effettuati(Agente, DoneSteps),
	roadControl(DoneSteps,TotSteps,I,J,Direction,Step,X,Y),
	control1Step(target,Sim,X,Y,Other,SimUpd).

roadControl(DoneSteps,DoneSteps,_,_,_,_,_,_):-!.
roadControl(DoneSteps,TotSteps,I,J,Direction,Step,X,Y):-
	not(nuova_posizione(I,J,Direction,Step,X,Y)),
	nuova_posizione(I,J,Direction,Step,NewI,NewJ),
	UpdDoneSteps is DoneSteps+1,
	roadControl(UpdDoneSteps,TotSteps,NewI,NewJ,Direction,Step,X,Y).
	
	
controlDestinationCell(Entita,'0',Entita):-
	è_un(Entita,agente);
	è_un(Entita,eletto).
controlDestinationCell(neo,'T',neo).
controlDestinationCell(Agente,'N',Agente):-
	è_un(Agente,agente),
	b_setval(neo_intercept,t),!.
controlDestinationCell(Agente,'W',Agente):-
	è_un(Agente,agente),
	editMovingCollision(Agente).
controlDestinationCell(Agente,IdOtherAgent,Agente):-
	id(OtherAgent, IdOtherAgent),
	è_un(Agente,agente),è_un(OtherAgent,agente),
	direzione(Agente, MeDirection),direzione(OtherAgent, OtherDirection),
	dir_opposta(MeDirection, OtherDirection),
	editMovingCollision(Agente),editMovingCollision(OtherAgent).
	
	
	