allowCellsAstar(X,Y,ListBrothers,ResultList):-
	adjacentCellsAstar(X,Y,['N','NE','NO','O','SO','S','SE','E'],[],AllowsCell),
	subtract(AllowsCell,ListBrothers,ResultList).
adjacentCellsAstar(_,_,[],AdjacentList,AdjacentList):-!.	
adjacentCellsAstar(X,Y,[Direction|OtherDirection],Partials,AdjacentList):-
	numero_passi_x_step(neo, NumStep),
	nuova_posizione(X, Y, Direction, NumStep, NewX, NewY),
	%controlInsideEnv(NewX, NewY),
	findall(Ostacolo, è_un(Ostacolo,ostacolo_fisso), OstacoliFissi),
	trovaCoordFixObstacle(OstacoliFissi,[],ListaCoordFixObj),
	%append(VisitedCells, ListaCoordFixObj, NotAdjacent2Consider),
	not(member([NewX,NewY],ListaCoordFixObj)),!,
	adjacentCellsAstar(X,Y,OtherDirection,[[NewX,NewY]|Partials],AdjacentList);
	adjacentCellsAstar(X,Y,OtherDirection,Partials,AdjacentList).

allowCells(X,Y,ListBrothers,ResultList):-
	assert(visitedCell(X,Y)),
	adjacentCells(X,Y,['N','NE','NO','O','SO','S','SE','E'],[],AllowsCell),
	subtract(AllowsCell,ListBrothers,ResultList).

adjacentCells(_,_,[],AdjacentList,AdjacentList):-!.	
adjacentCells(X,Y,[Direction|OtherDirection],Partials,AdjacentList):-
	numero_passi_x_step(neo, NumStep),
	nuova_posizione(X, Y, Direction, NumStep, NewX, NewY),
	%controlInsideEnv(NewX, NewY),
	findall([PrevX,PrevY],visitedCell(PrevX,PrevY),VisitedCells),
	findall(Ostacolo, è_un(Ostacolo,ostacolo_fisso), OstacoliFissi),
	trovaCoordFixObstacle(OstacoliFissi,[],ListaCoordFixObj),
	append(VisitedCells, ListaCoordFixObj, NotAdjacent2Consider),
	not(member([NewX,NewY],NotAdjacent2Consider)),!,
	adjacentCells(X,Y,OtherDirection,[[NewX,NewY]|Partials],AdjacentList);
	adjacentCells(X,Y,OtherDirection,Partials,AdjacentList).
	
trovaCoordFixObstacle([],Coords,Coords):-!.	
trovaCoordFixObstacle([Ostacolo|OtherObstacles],Partials,Coords):-
	prendi_coord_attuali(Ostacolo, X, Y),!,
	trovaCoordFixObstacle(OtherObstacles,[[X,Y]|Partials],Coords).

getAdjacents([],FinalList,FinalList):-!.
getAdjacents([[X,Y]|ListBrothers],PartialsAdjacentList,FinalList):-
	allowCells(X, Y, ListBrothers,AdjacentCells),
	append(AdjacentCells,PartialsAdjacentList,NewPartialsAdjacentList),!,
	getAdjacents(ListBrothers,NewPartialsAdjacentList,FinalList).
	
bfs(StartX,StartY,FinalX,FinalY):-
	bfs_aux([[StartX,StartY]],FinalX,FinalY).

bfs_aux([],_,_):-!,
	abolish(visitedCell/2),
	writeln('Il target NON è raggiungibile, NON ha senso effettuare l''esecuzione'),
	false.
bfs_aux(CellsList,FinalX,FinalY):-
	getAdjacents(CellsList, [], AdjacentsList),
	list_to_set(AdjacentsList,AdjacentsSet),
	not(member([FinalX,FinalY],AdjacentsSet)),!,
	bfs_aux(AdjacentsSet,FinalX,FinalY);
	writeln('Il target è raggiungibile, ha senso effettuare l''esecuzione'),
	abolish(visitedCell/2).
	
can_reached(Neo,Target):-
	prendi_coord_attuali(Neo,StartX,StartY),
	coord_goal(Target,FinalX,FinalY),
	bfs(StartX, StartY, FinalX, FinalY).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
findAgentsCell(_,_,NotAllow2go):-
	findall(Agente, è_un(Agente,agente), Agenti),
	getCoordAndNextCoord(Agenti,[],NotAllow2go).
	
getCoordAndNextCoord([],NotAllow2go,NotAllow2go):-!.
getCoordAndNextCoord([Agent|OtherAgents],Partial,NotAllow2go):-
	prendi_coord_attuali(Agent, X, Y),
	getNextPos(X,Y,Agent,NextX,NextY),
	append([[X,Y],[NextX,NextY]], Partial, NewPartial),!,
	getCoordAndNextCoord(OtherAgents,NewPartial,NotAllow2go).
	
getNextPos(ActualX,ActualY,Agente,NextX,NextY):-
	numero_passi_effettuati(Agente, DoneStep),numero_passi_in_direz(Agente, DoneStep),
	numero_passi_x_step(Agente, Step),
	direzione(Agente, Dir),
	dir_opposta(Dir, DirOpp),
	nuova_posizione(ActualX, ActualY, DirOpp, Step, NextX, NextY);
	numero_passi_x_step(Agente, Step),
	direzione(Agente, Dir),
	nuova_posizione(ActualX, ActualY, Dir, Step, NextX, NextY).